**Converting COCO Format to YOLO Format**

The following Python function converts annotations from the COCO (Common Objects in Context) format to the YOLO (You Only Look Once) format.

### Function Definition

```python
import json

def coco_to_yolo(coco_annotations, image_width, image_height):
    """
    Convert COCO annotations to YOLO format.

    Args:
    - coco_annotations (list): List of COCO annotations.
    - image_width (int): Width of the image.
    - image_height (int): Height of the image.

    Returns:
    - yolo_annotations (list): List of YOLO annotations.
    """

    # Initialize an empty list to store YOLO annotations
    yolo_annotations = []

    # Iterate over each COCO annotation
    for annotation in coco_annotations:
        # Extract relevant information
        image_id = annotation['image_id']
        bbox = annotation['bbox']
        category_id = annotation['category_id']

        # Convert COCO bounding box coordinates to YOLO format
        x, y, w, h = bbox
        x_center = x + w / 2
        y_center = y + h / 2

        # Normalize coordinates to YOLO format
        x_center /= image_width
        y_center /= image_height
        w /= image_width
        h /= image_height

        # Create YOLO annotation
        yolo_annotation = {
            'image_id': image_id,
            'category_id': category_id,
            'bbox': [x_center, y_center, w, h]
        }

        # Append YOLO annotation to the list
        yolo_annotations.append(yolo_annotation)

    return yolo_annotations
```

### Example Usage

```python
# Load COCO annotations from a JSON file
with open('coco_annotations.json') as f:
    coco_annotations = json.load(f)

# Define image dimensions
image_width = 640
image_height = 480

# Convert COCO annotations to YOLO format
yolo_annotations = coco_to_yolo(coco_annotations, image_width, image_height)

# Print YOLO annotations
print(yolo_annotations)
```

This function takes a list of COCO annotations and the image dimensions as input. It converts each COCO annotation to the YOLO format and returns a list of YOLO annotations. The example usage demonstrates how to load COCO annotations from a JSON file, define image dimensions, and convert the annotations to YOLO format.