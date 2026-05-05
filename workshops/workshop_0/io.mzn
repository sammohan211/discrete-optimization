% This is a MiniZinc model that takes a data file defining integer
% parameters n and outputs its vaue

int: n;

solve satisfy;

output ["n= ", show(n), "\n"];