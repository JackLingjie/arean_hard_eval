**Using Jetpack Compose with Container Queries**

In traditional Android development, `Container Queries` are not directly available. However, you can achieve similar behavior using Jetpack Compose's layout capabilities.

### Step 1: Define the Composable Function

First, define a composable function that will serve as the container. This function will take a `Modifier` parameter to apply layout constraints.

```kotlin
@Composable
fun Container(
    modifier: Modifier = Modifier,
    content: @Composable () -> Unit
) {
    Box(
        modifier = modifier
            .fillMaxWidth()
            .height(IntrinsicSize.Max)
    ) {
        content()
    }
}
```

### Step 2: Create a Composable Child

Next, create a composable child that will adapt its size and position based on the available space.

```kotlin
@Composable
fun AdaptableChild(
    modifier: Modifier = Modifier,
    content: @Composable () -> Unit
) {
    Box(
        modifier = modifier
            .fillMaxWidth()
            .height(IntrinsicSize.Max)
    ) {
        content()
    }
}
```

### Step 3: Use the Composable Child Inside the Container

Now, use the `AdaptableChild` inside the `Container` composable.

```kotlin
@Composable
fun Example() {
    Container {
        AdaptableChild {
            // Your content here
            Text("Adaptable Child")
        }
    }
}
```

### Step 4: Apply Layout Constraints

To make the child adapt to the available space, apply layout constraints.

```kotlin
@Composable
fun Example() {
    Container {
        AdaptableChild {
            // Your content here
            Text("Adaptable Child")
        }
    }
}

// Apply layout constraints
@Composable
fun Example() {
    Container {
        AdaptableChild(
            modifier = Modifier
                .fillMaxWidth()
                .height(IntrinsicSize.Max)
        ) {
            // Your content here
            Text("Adaptable Child")
        }
    }
}
```

### Example Use Cases

- **Vertical Layout**: Use `fillMaxWidth()` and `IntrinsicSize.Max` for the height to make the child adapt to the available vertical space.

- **Horizontal Layout**: Use `fillMaxHeight()` and `IntrinsicSize.Max` for the width to make the child adapt to the available horizontal space.

### Conclusion

By using Jetpack Compose's layout capabilities, you can create composables that adapt to the available space, similar to container queries in web development. This approach allows for flexible and responsive UI design.