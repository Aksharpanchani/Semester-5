% Define the objective function coefficients
c = [-2; -5];

% Define the constraint matrix
A = [1, 4; 3, 1; 1, 1];
b = [24; 21; 9];

% Initial basic variables
B = eye(3);

% Initial non-basic variables
N = [1; 2];

% Initialize the tableau
tableau = [B, N, A, b; -c' * B, zeros(1,numel(N)), -c', 0];

% Perform the Simplex method
while any(tableau(1, 1:end-1) < 0)
    pivot_col = find(tableau(1, 1:end-1) < 0, 1); % Determine the pivot column
    
    % Calculate the ratios for the pivot column
    ratios = tableau(2:end, end) ./ tableau(2:end, pivot_col);
    
    % Determine the pivot row
    pivot_row = find(ratios == min(ratios), 1) + 1;
    
    % Update the pivot element to 1
    tableau(pivot_row, :) = tableau(pivot_row, :) / tableau(pivot_row, pivot_col);
    
    % Update the other elements in the pivot column
    for i = 1:size(tableau, 1)
        if i ~= pivot_row
            tableau(i, :) = tableau(i, :) - tableau(i, pivot_col) * tableau(pivot_row, :);
        end
    end
end

% Display the final Simplex table
disp('Optimal Simplex Table:');
disp(tableau);

% Extract the optimal solution
optimal_solution = tableau(1, end);

% Display the optimal solution
fprintf('Optimal Solution (Z): %f\n', -optimal_solution);
fprintf('Optimal Values (x1, x2):\n');
disp(tableau(2:end, end-1));
