.section .vectors, "ax"
.globl _vectors
.align 4
_vectors:
    ldr pc, default_handler_addr
    ldr pc, default_handler_addr
    ldr pc, default_handler_addr
    ldr pc, default_handler_addr
    ldr pc, default_handler_addr
    ldr pc, default_handler_addr
    ldr pc, default_handler_addr
default_handler_addr:
    .word default_handler

.section .text
.globl _start
_start:
    mov sp,#0x8000
    /* r0 destination base address,
     * r1 source base address,
     * r2 words to copy, index
     * r3 temp register 
    */
    ldr r0, =0x0
    ldr r1, =_vectors
    ldr r2, =8   /* seven vectors plus word with default handler address */
vectors_copy_loop:
    subs r2, r2, #1
    ldr r3, [r1, r2, LSL #2]
    str r3, [r0, r2, LSL #2]
    bne vectors_copy_loop
    swi 2
loop: b loop

default_handler:
    nop
    bl main



