% A model with a single decision variable x taking values from 1 to 10, 
% which outputs its value

var 1..10: x;

solve satisfy;

output ["x = ", show(x), "\n"];