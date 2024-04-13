% Define parameters
ex = 0.5; % Roll-off factor for square-root raised-cosine filter
T = 1; % Time period
fc = 40 / T; % Carrier frequency
% Frequency range
f = linspace(-10/T, 10/T, 1000);
% Calculate baseband signal spectrum (PAM with square-root raised-cosine filter)
X_baseband = sinc(f * T) .* cos(pi * ex * f * T) ./ (1 - (2 * ex * f * T).^2);
% Calculate carrier spectrum (impulses at +/-fc)
carrier = zeros(size(f));
carrier(f == fc) = 1;
carrier(f == -fc) = 1;
% Calculate amplitude-modulated PAM signal spectrum
Y_AM_PAM = conv(X_baseband, carrier, 'same');
% Plotting the spectra
figure;
% Baseband signal spectrum
subplot(2, 1, 1);
plot(f, abs(X_baseband), 'b');
title('Baseband Signal Spectrum (PAM with SRRC filter)');
xlabel('Frequency');
ylabel('Amplitude');
grid on;
% AM-PAM signal spectrum
subplot(2, 1, 2);
plot(f, abs(Y_AM_PAM), 'r');
title('AM-PAM Signal Spectrum');
xlabel('Frequency');
ylabel('Amplitude');
grid on;
% Show plots
