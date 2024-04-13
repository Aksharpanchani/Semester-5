samp_time = 1/(16);
t = -8:samp_time:8;
%to truncate as per the question
s_timeDomain = 3*sinc(2*t-3);
%function
[X,f,df] = contFT(s_timeDomain,-8,1/16,1e-3);
figure(1);
plot(f,abs(X),'b');
title('Magnitude of Fourier Transform versus frequency');
ylabel('Magnitude of Fourier Transform |X(f)|');
xlabel('Frequency (in MHz)');
figure(2);
plot(f,angle(X),'r');
title('Phase of Fourier Transform versus frequency');
ylabel('Phase of Fourier Transform (X(f))');
xlabel('Frequency (in MHz)');
function [X,f,df] = contFT(x,tstart,dt,df_desired)
Nmin=max(ceil(1/(df_desired*dt)),length(x));
Nfft = 2^(nextpow2(Nmin));
X=dt*fftshift(fft(x,Nfft));
df=1/(Nfft*dt);
f = ((0:Nfft-1)-Nfft/2)*df;
X=X.*exp(-j*2*pi*f*tstart);
end