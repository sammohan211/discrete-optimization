% Define a model which takes an integer parameter n defining the length 
% of an array of numbers x taking values from 0 to 9. 
% Constrain the array so the sum of the numbers in the array is equal 
% to the product of the numbers in the array. Output the resulting array.

int: n;

array[1..n] of var 0..9: x;

constraint sum(x) = product(x);
constraint forall(i in 1..n-1) (x[i] <= x[i+1]);

solve satisfy;

output ["x= ", show(x), "\n"];