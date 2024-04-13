% MATLAB script for Problem 5.3
% Initialization:
K = 20; % Number of samples
A = 1; % Signal amplitude
l = 0:K;
% Defining signal waveforms:
s_0 = A * ones(1, K);
s_1 = [A * ones(1, K/2), -A * ones(1, K/2)];
% Initialize output signals:
r_0 = zeros(1, K);
r_1 = zeros(1, K);
% Noise variances:
noise_variances = [0.1, 1, 3];
for var_idx = 1:length(noise_variances)
% Generate noise with different variances
noise = sqrt(noise_variances(var_idx)) * randn(1, K);
% Sub-case s = s_0:
s = s_0;
r = s + noise; % received signal
for n = 1:K
r_0(n) = sum(r(1:n) .* s_0(1:n));
r_1(n) = sum(r(1:n) .* s_1(1:n));
end
% Plotting the results:
subplot(3, 3, var_idx)
plot(0:K, [0, r_0], '-', 0:K, [0, r_1], '--')
set(gca, 'XTickLabel', {'0', '5Tb', '10Tb', '15Tb', '20Tb'})
axis([0, 20, -5, 30])
title(['\sigma^2 = ' num2str(noise_variances(var_idx))], 'fontsize', 10)
if var_idx == 1
ylabel('Output', 'fontsize', 10)
end
% Sub-case s = s_1:
s = s_1;
r = s + noise; % received signal
for n = 1:K
r_0(n) = sum(r(1:n) .* s_0(1:n));
r_1(n) = sum(r(1:n) .* s_1(1:n));
end
% Plotting the results:
subplot(3, 3, var_idx + 3)
plot(0:K, [0, r_0], '-', 0:K, [0, r_1], '--')
set(gca, 'XTickLabel', {'0', '5Tb', '10Tb', '15Tb', '20Tb'})
axis([0, 20, -5, 30])
if var_idx == 1
ylabel('Output', 'fontsize', 10)
end
end
% Display the plots
subtitle('Signal Detection Scenarios');