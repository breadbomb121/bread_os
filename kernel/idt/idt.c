#include <stddef.h>
#include <stdint.h>

#include <idt.h>
#include <stdbool.h>
#include <tty.h>
#include <pic.h>
#define IDT_MAX_DESCRIPTORS 48

extern void hard_load_idt(void);

__attribute__((aligned(0x10))) 
static idt_entry_t idt[256];

static idtr_t idtr;
static bool vectors[IDT_MAX_DESCRIPTORS];

extern void* isr_stub_table[];

void idt_set_descriptor(uint8_t vector, void* isr, uint8_t flags) {
    idt_entry_t* descriptor = &idt[vector];

    descriptor->isr_low        = (uint32_t)isr & 0xFFFF;
    descriptor->kernel_cs      = 0x08; // this value can be whatever offset your kernel code selector is in your GDT
    descriptor->attributes     = flags;
    descriptor->isr_high       = (uint32_t)isr >> 16;
    descriptor->reserved       = 0;
}

void idt_init(uint8_t PIC_1, uint8_t PIC_2) {
    idtr.base = (uintptr_t)&idt[0];
    idtr.limit = (uint16_t)sizeof(idt_entry_t) * IDT_MAX_DESCRIPTORS - 1;

    for (uint8_t vector = 0; vector < 32; vector++) {
        idt_set_descriptor(vector, isr_stub_table[vector], 0x8E);
        vectors[vector] = true;
    }
	//Setup ISRs
	for (uint8_t vector = 32; vector < IDT_MAX_DESCRIPTORS; vector++) {
		idt_set_descriptor(vector, isr_stub_table[vector], 0x8E);
	}
	
    __asm__ volatile ("lidt %0" : : "m"(idtr)); // load the new IDT
	PIC_enable(); // setup PIC
	IRQ_hard_set_mask(PIC_1, PIC_2);
	//IRQ_hard_set_mask(0xFF, 0xFF);
	hard_load_idt();
}

