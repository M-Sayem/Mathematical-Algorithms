%% Lab 4: Noise and Filtering
close all; clear; clc;

%% Load image
I = im2double(rgb2gray(imread('peppers.png')));

%% ---------------------------------------------------------
% 1) Add different noise types
%% ---------------------------------------------------------
I_gauss = imnoise(I, 'gaussian', 0, 0.01);      % Gaussian noise
I_sp    = imnoise(I, 'salt & pepper', 0.05);    % Salt & Pepper noise

figure;
montage({I, I_gauss, I_sp}, 'Size', [1 3]);
title('Original | Gaussian Noise | Salt & Pepper Noise');

%% ---------------------------------------------------------
% 2) Compute quality metrics (MSE & SNR)
%% ---------------------------------------------------------
% MSE
MSE_gauss = immse(I_gauss, I);
MSE_sp    = immse(I_sp, I);

% SNR function
calcSNR = @(signal, noisy) 10*log10(sum(signal(:).^2) / sum((signal(:)-noisy(:)).^2));

SNR_gauss = calcSNR(I, I_gauss);
SNR_sp    = calcSNR(I, I_sp);

fprintf("MSE Gaussian: %.4f | SNR Gaussian: %.4f dB\n", MSE_gauss, SNR_gauss);
fprintf("MSE S&P: %.4f | SNR S&P: %.4f dB\n", MSE_sp, SNR_sp);

%% ---------------------------------------------------------
% 3) Linear filtering (mean & Gaussian)
%% ---------------------------------------------------------
h_avg = fspecial('average', 3);

I_avg_gauss = imfilter(I_gauss, h_avg, 'replicate');
I_avg_sp    = imfilter(I_sp, h_avg, 'replicate');

h_gauss = fspecial('gaussian', [3 3], 0.7);

I_gauss_gauss = imfilter(I_gauss, h_gauss, 'replicate');
I_gauss_sp    = imfilter(I_sp, h_gauss, 'replicate');

%% ---------------------------------------------------------
% 4) Nonlinear filtering (median)
%% ---------------------------------------------------------
I_med_gauss = medfilt2(I_gauss, [3 3]);
I_med_sp    = medfilt2(I_sp, [3 3]);

figure;
montage({I_avg_sp, I_med_sp, I_avg_gauss, I_med_gauss}, 'Size', [2 2]);
title('Top: Avg vs Median (S&P) | Bottom: Avg vs Median (Gaussian)');

%% ---------------------------------------------------------
% 5) Compare MSE after filtering
%% ---------------------------------------------------------
MSE_avg_sp = immse(I_avg_sp, I);
MSE_med_sp = immse(I_med_sp, I);
MSE_avg_gauss = immse(I_avg_gauss, I);
MSE_med_gauss = immse(I_med_gauss, I);

fprintf("\nFiltered S&P Noise:\n");
fprintf("  MSE (Average Filter): %.4f\n", MSE_avg_sp);
fprintf("  MSE (Median Filter):  %.4f\n", MSE_med_sp);

fprintf("\nFiltered Gaussian Noise:\n");
fprintf("  MSE (Average Filter): %.4f\n", MSE_avg_gauss);
fprintf("  MSE (Median Filter):  %.4f\n", MSE_med_gauss);

%% ---------------------------------------------------------
% 6) Reflections (add to GitHub)
% - Median filter removes salt-and-pepper noise best because it removes outliers.
% - Linear filters (mean, Gaussian) blur edges because they average intensities.
% - Adaptive filters (bilateral, anisotropic diffusion) preserve detail by
%   filtering based on intensity similarity or edge direction.

