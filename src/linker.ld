ENTRY(_start)

SECTIONS
{
    . = 4M;
    _kernel_physical_start = .;

    .boottext :
    {
        boot.o (.multiboot)
        boot.o (.text)
    }
    
    .bootrodata :
    {
        boot.o (.rodata)
    }

    .bootdata :
    {
        boot.o (.data)
    }

    .bootbss :
    {
        boot.o (.bss)
        boot.o (COMMON)
    }

    . = ALIGN(0x1000);
    _boot_end = .;

    _kernel_virtual_start = .;

    .text : AT(_boot_end)
    {   
        *(.text)
    }

    . = ALIGN(0x1000);

    .rodata : AT ( (LOADADDR (.text) + SIZEOF (.text) + 0xFFF) & 0xFFFFFFFFFFFFF000 )
    {
        *(.rodata)
        *(.rodata.*)
    }

    . = ALIGN(0x1000);

    .data : AT ( (LOADADDR (.rodata) + SIZEOF (.rodata) + 0xFFF) & 0xFFFFFFFFFFFFF000 )
    {
        *(.data)
        *(.eh_frame_hdr)
        *(.eh_frame)
    }

    . = ALIGN(0x1000);

    .bss : AT ( (LOADADDR (.data) + SIZEOF (.data) + 0xFFF) & 0xFFFFFFFFFFFFF000 )
    {
        *(COMMON)
        *(.bss)
    }

    /* Include the list of initialization functions sorted. */
    .init_array :
    {
        crti.o(.init_array)
        KEEP (*(SORT(EXCLUDE_FILE(crti.o crtn.o) .init_array.*)))
        KEEP (*(EXCLUDE_FILE(crti.o crtn.o) .init_array))
        crtn.o(.init_array)
    }

    /* Include the list of termination functions sorted. */
    .fini_array :
    {
        crti.o(.fini_array)
        KEEP (*(SORT(EXCLUDE_FILE(crti.o crtn.o) .fini_array.*)))
        KEEP (*(EXCLUDE_FILE(crti.o crtn.o) .fini_array))
        crtn.o(.fini_array)
    }

    /DISCARD/ :
    {
        *(.comment)
    }

    _kernel_virtual_end = .;

    _kernel_physical_end = (LOADADDR (.bss) + SIZEOF (.bss) + 0xFFF) & 0xFFFFFFFFFFFFF000;
}