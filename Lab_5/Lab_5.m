%% Lab 5: Edge Detection and Segmentation
% Course: Mathematical Algorithms (DSP) — Image Processing
% ---------------------------------------------------------

close all; clear; clc;

%% Load image
I = im2double(rgb2gray(imread('peppers.png')));

%% 1) Basic derivative filters (Sobel, Prewitt)
edges_sobel = edge(I,'Sobel');
edges_prewitt = edge(I,'Prewitt');

figure;
montage({edges_sobel, edges_prewitt}, 'Size', [1 2]);
title('Sobel | Prewitt edges');

%% 2) Canny detector (multi-stage)
edges_canny = edge(I,'Canny', [0.05 0.2]);

figure;
imshow(edges_canny);
title('Canny edges');

%% 3) Laplacian of Gaussian (LoG) — zero-crossing method
edges_log = edge(I,'log');

figure;
imshow(edges_log);
title('Laplacian of Gaussian (LoG) edges');

%% 4) Edge map → segmentation (Otsu threshold)
level = graythresh(I);        % Automatic threshold using Otsu
BW = imbinarize(I, level);

figure;
montage({I, BW}, 'Size', [1 2]);
title('Original Image | Otsu Threshold Binary Mask');

%% 5) Label and visualize connected regions
[L, num] = bwlabel(BW);       % Connected components
RGB = label2rgb(L);           % Convert labels to colors

figure;
imshow(RGB);
title(['Labeled Regions: ', num2str(num)]);

%% 6) Reflection notes (fill in your own answers in the report)
% - Which operator gives the thinnest, cleanest edges?
% - Why does Canny outperform simple gradient filters?
% - How does Otsu relate to histogram-based thresholding?
