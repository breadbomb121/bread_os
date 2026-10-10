#include <isr.h>
#include <pic.h>
#include <tty.h>
#include <keyboard.h>
#define PIC_OFFSET 0x20


#define IRQ_TIMER 0x0
#define IRQ_KEYBOARD 0x1

//__attribute__((noreturn))
void exception_handler(uint32_t int_num);
void exception_handler(uint32_t int_num) {
	terminal_writestring("EXCEPTION: \n");

    __asm__ volatile ("cli; hlt"); // Completely hangs the computer
}

void timer_handler(void) {
	kprintf("TIMER FIRED %c\n", 'g');
	PIC_sendEOI(0);
}


void generic_handler(uint32_t val){
	switch(val - PIC_OFFSET) {
		case (IRQ_TIMER):
		break;
		case (IRQ_KEYBOARD):
			handle_keyboard();
		break;
	}


	PIC_sendEOI((uint8_t)val);
};

