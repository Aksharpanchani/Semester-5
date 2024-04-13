% Define parameters
T = 1; % Time period
fc = 8 / T; % Carrier frequency
A = sqrt(2) - 1; % Signal constellation amplitude factor
t = linspace(0, T, 1000); % Time vector
% Define 8-QAM constellation points (in-phase and quadrature components)
constellation = [
 -A - 1i * A;
 -A + 1i * A;
 A - 1i * A;
 A + 1i * A;
 -A - 3i * A;
 -A + 3i * A;
 A - 3i * A;
 A + 3i * A
];
% Generate and plot 8-QAM signal waveforms
figure;
for i = 1:size(constellation, 1)
 % Generate waveform for each constellation point using rectangular pulse
 waveform = real(constellation(i)) * cos(2 * pi * fc * t) + imag(constellation(i)) * sin(2 * pi * fc * t);
 
 % Plot each waveform
 subplot(4, 2, i);
 plot(t, waveform);
 title(['8-QAM Waveform ' num2str(i)]);
 xlabel('Time');
 ylabel('Amplitude');
 grid on;
end
sgtitle('8-QAM Signal Waveforms with Rectangular Pulse GT(t)');
