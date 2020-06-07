.code16
.globl start
.text
start : 
	mov %cs, %ax
	mov %ax, %ds
	xor %ax, %ax
	mov %ax, %ss
	mov $0x7c00, %sp
	movl $row1, %ebx
	movd (%ebx), %xmm0
	movl $row2, %ebx
	movd (%ebx), %xmm1
	punpcklbw %xmm1, %xmm0
	mov $row1, %ebx
	movq %xmm0, (%ebx)
	mov $row1, %si
	mov $0x0008, %cx
loop:	lodsb
	call printnum
	dec %cx
	cmp $0x0000, %cx
	je out
out: 	int $0x10
	ret
printnum : push %bp
	mov %sp, %bp
	mov %al, %bl
	and $0xf0, %al
	shr %al
	shr %al
	shr %al
	shr %al
	call shnum
	mov %bl, %al
	and $0x0f, %al
	call shnum
	pop %bp
	ret

shnum:	push %bp
	mov %sp, %bp
	cmp $0x0a, %al
	jb next
	add $0x07, %al
next:	add $0x30, %al
	mov $0x0e, %ah
	int $0x10
	pop %bp
	ret



row1 : .byte 10, 20, 30, 40
row2: .byte 50, 60, 70, 80
row : .byte 2
column : .byte 3
.fill 510-(.-start), 1, 0
.word 0xaa55
