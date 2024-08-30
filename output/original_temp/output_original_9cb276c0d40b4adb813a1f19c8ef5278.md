**Removing Silence from Voice Recordings with Click**

Below is a Python script that uses the Click library to create a command-line tool. This tool removes silence from voice recordings.

### Prerequisites

- **Click**: Install using pip: `pip install click`
- **Pydub**: Install using pip: `pip install pydub`
- **ffmpeg**: Ensure it's installed on your system. You can download it from [here](https://ffmpeg.org/download.html).

### Script

```python
import click
from pydub import AudioSegment
import os

@click.command()
@click.argument('input_file', type=click.Path(exists=True))
@click.option('--output', '-o', type=click.Path(), default='output.wav',
              help='Specify the output file. Defaults to "output.wav".')
def remove_silence(input_file, output):
    """
    Remove silence from a voice recording.

    Args:
        input_file (str): Path to the input voice recording.
        output (str): Path to save the processed recording. Defaults to "output.wav".
    """

    # Load the audio file
    sound = AudioSegment.from_file(input_file)

    # Define the threshold for silence detection
    threshold = 0  # Adjust this value based on your audio

    # Split the audio into chunks
    chunks = []
    new_chunks = []
    for i in range(0, len(sound), 1000):  # Adjust the chunk size as needed
        chunk = sound[i:i+1000]
        chunks.append(chunk)

    # Remove silence from each chunk
    for chunk in chunks:
        # Convert the chunk to float
        chunk_float = np.frombuffer(chunk.raw_data, dtype=np.int16) / 32768.0

        # Find the threshold crossings
        threshold_crossings = np.where(np.abs(chunk_float) > threshold)[0]

        # If there are threshold crossings, add the chunk to the new list
        if len(threshold_crossings) > 0:
            new_chunks.append(chunk)

    # Combine the chunks back into a single audio segment
    new_sound = sum(new_chunks)

    # Export the processed audio
    new_sound.export(output, format="wav")

    click.echo(f"Silence removed from {input_file}. Saved as {output}")

if __name__ == '__main__':
    import numpy as np
    remove_silence()
```

### Usage

1. **Install Requirements**: Ensure you have Click, Pydub, and ffmpeg installed.
2. **Run the Script**: Execute the script with the input file path as an argument.

```bash
python script_name.py input_file.wav
```

- **Output**: The processed audio will be saved in the specified output file path. If no output path is provided, it defaults to "output.wav".

### Notes

- **Threshold Adjustment**: The `threshold` variable controls how much silence is removed. Adjust this value based on your audio to achieve the desired level of silence removal.
- **Chunk Size**: The script splits the audio into chunks of 1000 milliseconds. You can adjust this size as needed for your specific use case.
- **ffmpeg**: Ensure that ffmpeg is installed and accessible on your system.