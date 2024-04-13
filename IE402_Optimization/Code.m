A = [1 4 1 0 0;
    3 1 0 1 0;
    1 1 0 0 1];
c = [-2 -5 0 0 0];
b = [24; 21; 9];

[xopt, zopt] = simplex_method(A, b, c);
fprintf('Optimal Solution: %s\n', mat2str(xopt));
fprintf('Optimal Objective Value: %d\n', zopt);

function [x_optimal, z_optimal] = simplex_method(A, b, c)
    [m, n] = size(A);
    % Initialize the simplex table with slack variables
    simplex_table = [c, zeros(1, 1); A, b];

    fprintf('Initial Simplex Table:\n');
    disp(simplex_table);

    itr = 0;
    while any(simplex_table(1, 1:n) < 0)
        % Entering variable
        [min_rc, entering_col] = min(simplex_table(1, 1:n));

        if min_rc >= 0
            fprintf('The problem is unbounded.\n');
            return;
        end

        % Leaving variable
        ratios = simplex_table(2:m + 1, end) ./ simplex_table(2:m + 1, entering_col);
        ratios(ratios <= 0) = inf;
        [min_ratio, leaving_row] = min(ratios);
        leaving_row = leaving_row + 1;

        % Pivot element
        pivot_element = simplex_table(leaving_row, entering_col);
        simplex_table(leaving_row, :) = simplex_table(leaving_row, :) / pivot_element;

        for i = 1:m + 1
            if i ~= leaving_row
                simplex_table(i, :) = simplex_table(i, :) - simplex_table(i, entering_col) * simplex_table(leaving_row, :);
            end
        end

        itr = itr + 1;
        fprintf('Simplex Table after iteration %d:\n', itr);
        disp(simplex_table);
    end

    % Extract the optimal solution and objective value
    x_optimal = simplex_table(1, n + 2:end);
    z_optimal = -simplex_table(1, end);

    fprintf('Optimal Simplex Table:\n');
    disp(simplex_table);
end

% Test the simplex method with your data

