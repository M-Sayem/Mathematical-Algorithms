# Lab 5 — Edge Detection and Segmentation

**Course:** Mathematical Algorithms (DSP) — Image Processing  
**Topic:** Edge detection, gradients, zero-crossings, Otsu thresholding, segmentation  

This lab explores how edges correspond to high-frequency components in images and implements gradient-based, zero-crossing edge detection, and segmentation using Otsu’s method.

---

## 1. Edges and High-Frequency Components

Edges correspond to **rapid intensity changes**, which are high-frequency components.  
Derivative operators highlight these changes for easier edge detection.

---

## 2. Gradient-Based Edge Detection

**Sobel and Prewitt operators** approximate the gradient magnitude:

- **Sobel:** Adds smoothing, slightly cleaner edges.
- **Prewitt:** Simpler, more sensitive to noise.

---

## 3. Canny Edge Detector

Multi-stage method:

1. Gaussian smoothing  
2. Gradient magnitude and direction  
3. Non-maximum suppression  
4. Hysteresis thresholding  

**Produces thin, continuous edges and suppresses noise effectively.**

---

## 4. Laplacian of Gaussian (LoG) — Zero-Crossing

Detects edges as zero-crossings of the second derivative.  
Captures fine detail but can be noise-sensitive.

---

## 5. Otsu's Automatic Thresholding

Automatically selects a global threshold to **maximize separation between background and foreground**.  
Useful for simple segmentation based on intensity histograms.

---

## 6. Labeling and Visualizing Segmented Regions

Connected components in the binarized image are labeled and color-coded for visualization.

---

## 7. Reflections

- **Thinnest, cleanest edges:** Canny  
- **Why Canny outperforms gradient filters:** Smoothing, accurate gradients, non-maximum suppression, edge linking  
- **Otsu and histogram thresholding:** Chooses the threshold that maximizes between-class variance
