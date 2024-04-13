T = 1; % Pulse width
N = 128; % Number of samples
t = (0:N-1) / 10; % Time values from 0 to 12.7
g = rectpuls(t - T/2, T);
G = fft(g);
Sv = abs(G).^2 / N;
m = 0:N-1;
plot(m, Sv);
title('Power Spectrum of Rectangular Pulse');
xlabel('Frequency (m)');
ylabel('|G(m)|^2');

f = linspace(0, N-1, N) / 10; % Frequency values
G_f = fftshift(fft(g)); % Shift the zero frequency component to the center
G_f_squared = abs(G_f).^2;
plot(f, G_f_squared);
title('Exact Spectrum |G(f)|^2 of Rectangular Pulse');
xlabel('Frequency (f)');
ylabel('|G(f)|^2');
