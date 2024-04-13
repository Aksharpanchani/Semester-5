% (ExPCM.m)
% Example of sampling, quantization, and zero-order hold
%clear; clf;
td = 0.002;
t = 0:td:1.1; % original sampling rate 500 Hz, time interval of 1 second
xsig = sin(2 * pi * t) - sin(6 * pi * t);
Lsig = length(xsig);
Lfft = 2^ceil(log2(Lsig + 1)); % Ensure Lfft is a power of 2
Xsig = fftshift(fft(xsig, Lfft));
Fmax = 1 / (2 * td); % Maximum frequency
Faxis = linspace(-Fmax, Fmax, Lfft); % Frequency axis

ts = 0.02; % new sampling rate
Nfact = ts / td; % downsampling factor
% Send the signal through a 16-level uniform quantizer
[s_out, sq_out, sqh_out1, Delta, SQNR] = sampandquant(xsig, 16, td, ts);

% Plot the original signal and the PCM signal in the time domain
figure(1);
subplot(211);
sfig1 = plot(t, xsig, 'k', t, sqh_out1(1:Lsig), 'b');
set(sfig1, 'Linewidth', 2);
title('Signal {\it g}({\it t}) and its 16-level PCM signal')
xlabel('time (sec.)');

% Send the signal through a 4-level uniform quantizer
[s_out, sq_out, sqh_out2, Delta, SQNR] = sampandquant(xsig, 4, td, ts);

% Plot the original signal and the PCM signal in the time domain
subplot(212);
sfig2 = plot(t, xsig, 'k', t, sqh_out2(1:Lsig), 'b');
set(sfig2, 'Linewidth', 2);
title('Signal {\it g}({\it t}) and its 4-level PCM signal')
xlabel('time (sec.)');

% Frequency Domain Analysis
Lfft = 2^ceil(log2(Lsig + 1)); % Update Lfft
Fmax = 1 / (2 * td); % Maximum frequency
Faxis = linspace(-Fmax, Fmax, Lfft); % Frequency axis
SQH1 = fftshift(fft(sqh_out1, Lfft));
SQH2 = fftshift(fft(sqh_out2, Lfft));

% Ideal LPF to filter the two PCM signals
BW = 10; % Bandwidth is no larger than 10Hz
H_lpf = zeros(1, Lfft);
H_lpf(Lfft/2 - BW : Lfft/2 + BW - 1) = 1; % Ideal LPF

S1_recv = SQH1 .* H_lpf; % Ideal filtering
s_recv1 = real(ifft(ifftshift(S1_recv))); % Reconstructed time domain
s_recv1 = s_recv1(1:Lsig); % Trim to original signal length

S2_recv = SQH2 .* H_lpf; % Ideal filtering
s_recv2 = real(ifft(ifftshift(S2_recv))); % Reconstructed time domain
s_recv2 = s_recv2(1:Lsig); % Trim to original signal length

% Plot the filtered signals against the original signal
figure(2);
subplot(211);
sfig3 = plot(t, xsig, 'b-', t, s_recv1, 'b-.');
legend('original', 'recovered')
set(sfig3, 'Linewidth', 2);
title('Signal {\it g}({\it t}) and filtered 16-level PCM signal')
xlabel('time (sec.)');

subplot(212);
sfig4 = plot(t, xsig, 'b-', t, s_recv2, 'b-.');
legend('original', 'recovered')
set(sfig4, 'Linewidth', 2);
title('Signal {\it g}({\it t}) and filtered 4-level PCM signal')
xlabel('time (sec.)');

function [q_out, Delta, SQNR] = uniquan(sig_in, L)
% Usage
% [q_out, Delta, SQNR] = uniquan(sig_in, L)
% L number of uniform quantization levels
% sig_in - input signal vector
% Function outputs:
% q_out - quantized output
% Delta - quantization interval
% SQNR

sig_pmax = max(sig_in); % finding the positive peak
sig_nmax = min(sig_in); % finding the negative peak
Delta = (sig_pmax - sig_nmax) / L; % quantization interval
q_levels = sig_nmax + Delta / 2 : Delta : sig_pmax - Delta / 2; % define Q-levels
L_sig = length(sig_in); % find signal length
sigp = (sig_in - sig_nmax) / Delta + L / 2; % convert into 1/2 to L+ l/2 range
q_index = round(sigp); % round to 1, 2, ... L levels
q_index = min(q_index, L); % eliminate L+l as a rare possibility
q_out = q_levels(q_index); % use index vector to generate output
SQNR = 20 * log10(norm(sig_in) / norm(sig_in - q_out)); % actual SQNR value
end


function [s_out, sq_out, sqh_out, Delta, SQNR] = sampandquant(sig_in, L, td, ts)
% Usage
% [s_out, sq_out, sqh_out, Delta, SQNR] = sampandquant(sig_in, L, td, fs)
% L number of uniform quantization levels
% sig_in - input signal vector
% td original signal sampling period of sig_in
% ts new sampling period
% NOTE: td*fs must be a positive integer;
% Function outputs: s_out - sampled output
% sq_out - sample-and-quantized output
% sqh_out - sample, quantize, and hold output
% Delta - quantization interval
% SQNR - actual signal to quantization noise ratio

if (rem(ts/td, 1) == 0)
    nfac = round(ts/td);
    p_zoh = ones(1, nfac);
    s_out = downsample(sig_in, nfac);
    [sq_out, Delta, SQNR] = uniquan(s_out, L);
    s_out = upsample(s_out, nfac);
    sqh_out = kron(sq_out, p_zoh);
    sq_out = upsample(sq_out, nfac);
else
    warning('Error! ts/td is not an integer!');
    s_out = [];
    sq_out = [];
    sqh_out = [];
    Delta = [];
    SQNR = [];
end
end



