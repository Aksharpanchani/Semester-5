num_symbols = 10000;
% Generate random quaternary symbols (-3, -1, 1, 3)
symbols = 2 * (randi([0, 1], 1, num_symbols) * 2 - 1);
% Noise variance
noise_variance = 0; % Setting noise variance to 0
% Generate Gaussian noise with zero mean and specified variance
noise = sqrt(noise_variance) * randn(1, num_symbols);
% Add noise to the symbols
received_symbols = symbols + noise;
% Decision rule: Demodulation
decoded_symbols = zeros(size(received_symbols));
decoded_symbols(received_symbols < -2) = -3;
decoded_symbols(received_symbols >= -2 & received_symbols < 0) = -1;
decoded_symbols(received_symbols >= 0 & received_symbols < 2) = 1;
decoded_symbols(received_symbols >= 2) = 3;
% Calculate the symbol error rate from simulation
symbol_errors = sum(decoded_symbols ~= symbols);
simulated_symbol_error_rate = symbol_errors / num_symbols;
% Theoretical symbol error rate for QPAM with no noise
theoretical_symbol_error_rate = 0;
% Display simulated and theoretical symbol error rates
fprintf('Simulated Symbol Error Rate: %.6f\n', simulated_symbol_error_rate);
fprintf('Theoretical Symbol Error Rate: %.6f\n', theoretical_symbol_error_rate);
% Plot 1000 received signal-plus-noise samples
samples_to_plot = 1000;
if samples_to_plot > num_symbols
 samples_to_plot = num_symbols;
end
figure;
stem(1:samples_to_plot, received_symbols(1:samples_to_plot));
xlabel('Sample Index');
ylabel('Received Signal + Noise');
title('Received Signal-plus-Noise Samples at the Input to the Detector');