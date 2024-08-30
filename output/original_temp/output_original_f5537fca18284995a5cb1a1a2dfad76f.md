**Audio to Image Conversion**

This code reads an audio file, normalizes its waveform values, and generates an image with horizontal bands representing each sample.

### Prerequisites

- Install the required libraries:
  ```bash
  pip install numpy scikit-learn Pillow
  ```

### Code

```python
import numpy as np
from PIL import Image
from scipy.io import wavfile

def audio_to_image(audio_file):
    """
    Convert an audio file into an image.

    Args:
    - audio_file (str): Path to the audio file.

    Returns:
    - image (PIL Image): The generated image.
    """

    # Read the audio file
    sample_rate, audio = wavfile.read(audio_file)

    # Ensure the audio is in 16-bit format
    if audio.dtype.kind != 'i':
        audio = audio.astype(np.int16)

    # Normalize the audio waveform values to the range 0-255
    normalized_audio = (audio / np.max(np.abs(audio))) * 255

    # Convert normalized audio to integers
    normalized_audio = normalized_audio.astype(np.uint8)

    # Create an image with horizontal bands for each sample
    image_height = len(normalized_audio)
    image_width = 1  # Since we're dealing with mono audio
    image = Image.new('L', (image_width, image_height))  # 'L' mode for grayscale

    # Paste each sample into the image
    for i, value in enumerate(normalized_audio):
        image.putpixel((0, i), value)

    return image

# Example usage
audio_file_path = 'path_to_your_audio_file.wav'
image = audio_to_image(audio_file_path)
image.show()
```

### Explanation

1. **Import Libraries**: The code starts by importing the necessary libraries: `numpy` for numerical operations, `PIL` (Python Imaging Library) for image manipulation, and `scipy.io.wavfile` for reading audio files.

2. **Function Definition**: The `audio_to_image` function takes the path to an audio file as input.

3. **Read Audio File**: It reads the audio file using `wavfile.read`, which returns the sample rate and the audio data.

4. **Normalize Audio**: The audio waveform values are normalized to the range 0-255 by dividing by the maximum absolute value and multiplying by 255.

5. **Create Image**: An image is created with the height equal to the number of samples in the audio and a width of 1 (since we're dealing with mono audio). The image mode is set to 'L' for grayscale.

6. **Paste Samples into Image**: Each sample is pasted into the image at its corresponding position.

7. **Example Usage**: Finally, an example usage is shown where an image is generated from an audio file and displayed.

This code provides a straightforward way to convert an audio file into an image, useful for visualizing audio data.