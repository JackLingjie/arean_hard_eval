**Hamiltonian for a Damped Oscillator**

The equation of motion for a damped oscillator is given by:

\[
\ddot{x} + 2\lambda \dot{x} + \Omega^2 x = 0
\]

To derive the Hamiltonian for this system, we introduce an auxiliary variable $p$ such that:

\[
p = \dot{x}
\]

This allows us to rewrite the equation of motion in terms of $x$ and $p$:

\[
\dot{p} = -\Omega^2 x - 2\lambda p
\]

\[
\dot{x} = p
\]

### Hamiltonian

The Hamiltonian for this system can be expressed as:

\[
H(x, p) = \frac{p^2}{2} + \frac{\Omega^2 x^2}{2} + \frac{p^2 \lambda}{\Omega^2}
\]

This Hamiltonian includes the kinetic energy term $\frac{p^2}{2}$, the potential energy term $\frac{\Omega^2 x^2}{2}$, and an additional term $\frac{p^2 \lambda}{\Omega^2}$ that accounts for the damping.

### Key Points

- **Damping**: The term $\frac{p^2 \lambda}{\Omega^2}$ represents the effect of damping on the system.
- **Non-conservative System**: The presence of the damping term indicates that this system is non-conservative.

### Example Use Case

This Hamiltonian can be used to study the behavior of a damped oscillator under various conditions. For instance, you can analyze how the damping coefficient $\lambda$ affects the system's dynamics.

### Code Implementation

```python
import numpy as np

def hamiltonian(x, p, Omega, lambda_):
    """
    Calculate the Hamiltonian for a damped oscillator.

    Parameters:
    x (float): Position
    p (float): Momentum
    Omega (float): Angular frequency
    lambda_ (float): Damping coefficient

    Returns:
    float: The Hamiltonian value
    """
    return 0.5 * p**2 + 0.5 * Omega**2 * x**2 + 0.5 * p**2 * lambda_ / Omega**2

# Example usage
x = 1.0  # Position
p = 2.0  # Momentum
Omega = 3.0  # Angular frequency
lambda_ = 0.5  # Damping coefficient

H = hamiltonian(x, p, Omega, lambda_)
print("Hamiltonian:", H)
```

This code defines a function `hamiltonian` that calculates the Hamiltonian value given the position `x`, momentum `p`, angular frequency `Omega`, and damping coefficient `lambda_`. The example usage demonstrates how to call this function with specific values.