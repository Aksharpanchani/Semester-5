% Define parameters
M = 4; % Number of phases for PSK
Eb_N0_dB = 0:5:20; % Eb/N0 values in dB
num_symbols = 10^5; % Number of symbols to simulate
constellation = exp(1i * (0:2*pi/M:2*pi*(1-1/M))); % PSK constellation
% Monte Carlo simulation loop for different Eb/N0 values
for k = 1:length(Eb_N0_dB)
 Eb_N0 = 10^(Eb_N0_dB(k) / 10); % Convert dB to linear scale
 
 % Generate random information symbols
 info_symbols = randi([1 M], 1, num_symbols);
 transmitted_symbols = constellation(info_symbols); % Map symbols to 
constellation
 
 % AWGN channel
 noise_var = 1 / (2 * Eb_N0); % Calculate noise variance for given Eb/N0
 noise = sqrt(noise_var) * (randn(1, num_symbols) + 1i * randn(1, num_symbols)); % Complex Gaussian noise
 
 received_symbols = transmitted_symbols + noise; % Received symbols with noise
 
 % Detector: Find closest symbol to the received symbol
 detected_symbols = zeros(1, num_symbols);
 for i = 1:num_symbols
 received_phase = angle(received_symbols(i));
 [~, index] = min(abs(received_phase - angle(constellation)));
 detected_symbols(i) = constellation(index);
 end
 
 % Calculate symbol error rate (SER)
 symbol_errors = nnz(detected_symbols - transmitted_symbols);
 symbol_error_rate(k) = symbol_errors / num_symbols;
end
% Plot Symbol Error Rate (SER) vs Eb/N0
figure;
semilogy(Eb_N0_dB, symbol_error_rate, 'o-', 'linewidth', 2);
title('Symbol Error Rate (SER) vs Eb/N0 for 4-PSK with Phase Detector');
xlabel('Eb/N0 (dB)');
ylabel('Symbol Error Rate (SER)');
grid on;