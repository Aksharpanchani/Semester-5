mean_value = 0;
variance = 1;
num_elements = 1000;
gaussian_sequence = mean_value + sqrt(variance) * randn(num_elements, 1);
bits = [2, 3, 4, 5, 6];
levels = 2.^bits;
sqnr_dB = zeros(size(bits));
for i = 1:length(bits)
quantized_sequence = round(gaussian_sequence * (levels(i)-1) / (2*sqrt(variance))) * (2*sqrt(variance)) /(levels(i)-1);
signal_power = var(gaussian_sequence);
quantization_error = gaussian_sequence - quantized_sequence;

error_power = var(quantization_error);
sqnr_dB(i) = 10*log10(signal_power / error_power);
end
figure;
plot(bits, sqnr_dB, 'o-');
title('SQNR vs. Number of Bits');
xlabel('Number of Bits');
ylabel('SQNR (dB)');
grid on;