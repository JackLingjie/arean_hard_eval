**Using CSS Flexbox to Position an Image with a Paragraph**

To place an image on the same line as a paragraph and have the paragraph automatically format itself around the top and bottom of the picture, follow these steps:

### Step 1: **Wrap the Image and Paragraph in a Container**

First, wrap the image and paragraph in a container element. This will help you apply the flexbox layout.

```html
<div class="container">
  <img src="image.jpg" alt="Image Description">
  <p>This is a paragraph of text.</p>
</div>
```

### Step 2: **Apply Flexbox Styles**

Apply the following styles to the container:

```css
.container {
  display: flex;
  align-items: center; /* Centers the paragraph vertically */
  gap: 10px; /* Adds a gap between the image and paragraph */
}
```

### Step 3: **Optional: Adjust the Image Size**

If you want to adjust the image size, you can add the following styles:

```css
img {
  width: 100px; /* Adjust the image width */
  height: auto; /* Maintains the image aspect ratio */
}
```

### Step 4: **Optional: Add a Maximum Width**

To prevent the container from expanding too wide, you can add a maximum width:

```css
.container {
  max-width: 800px; /* Adjust the maximum width */
}
```

### Example Use Case

Here's an example use case:

```html
<div class="container">
  <img src="image.jpg" alt="Image Description">
  <p>This is a paragraph of text. It will automatically format itself around the top and bottom of the picture.</p>
</div>
```

```css
.container {
  display: flex;
  align-items: center;
  gap: 10px;
}

img {
  width: 100px;
  height: auto;
}

.container {
  max-width: 800px;
}
```

This will create a layout where the image and paragraph are on the same line, with the paragraph automatically formatting itself around the top and bottom of the picture.