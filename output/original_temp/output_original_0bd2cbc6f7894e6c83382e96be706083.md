**Spill Removal Algorithm**

### Problem Description

After chroma-key processing, the input image contains spill from the chroma color. This algorithm aims to remove the spill for arbitrary chroma colors.

### Algorithm Overview

The spill removal algorithm involves the following steps:

1. **Thresholding**: Separate the chroma color from the rest of the image.
2. **Spill Detection**: Identify areas where the chroma color is present but should not be.
3. **Boundary Detection**: Find the boundaries between the chroma color and the rest of the image.
4. **Spill Removal**: Gradually reduce the intensity of the chroma color within the detected boundaries.

### Step-by-Step Algorithm

#### **Thresholding**

- **Step 1**: Convert the input image to the HSV (Hue, Saturation, Value) color space.
- **Step 2**: Set a threshold for the hue value to isolate the chroma color.

#### **Spill Detection**

- **Step 3**: Identify areas where the chroma color is present but should not be. This is typically done by:
  - **Step 3.1**: Applying a threshold to the saturation value to filter out areas with low saturation.
  - **Step 3.2**: Using morphological operations (e.g., dilation and erosion) to refine the detection.

#### **Boundary Detection**

- **Step 4**: Find the boundaries between the chroma color and the rest of the image. This can be achieved by:
  - **Step 4.1**: Applying the Sobel operator to detect edges.
  - **Step 4.2**: Refining the edges using morphological operations.

#### **Spill Removal**

- **Step 5**: Gradually reduce the intensity of the chroma color within the detected boundaries. This can be done by:
  - **Step 5.1**: Applying a gradient filter to reduce the intensity.
  - **Step 5.2**: Adjusting the saturation value to minimize the spill.

### Example Use Case

Suppose we have an image with a chroma color of blue. The algorithm would:

1. **Thresholding**: Convert the image to HSV and set the hue threshold to isolate blue pixels.
2. **Spill Detection**: Apply a saturation threshold and morphological operations to detect areas with blue pixels that should not be.
3. **Boundary Detection**: Use the Sobel operator and morphological operations to find the boundaries between blue pixels and the rest of the image.
4. **Spill Removal**: Apply a gradient filter and adjust the saturation value to minimize the blue spill.

### Code Implementation

```python
import cv2
import numpy as np

def spill_removal(image_path, chroma_color):
    # Load the image
    image = cv2.imread(image_path)

    # Convert to HSV
    hsv_image = cv2.cvtColor(image, cv2.COLOR_BGR2HSV)

    # Thresholding
    lower_chroma = np.array([chroma_color[0] - 10, 100, 100])
    upper_chroma = np.array([chroma_color[0] + 10, 255, 255])
    thresholded_image = cv2.inRange(hsv_image, lower_chroma, upper_chroma)

    # Spill Detection
    kernel = np.ones((3, 3), np.uint8)
    dilated_image = cv2.dilate(thresholded_image, kernel, iterations=2)
    eroded_image = cv2.erode(dilated_image, kernel, iterations=1)

    # Boundary Detection
    grad_x = cv2.Sobel(eroded_image, cv2.CV_8U, 1, 0, ksize=3)
    grad_y = cv2.Sobel(eroded_image, cv2.CV_8U, 0, 1, ksize=3)
    edges = cv2.bitwise_or(grad_x, grad_y)

    # Spill Removal
    reduced_image = cv2.GaussianBlur(image, (5, 5), 0)
    result = cv2.addWeighted(image, 1, reduced_image, 0.5, 0)

    return result

# Example usage
image_path = "input_image.jpg"
chroma_color = (120, 255, 255)  # Blue color in HSV
result = spill_removal(image_path, chroma_color)
cv2.imwrite("output_image.jpg", result)
```

This code implements the spill removal algorithm using OpenCV and NumPy. It takes an image path and a chroma color as input and returns the processed image. The example usage demonstrates how to use the function with a blue chroma color.