OUTPUT_FORMAT("elf32-littlearm", "elf32-bigarm", "elf32-littlearm")
OUTPUT_ARCH(arm)
ENTRY(_start)

SECTIONS
{
  PROVIDE(__executable_start = SEGMENT_START("text-segment", 0x8000));
  . = SEGMENT_START("text-segment", 0x8000);

  .init   : { KEEP (*(SORT_NONE(.init))) }

  .text   :
  {
    *(.text.unlikely .text.*_unlikely .text.unlikely.*)
    *(.text.exit .text.exit.*)
    *(.text.startup .text.startup.*)
    *(.text.hot .text.hot.*)
    *(SORT(.text.sorted.*))
    *(.text .stub .text.* .gnu.linkonce.t.*)
    *(.gnu.warning)
    *(.glue_7t) *(.glue_7) *(.vfp11_veneer) *(.v4_bx)
  }

  .fini   : { KEEP (*(SORT_NONE(.fini))) }

  PROVIDE(__etext = .);
  PROVIDE(_etext = .);
  PROVIDE(etext = .);

  .rodata : { *(.rodata .rodata.* .gnu.linkonce.r.*) }

  .ARM.exidx :
  {
    PROVIDE_HIDDEN(__exidx_start = .);
    *(.ARM.exidx* .gnu.linkonce.armexidx.*)
    PROVIDE_HIDDEN(__exidx_end = .);
  }

  /*
   * The writable segment starts at the next page boundary.
   */
  . = ALIGN(CONSTANT(MAXPAGESIZE))
      + (. & (CONSTANT(MAXPAGESIZE) - 1));

  .init_array :
  {
    PROVIDE_HIDDEN(__init_array_start = .);
    KEEP (*(SORT_BY_INIT_PRIORITY(.init_array.*)))
    KEEP (*(.init_array))
    PROVIDE_HIDDEN(__init_array_end = .);
  }

  .fini_array :
  {
    PROVIDE_HIDDEN(__fini_array_start = .);
    KEEP (*(SORT_BY_INIT_PRIORITY(.fini_array.*)))
    KEEP (*(.fini_array))
    PROVIDE_HIDDEN(__fini_array_end = .);
  }

  .data :
  {
    __data_start = .;
    *(.data .data.* .gnu.linkonce.d.*)
    SORT(CONSTRUCTORS)
  }

  _edata = .;
  PROVIDE(edata = .);

  .persistent :
  {
    PROVIDE(__persistent_start = .);
    *(.persistent .persistent.* .gnu.linkonce.p.*)
    . = ALIGN(4);
    PROVIDE(__persistent_end = .);
  }

  __bss_start = .;
  __bss_start__ = .;

  .bss :
  {
    *(.dynbss)
    *(.bss .bss.* .gnu.linkonce.b.*)
    *(COMMON)
    . = ALIGN(4);
  }

  _bss_end__ = .;
  __bss_end__ = .;

  .noinit (NOLOAD) :
  {
    PROVIDE(__noinit_start = .);
    *(.noinit .noinit.* .gnu.linkonce.n.*)
    . = ALIGN(4);
    PROVIDE(__noinit_end = .);
  }

  . = ALIGN(4);

  __end__ = .;
  _end = .;
  PROVIDE(end = .);

  /*
   * The default script reserves a stack section at address 0x80000.
   */
  .stack 0x80000 :
  {
    _stack = .;
    *(.stack)
  }

  /DISCARD/ :
  {
    *(.note.GNU-stack)
    *(.gnu_debuglink)
    *(.gnu.lto_*)
    *(.gnu_object_only)
  }
}
