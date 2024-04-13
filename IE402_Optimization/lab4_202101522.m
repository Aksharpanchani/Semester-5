A = [1 4 1 0 0;
    3 1 0 1 0;
    1 1 0 0 1];
c = [-2 -5 0 0 0];

b = [24; 21; 9];

[xopt, zopt] = simplex(A, b, c);
fprintf('Optimal soln is %d \n',xopt);
disp(['Optimal Value:', num2str(zopt)]);

function [xopt, zopt] = simplex(A, b, c)
    % Initialize the simplex table
    [m, n] = size(A);
    table = [c, zeros(1, 1); A, b];
    
    fprintf('Simplex Table: \n');
    disp(table);

    iter=0;
    while any(table(1, 1:n) < 0)
        % Entering variable = EV
        [min_rc, EV] = min(table(1, 1:n));
        
        if min_rc >= 0
            disp('The problem is unbounded.');
            return;
        end
        
        % Leaving variable 
        ratios = table(2:m+1, end) ./ table(2:m+1, EV);
        
        % Assigning negative ratios to inf
        ratios(ratios <= 0) = inf;
        [~, LV] = min(ratios); % ~ represent the empty variable.
        
        %LV= Leaving variable.
        LV = LV + 1;
       
        % Pivot element=PE
        PE = table(LV, EV);
        table(LV, :) = table(LV, :) / PE;

        for i = 1:m+1
            if i ~= LV
                table(i, :) = table(i, :) - table(i, EV) * table(LV, :);
            end
        end
        iter = iter + 1;
        fprintf('Table  %d:\n', iter+1);
        disp(table);
    end
    
    % Storing the optimal solution and objective value
    xopt = table(2:m+1, n + 1);
    zopt = table(1, end);
    
end
