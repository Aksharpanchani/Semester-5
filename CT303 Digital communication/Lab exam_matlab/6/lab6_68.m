% MATLAB script for Illustrative Problem 6.8.
echo on
N = 31;
T = 1;
alpha = 1/4;
n = -(N-1)/2:(N-1)/2; % the indices for g_T

% Correct the computation of g_T
g_T = zeros(size(n)); % Initialize g_T with zeros

for i = 1:length(n)
    for m = 1:N
        g_T(i) = g_T(i) + sqrt(xrc(4 * (m - (N-1)/2) / (N * T), alpha, T)) * exp(1i * 2 * pi * (m - (N-1)/2) * n(i) / N);
    end
end

g_T = real(g_T); % The imaginary part is due to the finite machine precision

% Derive g_T(n-(N-1)/2).
n2 = 0:N-1;

% Get the frequency response characteristics.
[g_T_freq, W] = freqz(g_T, 1);

% normalized magnitude response
P = 20 * log10(abs(g_T_freq) / max(abs(g_T_freq)));

% impulse response of the cascade of the transmitter and the receiver filters
g_R = g_T;
imp_resp_cascade = conv(g_R, g_T);

% Plotting commands follow.

% Plot the time domain representation of g_T
figure;
subplot(2, 2, 1);
stem(n, g_T);
title('Time Domain Representation of g_T');
xlabel('n');
ylabel('g_T(n)');

% Plot the frequency response characteristics
subplot(2, 2, 2);
plot(W/pi, P);
title('Frequency Response Characteristics');
xlabel('Normalized Frequency (\omega/\pi)');
ylabel('Magnitude (dB)');

% Plot the impulse response of the cascade of transmitter and receiver filters
subplot(2, 2, [3, 4]);
stem(0:length(imp_resp_cascade)-1, imp_resp_cascade);
title('Impulse Response of Cascade (Transmitter and Receiver)');
xlabel('n');
ylabel('g_R * g_T(n)');


function [y] = xrc(f, alpha, T)
    % [y] = xrc(j,alpha,T)
    % Evaluates the expression Xrc(j). The parameters alpha and T
    % must also be given as inputs to the function.
    if (abs(f) > ((1 + alpha) / (2 * T)))
        y = 0;
    elseif (abs(f) > ((1 - alpha) / (2 * T)))
        y = (T / 2) * (1 + cos((pi * T / alpha) * (abs(f) - (1 - alpha) / (2 * T))));
    else
        y = T;
    end
end