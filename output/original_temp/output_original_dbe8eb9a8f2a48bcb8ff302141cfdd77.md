To get the Cartesian product of two arrays in JAX, you can use the `jax.lax.scan` function or the `np.meshgrid` function from the NumPy library, which is compatible with JAX.

### Method 1: Using `np.meshgrid`

First, ensure you have imported the necessary libraries:

```python
import jax.numpy as jnp
import numpy as np
```

Then, you can compute the Cartesian product as follows:

```python
# Define two arrays
array1 = jnp.array([1, 2])
array2 = jnp.array(['a', 'b'])

# Compute the Cartesian product
cartesian_product = jnp.stack(np.meshgrid(array1, array2), axis=-1).reshape(-1, 2)

print(cartesian_product)
```

### Method 2: Using `jax.lax.scan`

Here's how you can achieve the same result using `jax.lax.scan`:

```python
import jax.numpy as jnp

# Define two arrays
array1 = jnp.array([1, 2])
array2 = jnp.array(['a', 'b'])

# Compute the Cartesian product
def cartesian_product_scan(init, xs):
    """Compute the Cartesian product using lax.scan."""
    ys, _ = xs
    return jnp.stack([init, ys], axis=-1)

cartesian_product = jax.lax.scan(cartesian_product_scan, jnp.array([0]), (array1, array2))[0]

print(cartesian_product)
```

### Explanation

- **Method 1**: This method uses `np.meshgrid` to create a grid of coordinates. It then stacks these coordinates along the last axis and reshapes the result to obtain the Cartesian product.

- **Method 2**: This method uses `jax.lax.scan` to iterate over the elements of `array1` and `array2`. It accumulates the Cartesian product by stacking the current element of `array1` with each element of `array2`.

Both methods produce the same result: the Cartesian product of the two input arrays.