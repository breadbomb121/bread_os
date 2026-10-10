#include <lib/io.h>
#include <stdint.h>

uint8_t inb(uint16_t port){
    uint8_t ret;
    __asm__ volatile ( "inb %w1, %b0"
                   : "=a"(ret)
                   : "nd"(port)
                   : "memory");
    return ret;
}

void outb(uint16_t port, uint8_t val){
    __asm__ volatile ( "outb %b0, %w1" : : "a"(val), "Nd"(port) : "memory");
}

uint8_t inw(uint16_t port) {
    uint16_t ret;
	__asm__ volatile ( "in %w1, %w0"
                   : "=a"(ret)
                   : "nd"(port)
                   : "memory");
    return ret;

}

void outw(uint16_t port, uint16_t val){
    __asm__ volatile ( "out %w0, %w1" : : "a"(val), "Nd"(port) : "memory");
}

void io_wait(void)
{
    outb(0x80, 0);
}

