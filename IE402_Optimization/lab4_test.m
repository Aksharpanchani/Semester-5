% Define the objective function coefficients
f = [-2; -3];

% Define the constraint matrix A and right-hand side b
A = [2, 1; 1, 2];
b = [4; 5];

% Define the lower and upper bounds for decision variables (x1 and x2)
lb = [0; 0];
ub = [];

% Solve the linear programming problem using linprog
[x, fval, exitflag, output] = linprog(f, [], [], A, b, lb, ub);

% Display the results
if exitflag == 1
    fprintf('Optimal Solution Found:\n');
    fprintf('Optimal Objective Value (Z): %f\n', -fval);
    fprintf('Optimal Values (x1, x2): (%f, %f)\n', x(1), x(2));
else
    fprintf('No optimal solution found.\n');
end
