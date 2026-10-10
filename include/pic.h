#ifndef _KERNEL_PIC_H
#define _KERNEL_PIC_H

#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>

void PIC_sendEOI(uint8_t irq);

void PIC_remap(int offset1, int offset2);

void PIC_disable(void);

void IRQ_set_mask(uint8_t IRQline);
void IRQ_hard_set_mask(uint8_t pic_1, uint8_t pic_2);
void IRQ_clear_mask(uint8_t IRQline);

void PIC_enable(void);

#endif
