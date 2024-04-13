num_samples = 1000;
sigma_w = 0.1;
X = zeros(1, num_samples);
w = sigma_w * randn(1, num_samples);
for n = 2:num_samples
X(n) = 0.98 * X(n - 1) + w(n);
end
quantization_levels_8 = linspace(min(X), max(X), 8);
quantized_signal_8 = interp1(quantization_levels_8, quantization_levels_8, X, 'nearest');
subplot(2,2,1);
plot(quantized_signal_8);
title('8-level Uniform PCM Quantized Signal');
quantization_error_8 = X - quantized_signal_8;
subplot(2,2,2);
plot(quantization_error_8);
title('Quantization Error for 8-level Uniform PCM');
xlabel('Sample Number');
ylabel('Quantization Error');
signal_power = mean(X.^2);
noise_power = mean(quantization_error_8.^2);
sqnr_8 = 10 * log10(signal_power / noise_power);
disp(['SQNR for 8-level Uniform PCM: ' num2str(sqnr_8) ' dB']);
quantization_levels_16 = linspace(min(X), max(X), 16);
quantized_signal_16 = interp1(quantization_levels_16, quantization_levels_16, X, 'nearest');
subplot(2,2,3);

plot(quantized_signal_16);
title('16-level Uniform PCM Quantized Signal');
quantization_error_16 = X - quantized_signal_16;
subplot(2,2,4);
plot(quantization_error_16);
title('Quantization Error for 16-level Uniform PCM');
xlabel('Sample Number');
ylabel('Quantization Error');
signal_power = mean(X.^2);
noise_power = mean(quantization_error_16.^2);
sqnr_16 = 10 * log10(signal_power / noise_power);
disp(['SQNR for 16-level Uniform PCM: ' num2str(sqnr_16) ' dB']);