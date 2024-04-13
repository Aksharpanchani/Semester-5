% Parameters
T = 1; % Pulse width
N = 128; % Number of samples
t = (0:N-1) / 10; % Time values from 0 to 12.7
g = 1/2 * (1 - cos(2 * pi * t / T)); % Pulse function
% Calculate the correlation function Ra(m)
M = length(g);
Ra = zeros(1, M);
Ra(1) = 1;
Ra(2) = 1/2;
Ra(end) = 1/2;
% Generate the sequence {an}
an = Ra(1:2) / sqrt(sum(Ra(1:2)));
an = [an, zeros(1, N - length(an))];
% Compute the power spectrum Sv(j)
V = fft(g);
Sv = abs(V).^2 / N;
% Compute the power spectrum Sv(j) using the {an} sequence
Sv_an = abs(fft(an)).^2 / N;
% Plot the power spectrum
m = 0:N-1;
subplot(2, 1, 1);
plot(m, Sv);
title('Power Spectrum of v(t)');
xlabel('Frequency (m)');
ylabel('|V(m)|^2');
subplot(2, 1, 2);
plot(m, Sv_an);
title('Power Spectrum of v(t) Using {an}');
xlabel('Frequency (m)');
ylabel('|An(m)|^2');
