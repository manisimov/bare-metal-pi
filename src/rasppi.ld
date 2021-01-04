MEMORY
{
    ram : ORIGIN = 0x8000, LENGTH = 0x20000
}

SECTIONS
{

    .text :
    {
        *start.o(.text*) 
        *(.text*)
    } > ram

    .vectors :
    {
        KEEP(*(.vectors))
    } > ram

    .bss : { *(.bss*) } > ram

}
