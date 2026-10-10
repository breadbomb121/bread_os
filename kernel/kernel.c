#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#include <lib/io.h>

#include <tty.h>
#include <idt.h>
#include <pic.h>

extern void loadGdt(void);
extern void test_int(void);
extern void test_loop(void);

void kernel_main(void) {
	/* Initialize terminal interface */
	terminal_initialize();

	loadGdt();
	kprintf("TESTING NEW FN\n");
	kprintf("GDT Loaded\n");

	idt_init(0xFD, 0xFF);
	kprintf("Idt and PIC Loaded\n");

	/* Newline support is left as an exercise. */
	kprintf("Hello, kernel World!\n");

	for ( ; ; ) {
	
	}
}
