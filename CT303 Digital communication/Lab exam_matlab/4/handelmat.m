load handel.mat;
bit_depth = 8;
audio_signal = y;
quantized_signal = zeros(size(audio_signal));
prediction_error = zeros(size(audio_signal));
N = length(audio_signal);
alpha = 0.02;
W = zeros(1, 2);
U = [0, 0];
for n = 1:N
prediction = W * U.';
prediction_error(n) = audio_signal(n) - prediction;
quantized_error = round(prediction_error(n) * (2^(bit_depth - 1)));
W = W + alpha * quantized_error * U;
U = [audio_signal(n), U(1)];
quantized_signal(n) = prediction + quantized_error / (2^(bit_depth - 1));
end
signal_power = sum(audio_signal.^2) / N;
quantization_error_power = sum((audio_signal - quantized_signal).^2) / N;
SQNR = 10 * log10(signal_power / quantization_error_power);
figure;
subplot(2, 1, 1);
plot(audio_signal);
title('Original Signal');

xlabel('Sample');
ylabel('Amplitude');
subplot(2, 1, 2);
plot(prediction_error);
title('Quantization Error');
xlabel('Sample');
ylabel('Error Amplitude');
audiowrite('quantized_audio.wav', quantized_signal, Fs);

disp(['SQNR (dB): ', num2str(SQNR)]);