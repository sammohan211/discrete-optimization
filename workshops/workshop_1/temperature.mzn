% =============================================================================
% Workshop 1, Part 2: Temperature control with cost minimisation.
%
% A forge building must be kept between 25 and 30 degrees. Each hour we observe
% the outside temperature and pick ONE control action. The building's new temp
% is the floor-average of the previous building temp and the outside reading,
% with the action's degree effect added on top.
%
% Goal: choose the cheapest sequence of actions that keeps temp in [25, 30].
% =============================================================================


% ----- INPUT PARAMETERS ------------------------------------------------------
% These are read from the .dzn data files. `par` (parameter) values are fixed
% before solving; the solver only chooses `var` (variable) values.

array[int] of int: readings;          % outside temperature each hour
int: start;                           % building's temperature at hour 0
int: n = length(readings);            % number of hours

set of int: HOUR  = 1..n;             % indices for hours 1..n  (where actions apply)
set of int: HOUR0 = 0..n;             % indices for hours 0..n  (includes the start state)


% ----- ACTION CATALOG --------------------------------------------------------
% An enum gives us symbolic names instead of magic numbers. The output will
% print these names directly, e.g. "choice = [do_nothing, cool, ...]".
enum CHOICE = {heat, strongly_heat, cool, strongly_cool, do_nothing};

% Two parallel arrays indexed BY THE ENUM. Order must match the enum above.
% This is the MiniZinc-idiomatic way to attach data to enum members: a single
% lookup `effect[choice[h]]` replaces a long if/else chain.
array[CHOICE] of int: effect = [ 1,  4, -2, -5, 0];   % degrees added each hour
array[CHOICE] of int: price  = [ 1,  5,  3,  9, 0];   % dollars per use


% ----- DECISION VARIABLES ----------------------------------------------------
% `var 25..30` declares the variable AND the constraint that it stays in the
% legal range -- no separate `constraint temp[h] >= 25 /\ temp[h] <= 30` needed.
% The solver will only ever consider values inside this domain, which is
% tighter (and faster) than posting the bounds as constraints after the fact.
array[HOUR0] of var 25..30: temp;     % temp[0] = start, temp[1..n] are derived

% At each hour we pick one action from the CHOICE enum.
array[HOUR]  of var CHOICE: choice;


% ----- CONSTRAINTS -----------------------------------------------------------

% Pin the building's initial temperature to the given start value.
constraint temp[0] = start;

% State transition for every hour:
%   new_temp = floor( (prev_temp + outside) / 2 )  +  effect_of_chosen_action
%
% `div` is integer division (rounds toward zero). For the non-negative values
% involved here, that matches the "rounding down" wording in the brief.
%
% Because `temp[h]` is declared `var 25..30`, this same equation also enforces
% the legal-range constraint: any choice that would push temp out of [25, 30]
% makes the equation unsatisfiable, so the solver rejects it.
constraint forall(h in HOUR)
                 (temp[h] = (temp[h-1] + readings[h]) div 2 + effect[choice[h]]);


% ----- OBJECTIVE -------------------------------------------------------------
% Total spend is the sum of the per-hour action costs. `cost` is a `var int`
% (a derived expression) -- not a parameter -- because it depends on `choice`.
var int: cost = sum(h in HOUR)(price[choice[h]]);

% The supplied solution checker (`temperature.mzc`) expects the objective to be
% named `obj`, so we expose it under that name as well. Aliasing keeps the
% friendlier `cost` name in the output without duplicating the expression.
var int: obj = cost;

% Find the assignment with the smallest `cost`. `minimize` turns this from
% a satisfaction problem into an optimisation problem.
solve minimize cost;


% ----- OUTPUT ----------------------------------------------------------------
% String interpolation with \(...) prints the value of each variable. We match
% the format shown in the worksheet so the .mzc checker can validate us.
output [
  "temp = \(temp);\n",
  "choice = \(choice);\n",
  "cost = \(cost);\n"
];
