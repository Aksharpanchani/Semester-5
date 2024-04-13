T = 1; % Time period
fc = 6 / T; % Carrier frequency
M = 8; % Number of phases for PSK
t = linspace(0, T, 1000); % Time vector
% Define GT(t) pulse shape function
GT = @(t) 0.5 * (1 - cos(2 * pi * t / T)) .* (0 <= t & t <= T);
% Generate 8-PSK waveforms
theta = linspace(0, 2 * pi, M + 1); % Phase angles
theta = theta(1:M); % Remove the last angle to avoid overlap
PSK_waveforms = zeros(M, length(t));
for i = 1:M
 PSK_waveforms(i, :) = cos(2 * pi * fc * t + theta(i)) .* GT(t);
end
% Plotting the 8-PSK signal waveforms
figure;
for i = 1:M
 subplot(M/2, 2, i);
 plot(t, PSK_waveforms(i, :));
 title(['Phase ' num2str(i)]);
 xlabel('Time');
 ylabel('Amplitude');
 grid on;
end
sgtitle('8-PSK Signal Waveforms with GT(t) Pulse Shape');
