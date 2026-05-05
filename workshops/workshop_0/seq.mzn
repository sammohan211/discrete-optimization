% Define a MiniZinc model seq.mzn which takes a integer parameter n defining the length 
% of an array of numbers x taking values from 0 to 3. Constrain the numbers so that the 
% first number is zero, the last number is 3, and the sum of any two adjacent numbers in  
% the array x is at most 3. Also constrain the value of x at positions divisible by 3 to 
% be greater than or equal to 2. Maximize the sum of the numbers in the array x.

int: n;

array[1..n] of var 0..3: x;

constraint x[1] = 0;
constraint x[n] = 3;

constraint forall(i in 1..n-1) (x[i]+x[i+1] <= 3);
constraint forall(i in 1..n where i mod 3 = 0) (x[i] >= 2);

solve maximize sum(x);

output [show(sum(x))," = ", show(x), "\n"];