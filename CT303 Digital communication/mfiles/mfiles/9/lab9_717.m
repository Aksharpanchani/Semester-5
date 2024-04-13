% Define parameters
M = 8; % Number of symbols in 8-QAM
num_symbols = 10000; % Number of symbols to simulate
Eb_N0_dB = 0:2:20; % Eb/N0 values in dB
Eb_N0 = 10.^(Eb_N0_dB / 10); % Convert Eb/N0 values to linear scale
% Constellation points for 8-QAM
constellation = [
 -3-3i;
 -3-1i;
 -3+3i;
 -3+1i;
 -1-3i;
 -1-1i;
 -1+3i;
 -1+1i
];
% Initialize arrays to store symbol error rates (SER)
SER_simulated = zeros(1, length(Eb_N0));
SER_upper_bound = zeros(1, length(Eb_N0));
% Monte Carlo simulation loop for different Eb/N0 values
for k = 1:length(Eb_N0)
 % Generate random information symbols
 info_symbols = randi([1 M], 1, num_symbols);
 transmitted_symbols = constellation(info_symbols); % Map symbols to constellation
 
 % Normalization of energy to unity 
 normalized_symbols = transmitted_symbols
 sqrt(mean(abs(transmitted_symbols).^2));
 
 % Generate noise components
 sigma = 1 / sqrt(2 * Eb_N0(k)); % Calculate noise standard deviation
 noise = sigma * (randn(1, num_symbols) + 1i * randn(1, num_symbols)); % Complex Gaussian noise
 
 % Received symbols with noise
 received_symbols = normalized_symbols + noise;
 
 % Demodulate received symbols (nearest neighbor detection)
 detected_symbols = zeros(size(received_symbols));
 for i = 1:num_symbols
 [~, index] = min(abs(received_symbols(i) - constellation));
 detected_symbols(i) = constellation(index);
 end
 
 % Calculate symbol error rate (SER)
 symbol_errors = nnz(detected_symbols - transmitted_symbols);
 SER_simulated(k) = symbol_errors / num_symbols;
 
 % Theoretical upper bound on symbol error rate
 SER_upper_bound(k) = 2 * qfunc(sqrt(3 * Eb_N0(k))); % Theoretical upper bound formula
end
% Plotting the results
figure;
semilogy(Eb_N0_dB, SER_simulated, 'o-', 'linewidth', 2, 'DisplayName', 'Simulated SER');
hold on;
semilogy(Eb_N0_dB, SER_upper_bound, 'r--', 'linewidth', 2, 'DisplayName', 'Theoretical Upper Bound');
title('Symbol Error Rate (SER) vs Eb/N0 for 8-QAM System');
xlabel('Eb/N0 (dB)');
ylabel('Symbol Error Rate (SER)');
legend('Location', 'best');
grid on;