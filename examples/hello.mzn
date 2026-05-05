% Smallest sanity-check model: find an integer x in 1..10 such that 2*x = 14.
var 1..10: x;
constraint 2 * x = 14;
solve satisfy;
output ["x = ", show(x), "\n"];
