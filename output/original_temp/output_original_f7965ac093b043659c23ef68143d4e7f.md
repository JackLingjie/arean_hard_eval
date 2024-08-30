**Recurrent Neural Network (RNN) Implementation in TypeScript**

### Overview

This implementation provides a basic structure for a Recurrent Neural Network (RNN) using plain TypeScript. It includes the following components:

- **RNN**: The main class representing the RNN.
- **Neuron**: A basic class for a neuron in the network.
- **Activation Functions**: Implementations of common activation functions used in neural networks.

### Activation Functions

#### Sigmoid Function

```typescript
/**
 * Sigmoid activation function.
 *
 * @param x Input value.
 * @returns The output of the sigmoid function.
 */
function sigmoid(x: number): number {
  return 1 / (1 + Math.exp(-x));
}
```

#### Derivative of Sigmoid Function

```typescript
/**
 * Derivative of the sigmoid function.
 *
 * @param x Input value.
 * @returns The derivative of the sigmoid function.
 */
function sigmoidDerivative(x: number): number {
  return x * (1 - x);
}
```

#### Tanh Function

```typescript
/**
 * Hyperbolic tangent (tanh) activation function.
 *
 * @param x Input value.
 * @returns The output of the tanh function.
 */
function tanh(x: number): number {
  return Math.tanh(x);
}
```

#### Derivative of Tanh Function

```typescript
/**
 * Derivative of the hyperbolic tangent (tanh) function.
 *
 * @param x Input value.
 * @returns The derivative of the tanh function.
 */
function tanhDerivative(x: number): number {
  return 1 - x ** 2;
}
```

### Neuron Class

```typescript
/**
 * Basic neuron class.
 */
class Neuron {
  private weights: number[];
  private bias: number;

  /**
   * Initializes a new instance of the Neuron class.
   *
   * @param numInputs The number of inputs.
   */
  constructor(numInputs: number) {
    this.weights = new Array(numInputs).fill(0).map(() => Math.random() - 0.5);
    this.bias = Math.random() - 0.5;
  }

  /**
   * Calculates the output of the neuron.
   *
   * @param inputs The input values.
   * @returns The output of the neuron.
   */
  calculateOutput(inputs: number[]): number {
    let sum = 0;
    for (let i = 0; i < inputs.length; i++) {
      sum += inputs[i] * this.weights[i];
    }
    sum += this.bias;
    return sigmoid(sum);
  }

  /**
   * Calculates the derivative of the neuron's output.
   *
   * @param inputs The input values.
   * @returns The derivative of the neuron's output.
   */
  calculateDerivative(inputs: number[]): number {
    let sum = 0;
    for (let i = 0; i < inputs.length; i++) {
      sum += inputs[i] * this.weights[i] * sigmoidDerivative(this.calculateOutput(inputs));
    }
    sum += sigmoidDerivative(this.calculateOutput(inputs)) * this.bias;
    return sum;
  }
}
```

### RNN Class

```typescript
/**
 * Recurrent Neural Network (RNN) class.
 */
class RNN {
  private neurons: Neuron[];

  /**
   * Initializes a new instance of the RNN class.
   *
   * @param numInputs The number of inputs.
   * @param numHidden The number of hidden neurons.
   */
  constructor(numInputs: number, numHidden: number) {
    this.neurons = new Array(numHidden).fill(0).map(() => new Neuron(numInputs));
  }

  /**
   * Calculates the output of the RNN.
   *
   * @param inputs The input values.
   * @returns The output of the RNN.
   */
  calculateOutput(inputs: number[]): number[] {
    let hiddenStates = new Array(this.neurons.length).fill(0);
    for (let i = 0; i < this.neurons.length; i++) {
      hiddenStates[i] = this.neurons[i].calculateOutput(inputs);
    }
    return hiddenStates;
  }

  /**
   * Calculates the derivative of the RNN's output.
   *
   * @param inputs The input values.
   * @returns The derivative of the RNN's output.
   */
  calculateDerivative(inputs: number[]): number[] {
    let derivatives = new Array(this.neurons.length).fill(0);
    for (let i = 0; i < this.neurons.length; i++) {
      derivatives[i] = this.neurons[i].calculateDerivative(inputs);
    }
    return derivatives;
  }
}
```

### Example Usage

```typescript
// Create an instance of the RNN class.
const rnn = new RNN(2, 3);

// Define the input values.
const inputs = [1, 2];

// Calculate the output of the RNN.
const output = rnn.calculateOutput(inputs);

// Calculate the derivative of the RNN's output.
const derivative = rnn.calculateDerivative(inputs);

console.log("Output:", output);
console.log("Derivative:", derivative);
```

This implementation provides a basic structure for a Recurrent Neural Network (RNN) using plain TypeScript. It includes the necessary components for calculating the output and derivative of the RNN. The example usage demonstrates how to create an instance of the RNN class, define input values, and calculate the output and derivative.