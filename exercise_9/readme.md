# Exercise 9: DFT with Fixed Length (n = 512) in MATLAB

This project demonstrates how to compute the **Discrete Fourier Transform (DFT)** of a signal using a fixed FFT length in MATLAB.  

The signal is:  

$$
x(t) = \sin(2 \pi \cdot 15 t) + \sin(2 \pi \cdot 40 t)
$$  

with a **sampling frequency** of 100 Hz and **FFT length** \(n = 512\).

## Features
- Compute the DFT of a signal with a fixed length.  
- Plot **magnitude** and **phase** spectra.  
- Mark key frequency components on the plots.  

## MATLAB Code
```matlab
%% Exercise 9: DFT with fixed length n = 512
clc; clear all; close all;

% --- Time vector ---
t = 0:1/100:10;  % from 0 to 10 s, step = 1/100 s

% --- Signal definition ---
x = sin(2*pi*15*t) + sin(2*pi*40*t);

% --- FFT parameters ---
n = 512;             % fixed FFT length
y = fft(x, n);       % DFT of signal
m = abs(y);          % magnitude
p = unwrap(angle(y));% unwrapped phase (radians)

% --- Frequency vector for plotting ---
f = (0:n-1) * 100 / n;   % based on sampling frequency (100 Hz)

% --- Magnitude plot ---
subplot(2,1,1);
plot(f, m);
grid on;
title('Magnitude');
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
ax = gca;
ax.XTick = [15 40 60 85];  % mark key frequencies

% --- Phase plot ---
subplot(2,1,2);
plot(f, p * 180 / pi);
grid on;
title('Phase');
xlabel('Frequency (Hz)');
ylabel('Phase (degrees)');
ax = gca;
ax.XTick = [15 40 60 85];
