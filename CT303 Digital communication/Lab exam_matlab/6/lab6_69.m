% MATLAB script for Illustrative Problem 6.9.
echo on
N = 31;
T = 1;
W = 1 / (2 * T);
n = -(N - 1) / 2:(N - 1) / 2; % the indices for g_T

% The expression for g_T is obtained next.
for i = 1:length(n)
    g_T(i) = 0;
    for m = -(N - 1) / 2:(N - 1) / 2
        if (abs((4 * m) / (N * T)) <= W)
            g_T(i) = g_T(i) + sqrt((1 / W) * cos((2 * pi * m) / (N * T * W))) * exp(1i * 2 * pi * m * n(i) / N);
        end
    end
end

g_T = real(g_T); % The imaginary part is due to the finite machine precision

% Obtain g_T(n-(N-1)/2).
n2 = 0:N - 1;

% Obtain the frequency response characteristics.
[G_T, W] = freqz(g_T, 1);

% normalized magnitude response
magG_T_in_dB = 20 * log10(abs(G_T) / max(abs(G_T)));

% impulse response of the cascade of the transmitter and the receiver filters
g_R = g_T;
imp_resp_of_cascade = conv(g_R, g_T);

% Plotting commands
subplot(3, 1, 1);
stem(n, g_T);
title('Transmitter Filter g_T(n)');
xlabel('n');
ylabel('Amplitude');

subplot(3, 1, 2);
plot(W/pi, magG_T_in_dB);
title('Frequency Response of g_T');
xlabel('Normalized Frequency (\omega/\pi)');
ylabel('Magnitude (dB)');

subplot(3, 1, 3);
stem(0:length(imp_resp_of_cascade)-1, imp_resp_of_cascade);
title('Impulse Response of the Cascade');
xlabel('n');
ylabel('Amplitude');

echo off
