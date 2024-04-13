% MATLAB script for Problem 5.4.
% Initialization:
K = 20; % Number of samples
A = 1; % Signal amplitude 
l = 0:K; % Defining the time index

% Defining signal waveforms:
s_0 = A * ones(1, K);
s_1 = [A * ones(1, K/2), -A * ones(1, K/2)];

% Different noise variances:
variances = [0.1, 1, 3];

figure;

for var_idx = 1:length(variances)
    % Initializing output signals:
    y_0 = zeros(1, K);
    y_1 = zeros(1, K);
    
    % Noise for the current variance:
    variance = variances(var_idx);
    noise = random('Normal', 0, variance, 1, K);
    
    % Sub-case s = s_0:
    s = s_0;
    y = s + noise; % received signal
    y_0 = conv(y, fliplr(s_0));
    y_1 = conv(y, fliplr(s_1));
    
    % Plotting the results for the current variance:
    subplot(3, length(variances), var_idx);
    plot(l, [0, y_0(1:K)], '-k', l, [0, y_1(1:K)], '--k');
    set(gca, 'XTickLabel', {'0', '5Tb', '10Tb', '15Tb', '20Tb'});
    axis([0 20 -30 30]);
    title(['\sigma^2 = ' num2str(variance)], 'fontsize', 10);
    
    % Sub-case s = s_1:
    s = s_1;
    y = s + noise; % received signal
    y_0 = conv(y, fliplr(s_0));
    y_1 = conv(y, fliplr(s_1));
    
    % Plotting the results for the current variance:
    subplot(3, length(variances), length(variances) + var_idx);
    plot(l, [0, y_0(1:K)], '-k', l, [0, y_1(1:K)], '--k');
    set(gca, 'XTickLabel', {'0', '5Tb', '10Tb', '15Tb', '20Tb'});
    axis([0 20 -30 30]);
    title(['\sigma^2 = ' num2str(variance)], 'fontsize', 10);
end
