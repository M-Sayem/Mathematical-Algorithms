% Assignment Code: Hybrid Traditional + AI Pipeline
close all; clear; clc;

% ---------------------------------------------------
% Section 1: Load Image and AI Network
% ---------------------------------------------------
% Load a sample image of a flower (example: peppers.png)
targetImage = imread('peppers.png');

% Load a pre-trained SqueezeNet network for classification
disp('Loading pre-trained AI network (SqueezeNet)...');
net = squeezenet;
disp('Network loaded.');

figure('Name', 'Hybrid Pipeline Images');
subplot(2, 2, 1); imshow(targetImage); title('Original Image');

% ---------------------------------------------------
% Section 2: Traditional Method (Color Segmentation using K-Means)
% ---------------------------------------------------
disp('Applying traditional color segmentation (K-Means)...');

imgLab = rgb2lab(targetImage);
ab = imgLab(:,:,2:3);
ab = im2single(ab);

pixelLabels = imsegkmeans(ab, 2); % Segment into 2 clusters

mask = pixelLabels == 2; % Choose the main object cluster

isolatedObject = targetImage;
isolatedObject(repmat(~mask, 1, 1, 3)) = 0;

subplot(2, 2, 2); imshow(mask); title('Traditional Mask (K-Means)');
subplot(2, 2, 3); imshow(isolatedObject); title('Isolated Object (Input to AI)');

% ---------------------------------------------------
% Section 3: AI Method (Image Classification)
% ---------------------------------------------------
disp('Running AI classification on the isolated object...');

inputSize = net.Layers(1).InputSize;
resizedObject = imresize(isolatedObject, [inputSize(1) inputSize(2)]);

[YPred, probs] = classify(net, resizedObject);

% ---------------------------------------------------
% Section 4: Results Analysis
% ---------------------------------------------------
subplot(2, 2, 4); imshow(resizedObject); title('Resized Input to AI');

fprintf('\n--- Hybrid Pipeline Results ---\n');
fprintf('The AI model classified the isolated object as: **%s**\n', string(YPred));
fprintf('Confidence (Probability): %.2f%%\n', max(probs)*100);

% The idea: isolating the object first using traditional methods
% helps the AI classifier focus only on the target region,
% improving accuracy over using the raw image.
