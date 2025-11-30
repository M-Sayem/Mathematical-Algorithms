%% tire_stud_detector

clear; clc; close all;

imageFiles = {'studded_tire.jpeg', 'summer_tire.jpg'};

for i = 1:numel(imageFiles)
    
    %% ---------- 1) Read & resize ----------
    I = imread(imageFiles{i});
    I = imresize(I, 0.5);

    if size(I,3) == 3
        Igray = rgb2gray(I);
    else
        Igray = I;
    end

    %% ---------- 2) Enhance studs using tophat filtering ----------
    % Metal studs = small bright objects on darker surface
    se = strel('disk', 8);
    Ienh = imtophat(Igray, se);

    %% ---------- 3) Tire mask (stronger & more accurate) ----------
    % Tire is dark → use adaptive thresholding
    T = adaptthresh(Igray, 0.45);    % slightly higher to avoid rim/background
    tireMask = imbinarize(Igray, T) == 0;  % dark regions are tire

    tireMask = imfill(tireMask, 'holes');
    tireMask = bwareaopen(tireMask, 800);   % reject small dark spots

    %% ---------- 4) Stud candidates ----------
    % Local adaptive threshold for tiny bright metal pieces
    T2 = adaptthresh(Ienh, 0.35);
    cand = imbinarize(Ienh, T2);

    % Only inside tire
    cand = cand & tireMask;

    % Morphological cleaning
    cand = imopen(cand, strel('disk', 2));
    cand = imclose(cand, strel('disk', 2));
    cand = bwareaopen(cand, 5);

    %% ---------- 5) Connected components ----------
    CC = bwconncomp(cand);
    stats = regionprops(CC, Ienh, ...
        'Area', 'Perimeter', 'Eccentricity', 'MeanIntensity');

    studMask = false(size(cand));
    studCount = 0;

    %% ---------- 6) Filter true studs ----------
    for k = 1:numel(stats)
        A = stats(k).Area;
        P = stats(k).Perimeter;
        E = stats(k).Eccentricity;
        Imean = stats(k).MeanIntensity;

        if P == 0, continue; end

        circ = 4*pi*A / (P^2);

        % Updated thresholds (more inclusive)
        if A >= 3 && A <= 150 && circ > 0.45 && E < 0.85 && Imean > 30
            studMask(CC.PixelIdxList{k}) = true;
            studCount = studCount + 1;
        end
    end

    %% ---------- 7) Stud/non-stud decision ----------
    tireArea = sum(tireMask(:));
    density = studCount / tireArea;

    isStudded = (studCount > 15) || (density > 0.00025);

    %% ---------- 8) Visualization ----------
    figure('Name', imageFiles{i});
    subplot(1,3,1);
    imshow(I);
    title(sprintf('Input: %s', imageFiles{i}), 'Interpreter','none');

    subplot(1,3,2);
    imshow(cand);
    title('Candidate Studs (binary)');

    subplot(1,3,3);
    imshow(I); hold on;
    visboundaries(studMask, 'Color','y', 'LineWidth', 1);

    if isStudded
        title(sprintf('STUDDED TIRE (studs detected: %d)', studCount), 'Color','g');
    else
        title(sprintf('SUMMER TIRE (studs detected: %d)', studCount), 'Color','r');
    end

end