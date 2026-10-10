.section .text


.global test_int
test_int:
	int $0x20
	ret


.global test_loop
test_loop:
	1:
		hlt
		jmp 1
