% (a) Generate vector x of length 10^6 with uniform random variables between 0 and 1
x = rand(1, 10^6);

% (b) Calculate the average of every 100 consecutive elements of x
averages = mean(reshape(x, 100, []));

% (c) Plot the histogram of the sequence y with 50 bins
histogram(averages, 50);
title('Histogram of Averages');
xlabel('Average Values');
ylabel('Frequency');
