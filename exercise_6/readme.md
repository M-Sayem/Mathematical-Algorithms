# FFT of Sinusoidal Signal in MATLAB

This project demonstrates the **time-domain** and **frequency-domain** representation of a sinusoidal signal:

$$
x(t) = \sin(2 \pi \cdot 50 t)
$$

using MATLAB.  

## Features
- Time-domain signal generation for `x(t)`  
- Fast Fourier Transform (FFT) for frequency-domain analysis  
- Visualization with `subplot`:
  - **Top plot:** Time-domain signal (zoomed section)  
  - **Bottom plot:** Frequency-domain representation using `fft` and `fftshift`  

## MATLAB Code Example
```matlab
% Define time vector
fs = 1000;               % Sampling frequency
t = 0:1/fs:0.1;          % Time vector

% Generate sinusoidal signal
x = sin(2*pi*50*t);

% Compute FFT
X = fft(x);
f = (-length(X)/2:length(X)/2-1)*(fs/length(X));

% Plot time-domain and frequency-domain signals
figure;
subplot(2,1,1);
plot(t, x, 'LineWidth', 1.5);
xlabel('Time (s)'); ylabel('Amplitude');
title('Time-domain Signal');
grid on;

subplot(2,1,2);
plot(f, fftshift(abs(X)), 'LineWidth', 1.5);
xlabel('Frequency (Hz)'); ylabel('Magnitude');
title('Frequency-domain Signal');
grid on;
