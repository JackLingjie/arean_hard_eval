**ARM Assembly Program: Adding Elements in an Array**

### Overview

This program uses the stack frame concept to implement a program that adds 150 numbers. It utilizes the `memorygenerate` macro to create an array of numbers from 1 to 150.

### Instructions

1. **Subroutine to Add Two Last Pushed Values**

   - **`addsubroutine`**: A subroutine that adds the two last pushed values in the stack and stores the result in the location of the second value.

   ```assembly
   .text
   .global addsubroutine
   addsubroutine:
       # Pop the top two values from the stack
       ldr r0, [sp]  # Load the top value into r0
       add sp, #4     # Move the stack pointer up by 4 bytes

       ldr r1, [sp]  # Load the second value into r1
       add sp, #4     # Move the stack pointer up by 4 bytes

       # Add the two values
       add r0, r0, r1

       # Store the result in the location of the second value
       str r0, [sp]

       bx lr          # Return from subroutine
   ```

2. **Generate Array Using `memorygenerate` Macro**

   - **`myArray`**: An array of numbers from 1 to 150.

   ```assembly
   .data
   .align 4
   myArray: .space 600

   .text
   .global main
   main:
       memorygenerate myArray, 150
   ```

3. **Program to Add Elements in the Array**

   - **`sumOfarray`**: The total sum of elements in `myArray`.

   ```assembly
   .data
   .align 4
   sumOfarray: .word 0

   .text
   .global main
   main:
       # Initialize the stack pointer
       mov sp, #0x8000

       # Push the initial value of sumOfarray onto the stack
       ldr r0, =sumOfarray
       str r0, [sp]

       # Call the addsubroutine for each element in myArray
       ldr r0, =myArray
       mov r1, #150
   loop\@:
       # Load the current element into r2
       ldr r2, [r0]

       # Push the current element and the sum onto the stack
       str r2, [sp]
       add sp, #4

       # Call the addsubroutine
       bl addsubroutine

       # Move the stack pointer back down
       add sp, #4

       # Increment the pointer to the next element
       add r0, #4

       # Decrement the loop counter
       sub r1, #1

       # Check if the loop is complete
       cmp r1, #0
       ble loop\@

       # The final sum is now in the location of the second value
       # on the stack. Load it into sumOfarray.
       ldr r0, [sp]
       str r0, =sumOfarray

       # Return from main
       bx lr
   ```

### Example Use Case

- Compile the program using the ARM compiler.
- Run the program to generate the array and calculate the sum.
- Verify that the sum is correct.

### Notes

- This program uses the stack to store temporary values.
- The `addsubroutine` is used to add two values and store the result.
- The `memorygenerate` macro is used to create the array.
- The program initializes the stack pointer and pushes the initial value of `sumOfarray` onto the stack.
- It then calls the `addsubroutine` for each element in `myArray`.
- After the loop, the final sum is loaded into `sumOfarray`.