ENTRY(Reset_Handler)

MEMORY
{
    /* QEMU mps2-an386:
       ZBT SSRAM1, executable CODE region
       Physical range: 0x00000000 - 0x007FFFFF
       Actual SRAM: 4 MiB, mirrored/wrapped in the 8 MiB region
    */
    FLASH (rx)  : ORIGIN = 0x00000000, LENGTH = 4M

    /* ZBT SSRAM2/3
       Physical range: 0x20000000 - 0x207FFFFF
       Actual SRAM: 4 MiB
    */
    RAM (rwx)   : ORIGIN = 0x20000000, LENGTH = 4M
}

_estack = ORIGIN(RAM) + LENGTH(RAM);

SECTIONS
{
    .isr_vector :
    {
        . = ALIGN(4);
        KEEP(*(.isr_vector))
        . = ALIGN(4);
    } > FLASH

    .text :
    {
        . = ALIGN(4);

        *(.text)
        *(.text*)
        *(.rodata)
        *(.rodata*)

        KEEP(*(.init))
        KEEP(*(.fini))

        . = ALIGN(4);
        _etext = .;
    } > FLASH

    /* Initial values for .data are stored after .text */
    _sidata = LOADADDR(.data);

    .data :
    {
        . = ALIGN(4);
        _sdata = .;

        *(.data)
        *(.data*)

        . = ALIGN(4);
        _edata = .;
    } > RAM AT > FLASH

    .bss :
    {
        . = ALIGN(4);
        _sbss = .;

        *(.bss)
        *(.bss*)
        *(COMMON)

        . = ALIGN(4);
        _ebss = .;
    } > RAM

    .heap :
    {
        . = ALIGN(8);
        _heap_start = .;
    } > RAM

    _end = .;
}

