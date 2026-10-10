.section .rodata

.section .bss
	.macro isr_err_stub val
		isr_stub_\val:
			pusha

			pushl $\val
			call exception_handler 
			addl $4, %esp

			popa
			iret
	.endm
	.macro isr_no_err_stub val
		isr_stub_\val:
			pusha

			pushl $\val
			call exception_handler 
			addl $4, %esp

			popa
			iret
	.endm

	.macro isr_table_entry n
		.long isr_stub_\n
	.endm

	.macro irq_table_entry n
		.long irq_stub_\n
	.endm

	.macro irq_stub val
		irq_stub_\val:
		pusha
		
		cld
		call timer_handler
		
		popa
		iret
	.endm

	.macro irq_stub_gen val
		irq_stub_\val:
		pusha

		pushl $\val

		call generic_handler
		addl $4, %esp
		popa
		iret


	.endm
.section .text

isr_no_err_stub 0
isr_no_err_stub 1
isr_no_err_stub 2
isr_no_err_stub 3
isr_no_err_stub 4
isr_no_err_stub 5
isr_no_err_stub 6
isr_no_err_stub 7
isr_err_stub    8
isr_no_err_stub 9
isr_err_stub    10
isr_err_stub    11
isr_err_stub    12
isr_err_stub    13
isr_err_stub    14
isr_no_err_stub 15
isr_no_err_stub 16
isr_err_stub    17
isr_no_err_stub 18
isr_no_err_stub 19
isr_no_err_stub 20
isr_no_err_stub 21
isr_no_err_stub 22
isr_no_err_stub 23
isr_no_err_stub 24
isr_no_err_stub 25
isr_no_err_stub 26
isr_no_err_stub 27
isr_no_err_stub 28
isr_no_err_stub 29
isr_err_stub    30
isr_no_err_stub 31
irq_stub_gen 32
irq_stub_gen 33
irq_stub 34
irq_stub 35
irq_stub 36
irq_stub 37
irq_stub 38
irq_stub 39
irq_stub 40 
irq_stub 41 
irq_stub 42 
irq_stub 43 
irq_stub 44 
irq_stub 45 
irq_stub 46
irq_stub 47 
irq_stub 48 

.global isr_stub_table
isr_stub_table:
	isr_table_entry 0	
	isr_table_entry 1
	isr_table_entry 2	
	isr_table_entry 3	
	isr_table_entry 4	
	isr_table_entry 5	
	isr_table_entry 6	
	isr_table_entry 7	
	isr_table_entry 8	
	isr_table_entry 9	
	isr_table_entry 10	
	isr_table_entry 11	
	isr_table_entry 12	
	isr_table_entry 13	
	isr_table_entry 14
	isr_table_entry 15	
	isr_table_entry 16	
	isr_table_entry 17	
	isr_table_entry 18
	isr_table_entry 19
	isr_table_entry 20
	isr_table_entry 21
	isr_table_entry 22
	isr_table_entry 23
	isr_table_entry 24
	isr_table_entry 25
	isr_table_entry 26
	isr_table_entry 27
	isr_table_entry 28
	isr_table_entry 29
	isr_table_entry 30	
	isr_table_entry 31
	irq_table_entry 32
	irq_table_entry 33
	irq_table_entry 34
	irq_table_entry 35
	irq_table_entry 36
	irq_table_entry 37
	irq_table_entry 38
	irq_table_entry 39
	irq_table_entry 40 
	irq_table_entry 41
	irq_table_entry 42 
	irq_table_entry 43 
	irq_table_entry 44 
	irq_table_entry 45
	irq_table_entry 46
	irq_table_entry 47



.global hard_load_idt
hard_load_idt:
	sti
	ret
