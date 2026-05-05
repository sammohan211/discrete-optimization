% An optimization model with a decision variable x taking values from 0 to 10, with  
% constrains to ensure that x is divisible by 4, which outputs the value of x
% that gives the minimum value of (x-7) squared

var 0..10: x;

constraint x mod 4 = 0;

solve minimize (x-7)*(x-7);

output ["x= ", show(x), "\n"]