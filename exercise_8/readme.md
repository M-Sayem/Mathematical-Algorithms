# Exercise 8: Clean FFT Plots in MATLAB

This project demonstrates how to generate **clean FFT plots** for a composite signal, including:  

- Time-domain signal  
- Magnitude spectrum (single-sided)  
- Phase spectrum (only at significant frequency bins)  

The signal is composed of multiple sinusoids:  

$$
x(t) = \sin(2 \pi \cdot 15 t) + \sin(2 \pi \cdot 40 t) + \sin(2 \pi \cdot 60 t) + \sin(2 \pi \cdot 85 t)
$$  

with a sampling frequency of 200 Hz.

## Features
- Generate a composite sinusoidal signal in time domain.  
- Compute its FFT and single-sided magnitude spectrum.  
- Display phase spectrum only at significant frequency bins (above a threshold).  
- Use `subplot` to visualize time-domain, magnitude, and phase plots clearly.  

## MATLAB Code
```matlab
%% Exercise 8: Clean FFT plots (time, magnitude, phase)
clc; clear; close all;

% --- Sampling / time settings ---
Fs = 200;         % sampling frequency (Hz)
T = 1/Fs;         % sampling period
L = 2000;         % number of samples (duration = L/Fs seconds)
t = (0:L-1)*T;    % time vector

% --- Define signal ---
x = sin(2*pi*15*t) + sin(2*pi*40*t) + ...
    sin(2*pi*60*t) + sin(2*pi*85*t);

% --- Time-domain plot ---
subplot(3,1,1);
plot(t, x);
title('Given Original Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% --- FFT and single-sided spectrum ---
Y = fft(x);
P2 = abs(Y/L);                    % two-sided spectrum (normalized)
P1 = P2(1:floor(L/2)+1);          % single-sided spectrum
P1(2:end-1) = 2*P1(2:end-1);      % scale (except DC & Nyquist)
f = Fs*(0:floor(L/2))/L;          % frequency axis (0..Fs/2)

% --- Magnitude plot ---
subplot(3,1,2);
stem(f, P1, 'filled','LineWidth',1.2);
title('Magnitude');
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
xlim([0 100]); % zoom in
grid on;

% --- Phase: only at significant bins ---
phase_deg = angle(Y(1:floor(L/2)+1)) * 180/pi; % phase in degrees
threshold_ratio = 0.05;                        % 5% threshold
mask = P1 > (max(P1) * threshold_ratio);

% If no bins pass threshold, force-show top 4 peaks
if ~any(mask)
    [~, idx_sort] = sort(P1,'descend');
    mask(idx_sort(1:min(4,length(idx_sort)))) = true;
end

subplot(3,1,3);
stem(f(mask), phase_deg(mask), 'filled','LineWidth',1.2);
title('Phase');
xlabel('Frequency (Hz)');
ylabel('Phase (degrees)');
xlim([0 100]);
ylim([-180 180]);
grid on;
