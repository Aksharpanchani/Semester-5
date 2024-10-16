A = [1 4 1 0 0;
    3 1 0 1 0;
    1 1 0 0 1];
c = [-2 -5 0 0 0];

b = [24; 21; 9];

[xopt, zopt] = simplex_method(A, b, c);
fprintf('Optimal soln is %d',xopt);
%disp('Optimal Solution:');
%disp(xopt);
fprintf(['Optimal Objective Value: %d', num2str(zopt)]);

function [x_optimal, z_optimal] = simplex_method(A, b, c)
    % Initialize the simplex table
    [m, n] = size(A);
    simplex_table = [c, zeros(1, 1); A, b];
    disp('Simplex Table: ');
    disp(simplex_table);

    % Main Simplex algorithm loop which runs untill any element in the
    % first row is negative
    itr=0;
    while any(simplex_table(1, 1:n) < 0)
        % Entering variable
        [min_rc, entering_col] = min(simplex_table(1, 1:n));
        %disp(min_rc);
        %disp(entering_col);

        % Check whether we have reached the optimal solution or not i.e. if
        % the min_rc is a positive value
        if min_rc >= 0
            disp('The problem is unbounded.');
            return;
        end
        
        % Leaving variable 
        ratios = simplex_table(2:m+1, end) ./ simplex_table(2:m+1, entering_col);
        %disp(ratios);

        % Assigning negative ratios to inf
        ratios(ratios <= 0) = inf;
        [min_ratio, leaving_row] = min(ratios);
        %disp(min_ratio);
        %disp(leaving_row);
        
        leaving_row = leaving_row + 1;
        %disp(leaving_row);
        %disp(entering_col);
        
        % Pivot element
        pivot_element = simplex_table(leaving_row, entering_col);
        simplex_table(leaving_row, :) = simplex_table(leaving_row, :) / pivot_element;

        for i = 1:m+1
            if i ~= leaving_row
                simplex_table(i, :) = simplex_table(i, :) - simplex_table(i, entering_col) * simplex_table(leaving_row, :);
            end
        end
        itr = itr + 1;
        fprintf('Simplex Table after iteration %d:\n', itr);
        disp(simplex_table);
    end
    
    % Storing the optimal solution and objective value
    x_optimal = simplex_table(2:m+1, n + 1);
    z_optimal = simplex_table(1, end);
    
    % Displaying the final simplex table
    disp('Optimal Simplex Table:');
    disp(simplex_table);
end

