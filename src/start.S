.section .vectors, "ax"
.globl _vectors
.align 4
_vectors:
    ldr pc, reset_h_addr
    ldr pc, undefined_h_addr
    ldr pc, swi_h_addr
    ldr pc, prefetch_abort_h_addr
    ldr pc, data_abort_h_addr
    ldr pc, irq_h_addr
    ldr pc, fiq_handler_addr
reset_h_addr:           .word default_handler
undefined_h_addr:       .word default_handler
swi_h_addr:             .word default_handler
prefetch_abort_h_addr:  .word default_handler
data_abort_h_addr:      .word default_handler
irq_h_addr:             .word default_handler
fiq_handler_addr:       .word default_handler

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
    ldr r2, =14   /* seven vectors plus addresses of handlers */
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



