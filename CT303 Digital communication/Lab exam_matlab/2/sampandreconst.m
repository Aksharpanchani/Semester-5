% Parameters
duration = 2; % Duration in seconds
sampling_rate = 1000; % Sampling rate in Hz
t = 0:1/sampling_rate:duration-1/sampling_rate; % Time vector
% Frequencies of the cosine functions
freq1 = 5; % 5 Hz
freq2 = 8; % 8 Hz
% Generate the original signal
signal = cos(2*pi*freq1*t) + cos(2*pi*freq2*t);
% Sample the signal
num_samples = duration * sampling_rate;
sampled_signal = signal(1:num_samples);
% Reconstruct the signal
reconstructed_signal = zeros(size(t));
for i = 1:num_samples
reconstructed_signal = reconstructed_signal + sampled_signal(i)*cos(2*pi*(i-1)/sampling_rate*t);
end
% Plot the original, sampled, and reconstructed signals
subplot(3,1,1);
plot(t, signal);
title('Original Signal');
xlabel('Time (s)');
ylabel('Amplitude');
subplot(3,1,2);
stem(t(1:num_samples), sampled_signal);
title('Sampled Signal');
xlabel('Time (s)');
ylabel('Amplitude');
subplot(3,1,3);
plot(t, reconstructed_signal);
title('Reconstructed Signal');
xlabel('Time (s)');
ylabel('Amplitude');
sgtitle('Sampling and Reconstruction of Cosine Functions');