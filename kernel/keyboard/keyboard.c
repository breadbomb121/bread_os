#include <keyboard.h>

#include <lib/io.h>
#include <tty.h>

static const char keyboard_map[] = {
    0,   27,  '1', '2', '3', '4', '5', '6',
    '7', '8', '9', '0', '-', '=', '\b', '\t',
    'q', 'w', 'e', 'r', 't', 'y', 'u', 'i',
    'o', 'p', '[', ']', '\n', 0,   'a', 's',
    'd', 'f', 'g', 'h', 'j', 'k', 'l', ';',
    '\'', '`', 0, '\\', 'z', 'x', 'c', 'v',
    'b', 'n', 'm', ',', '.', '/', 0,   '*',
    0,   ' '
};


void handle_keyboard(void) {
	uint8_t scancode = inb(0x60);
	if (scancode & 0x80)
		return;

	if(scancode < sizeof(keyboard_map)){
		char c = keyboard_map[scancode];
		if (c)
			terminal_putchar(c);
	}


}
