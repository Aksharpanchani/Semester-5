% Define the objective function coefficients
c = [2; 1];

% Define the constraint coefficients and RHS values
A = [1, 2; 1, 1; 1, -1; 1, -2];
b = [10; 6; 2; 1];

% Create a grid of points for visualization
x1_range = 0:0.1:10;
x2_range = 0:0.1:10;
[X1, X2] = meshgrid(x1_range, x2_range);

% Check feasibility and calculate Z values for each point
feasible_points = all(A * [X1(:), X2(:)]' <= b, 1);
Z = c(1) * X1 + c(2) * X2;

% Plot the constraint lines and feasible region
figure;
hold on;
plot(x1_range, (10 - x1_range) / 2, 'r', 'LineWidth', 2);
plot(x1_range, 6 - x1_range, 'g', 'LineWidth', 2);
plot(x1_range, x1_range - 2, 'b', 'LineWidth', 2);
plot(x1_range, x1_range / 2, 'm', 'LineWidth', 2);
fill([0, 0, 2, 4, 5, 6, 10], [0, 2, 2, 1, 0, 0, 0], [0.8, 0.8, 0.8]);

% Plot the objective function values over the feasible region
contour(X1, X2, Z, 'ShowText', 'on');

% Find and plot the optimal solution point
options = optimset('linprog');
options.Display = 'off';
[x_opt, z_opt] = linprog(-c, A, b, [], [], zeros(2, 1), [], [], options);
plot(x_opt(1), x_opt(2), 'ro', 'MarkerSize', 10);

hold off;
grid on;
xlabel('x1');
ylabel('x2');
title('Graphical Solution of Linear Programming Problem');
legend('x1 + 2x2 <= 10', 'x1 + x2 <= 6', 'x1 - x2 <= 2', 'x1 - 2x2 <= 1', 'Feasible Region', 'Location', 'best');
