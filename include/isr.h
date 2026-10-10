#ifndef _KERNEL_ISR_H
#define _KERNEL_ISR_H

#include <stddef.h>
#include <stdint.h>

//__attribute__((noreturn))
void exception_handler(uint32_t int_num);
void timer_handler(void);


void generic_handler(uint32_t val);

#endif

