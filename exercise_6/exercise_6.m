%% Signal in Time and Frequency Domain
clc;
clear all;
close all;

% Time domain signal
t = -1:0.001:1;
x = sin(2*pi*50*t);

% Time plot
subplot(2,1,1);
plot(t(1001:1200), x(1001:1200));
grid on;
title('Sin(2\pi50t)');
xlabel('Time (s)');
ylabel('Amplitude');

% Frequency domain
X = abs(fft(x));
X2 = fftshift(X);
f = -499.9 : 1000/2001 : 500;

subplot(2,1,2);
plot(f, X2);
grid on;
title('Frequency domain representation of Sin(2\pi50t)');
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
