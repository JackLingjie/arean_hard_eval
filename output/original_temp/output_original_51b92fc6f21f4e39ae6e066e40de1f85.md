**Reverb Effect using Kotlin JNI**

This example demonstrates how to add a reverb effect to microphone audio using Kotlin's Java Native Interface (JNI).

### Prerequisites

- **Kotlin**: Ensure you have Kotlin installed in your project.
- **JNI**: Familiarize yourself with the basics of Java Native Interface.

### Step 1: **Setup**

First, create a Kotlin project and add the necessary dependencies.

### Step 2: **Native Library**

Create a native library to handle the audio processing.

#### `ReverbNative.kt`

```kotlin
// ReverbNative.kt

import kotlin.native.concurrent.Worker

// Define the native library
native-lib {
    // Load the native library
    fun loadLibrary(): NativeLibrary {
        return NativeLibrary.find("reverb")
    }

    // Define the native function
    fun addReverb(
        inputBuffer: ShortArray,
        outputBuffer: ShortArray,
        sampleRate: Int,
        reverbLevel: Float
    ): ShortArray {
        // Call the native function
        val result = nativeCall("addReverb", inputBuffer, outputBuffer, sampleRate, reverbLevel)
        return result
    }
}
```

### Step 3: **Native Function Implementation**

Implement the native function in C++.

#### `reverb.cpp`

```cpp
// reverb.cpp

#include <jni.h>
#include <android/log.h>

// Define the native function
JNIEXPORT jshortArray JNICALL Java_ReverbNative_addReverb(
    JNIEnv* env,
    jobject obj,
    jshortArray inputBuffer,
    jshortArray outputBuffer,
    jint sampleRate,
    jfloat reverbLevel
) {
    // Get the input and output buffers
    jshort* input = env->GetShortArrayElements(inputBuffer, NULL);
    jshort* output = env->GetShortArrayElements(outputBuffer, NULL);

    // Apply reverb effect
    for (int i = 0; i < inputBuffer->length; i++) {
        // Simple reverb implementation: add a delay and fade
        output[i] = input[i] + (int)(reverbLevel * input[i - 1]);
    }

    // Release the input and output buffers
    env->ReleaseShortArrayElements(inputBuffer, input, 0);
    env->ReleaseShortArrayElements(outputBuffer, output, 0);

    // Return the output buffer
    jshortArray result = env->NewShortArray(outputBuffer->length);
    env->SetShortArrayRegion(result, 0, outputBuffer->length, output);
    return result;
}
```

### Step 4: **Kotlin Integration**

Integrate the native library with Kotlin.

#### `Reverb.kt`

```kotlin
// Reverb.kt

import kotlin.native.concurrent.Worker

// Define the reverb class
class Reverb(
    private val sampleRate: Int,
    private val reverbLevel: Float
) {
    // Apply reverb effect
    fun addReverb(inputBuffer: ShortArray): ShortArray {
        // Load the native library
        val nativeLib = NativeLibrary.find("reverb")

        // Create a new output buffer
        val outputBuffer = ShortArray(inputBuffer.size)

        // Call the native function
        val result = nativeLib.addReverb(inputBuffer, outputBuffer, sampleRate, reverbLevel)

        // Return the output buffer
        return result
    }
}
```

### Step 5: **Example Usage**

Use the `Reverb` class to apply the reverb effect.

#### `MainActivity.kt`

```kotlin
// MainActivity.kt

import android.media.AudioFormat
import android.media.AudioRecord
import android.media.MediaRecorder
import android.os.Bundle
import android.util.Log
import androidx.appcompat.app.AppCompatActivity

class MainActivity : AppCompatActivity() {
    // Define the reverb level
    private val reverbLevel = 0.5f

    // Define the sample rate
    private val sampleRate = 44100

    // Define the buffer size
    private val bufferSize = 1024

    // Define the audio record object
    private lateinit var audioRecord: AudioRecord

    // Define the reverb object
    private lateinit var reverb: Reverb

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        // Initialize the reverb object
        reverb = Reverb(sampleRate, reverbLevel)

        // Initialize the audio record object
        audioRecord = AudioRecord(
            MediaRecorder.AudioSource.MIC,
            sampleRate,
            AudioFormat.CHANNEL_IN_MONO,
            AudioFormat.ENCODING_PCM_16BIT,
            bufferSize
        )

        // Start recording
        audioRecord.startRecording()

        // Create a new thread to process the audio
        Thread {
            while (true) {
                // Read the audio buffer
                val buffer = ShortArray(bufferSize)
                audioRecord.read(buffer, bufferSize)

                // Apply the reverb effect
                val outputBuffer = reverb.addReverb(buffer)

                // Log the output buffer
                Log.d("Reverb", "Output Buffer: $outputBuffer")
            }
        }.start()
    }
}
```

This example demonstrates how to add a reverb effect to microphone audio using Kotlin's Java Native Interface (JNI). The `Reverb` class applies a simple reverb effect by adding a delay and fading the input signal. The `MainActivity` class initializes the `Reverb` object and starts recording audio using the `AudioRecord` class. The recorded audio is then processed in a new thread, applying the reverb effect using the `addReverb` function.