clear;
clf;

data = sign(randn(1, 400));
Tau = 64;
dataup = upsample(data, Tau);

yrz = conv(dataup, prz(Tau));
yrz = yrz(1:end-Tau+1);

ynrz = conv(dataup, pnrz(Tau));
ynrz = ynrz(1:end-Tau+1);

ysine = conv(dataup, psine(Tau));
ysine = ysine(1:end-Tau+1);

Td = 4;
yrcos = conv(dataup, prcos(0.5, Td, Tau));
yrcos = yrcos(2*Td*Tau : end-2*Td*Tau+1);

eye1 = eyediagram(yrz, 2*Tau, Tau, Tau/2);
title('RZ eye-diagram');

eye2 = eyediagram(ynrz, 2*Tau, Tau, Tau/2);
title('NRZ eye-diagram');

eye3 = eyediagram(ysine, 2*Tau, Tau, Tau/2);
title('Half-sine eye-diagram');

eye4 = eyediagram(yrcos, 2*Tau, Tau);
title('Raised-cosine eye-diagram');


% (prz.m)
function pout = prz(T)
    pout = [zeros(1, T/4), ones(1, T/2), zeros(1, T/4)];
end

% (pnrz.m)
function pout = pnrz(T)
    pout = ones(1, T);
end

% (psine.m)
function pout = psine(T)
    pout = sin(pi * (0:T-1) / T);
end

% (prcos.m)
function y = prcos(rollfac, length, T)
    y = rcosdesign(rollfac, length, T, 'normal');
end

