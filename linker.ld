ENTRY(main)

MEMORY
{
    RAM (rwx) : ORIGIN = 0x00000000, LENGTH = 16M
}

SECTIONS
{
    .text :
    {
        KEEP(*(.init))
        *(.text*)
        *(.rodata*)
        *(.ARM.exidx*)
        KEEP(*(.fini))
    } > RAM

    .data :
    {
        *(.data*)
    } > RAM

    .bss (NOLOAD) :
    {
        __bss_start__ = .;
        *(.bss*)
        *(COMMON)
        __bss_end__ = .;
    } > RAM

    . = ALIGN(8);
    __heap_start__ = .;
    _end = .;
    PROVIDE(end = .);
    . = ORIGIN(RAM) + LENGTH(RAM);
    __stack_top__ = .;
}
