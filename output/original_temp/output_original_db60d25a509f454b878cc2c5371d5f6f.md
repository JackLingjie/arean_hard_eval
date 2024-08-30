**Allocating Space on the Stack in x86-64 NASM Assembly**

To allocate space on the stack for local variables in x86-64 NASM assembly, you can use the `sub` instruction. This instruction subtracts a value from the stack pointer (`rsp` register), effectively reserving space on the stack.

### Example

```nasm
; Allocate space for a local variable
; Assume we want to reserve space for an integer variable

; Save the current stack pointer value
push rbp
mov rbp, rsp

; Reserve space for the local variable
sub rsp, 8  ; Reserve 8 bytes (size of an integer)

; Use the local variable...
mov eax, 10  ; Example: store the value 10 in the local variable

; Clean up
mov rsp, rbp  ; Restore the original stack pointer
pop rbp       ; Restore the original base pointer
```

### Key Points:

- **`push rbp`**: Saves the current value of the `rbp` register on the stack.
- **`mov rbp, rsp`**: Copies the current stack pointer (`rsp`) to `rbp`, establishing a new stack frame.
- **`sub rsp, 8`**: Allocates space for the local variable by subtracting 8 bytes from the stack pointer (`rsp`). This is equivalent to reserving space for an integer variable.
- **`mov eax, 10`**: An example of using the local variable. In this case, it stores the value 10 in the local variable.
- **`mov rsp, rbp`**: Restores the original stack pointer value.
- **`pop rbp`**: Restores the original base pointer value.

### Best Practices:

- Always establish a new stack frame with `push rbp` and `mov rbp, rsp`.
- Use `sub rsp, <size>` to allocate space for local variables.
- Clean up by restoring the original stack pointer and base pointer values.

### Example Use Case:

```nasm
section .text
global _start

_start:
    ; Allocate space for a local variable
    push rbp
    mov rbp, rsp
    sub rsp, 8  ; Reserve space for an integer variable

    ; Use the local variable
    mov eax, 10  ; Store the value 10 in the local variable

    ; Clean up
    mov rsp, rbp
    pop rbp

    ; Exit the program
    mov rax, 60  ; sys_exit
    xor rdi, rdi  ; Return code 0
    syscall
```

This example demonstrates how to allocate space on the stack for a local variable and use it. It also shows how to clean up after using the local variable.