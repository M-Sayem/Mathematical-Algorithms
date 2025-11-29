# Lab 4 — Noise and Filtering  
**Course:** Mathematical Algorithms (DSP) — Image Processing  
**Topic:** Noise modelling, MSE/SNR evaluation, linear & nonlinear filtering  

This lab investigates the effects of Gaussian and salt-and-pepper noise on an image, computes quality metrics, and compares filtering methods such as mean, Gaussian, and median filtering.

---

## 1. Adding Noise (Gaussian and Salt-and-Pepper)

Two types of noise were added to the grayscale *peppers* image:

- **Gaussian noise** (mean = 0, variance = 0.01)  
- **Salt-and-pepper (S&P) noise** with density 0.05  

**Observation:**  
Gaussian noise produces fine grain across the image, while S&P noise creates strong black and white impulse spikes.

**Screenshot:**  
*Insert: Original | Gaussian | S&P noise montage*

---

## 2. Quality Metrics (MSE and SNR)

The following values were computed using MATLAB:

### **Measured Results**
| Noise Type | MSE | SNR (dB) |
|------------|-------------|-----------|
| Gaussian | **0.0096** | **11.5114 dB** |
| Salt & Pepper | **0.0158** | **9.3372 dB** |

**Interpretation:**
- S&P noise has **higher MSE** → it distorts pixel values more heavily.
- Gaussian noise has **higher SNR** → it is less visually disruptive.

**Screenshot:**  
*Insert MATLAB command window text*

---

## 3. Linear Filtering (Mean & Gaussian Filters)

Two linear smoothing filters were applied:

### **Mean Filter (3×3 average)**
- Reduces Gaussian noise modestly  
- Performs poorly on removing impulse noise  
- Produces noticeable blurring

### **Gaussian Filter (σ = 0.7)**
- Best suited to Gaussian noise  
- Smoother and less harsh than the mean filter  
- Still ineffective for salt-and-pepper impulse pixels  

**Screenshot:**  
*Insert filtered image montage*

---

## 4. Nonlinear Filtering (Median Filter)

The median filter was applied using a 3×3 window.

**Why median?**  
It removes isolated spikes (S&P noise) while preserving edges, unlike linear filters which blur boundaries.

**Screenshot:**  
*Insert Avg vs Median comparison (Gaussian & S&P)*

---

## 5. Filter Performance — MSE After Filtering

### **Salt-and-Pepper Noise**
| Filter | MSE |
|--------|--------|
| Average Filter | **0.0021** |
| Median Filter | **0.0001** |

**Conclusion:**  
Median filtering is **vastly better** for impulse noise.  
Average filtering reduces some noise but leaves many impulse pixels and blurs edges.

---

### **Gaussian Noise**
| Filter | MSE |
|--------|--------|
| Average Filter | **0.0013** |
| Median Filter | **0.0019** |

**Conclusion:**  
The **average filter performs better** than the median filter for Gaussian noise.  
Median filtering is not designed for Gaussian statistics, so it performs slightly worse.

---

## 6. Reflections

### **Which noise is best removed by the median filter? Why?**  
Salt-and-pepper noise is best removed by the median filter because the noise appears as isolated 0/1 spikes. The median operator eliminates outliers while preserving edges.

---

### **Why does linear filtering blur edges?**  
Linear filters (mean, Gaussian) compute averages of neighboring pixels. Edges are high-frequency features, and averaging suppresses high-frequency content, causing noticeable blur.


