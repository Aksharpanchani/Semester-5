% Load audio data using audioread (replace 'speech_sample' with your file)
[X, Fs] = audioread('speech_sample.wav');

mu = 255; % Define mu for mu-law PCM
n = 256;  % Define the quantization level

% Call the PCM functions (d_pcm, mula_pcm, u_pcm) to obtain quantized signals
% Replace the function calls with the appropriate function definitions.

% Example function calls (replace with your own function calls):
% [sqnr_dpcm, X_quan_dpcm, code_dpcm] = d_pcm(X, n);
% [sqnr_mula_pcm, X_quan_mula_pcm, code_mula_pcm] = mula_pcm(X, n, mu);
% [sqnr_upcm, X_quan_upcm, code_upcm] = u_pcm(X, n);

% Plot the error for each PCM technique
subplot(311)
plot(X - X_quan_dpcm)
title('DPCM Error')

subplot(312)
plot(X - X_quan_mula_pcm)
title('Mu-PCM Error')

subplot(313)
plot(X - X_quan_upcm)
title('Uniform PCM Error')

% Display SQNR values
fprintf('SQNR for Uniform PCM: %.2f\n', sqnr_upcm);
fprintf('SQNR for Mu-law PCM: %.2f\n', sqnr_mula_pcm);
fprintf('SQNR for DPCM: %.2f\n', sqnr_dpcm);
