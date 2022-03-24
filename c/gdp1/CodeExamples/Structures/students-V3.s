	.file	"students-V3.c"
	.intel_syntax noprefix
	.section	.rodata
.LC2:
	.string	"Stadt"
.LC3:
	.string	"PLZ"
.LC4:
	.string	"HNr"
.LC5:
	.string	"Strasse"
.LC6:
	.string	"Vorname"
.LC7:
	.string	"Nachname"
.LC8:
	.string	"StGg"
.LC9:
	.string	"MatNr"
	.align 4
.LC10:
	.string	"\n%6s%5s%21s%21s%21s%6s%6s%20s\n"
.LC11:
	.string	"%6s%5s%21s%21s%21s%6s%6d%20s\n"
	.text
	.globl	druckeStudent
	.type	druckeStudent, @function
druckeStudent:
.LFB0:
	.cfi_startproc
	push	ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	mov	ebp, esp
	.cfi_def_cfa_register 5
	sub	esp, 56
	mov	DWORD PTR [esp+32], OFFSET FLAT:.LC2
	mov	DWORD PTR [esp+28], OFFSET FLAT:.LC3
	mov	DWORD PTR [esp+24], OFFSET FLAT:.LC4
	mov	DWORD PTR [esp+20], OFFSET FLAT:.LC5
	mov	DWORD PTR [esp+16], OFFSET FLAT:.LC6
	mov	DWORD PTR [esp+12], OFFSET FLAT:.LC7
	mov	DWORD PTR [esp+8], OFFSET FLAT:.LC8
	mov	DWORD PTR [esp+4], OFFSET FLAT:.LC9
	mov	DWORD PTR [esp], OFFSET FLAT:.LC10
	call	printf
	mov	eax, DWORD PTR [ebp+88]
	lea	edx, [ebp+92]
	mov	DWORD PTR [esp+32], edx
	mov	DWORD PTR [esp+28], eax
	lea	eax, [ebp+80]
	mov	DWORD PTR [esp+24], eax
	lea	eax, [ebp+60]
	mov	DWORD PTR [esp+20], eax
	lea	eax, [ebp+39]
	mov	DWORD PTR [esp+16], eax
	lea	eax, [ebp+19]
	mov	DWORD PTR [esp+12], eax
	lea	eax, [ebp+14]
	mov	DWORD PTR [esp+8], eax
	lea	eax, [ebp+8]
	mov	DWORD PTR [esp+4], eax
	mov	DWORD PTR [esp], OFFSET FLAT:.LC11
	call	printf
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	druckeStudent, .-druckeStudent
	.section	.rodata
	.align 32
.LC0:
	.string	"00001"
	.string	"IB"
	.zero	2
	.string	"Munter"
	.zero	13
	.string	"Monika"
	.zero	13
	.zero	1
	.string	"Jam Alley"
	.zero	10
	.string	"2"
	.zero	3
	.zero	3
	.long	73210
	.string	"Gotham City"
	.zero	8
	.align 32
.LC1:
	.string	"00002"
	.string	"IB"
	.zero	2
	.string	"Tragel"
	.zero	13
	.string	"Lars"
	.zero	15
	.zero	1
	.string	"Komaweg"
	.zero	12
	.string	"4"
	.zero	3
	.zero	3
	.long	98765
	.string	"Bruchtal"
	.zero	11
	.text
	.globl	main
	.type	main, @function
main:
.LFB1:
	.cfi_startproc
	push	ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	mov	ebp, esp
	.cfi_def_cfa_register 5
	push	edi
	push	esi
	push	ebx
	and	esp, -16
	sub	esp, 336
	.cfi_offset 7, -12
	.cfi_offset 6, -16
	.cfi_offset 3, -20
	mov	eax, DWORD PTR gs:20
	mov	DWORD PTR [esp+332], eax
	xor	eax, eax
	lea	edx, [esp+124]
	mov	ebx, OFFSET FLAT:.LC0
	mov	eax, 26
	mov	edi, edx
	mov	esi, ebx
	mov	ecx, eax
	rep movsd
	lea	edx, [esp+228]
	mov	ebx, OFFSET FLAT:.LC1
	mov	eax, 26
	mov	edi, edx
	mov	esi, ebx
	mov	ecx, eax
	rep movsd
	mov	edx, esp
	lea	ebx, [esp+124]
	mov	eax, 26
	mov	edi, edx
	mov	esi, ebx
	mov	ecx, eax
	rep movsd
	call	druckeStudent
	mov	edx, esp
	lea	ebx, [esp+228]
	mov	eax, 26
	mov	edi, edx
	mov	esi, ebx
	mov	ecx, eax
	rep movsd
	call	druckeStudent
	mov	eax, 0
	mov	edx, DWORD PTR [esp+332]
	xor	edx, DWORD PTR gs:20
	je	.L4
	call	__stack_chk_fail
.L4:
	lea	esp, [ebp-12]
	pop	ebx
	.cfi_restore 3
	pop	esi
	.cfi_restore 6
	pop	edi
	.cfi_restore 7
	pop	ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE1:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 4.8.4-2ubuntu1~14.04.3) 4.8.4"
	.section	.note.GNU-stack,"",@progbits
