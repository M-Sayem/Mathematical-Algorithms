close all; clear; clc;

%% Load image
if exist('peppers.png','file')
    I0 = imread('peppers.png');
else
    I0 = repmat(imread('cameraman.tif'),1,1,3);
end
I = im2double(rgb2gray(I0));
[M,N] = size(I);

%% 1) Magnitude spectrum (log-scale)
F = fft2(I);
Fshift = fftshift(F);
S = log(1 + abs(Fshift));

figure;
subplot(1,2,1); imshow(I,[]); title('Image');
subplot(1,2,2); imshow(S,[]); title('Log-magnitude spectrum (centered)');

%% 2) Ideal & Gaussian Low-pass in frequency
[u,v] = meshgrid(-floor(N/2):ceil(N/2)-1, -floor(M/2):ceil(M/2)-1);
D = sqrt(u.^2 + v.^2);

D0 = 40;                     % Ideal LP cutoff
H_ideal_LP = double(D <= D0);

sigma = 20;
H_gauss_LP = exp(-(D.^2) / (2*sigma^2));

%% 3) Apply LP filters in frequency domain
G_ideal = ifft2(ifftshift(H_ideal_LP .* Fshift));
G_gauss = ifft2(ifftshift(H_gauss_LP .* Fshift));

figure;
montage({I, real(G_ideal), real(G_gauss)}, 'Size', [1 3]);
title('Original | Ideal LP | Gaussian LP');

%% 4) High-pass via complement
H_gauss_HP = 1 - H_gauss_LP;
G_hp = real(ifft2(ifftshift(H_gauss_HP .* Fshift)));
G_hp = mat2gray(G_hp);

figure;
montage({I, G_hp}, 'Size', [1 2]);
title('Original | Gaussian High-pass result');

%% 5) Spatial vs Frequency-domain Gaussian LP
g1d = fspecial('gaussian',[1 7], 1.2);
I_spatial_gauss = imfilter(I, g1d'*g1d, 'replicate');

figure;
montage({I_spatial_gauss, real(G_gauss)}, 'Size', [1 2]);
title('Spatial Gaussian LP | Frequency-domain Gaussian LP');

%% 6) RINGING ILLUSTRATION (Ideal LP vs Gaussian)
% Select a region with strong edges
x_range = 120:170;
y_range = 70:120;

ideal_crop  = real(G_ideal(y_range, x_range));
gauss_crop  = real(G_gauss(y_range, x_range));

figure;
subplot(1,2,1);
imshow(ideal_crop, []);
title('Ideal LP (Ringing visible)');
hold on;
rectangle('Position',[1 1 length(x_range) length(y_range)], 'EdgeColor','r','LineWidth',2);

subplot(1,2,2);
imshow(gauss_crop, []);
title('Gaussian LP (Smooth)');
hold on;
rectangle('Position',[1 1 length(x_range) length(y_range)], 'EdgeColor','g','LineWidth',2);

sgtitle('Zoomed comparison: Ringing vs Smoothness');

%% Optional arrows pointing to ringing oscillations
figure;
imshow(ideal_crop, []);
title('Ringing oscillations (Ideal LP)');
hold on;
annotation('arrow',[0.3 0.4],[0.6 0.5],'Color','r','LineWidth',2);
annotation('arrow',[0.6 0.7],[0.7 0.6],'Color','r','LineWidth',2);
hold off;


