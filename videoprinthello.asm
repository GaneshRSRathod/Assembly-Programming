.code16
.text
	.globl start
start:	
	xor %ax, %ax
	mov %ax, %ss
	mov $0x7c00, %sp
	mov $0xB000, %ax
	mov %ax, %es
	mov $0x8500, %di
	mov $0x00, %ah
	int $0x16
	mov $0x2448, %ax
	stosw
	mov $0x2465, %ax
	stosw
	mov $0x246C, %ax
	stosw
	mov $0x246C, %ax
	stosw
	mov $0x246F, %ax
	stosw
	mov $0x2420, %ax
	stosw
	mov $0x2457, %ax
	stosw
	mov $0x246F, %ax
	stosw
	mov $0x2472, %ax
	stosw
	mov $0x246C, %ax
	stosw
	mov $0x2464, %ax
	stosw
	int $0x10
	int $0x13
	ret

.fill 510-(.-start), 1, 0
.word 0xAA55
