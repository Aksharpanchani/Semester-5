% MATLAB script for Illustrative Problem 5.4.
% Initialization:
K = 20; % Number of samples
A = 1; % Signal amplitude
l = 0:K; % Defining the time index

% Defining signal waveforms:
s_0 = A * ones(1, K);
s_1 = [A * ones(1, K/2), -A * ones(1, K/2)];

% Initializing output signals:
y_0 = zeros(1, K);
y_1 = zeros(1, K);

figure;

% Case 1: noise - N(0, 0)
noise = random('Normal', 0, 0, 1, K);

% Sub-case s = s_0:
s = s_0;
y = s + noise; % received signal
y_0 = conv(y, fliplr(s_0));
y_1 = conv(y, fliplr(s_1));

% Plotting the results:
subplot(3, 2, 1);
plot(l, [0, y_0(1:K)], '-k', l, [0, y_1(1:K)], '--k');
set(gca, 'XTickLabel', {'0', '5Tb', '10Tb', '15Tb', '20Tb'});
axis([0 20 -30 30]);
xlabel('(a) \sigma^2 = 0 & S_0 is transmitted');

% ... (Repeat for other cases)

% Case 2: noise - N(0, 0.1)
noise = random('Normal', 0, 0.1, 1, K);

% Sub-case s = s_0 (continue as before for other cases)

% ...
