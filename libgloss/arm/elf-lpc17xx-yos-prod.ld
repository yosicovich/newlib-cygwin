GROUP(libc.a ../os/libos.a)

ENTRY(__bspStart)

SECTIONS
{

	/* MAIN TEXT SECTION */	
	.text : ALIGN(4)
	{
		CREATE_OBJECT_SYMBOLS
		FILL(0xff)
		PROVIDE_HIDDEN(__text_start__ = .);
		KEEP(*(.isr_vector))
		
        /* Firmware info data */
        . = 0x000000CC ;
        PROVIDE(__FIRMWARE_INFO_START__ = .) ;
        KEEP(*(.firmware_info))
        PROVIDE(__FIRMWARE_INFO_END__ = .) ;
        ASSERT(!(__FIRMWARE_INFO_START__ == __FIRMWARE_INFO_END__), "Linker: No Firmware info defined. It isn't suitable for production!");
        /* End of Firmware info */
        . = ALIGN(4) ;
		*(.after_vectors*)
			
		*(.text* .gnu.linkonce.t.*)
		*(.plt)
		*(.gnu.warning)
		*(.glue_7t) *(.glue_7) *(.vfp11_veneer)
		. = ALIGN(4);
		*(.ARM.extab* .gnu.linkonce.armextab.*)
		*(.gcc_except_table)
	} > flash
	.eh_frame_hdr : ALIGN (4)
	{
		KEEP (*(.eh_frame_hdr))
	} >flash
	.eh_frame : ALIGN (4)
	{
		KEEP (*(.eh_frame))
	} >flash
	/* .ARM.exidx is sorted, so has to go in its own output section.  */
	PROVIDE_HIDDEN (__exidx_start = .);
	.ARM.exidx :
	{
		*(.ARM.exidx* .gnu.linkonce.armexidx.*)
	} >flash
	PROVIDE_HIDDEN (__exidx_end = .);
  
	.rodata : ALIGN (4)
	{
		*(.rodata .rodata.* .gnu.linkonce.r.*)

		. = ALIGN(4);
		KEEP(*(.init))

		. = ALIGN(4);
		__preinit_array_start = .;
		KEEP (*(.preinit_array))
		__preinit_array_end = .;

		. = ALIGN(4);
		__init_array_start = .;
		KEEP (*(SORT(.init_array.*)))
		KEEP (*(.init_array))
		__init_array_end = .;

		. = ALIGN(4);
		KEEP(*(.fini))

		. = ALIGN(4);
		__fini_array_start = .;
		KEEP (*(.fini_array))
		KEEP (*(SORT(.fini_array.*)))
		__fini_array_end = .;

		. = ALIGN(4);
		KEEP (*crtbegin.o(.ctors))
		KEEP (*(EXCLUDE_FILE (*crtend.o) .ctors))
		KEEP (*(SORT(.ctors.*)))
		KEEP (*crtend.o(.ctors))

		. = ALIGN(4);
		KEEP (*crtbegin.o(.dtors))
		KEEP (*(EXCLUDE_FILE (*crtend.o) .dtors))
		KEEP (*(SORT(.dtors.*)))
		KEEP (*crtend.o(.dtors))

		. = ALIGN (8);
		*(.rom)
		*(.rom.b .bss.rom)

		. = ALIGN(4);
		PROVIDE_HIDDEN(__yos_drvtable_start__ = .);
		KEEP (*(.yos_drvtable.*))
		PROVIDE_HIDDEN(__yos_drvtable_end__ = .);
		
		PROVIDE_HIDDEN(__text_end__ = .);
	} >flash
	
	.data : ALIGN (8)
	{
		FILL(0xff)
		PROVIDE_HIDDEN(__data_start__ = .);
		KEEP(*(.jcr))
		*(.got.plt) *(.got)
		*(.shdata)
		*(.data .data.* .gnu.linkonce.d.*)
		. = ALIGN (8);
		*(.ram)
		PROVIDE_HIDDEN(__data_end__ = .);
	} >ram AT>flash
	PROVIDE_HIDDEN(__data_load__ = LOADADDR(.data));
	
	.bss : ALIGN (4)
	{
	    PROVIDE_HIDDEN(__bss_start__ = .);
		*(.shbss)
		*(.bss .bss.* .gnu.linkonce.b.*)
		*(COMMON)
		. = ALIGN (8);
		*(.ram.b .bss.ram)
		. = ALIGN (4);
		KEEP(*(.bss.$RESERVED*))
	    PROVIDE_HIDDEN(__bss_end__ = .);
	} >ram

	.noinit : ALIGN (4)
	{
	    PROVIDE_HIDDEN(__noinit_start__ = .);
	    *(.noinit .noinit.*)
	    . = ALIGN (4);
	    KEEP(*(.noinit.$RESERVED*))
	    PROVIDE_HIDDEN(__noinit_end__ = .);
	    PROVIDE_HIDDEN(__end__ = .);
	} >ram

	.iap ORIGIN(ram) + LENGTH(ram) - 32:
	{
	    . += 32;
	} >ram

	.yos_rodata : ALIGN (4)
	{
		*(.yos_rodata*)
	   . = ALIGN(4) ;
	} > flash
	
	.yos_syscalls_stack : ALIGN (4)
	{
	    PROVIDE_HIDDEN(__yos_syscalls_stack_start__ = .);
		KEEP(*(.yos_syscalls_stack*))
	   . = ALIGN(4) ;
	    PROVIDE_HIDDEN(__yos_syscalls_stack_end__ = .);
	} > yos_ram

	.yos_data : ALIGN (4)
	{
	    PROVIDE_HIDDEN(__yos_data_start__ = .);
		*(.yos_data*)
	   . = ALIGN(4) ;
	    PROVIDE_HIDDEN(__yos_data_end__ = .);
	} > yos_ram AT>flash
	PROVIDE_HIDDEN(__yos_data_load__ = LOADADDR(.yos_data));

	.yos_bss : ALIGN( 4)
	{
	    PROVIDE_HIDDEN(__yos_bss_start__ = .);
		*(.yos_heap*)
	   . = ALIGN(4) ;
	   *(.yos_bss*)
	   . = ALIGN(4) ;
	    PROVIDE_HIDDEN(__yos_bss_end__ = .);
	} > yos_ram

	.yos_noinit : ALIGN( 4)
	{
	    PROVIDE_HIDDEN(__yos_noinit_start__ = .);
	    *(.yos_noinit*)
	    . = ALIGN(4) ;
	    PROVIDE_HIDDEN(__yos_noinit_end__ = .);
	    PROVIDE_HIDDEN(__yos_end__ = .);
	} > yos_ram

	PROVIDE_HIDDEN(__heap_start = __end__);
	PROVIDE_HIDDEN(__heap_end = ADDR(.iap));
	PROVIDE_HIDDEN(__stack__ = __yos_syscalls_stack_end__);
	PROVIDE_HIDDEN(__flash_end__ = ORIGIN(flash) + LENGTH(flash)-1);
	PROVIDE_HIDDEN(__yos_ram_end__ = ORIGIN(yos_ram) + LENGTH(yos_ram));
    
INCLUDE yos-debug.ld
    
}
