clc; clear all; close all;

% Time vector from -1 to 1 with step 0.001
t = -1:0.001:1;

% Sinusoidal function
x = sin(2*pi*50*t) + sin(2*pi*75*t);

%% === Time Domain Plot ===
subplot(2,1,1);
plot(t(1001:1200), x(1001:1200));  % show 0 to 0.2 sec for clarity
grid on;
title('Sin(2\pi50t) + Sin(2\pi75t)');
xlabel('Time (s)');
ylabel('Amplitude');

%% === Frequency Domain Plot ===
N = length(t);    % number of samples
Fs = 1000;        % sampling frequency (1/0.001)
X = abs(fft(x));  % magnitude of FFT
X2 = fftshift(X); % shift zero freq to center

% Frequency axis
f = (-N/2 : N/2-1) * (Fs/N);

subplot(2,1,2);
plot(f, X2);
grid on;
title('Frequency domain representation of Sin(2\pi50t) + Sin(2\pi75t)');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
