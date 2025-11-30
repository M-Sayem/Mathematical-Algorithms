% --- 1. Setup: Load an image and add Gaussian noise ---

% Read a sample image and convert to grayscale double format
originalImage = im2double(imread('cameraman.tif'));

% Define the noise standard deviation
noiseSigma = 0.04;

% Add Gaussian noise to the image
noisyImage = imnoise(originalImage, 'gaussian', 0, noiseSigma^2);

% Display the original and noisy images
figure('Name', 'Gaussian Noise Denoising Comparison');
subplot(1, 4, 1); imshow(originalImage); title('Original Image');
subplot(1, 4, 2); imshow(noisyImage); title('Noisy Image');

% --- 2. Traditional Filter (Adaptive Wiener Filter) ---

% Wiener filter adapts to the local variance and performs well with
% additive white Gaussian noise.
traditionalFiltered = wiener2(noisyImage, [5 5], noiseSigma^2);

subplot(1, 4, 3); imshow(traditionalFiltered);
title('Traditional (Wiener) Filter');

% --- 3. AI Filter (Pre-trained DnCNN) ---

% Load pre-trained deep CNN designed for Gaussian denoising
net = denoisingNetwork('DnCNN');

% Apply the deep-learning filter
aiFiltered = denoiseImage(noisyImage, net);

subplot(1, 4, 4); imshow(aiFiltered);
title('AI (DnCNN) Filter');

% --- 4. Quantitative Evaluation (PSNR and SSIM) ---

% Higher PSNR/SSIM = better quality
psnrNoisy = psnr(noisyImage, originalImage);
ssimNoisy = ssim(noisyImage, originalImage);

psnrTraditional = psnr(traditionalFiltered, originalImage);
ssimTraditional = ssim(traditionalFiltered, originalImage);

psnrAI = psnr(aiFiltered, originalImage);
ssimAI = ssim(aiFiltered, originalImage);

% Display metrics
fprintf('\n--- Image Quality Metrics Comparison ---\n');
fprintf('Method                    | PSNR (dB) | SSIM\n');
fprintf('--------------------------|-----------|----------\n');
fprintf('Noisy Image               | %8.4f | %8.4f\n', psnrNoisy, ssimNoisy);
fprintf('Traditional (Wiener)      | %8.4f | %8.4f\n', psnrTraditional, ssimTraditional);
fprintf('AI (DnCNN)                | %8.4f | %8.4f\n', psnrAI, ssimAI);

% --- 5. Visual Observation ---
% DnCNN usually produces the highest PSNR and SSIM.
% It preserves edges and fine details better than traditional filters.
