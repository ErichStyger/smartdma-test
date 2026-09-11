/* M33 */
/*
mps2-an505   Cortex-M33, AN505
mps2-an521   dual Cortex-M33, AN521

an505:
0x00000000 - 0x0DFFFFFF   Non-secure CODE
0x10000000 - 0x1DFFFFFF   Secure CODE alias

0x20000000 - 0x20FFFFFF   Internal SRAM address space
0x30000000 - 0x30FFFFFF   Secure SRAM alias

0x40000000 - 0x4FFFFFFF   Non-secure peripherals
0x50000000 - 0x5FFFFFFF   Secure peripheral aliases
*/

/* mps2-an505.ld
 *
 * QEMU machine:
 *   qemu-system-arm -M mps2-an505
 *
 * Cortex-M33 / ARMv8-M
 */

ENTRY(Reset_Handler)

MEMORY
{
    /*
     * SSRAM0
     *
     * QEMU:
     *   0x00000000 - 0x003FFFFF
     *   4 MiB
     *
     * Normally used for vector table and program code.
     */
    CODE (rx) :
        ORIGIN = 0x00000000,
        LENGTH = 4M

    /*
     * SSRAM1 + SSRAM2
     *
     * SSRAM1:
     *   0x28000000 - 0x281FFFFF
     *
     * SSRAM2:
     *   0x28200000 - 0x283FFFFF
     *
     * They are contiguous, so use them as one 4 MiB region.
     */
    RAM (rwx) :
        ORIGIN = 0x28000000,
        LENGTH = 4M
}


/* Initial stack pointer */
_estack = ORIGIN(RAM) + LENGTH(RAM);


SECTIONS
{
    /*
     * Cortex-M vector table.
     * Must be first in the image.
     */
    .isr_vector :
    {
        . = ALIGN(4);
        KEEP(*(.isr_vector))
        . = ALIGN(4);
    } > CODE


    /*
     * Program code and constants
     */
    .text :
    {
        . = ALIGN(4);

        *(.text)
        *(.text*)

        KEEP(*(.init))
        KEEP(*(.fini))

        *(.rodata)
        *(.rodata*)

        . = ALIGN(4);
        _etext = .;
    } > CODE


    /*
     * Exception unwinding sections, useful when linking
     * with some GCC libraries.
     */
    .ARM.extab :
    {
        *(.ARM.extab* .gnu.linkonce.armextab.*)
    } > CODE

    .ARM.exidx :
    {
        __exidx_start = .;
        *(.ARM.exidx* .gnu.linkonce.armexidx.*)
        __exidx_end = .;
    } > CODE


    /*
     * Initial data values are stored in CODE.
     */
    _sidata = LOADADDR(.data);

    .data :
    {
        . = ALIGN(4);

        _sdata = .;

        *(.data)
        *(.data*)

        . = ALIGN(4);

        _edata = .;
    } > RAM AT > CODE


    /*
     * Zero-initialized data
     */
    .bss :
    {
        . = ALIGN(4);

        _sbss = .;
        __bss_start__ = .;

        *(.bss)
        *(.bss*)
        *(COMMON)

        . = ALIGN(4);

        _ebss = .;
        __bss_end__ = .;
    } > RAM


    /*
     * Heap starts after BSS.
     */
    .heap :
    {
        . = ALIGN(8);
        _heap_start = .;
        __HeapBase = .;
    } > RAM

    _end = .;
    end = .;

    /*
     * The stack grows downward from 0x28400000.
     */
    __StackTop = ORIGIN(RAM) + LENGTH(RAM);
}

