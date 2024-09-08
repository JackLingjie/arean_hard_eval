Here is a Python implementation of the program to find the common elements in two arrays without using any extra data structures:

```python
def find_common_elements(arr1, arr2):
    i = 0
    j = 0
    while i < len(arr1) and j < len(arr2):
        if arr1[i] < arr2[j]:
            i += 1
        elif arr1[i] > arr2[j]:
            j += 1
        else:
            print(arr1[i])
            i += 1
            j += 1

arr1 = [1, 2, 3, 4, 5]
arr2 = [4, 5, 6, 7, 8]
find_common_elements(arr1, arr2)
```

This program uses two pointers, `i` and `j`, to iterate through the elements of the two arrays. It compares the elements at the current positions of the pointers and moves the pointer that points to the smaller element forward. If the elements are equal, it prints the element and moves both pointers forward. This process continues until one of the pointers reaches the end of its respective array.