#include "cr.h"

// Kernel related values.
#pragma once

// Physical and virtual memory stack pointers.
#define KERNEL_PHYSICAL_START 0x0000000000400000
#define KERNEL_VIRTUAL_START  0xFFFFFFFF80400000

// Kernel GDT entry index.
#define KERNEL_GDT_ENTRY 1

// Control register 0 value.
#define KERNEL_CR0         \
    (                      \
        CR0_PG_ENABLE |    \
        CR0_PM_ENABLE |    \
        CR0_ET             \
    )

// Control register 4 value.
#define KERNEL_CR4 (CR4_PAE_ENABLE)     // PAE Enables PSE by default and sets the page size to 2MB