.code16
.globl G_table
.globl start
.globl display
.globl msg
.globl gan

	
.text
.set code, 0x0008
start:	
	xor %ax, %ax
	mov %ax, %ss
	mov $0x7c00, %sp
	mov $G_table, %eax
	mov $0x27, %bx
	push %eax
	push %bx
	lgdt (%esp)
	add $0x06, %sp
	mov %cr0, %eax
	or $0x0001, %eax
	mov %eax, %cr0
.code32
	ljmp $0x0008, $gan
gan:	mov $0x67, %al
	mov $0x0e, %ah
	int $0x10

	mov $0x0028, %ax
	mov %ax, %ss
	mov $0x7c00, %sp
	mov $0x0010, %ax
	mov %ax, %ds
	mov $0x0018, %ax
	mov %ax, %es
	mov $0x0000, %di	
	mov $0x24, %ah
	mov $msg, %si
	call display
	mov $0x00, %ah
	int $0x16
	int $0x19
	ret
display : 
loop:	lodsb
	cmp $0x24, %al
	jz over
	stosw
	jmp loop
over : ret

msg : .string "protected mode$"
G_table: .word 0x0000, 0x0000, 0x0000, 0x0000, 0x01ff, 0x7c00, 0x9a00, 0x0000, 0x01ff, 0x7c00, 0x9200, 0x0000, 0x7fff, 0x8000, 0x920b, 0x0000, 0x7c00, 0x0000, 0x9200, 0x0000






.fill 510-(.-start), 1, 0
.word 0xAA55
