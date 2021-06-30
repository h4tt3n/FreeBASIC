	.file	"Arduino_FreeBASIC_serial_06.c"
	.intel_syntax noprefix
	.comm	_ZN12ONDELAYTIMER6TIME0$E, 8, 3
	.text
	.globl	_ZN12ONDELAYTIMERC1Eu7INTEGER
	.def	_ZN12ONDELAYTIMERC1Eu7INTEGER;	.scl	2;	.type	32;	.endef
_ZN12ONDELAYTIMERC1Eu7INTEGER:
	push	rbp
	mov	rbp, rsp
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
.L2:
	mov	rax, QWORD PTR 16[rbp]
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 8
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 8[rax]
	mov	rax, QWORD PTR 24[rbp]
	mov	QWORD PTR [rdx], rax
	nop
	pop	rbp
	ret
.L3:
	.globl	_ZN12ONDELAYTIMER6STATUSEv
	.def	_ZN12ONDELAYTIMER6STATUSEv;	.scl	2;	.type	32;	.endef
_ZN12ONDELAYTIMER6STATUSEv:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	mov	QWORD PTR 16[rbp], rcx
	mov	BYTE PTR -1[rbp], 0
.L5:
	mov	rax, QWORD PTR 16[rbp]
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	add	rdx, rax
	lea	rax, _ZN12ONDELAYTIMER6TIME0$E[rip]
	mov	rax, QWORD PTR [rax]
	cmp	rdx, rax
	setle	al
	mov	BYTE PTR -1[rbp], al
	nop
.L6:
	movzx	eax, BYTE PTR -1[rbp]
	leave
	ret
	.globl	_ZN12ONDELAYTIMER8NEXTTICKEv
	.def	_ZN12ONDELAYTIMER8NEXTTICKEv;	.scl	2;	.type	32;	.endef
_ZN12ONDELAYTIMER8NEXTTICKEv:
	push	rbp
	mov	rbp, rsp
.L9:
	lea	rax, _ZN12ONDELAYTIMER6TIME0$E[rip]
	mov	rax, QWORD PTR [rax]
	lea	rdx, 1[rax]
	lea	rax, _ZN12ONDELAYTIMER6TIME0$E[rip]
	mov	QWORD PTR [rax], rdx
	nop
	pop	rbp
	ret
.L10:
	.globl	_ZN12ONDELAYTIMER5RESETEv
	.def	_ZN12ONDELAYTIMER5RESETEv;	.scl	2;	.type	32;	.endef
_ZN12ONDELAYTIMER5RESETEv:
	push	rbp
	mov	rbp, rsp
	mov	QWORD PTR 16[rbp], rcx
.L12:
	lea	rax, _ZN12ONDELAYTIMER6TIME0$E[rip]
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR 16[rbp]
	mov	QWORD PTR [rax], rdx
	nop
	pop	rbp
	ret
.L13:
	.globl	_ZN9COMPONENTC1ER8FBSTRINGu7INTEGERS2_S2_S2_S2_10TIMER_ENUM10STYLE_ENUM
	.def	_ZN9COMPONENTC1ER8FBSTRINGu7INTEGERS2_S2_S2_S2_10TIMER_ENUM10STYLE_ENUM;	.scl	2;	.type	32;	.endef
_ZN9COMPONENTC1ER8FBSTRINGu7INTEGERS2_S2_S2_S2_10TIMER_ENUM10STYLE_ENUM:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 64
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
	mov	QWORD PTR 32[rbp], r8
	mov	QWORD PTR 40[rbp], r9
.L15:
	mov	rax, QWORD PTR 16[rbp]
	mov	QWORD PTR [rax], 0
	mov	QWORD PTR 8[rax], 0
	mov	QWORD PTR 16[rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 24
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 32
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 40
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 48
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 56
	mov	QWORD PTR [rax], 0
	mov	QWORD PTR 8[rax], 0
	mov	QWORD PTR 16[rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 80
	mov	BYTE PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 88
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 96
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 104
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 112
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 120
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 24[rbp]
	mov	DWORD PTR 32[rsp], 0
	mov	r9, -1
	mov	r8, rax
	mov	rdx, -1
	mov	rcx, QWORD PTR 16[rbp]
	call	fb_StrAssign
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 24[rax]
	mov	rax, QWORD PTR 32[rbp]
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 32[rax]
	mov	rax, QWORD PTR 40[rbp]
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 40[rax]
	mov	rax, QWORD PTR 48[rbp]
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 48[rax]
	mov	rax, QWORD PTR 56[rbp]
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 120[rax]
	mov	rax, QWORD PTR 64[rbp]
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 96[rax]
	mov	rax, QWORD PTR 72[rbp]
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 104[rax]
	mov	rax, QWORD PTR 80[rbp]
	mov	QWORD PTR [rdx], rax
	nop
	leave
	ret
.L16:
	.globl	_ZN9COMPONENT3ADDERK8FBSTRING
	.def	_ZN9COMPONENT3ADDERK8FBSTRING;	.scl	2;	.type	32;	.endef
_ZN9COMPONENT3ADDERK8FBSTRING:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 176
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
.L18:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 80
	movzx	eax, BYTE PTR [rax]
	test	al, al
	je	.L28
	lea	rax, -96[rbp]
	mov	QWORD PTR [rax], 0
	mov	QWORD PTR 8[rax], 0
	mov	QWORD PTR 16[rax], 0
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 56[rax]
	mov	rcx, QWORD PTR 24[rbp]
	lea	rax, -96[rbp]
	mov	QWORD PTR 32[rsp], -1
	mov	r9, rcx
	mov	r8, -1
	mov	rcx, rax
	call	fb_StrConcat
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 56
	mov	rdx, QWORD PTR -8[rbp]
	mov	DWORD PTR 32[rsp], 0
	mov	r9, -1
	mov	r8, rdx
	mov	rdx, -1
	mov	rcx, rax
	call	fb_StrAssign
	mov	QWORD PTR -16[rbp], rax
.L21:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 56
	mov	rdx, -1
	mov	rcx, rax
	call	fb_StrLen
	mov	QWORD PTR -24[rbp], rax
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 40
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 48
	mov	rax, QWORD PTR [rax]
	imul	rax, rdx
	cmp	rax, QWORD PTR -24[rbp]
	jge	.L29
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 48
	mov	rax, QWORD PTR [rax]
	lea	rdx, 1[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 56
	mov	r8, -1
	mov	rcx, rax
	call	fb_StrMid
	mov	QWORD PTR -32[rbp], rax
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 56
	mov	rdx, QWORD PTR -32[rbp]
	mov	DWORD PTR 32[rsp], 0
	mov	r9, -1
	mov	r8, rdx
	mov	rdx, -1
	mov	rcx, rax
	call	fb_StrAssign
	mov	QWORD PTR -40[rbp], rax
	jmp	.L21
.L29:
	nop
.L23:
	jmp	.L25
.L28:
	nop
.L20:
	lea	rax, -128[rbp]
	mov	QWORD PTR [rax], 0
	mov	QWORD PTR 8[rax], 0
	mov	QWORD PTR 16[rax], 0
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 56[rax]
	mov	rcx, QWORD PTR 24[rbp]
	lea	rax, -128[rbp]
	mov	QWORD PTR 32[rsp], -1
	mov	r9, rcx
	mov	r8, -1
	mov	rcx, rax
	call	fb_StrConcat
	mov	QWORD PTR -48[rbp], rax
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 40
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 48
	mov	rax, QWORD PTR [rax]
	imul	rdx, rax
	mov	rax, QWORD PTR -48[rbp]
	mov	rcx, rax
	call	fb_LEFT
	mov	QWORD PTR -56[rbp], rax
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 56
	mov	rdx, QWORD PTR -56[rbp]
	mov	DWORD PTR 32[rsp], 0
	mov	r9, -1
	mov	r8, rdx
	mov	rdx, -1
	mov	rcx, rax
	call	fb_StrAssign
	mov	QWORD PTR -64[rbp], rax
.L24:
.L25:
	nop
	leave
	ret
	.globl	_ZN9COMPONENT6REMOVEEu7INTEGERS0_
	.def	_ZN9COMPONENT6REMOVEEu7INTEGERS0_;	.scl	2;	.type	32;	.endef
_ZN9COMPONENT6REMOVEEu7INTEGERS0_:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 144
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
	mov	QWORD PTR 32[rbp], r8
	lea	rax, -96[rbp]
	mov	QWORD PTR [rax], 0
	mov	QWORD PTR 8[rax], 0
	mov	QWORD PTR 16[rax], 0
.L31:
	cmp	QWORD PTR 24[rbp], 0
	jg	.L40
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 56
	mov	rdx, -1
	mov	rcx, rax
	call	fb_StrLen
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -8[rbp]
	mov	QWORD PTR 24[rbp], rax
	jmp	.L34
.L33:
.L40:
	nop
.L34:
	cmp	QWORD PTR 32[rbp], 0
	jle	.L41
	mov	rax, QWORD PTR 32[rbp]
	mov	rdx, rax
	mov	ecx, 1
	call	fb_CHR
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 56
	mov	rdx, QWORD PTR -16[rbp]
	mov	r8, rdx
	mov	rdx, rax
	mov	ecx, 1
	call	fb_StrInstr
	mov	QWORD PTR -24[rbp], rax
	mov	rax, QWORD PTR -24[rbp]
	mov	QWORD PTR 24[rbp], rax
	jmp	.L37
.L36:
.L41:
	nop
.L37:
	mov	rax, QWORD PTR 16[rbp]
	lea	rcx, 56[rax]
	mov	rax, QWORD PTR 24[rbp]
	mov	rdx, rax
	call	fb_LEFT
	mov	QWORD PTR -32[rbp], rax
	mov	rdx, QWORD PTR -32[rbp]
	lea	rax, -96[rbp]
	mov	DWORD PTR 32[rsp], 0
	mov	r9, -1
	mov	r8, rdx
	mov	rdx, -1
	mov	rcx, rax
	call	fb_StrAssign
	mov	QWORD PTR -40[rbp], rax
	mov	rax, QWORD PTR 24[rbp]
	lea	rdx, 1[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 56
	mov	r8, -1
	mov	rcx, rax
	call	fb_StrMid
	mov	QWORD PTR -48[rbp], rax
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 56
	mov	rdx, QWORD PTR -48[rbp]
	mov	DWORD PTR 32[rsp], 0
	mov	r9, -1
	mov	r8, rdx
	mov	rdx, -1
	mov	rcx, rax
	call	fb_StrAssign
	mov	QWORD PTR -56[rbp], rax
.L38:
	lea	rax, -96[rbp]
	mov	rcx, rax
	call	fb_StrAllocTempResult
	mov	QWORD PTR -64[rbp], rax
	mov	rax, QWORD PTR -64[rbp]
	leave
	ret
	.section .rdata,"dr"
.LC1:
	.ascii " (need CR)\0"
.LC3:
	.ascii "\0"
	.text
	.globl	_ZN9COMPONENT6RENDEREv
	.def	_ZN9COMPONENT6RENDEREv;	.scl	2;	.type	32;	.endef
_ZN9COMPONENT6RENDEREv:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 272
	movaps	XMMWORD PTR -16[rbp], xmm6
	mov	QWORD PTR 16[rbp], rcx
.L43:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 32
	mov	rax, QWORD PTR [rax]
	sal	rax, 3
	sub	rax, 8
	pxor	xmm0, xmm0
	cvtsi2ssq	xmm0, rax
	movss	DWORD PTR -36[rbp], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	sal	rax, 3
	sub	rax, 8
	pxor	xmm0, xmm0
	cvtsi2ssq	xmm0, rax
	movss	DWORD PTR -40[rbp], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 32
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 48
	mov	rax, QWORD PTR [rax]
	add	rax, rdx
	sal	rax, 3
	sub	rax, 8
	pxor	xmm0, xmm0
	cvtsi2ssq	xmm0, rax
	movss	DWORD PTR -44[rbp], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 24
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 40
	mov	rax, QWORD PTR [rax]
	add	rax, rdx
	sal	rax, 3
	sub	rax, 8
	pxor	xmm0, xmm0
	cvtsi2ssq	xmm0, rax
	movss	DWORD PTR -48[rbp], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 104
	mov	rax, QWORD PTR [rax]
	cmp	rax, 1
	jne	.L65
	movss	xmm0, DWORD PTR -48[rbp]
	movss	xmm1, DWORD PTR .LC0[rip]
	subss	xmm0, xmm1
	movss	xmm2, DWORD PTR -40[rbp]
	movss	xmm1, DWORD PTR .LC0[rip]
	movaps	xmm4, xmm2
	addss	xmm4, xmm1
	movss	xmm2, DWORD PTR -36[rbp]
	movss	xmm1, DWORD PTR .LC0[rip]
	addss	xmm1, xmm2
	movss	xmm2, DWORD PTR -44[rbp]
	mov	DWORD PTR 64[rsp], 0
	mov	DWORD PTR 56[rsp], 61680
	mov	DWORD PTR 48[rsp], 0
	mov	DWORD PTR 40[rsp], 8
	movss	DWORD PTR 32[rsp], xmm0
	movaps	xmm3, xmm2
	movaps	xmm2, xmm4
	mov	ecx, 0
	call	fb_GfxLine
	mov	QWORD PTR -24[rbp], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 40
	mov	rax, QWORD PTR [rax]
	sub	rax, 1
	mov	QWORD PTR -56[rbp], rax
	jmp	.L46
.L63:
.L47:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 48
	mov	rcx, QWORD PTR [rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 48
	mov	rax, QWORD PTR [rax]
	imul	rax, QWORD PTR -24[rbp]
	lea	rdx, 1[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 56
	mov	r8, rcx
	mov	rcx, rax
	call	fb_StrMid
	mov	QWORD PTR -64[rbp], rax
	mov	rdx, QWORD PTR -64[rbp]
	lea	rax, -144[rbp]
	mov	DWORD PTR 32[rsp], 0
	mov	r9, -1
	mov	r8, rdx
	mov	rdx, -1
	mov	rcx, rax
	call	fb_StrInit
	mov	QWORD PTR -72[rbp], rax
	lea	rax, -144[rbp]
	mov	rdx, -1
	mov	rcx, rax
	call	fb_StrLen
	mov	QWORD PTR -80[rbp], rax
	mov	rax, QWORD PTR -24[rbp]
	sal	rax, 3
	pxor	xmm0, xmm0
	cvtsi2ssq	xmm0, rax
	movaps	xmm6, xmm0
	addss	xmm6, DWORD PTR -40[rbp]
	movss	xmm0, DWORD PTR -36[rbp]
	movaps	xmm1, xmm0
	addss	xmm1, DWORD PTR -44[rbp]
	mov	rax, QWORD PTR -80[rbp]
	sal	rax, 3
	pxor	xmm0, xmm0
	cvtsi2ssq	xmm0, rax
	addss	xmm0, xmm1
	call	nearbyintf
	cvttss2si	rax, xmm0
	mov	rdx, rax
	shr	rdx, 63
	add	rax, rdx
	sar	rax
	pxor	xmm0, xmm0
	cvtsi2ssq	xmm0, rax
	mov	QWORD PTR 80[rsp], 0
	mov	QWORD PTR 72[rsp], 0
	mov	QWORD PTR 64[rsp], 0
	mov	DWORD PTR 56[rsp], 0
	mov	QWORD PTR 48[rsp], 0
	mov	DWORD PTR 40[rsp], 15
	lea	rax, -144[rbp]
	mov	QWORD PTR 32[rsp], rax
	mov	r9d, 4
	movaps	xmm2, xmm6
	movaps	xmm1, xmm0
	mov	ecx, 0
	call	fb_GfxDrawString
	lea	rax, -144[rbp]
	mov	rcx, rax
	call	fb_StrDelete
.L48:
	add	QWORD PTR -24[rbp], 1
.L46:
	mov	rax, QWORD PTR -24[rbp]
	cmp	rax, QWORD PTR -56[rbp]
	jg	.L66
	jmp	.L63
.L49:
.L65:
	nop
.L45:
	lea	rax, -176[rbp]
	mov	DWORD PTR 32[rsp], 0
	mov	r9, -1
	mov	r8, QWORD PTR 16[rbp]
	mov	rdx, -1
	mov	rcx, rax
	call	fb_StrInit
	mov	QWORD PTR -88[rbp], rax
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 112
	mov	rax, QWORD PTR [rax]
	test	rax, rax
	je	.L67
	lea	rax, -176[rbp]
	mov	DWORD PTR 32[rsp], 0
	mov	r9d, 11
	lea	r8, .LC1[rip]
	mov	rdx, -1
	mov	rcx, rax
	call	fb_StrConcatAssign
	mov	QWORD PTR -96[rbp], rax
	jmp	.L53
.L52:
.L67:
	nop
.L53:
	movss	xmm0, DWORD PTR -40[rbp]
	movss	xmm1, DWORD PTR .LC2[rip]
	movaps	xmm2, xmm0
	subss	xmm2, xmm1
	movss	xmm0, DWORD PTR -36[rbp]
	movss	xmm1, DWORD PTR .LC0[rip]
	subss	xmm0, xmm1
	mov	QWORD PTR 80[rsp], 0
	mov	QWORD PTR 72[rsp], 0
	mov	QWORD PTR 64[rsp], 0
	mov	DWORD PTR 56[rsp], 0
	mov	QWORD PTR 48[rsp], 0
	mov	DWORD PTR 40[rsp], 7
	lea	rax, -176[rbp]
	mov	QWORD PTR 32[rsp], rax
	mov	r9d, 4
	movaps	xmm1, xmm0
	mov	ecx, 0
	call	fb_GfxDrawString
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 56
	mov	r9d, 1
	lea	r8, .LC3[rip]
	mov	rdx, -1
	mov	rcx, rax
	call	fb_StrCompare
	mov	DWORD PTR -100[rbp], eax
	cmp	DWORD PTR -100[rbp], 0
	jle	.L68
	movss	xmm1, DWORD PTR -48[rbp]
	movss	xmm0, DWORD PTR .LC4[rip]
	addss	xmm0, xmm1
	movss	xmm2, DWORD PTR -44[rbp]
	movss	xmm1, DWORD PTR .LC4[rip]
	movaps	xmm3, xmm2
	addss	xmm3, xmm1
	movss	xmm1, DWORD PTR -40[rbp]
	movss	xmm2, DWORD PTR .LC4[rip]
	movaps	xmm4, xmm1
	subss	xmm4, xmm2
	movss	xmm1, DWORD PTR -36[rbp]
	movss	xmm2, DWORD PTR .LC4[rip]
	subss	xmm1, xmm2
	mov	DWORD PTR 64[rsp], 0
	mov	DWORD PTR 56[rsp], 65535
	mov	DWORD PTR 48[rsp], 2
	mov	DWORD PTR 40[rsp], 1
	movss	DWORD PTR 32[rsp], xmm0
	movaps	xmm2, xmm4
	mov	ecx, 0
	call	fb_GfxLine
	jmp	.L56
.L55:
.L68:
	nop
.L56:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 120
	mov	rax, QWORD PTR [rax]
	movss	xmm1, DWORD PTR -48[rbp]
	movss	xmm0, DWORD PTR .LC5[rip]
	addss	xmm0, xmm1
	movss	xmm2, DWORD PTR -44[rbp]
	movss	xmm1, DWORD PTR .LC5[rip]
	movaps	xmm3, xmm2
	addss	xmm3, xmm1
	movss	xmm1, DWORD PTR -40[rbp]
	movss	xmm2, DWORD PTR .LC5[rip]
	movaps	xmm4, xmm1
	subss	xmm4, xmm2
	movss	xmm1, DWORD PTR -36[rbp]
	movss	xmm2, DWORD PTR .LC5[rip]
	subss	xmm1, xmm2
	mov	DWORD PTR 64[rsp], 0
	mov	DWORD PTR 56[rsp], 65535
	mov	DWORD PTR 48[rsp], 1
	mov	DWORD PTR 40[rsp], eax
	movss	DWORD PTR 32[rsp], xmm0
	movaps	xmm2, xmm4
	mov	ecx, 0
	call	fb_GfxLine
	mov	QWORD PTR -32[rbp], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 40
	mov	rax, QWORD PTR [rax]
	sub	rax, 1
	mov	QWORD PTR -112[rbp], rax
	jmp	.L57
.L69:
	nop
.L58:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 48
	mov	rcx, QWORD PTR [rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 48
	mov	rax, QWORD PTR [rax]
	imul	rax, QWORD PTR -32[rbp]
	lea	rdx, 1[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 56
	mov	r8, rcx
	mov	rcx, rax
	call	fb_StrMid
	mov	QWORD PTR -120[rbp], rax
	mov	rax, QWORD PTR -32[rbp]
	sal	rax, 3
	pxor	xmm0, xmm0
	cvtsi2ssq	xmm0, rax
	addss	xmm0, DWORD PTR -40[rbp]
	movss	xmm1, DWORD PTR -36[rbp]
	mov	QWORD PTR 80[rsp], 0
	mov	QWORD PTR 72[rsp], 0
	mov	QWORD PTR 64[rsp], 0
	mov	DWORD PTR 56[rsp], 0
	mov	QWORD PTR 48[rsp], 0
	mov	DWORD PTR 40[rsp], 15
	mov	rax, QWORD PTR -120[rbp]
	mov	QWORD PTR 32[rsp], rax
	mov	r9d, 4
	movaps	xmm2, xmm0
	mov	ecx, 0
	call	fb_GfxDrawString
.L59:
	add	QWORD PTR -32[rbp], 1
.L57:
	mov	rax, QWORD PTR -32[rbp]
	cmp	rax, QWORD PTR -112[rbp]
	jle	.L69
.L60:
	lea	rax, -176[rbp]
	mov	rcx, rax
	call	fb_StrDelete
	jmp	.L61
.L50:
.L66:
	nop
.L61:
	nop
	movaps	xmm6, XMMWORD PTR -16[rbp]
	leave
	ret
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC6:
	.ascii "Display\0"
.LC7:
	.ascii "Host In\0"
.LC8:
	.ascii "Serial In\0"
.LC9:
	.ascii "Wire 1\0"
.LC10:
	.ascii "Serial Out\0"
.LC11:
	.ascii "Device Out\0"
.LC12:
	.ascii "Device In\0"
.LC13:
	.ascii "Wire 2\0"
.LC14:
	.ascii "Host Out\0"
.LC15:
	.ascii "Keyboard\0"
.LC16:
	.ascii "\33\0"
.LC17:
	.ascii "\11\0"
.LC18:
	.ascii "\15\0"
.LC19:
	.ascii "\377;\0"
.LC20:
	.ascii "\377T\0"
.LC21:
	.ascii "\377<\0"
.LC22:
	.ascii "\377U\0"
.LC23:
	.ascii "\377=\0"
.LC24:
	.ascii "\377V\0"
.LC25:
	.ascii "\377>\0"
.LC26:
	.ascii "\377?\0"
.LC27:
	.ascii "\377@\0"
.LC28:
	.ascii "\377A\0"
.LC29:
	.ascii "\377B\0"
.LC30:
	.ascii "\377C\0"
.LC31:
	.ascii " \0"
.LC32:
	.ascii "~\0"
.LC33:
	.ascii "---<<< P A U S E D >>>---\0"
.LC34:
	.ascii "Host Speed  : ###%\0"
.LC35:
	.ascii "  (F1/Shift+F1 to adjust)\0"
.LC36:
	.ascii "Serial Speed: ###%\0"
.LC37:
	.ascii "  (F2/Shift+F2 to adjust)\0"
.LC38:
	.ascii "Device Speed: ###%\0"
.LC39:
	.ascii "  (F3/Shift+F3 to adjust)\0"
.LC40:
	.ascii "Type keys to start\0"
.LC41:
	.ascii "ESC to EXIT\0"
.LC42:
	.ascii "F4 to clear display\0"
	.align 8
.LC43:
	.ascii "F5 to toggle 'Host Out' buffering\0"
	.align 8
.LC44:
	.ascii "F6 to toggle 'Device In' buffering\0"
	.align 8
.LC45:
	.ascii "F7 to toggle 'Device Out' buffering\0"
	.align 8
.LC46:
	.ascii "F8 to toggle 'Host In' buffering\0"
.LC47:
	.ascii "F9 to reset everything\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
main:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 2656
	mov	DWORD PTR 16[rbp], ecx
	mov	QWORD PTR 24[rbp], rdx
	call	__main
	mov	DWORD PTR -772[rbp], 0
	mov	rax, QWORD PTR 24[rbp]
	mov	r8d, 0
	mov	rdx, rax
	mov	ecx, DWORD PTR 16[rbp]
	call	fb_Init
.L71:
	lea	rax, -912[rbp]
	lea	rdx, -848[rbp]
	mov	QWORD PTR [rax], rdx
	lea	rax, -912[rbp]
	add	rax, 8
	lea	rdx, -848[rbp]
	mov	QWORD PTR [rax], rdx
	lea	rax, -912[rbp]
	add	rax, 16
	mov	QWORD PTR [rax], 64
	lea	rax, -912[rbp]
	add	rax, 24
	mov	QWORD PTR [rax], 16
	lea	rax, -912[rbp]
	add	rax, 32
	mov	QWORD PTR [rax], 1
	lea	rax, -912[rbp]
	add	rax, 40
	mov	QWORD PTR [rax], 4
	lea	rax, -912[rbp]
	add	rax, 48
	mov	QWORD PTR [rax], 0
	lea	rax, -912[rbp]
	add	rax, 56
	mov	QWORD PTR [rax], 3
	lea	rax, -848[rbp]
	mov	edx, 0
	mov	rcx, rax
	call	_ZN12ONDELAYTIMERC1Eu7INTEGER
	lea	rax, -848[rbp]
	add	rax, 16
	mov	edx, 10
	mov	rcx, rax
	call	_ZN12ONDELAYTIMERC1Eu7INTEGER
	lea	rax, -848[rbp]
	add	rax, 32
	mov	edx, 30
	mov	rcx, rax
	call	_ZN12ONDELAYTIMERC1Eu7INTEGER
	lea	rax, -848[rbp]
	add	rax, 48
	mov	edx, 20
	mov	rcx, rax
	call	_ZN12ONDELAYTIMERC1Eu7INTEGER
	lea	rax, -2512[rbp]
	lea	rdx, -2448[rbp]
	mov	QWORD PTR [rax], rdx
	lea	rax, -2512[rbp]
	add	rax, 8
	lea	rdx, -2448[rbp]
	mov	QWORD PTR [rax], rdx
	lea	rax, -2512[rbp]
	add	rax, 16
	mov	QWORD PTR [rax], 1536
	lea	rax, -2512[rbp]
	add	rax, 24
	mov	QWORD PTR [rax], 128
	lea	rax, -2512[rbp]
	add	rax, 32
	mov	QWORD PTR [rax], 1
	lea	rax, -2512[rbp]
	add	rax, 40
	mov	QWORD PTR [rax], 12
	lea	rax, -2512[rbp]
	add	rax, 48
	mov	QWORD PTR [rax], 0
	lea	rax, -2512[rbp]
	add	rax, 56
	mov	QWORD PTR [rax], 11
	lea	rax, -416[rbp]
	mov	QWORD PTR [rax], 0
	mov	QWORD PTR 8[rax], 0
	mov	QWORD PTR 16[rax], 0
	lea	rax, -416[rbp]
	mov	DWORD PTR 32[rsp], 0
	mov	r9d, 8
	lea	r8, .LC6[rip]
	mov	rdx, -1
	mov	rcx, rax
	call	fb_StrAssign
	mov	QWORD PTR -48[rbp], rax
	lea	rdx, -416[rbp]
	lea	rax, -2448[rbp]
	mov	QWORD PTR 64[rsp], 0
	mov	QWORD PTR 56[rsp], 1
	mov	QWORD PTR 48[rsp], 15
	mov	QWORD PTR 40[rsp], 16
	mov	QWORD PTR 32[rsp], 5
	mov	r9d, 5
	mov	r8d, 5
	mov	rcx, rax
	call	_ZN9COMPONENTC1ER8FBSTRINGu7INTEGERS2_S2_S2_S2_10TIMER_ENUM10STYLE_ENUM
	lea	rax, -448[rbp]
	mov	QWORD PTR [rax], 0
	mov	QWORD PTR 8[rax], 0
	mov	QWORD PTR 16[rax], 0
	lea	rax, -448[rbp]
	mov	DWORD PTR 32[rsp], 0
	mov	r9d, 8
	lea	r8, .LC7[rip]
	mov	rdx, -1
	mov	rcx, rax
	call	fb_StrAssign
	mov	QWORD PTR -56[rbp], rax
	lea	rax, -2448[rbp]
	sub	rax, -128
	lea	rdx, -448[rbp]
	mov	QWORD PTR 64[rsp], 0
	mov	QWORD PTR 56[rsp], 1
	mov	QWORD PTR 48[rsp], 14
	mov	QWORD PTR 40[rsp], 16
	mov	QWORD PTR 32[rsp], 1
	mov	r9d, 5
	mov	r8d, 15
	mov	rcx, rax
	call	_ZN9COMPONENTC1ER8FBSTRINGu7INTEGERS2_S2_S2_S2_10TIMER_ENUM10STYLE_ENUM
	lea	rax, -480[rbp]
	mov	QWORD PTR [rax], 0
	mov	QWORD PTR 8[rax], 0
	mov	QWORD PTR 16[rax], 0
	lea	rax, -480[rbp]
	mov	DWORD PTR 32[rsp], 0
	mov	r9d, 10
	lea	r8, .LC8[rip]
	mov	rdx, -1
	mov	rcx, rax
	call	fb_StrAssign
	mov	QWORD PTR -64[rbp], rax
	lea	rax, -2448[rbp]
	add	rax, 256
	lea	rdx, -480[rbp]
	mov	QWORD PTR 64[rsp], 0
	mov	QWORD PTR 56[rsp], 2
	mov	QWORD PTR 48[rsp], 8
	mov	QWORD PTR 40[rsp], 16
	mov	QWORD PTR 32[rsp], 1
	mov	r9d, 5
	mov	r8d, 20
	mov	rcx, rax
	call	_ZN9COMPONENTC1ER8FBSTRINGu7INTEGERS2_S2_S2_S2_10TIMER_ENUM10STYLE_ENUM
	lea	rax, -512[rbp]
	mov	QWORD PTR [rax], 0
	mov	QWORD PTR 8[rax], 0
	mov	QWORD PTR 16[rax], 0
	lea	rax, -512[rbp]
	mov	DWORD PTR 32[rsp], 0
	mov	r9d, 7
	lea	r8, .LC9[rip]
	mov	rdx, -1
	mov	rcx, rax
	call	fb_StrAssign
	mov	QWORD PTR -72[rbp], rax
	lea	rax, -2448[rbp]
	add	rax, 384
	lea	rdx, -512[rbp]
	mov	QWORD PTR 64[rsp], 1
	mov	QWORD PTR 56[rsp], 2
	mov	QWORD PTR 48[rsp], 8
	mov	QWORD PTR 40[rsp], 38
	mov	QWORD PTR 32[rsp], 1
	mov	r9d, 21
	mov	r8d, 20
	mov	rcx, rax
	call	_ZN9COMPONENTC1ER8FBSTRINGu7INTEGERS2_S2_S2_S2_10TIMER_ENUM10STYLE_ENUM
	lea	rax, -544[rbp]
	mov	QWORD PTR [rax], 0
	mov	QWORD PTR 8[rax], 0
	mov	QWORD PTR 16[rax], 0
	lea	rax, -544[rbp]
	mov	DWORD PTR 32[rsp], 0
	mov	r9d, 11
	lea	r8, .LC10[rip]
	mov	rdx, -1
	mov	rcx, rax
	call	fb_StrAssign
	mov	QWORD PTR -80[rbp], rax
	lea	rax, -2448[rbp]
	add	rax, 512
	lea	rdx, -544[rbp]
	mov	QWORD PTR 64[rsp], 0
	mov	QWORD PTR 56[rsp], 3
	mov	QWORD PTR 48[rsp], 8
	mov	QWORD PTR 40[rsp], 16
	mov	QWORD PTR 32[rsp], 1
	mov	r9d, 60
	mov	r8d, 20
	mov	rcx, rax
	call	_ZN9COMPONENTC1ER8FBSTRINGu7INTEGERS2_S2_S2_S2_10TIMER_ENUM10STYLE_ENUM
	lea	rax, -576[rbp]
	mov	QWORD PTR [rax], 0
	mov	QWORD PTR 8[rax], 0
	mov	QWORD PTR 16[rax], 0
	lea	rax, -576[rbp]
	mov	DWORD PTR 32[rsp], 0
	mov	r9d, 11
	lea	r8, .LC11[rip]
	mov	rdx, -1
	mov	rcx, rax
	call	fb_StrAssign
	mov	QWORD PTR -88[rbp], rax
	lea	rax, -2448[rbp]
	add	rax, 640
	lea	rdx, -576[rbp]
	mov	QWORD PTR 64[rsp], 0
	mov	QWORD PTR 56[rsp], 3
	mov	QWORD PTR 48[rsp], 14
	mov	QWORD PTR 40[rsp], 16
	mov	QWORD PTR 32[rsp], 1
	mov	r9d, 60
	mov	r8d, 25
	mov	rcx, rax
	call	_ZN9COMPONENTC1ER8FBSTRINGu7INTEGERS2_S2_S2_S2_10TIMER_ENUM10STYLE_ENUM
	lea	rax, -608[rbp]
	mov	QWORD PTR [rax], 0
	mov	QWORD PTR 8[rax], 0
	mov	QWORD PTR 16[rax], 0
	lea	rax, -608[rbp]
	mov	DWORD PTR 32[rsp], 0
	mov	r9d, 10
	lea	r8, .LC12[rip]
	mov	rdx, -1
	mov	rcx, rax
	call	fb_StrAssign
	mov	QWORD PTR -96[rbp], rax
	lea	rax, -2448[rbp]
	add	rax, 768
	lea	rdx, -608[rbp]
	mov	QWORD PTR 64[rsp], 0
	mov	QWORD PTR 56[rsp], 3
	mov	QWORD PTR 48[rsp], 14
	mov	QWORD PTR 40[rsp], 16
	mov	QWORD PTR 32[rsp], 1
	mov	r9d, 60
	mov	r8d, 30
	mov	rcx, rax
	call	_ZN9COMPONENTC1ER8FBSTRINGu7INTEGERS2_S2_S2_S2_10TIMER_ENUM10STYLE_ENUM
	lea	rax, -640[rbp]
	mov	QWORD PTR [rax], 0
	mov	QWORD PTR 8[rax], 0
	mov	QWORD PTR 16[rax], 0
	lea	rax, -640[rbp]
	mov	DWORD PTR 32[rsp], 0
	mov	r9d, 10
	lea	r8, .LC8[rip]
	mov	rdx, -1
	mov	rcx, rax
	call	fb_StrAssign
	mov	QWORD PTR -104[rbp], rax
	lea	rax, -2448[rbp]
	add	rax, 896
	lea	rdx, -640[rbp]
	mov	QWORD PTR 64[rsp], 0
	mov	QWORD PTR 56[rsp], 2
	mov	QWORD PTR 48[rsp], 8
	mov	QWORD PTR 40[rsp], 16
	mov	QWORD PTR 32[rsp], 1
	mov	r9d, 60
	mov	r8d, 35
	mov	rcx, rax
	call	_ZN9COMPONENTC1ER8FBSTRINGu7INTEGERS2_S2_S2_S2_10TIMER_ENUM10STYLE_ENUM
	lea	rax, -672[rbp]
	mov	QWORD PTR [rax], 0
	mov	QWORD PTR 8[rax], 0
	mov	QWORD PTR 16[rax], 0
	lea	rax, -672[rbp]
	mov	DWORD PTR 32[rsp], 0
	mov	r9d, 7
	lea	r8, .LC13[rip]
	mov	rdx, -1
	mov	rcx, rax
	call	fb_StrAssign
	mov	QWORD PTR -112[rbp], rax
	lea	rax, -2448[rbp]
	add	rax, 1024
	lea	rdx, -672[rbp]
	mov	QWORD PTR 64[rsp], 1
	mov	QWORD PTR 56[rsp], 2
	mov	QWORD PTR 48[rsp], 8
	mov	QWORD PTR 40[rsp], 38
	mov	QWORD PTR 32[rsp], 1
	mov	r9d, 21
	mov	r8d, 35
	mov	rcx, rax
	call	_ZN9COMPONENTC1ER8FBSTRINGu7INTEGERS2_S2_S2_S2_10TIMER_ENUM10STYLE_ENUM
	lea	rax, -704[rbp]
	mov	QWORD PTR [rax], 0
	mov	QWORD PTR 8[rax], 0
	mov	QWORD PTR 16[rax], 0
	lea	rax, -704[rbp]
	mov	DWORD PTR 32[rsp], 0
	mov	r9d, 11
	lea	r8, .LC10[rip]
	mov	rdx, -1
	mov	rcx, rax
	call	fb_StrAssign
	mov	QWORD PTR -120[rbp], rax
	lea	rax, -2448[rbp]
	add	rax, 1152
	lea	rdx, -704[rbp]
	mov	QWORD PTR 64[rsp], 0
	mov	QWORD PTR 56[rsp], 1
	mov	QWORD PTR 48[rsp], 8
	mov	QWORD PTR 40[rsp], 16
	mov	QWORD PTR 32[rsp], 1
	mov	r9d, 5
	mov	r8d, 35
	mov	rcx, rax
	call	_ZN9COMPONENTC1ER8FBSTRINGu7INTEGERS2_S2_S2_S2_10TIMER_ENUM10STYLE_ENUM
	lea	rax, -736[rbp]
	mov	QWORD PTR [rax], 0
	mov	QWORD PTR 8[rax], 0
	mov	QWORD PTR 16[rax], 0
	lea	rax, -736[rbp]
	mov	DWORD PTR 32[rsp], 0
	mov	r9d, 9
	lea	r8, .LC14[rip]
	mov	rdx, -1
	mov	rcx, rax
	call	fb_StrAssign
	mov	QWORD PTR -128[rbp], rax
	lea	rax, -2448[rbp]
	add	rax, 1280
	lea	rdx, -736[rbp]
	mov	QWORD PTR 64[rsp], 0
	mov	QWORD PTR 56[rsp], 1
	mov	QWORD PTR 48[rsp], 14
	mov	QWORD PTR 40[rsp], 16
	mov	QWORD PTR 32[rsp], 1
	mov	r9d, 5
	mov	r8d, 40
	mov	rcx, rax
	call	_ZN9COMPONENTC1ER8FBSTRINGu7INTEGERS2_S2_S2_S2_10TIMER_ENUM10STYLE_ENUM
	lea	rax, -768[rbp]
	mov	QWORD PTR [rax], 0
	mov	QWORD PTR 8[rax], 0
	mov	QWORD PTR 16[rax], 0
	lea	rax, -768[rbp]
	mov	DWORD PTR 32[rsp], 0
	mov	r9d, 9
	lea	r8, .LC15[rip]
	mov	rdx, -1
	mov	rcx, rax
	call	fb_StrAssign
	mov	QWORD PTR -136[rbp], rax
	lea	rax, -2448[rbp]
	add	rax, 1408
	lea	rdx, -768[rbp]
	mov	QWORD PTR 64[rsp], 0
	mov	QWORD PTR 56[rsp], -1
	mov	QWORD PTR 48[rsp], 15
	mov	QWORD PTR 40[rsp], 16
	mov	QWORD PTR 32[rsp], 1
	mov	r9d, 5
	mov	r8d, 45
	mov	rcx, rax
	call	_ZN9COMPONENTC1ER8FBSTRINGu7INTEGERS2_S2_S2_S2_10TIMER_ENUM10STYLE_ENUM
	lea	rax, -768[rbp]
	mov	rcx, rax
	call	fb_StrDelete
	lea	rax, -736[rbp]
	mov	rcx, rax
	call	fb_StrDelete
	lea	rax, -704[rbp]
	mov	rcx, rax
	call	fb_StrDelete
	lea	rax, -672[rbp]
	mov	rcx, rax
	call	fb_StrDelete
	lea	rax, -640[rbp]
	mov	rcx, rax
	call	fb_StrDelete
	lea	rax, -608[rbp]
	mov	rcx, rax
	call	fb_StrDelete
	lea	rax, -576[rbp]
	mov	rcx, rax
	call	fb_StrDelete
	lea	rax, -544[rbp]
	mov	rcx, rax
	call	fb_StrDelete
	lea	rax, -512[rbp]
	mov	rcx, rax
	call	fb_StrDelete
	lea	rax, -480[rbp]
	mov	rcx, rax
	call	fb_StrDelete
	lea	rax, -448[rbp]
	mov	rcx, rax
	call	fb_StrDelete
	lea	rax, -416[rbp]
	mov	rcx, rax
	call	fb_StrDelete
	lea	rax, -2448[rbp]
	add	rax, 80
	mov	BYTE PTR [rax], 1
	lea	rax, -2448[rbp]
	add	rax, 1240
	mov	QWORD PTR [rax], 1
	lea	rax, -2448[rbp]
	add	rax, 600
	mov	QWORD PTR [rax], 1
	lea	rax, -2448[rbp]
	add	rax, 472
	mov	QWORD PTR [rax], 1
	lea	rax, -2448[rbp]
	add	rax, 1112
	mov	QWORD PTR [rax], 1
	mov	QWORD PTR -8[rbp], 0
	mov	DWORD PTR 40[rsp], 0
	mov	DWORD PTR 32[rsp], 0
	mov	r9d, 2
	mov	r8d, 8
	mov	edx, 480
	mov	ecx, 640
	call	fb_GfxScreenRes
	mov	rax, QWORD PTR -8[rbp]
	mov	edx, eax
	mov	rax, QWORD PTR -8[rbp]
	mov	ecx, 1
	sub	ecx, eax
	mov	eax, ecx
	mov	ecx, eax
	call	fb_GfxPageSet
	mov	BYTE PTR -2513[rbp], 0
.L72:
	movzx	eax, BYTE PTR -2513[rbp]
	test	al, al
	jne	.L174
	call	_ZN12ONDELAYTIMER8NEXTTICKEv
	jmp	.L75
.L74:
.L174:
	nop
.L75:
	call	fb_Inkey
	mov	QWORD PTR -144[rbp], rax
	mov	rdx, QWORD PTR -144[rbp]
	lea	rax, -2544[rbp]
	mov	DWORD PTR 32[rsp], 0
	mov	r9, -1
	mov	r8, rdx
	mov	rdx, -1
	mov	rcx, rax
	call	fb_StrInit
	mov	QWORD PTR -152[rbp], rax
	lea	rax, -2544[rbp]
	mov	r9d, 2
	lea	r8, .LC16[rip]
	mov	rdx, -1
	mov	rcx, rax
	call	fb_StrCompare
	mov	DWORD PTR -156[rbp], eax
	cmp	DWORD PTR -156[rbp], 0
	jne	.L175
.L76:
	lea	rax, -2544[rbp]
	mov	rcx, rax
	call	fb_StrDelete
	nop
	jmp	.L156
.L175:
	nop
.L77:
	lea	rax, -2544[rbp]
	mov	r9d, 2
	lea	r8, .LC17[rip]
	mov	rdx, -1
	mov	rcx, rax
	call	fb_StrCompare
	mov	DWORD PTR -160[rbp], eax
	cmp	DWORD PTR -160[rbp], 0
	jne	.L176
.L79:
	movzx	eax, BYTE PTR -2513[rbp]
	test	al, al
	sete	al
	mov	BYTE PTR -2513[rbp], al
	jmp	.L114
.L176:
	nop
.L80:
	lea	rax, -2544[rbp]
	mov	r9d, 2
	lea	r8, .LC18[rip]
	mov	rdx, -1
	mov	rcx, rax
	call	fb_StrCompare
	mov	DWORD PTR -164[rbp], eax
	cmp	DWORD PTR -164[rbp], 0
	jne	.L177
.L82:
	lea	rax, -2448[rbp]
	add	rax, 1408
	lea	rdx, -2544[rbp]
	mov	rcx, rax
	call	_ZN9COMPONENT3ADDERK8FBSTRING
	jmp	.L114
.L177:
	nop
.L83:
	lea	rax, -2544[rbp]
	mov	r9d, 3
	lea	r8, .LC19[rip]
	mov	rdx, -1
	mov	rcx, rax
	call	fb_StrCompare
	mov	DWORD PTR -168[rbp], eax
	cmp	DWORD PTR -168[rbp], 0
	jne	.L178
.L84:
	lea	rax, -848[rbp]
	add	rax, 24
	lea	rdx, -848[rbp]
	add	rdx, 24
	mov	rdx, QWORD PTR [rdx]
	add	rdx, 1
	mov	QWORD PTR [rax], rdx
	jmp	.L114
.L178:
	nop
.L85:
	lea	rax, -2544[rbp]
	mov	r9d, 3
	lea	r8, .LC20[rip]
	mov	rdx, -1
	mov	rcx, rax
	call	fb_StrCompare
	mov	DWORD PTR -172[rbp], eax
	cmp	DWORD PTR -172[rbp], 0
	jne	.L179
.L86:
	lea	rax, -848[rbp]
	add	rax, 24
	lea	rdx, -848[rbp]
	add	rdx, 24
	mov	rdx, QWORD PTR [rdx]
	sub	rdx, 1
	mov	QWORD PTR [rax], rdx
	jmp	.L114
.L179:
	nop
.L87:
	lea	rax, -2544[rbp]
	mov	r9d, 3
	lea	r8, .LC21[rip]
	mov	rdx, -1
	mov	rcx, rax
	call	fb_StrCompare
	mov	DWORD PTR -176[rbp], eax
	cmp	DWORD PTR -176[rbp], 0
	jne	.L180
.L88:
	lea	rax, -848[rbp]
	add	rax, 40
	lea	rdx, -848[rbp]
	add	rdx, 40
	mov	rdx, QWORD PTR [rdx]
	add	rdx, 1
	mov	QWORD PTR [rax], rdx
	jmp	.L114
.L180:
	nop
.L89:
	lea	rax, -2544[rbp]
	mov	r9d, 3
	lea	r8, .LC22[rip]
	mov	rdx, -1
	mov	rcx, rax
	call	fb_StrCompare
	mov	DWORD PTR -180[rbp], eax
	cmp	DWORD PTR -180[rbp], 0
	jne	.L181
.L90:
	lea	rax, -848[rbp]
	add	rax, 40
	lea	rdx, -848[rbp]
	add	rdx, 40
	mov	rdx, QWORD PTR [rdx]
	sub	rdx, 1
	mov	QWORD PTR [rax], rdx
	jmp	.L114
.L181:
	nop
.L91:
	lea	rax, -2544[rbp]
	mov	r9d, 3
	lea	r8, .LC23[rip]
	mov	rdx, -1
	mov	rcx, rax
	call	fb_StrCompare
	mov	DWORD PTR -184[rbp], eax
	cmp	DWORD PTR -184[rbp], 0
	jne	.L182
.L92:
	lea	rax, -848[rbp]
	add	rax, 56
	lea	rdx, -848[rbp]
	add	rdx, 56
	mov	rdx, QWORD PTR [rdx]
	add	rdx, 1
	mov	QWORD PTR [rax], rdx
	jmp	.L114
.L182:
	nop
.L93:
	lea	rax, -2544[rbp]
	mov	r9d, 3
	lea	r8, .LC24[rip]
	mov	rdx, -1
	mov	rcx, rax
	call	fb_StrCompare
	mov	DWORD PTR -188[rbp], eax
	cmp	DWORD PTR -188[rbp], 0
	jne	.L183
.L94:
	lea	rax, -848[rbp]
	add	rax, 56
	lea	rdx, -848[rbp]
	add	rdx, 56
	mov	rdx, QWORD PTR [rdx]
	sub	rdx, 1
	mov	QWORD PTR [rax], rdx
	jmp	.L114
.L183:
	nop
.L95:
	lea	rax, -2544[rbp]
	mov	r9d, 3
	lea	r8, .LC25[rip]
	mov	rdx, -1
	mov	rcx, rax
	call	fb_StrCompare
	mov	DWORD PTR -192[rbp], eax
	cmp	DWORD PTR -192[rbp], 0
	jne	.L184
.L96:
	lea	rax, -2448[rbp]
	mov	r8d, 0
	mov	edx, 0
	mov	rcx, rax
	call	_ZN9COMPONENT6REMOVEEu7INTEGERS0_
	mov	QWORD PTR -232[rbp], rax
	mov	rax, QWORD PTR -232[rbp]
	mov	rcx, rax
	call	fb_hStrDelTemp
	jmp	.L114
.L184:
	nop
.L97:
	lea	rax, -2544[rbp]
	mov	r9d, 3
	lea	r8, .LC26[rip]
	mov	rdx, -1
	mov	rcx, rax
	call	fb_StrCompare
	mov	DWORD PTR -196[rbp], eax
	cmp	DWORD PTR -196[rbp], 0
	jne	.L185
.L98:
	lea	rax, -2448[rbp]
	add	rax, 1392
	lea	rdx, -2448[rbp]
	add	rdx, 1392
	mov	rdx, QWORD PTR [rdx]
	xor	rdx, 13
	mov	QWORD PTR [rax], rdx
	jmp	.L114
.L185:
	nop
.L99:
	lea	rax, -2544[rbp]
	mov	r9d, 3
	lea	r8, .LC27[rip]
	mov	rdx, -1
	mov	rcx, rax
	call	fb_StrCompare
	mov	DWORD PTR -200[rbp], eax
	cmp	DWORD PTR -200[rbp], 0
	jne	.L186
.L100:
	lea	rax, -2448[rbp]
	add	rax, 880
	lea	rdx, -2448[rbp]
	add	rdx, 880
	mov	rdx, QWORD PTR [rdx]
	xor	rdx, 13
	mov	QWORD PTR [rax], rdx
	jmp	.L114
.L186:
	nop
.L101:
	lea	rax, -2544[rbp]
	mov	r9d, 3
	lea	r8, .LC28[rip]
	mov	rdx, -1
	mov	rcx, rax
	call	fb_StrCompare
	mov	DWORD PTR -204[rbp], eax
	cmp	DWORD PTR -204[rbp], 0
	jne	.L187
.L102:
	lea	rax, -2448[rbp]
	add	rax, 752
	lea	rdx, -2448[rbp]
	add	rdx, 752
	mov	rdx, QWORD PTR [rdx]
	xor	rdx, 13
	mov	QWORD PTR [rax], rdx
	jmp	.L114
.L187:
	nop
.L103:
	lea	rax, -2544[rbp]
	mov	r9d, 3
	lea	r8, .LC29[rip]
	mov	rdx, -1
	mov	rcx, rax
	call	fb_StrCompare
	mov	DWORD PTR -208[rbp], eax
	cmp	DWORD PTR -208[rbp], 0
	jne	.L188
.L104:
	lea	rax, -2448[rbp]
	add	rax, 240
	lea	rdx, -2448[rbp]
	add	rdx, 240
	mov	rdx, QWORD PTR [rdx]
	xor	rdx, 13
	mov	QWORD PTR [rax], rdx
	jmp	.L114
.L188:
	nop
.L105:
	lea	rax, -2544[rbp]
	mov	r9d, 3
	lea	r8, .LC30[rip]
	mov	rdx, -1
	mov	rcx, rax
	call	fb_StrCompare
	mov	DWORD PTR -212[rbp], eax
	cmp	DWORD PTR -212[rbp], 0
	jne	.L189
.L106:
	mov	QWORD PTR -16[rbp], 0
.L108:
	mov	rax, QWORD PTR -16[rbp]
	sal	rax, 7
	lea	rdx, 56[rax]
	lea	rax, -2448[rbp]
	add	rax, rdx
	mov	DWORD PTR 32[rsp], 0
	mov	r9d, 1
	lea	r8, .LC3[rip]
	mov	rdx, -1
	mov	rcx, rax
	call	fb_StrAssign
	mov	rax, QWORD PTR -16[rbp]
	sal	rax, 7
	lea	rdx, 112[rax]
	lea	rax, -2448[rbp]
	add	rax, rdx
	mov	QWORD PTR [rax], 0
.L109:
	add	QWORD PTR -16[rbp], 1
.L110:
	cmp	QWORD PTR -16[rbp], 11
	jg	.L190
	jmp	.L108
.L111:
.L189:
	nop
.L107:
	lea	rax, -2544[rbp]
	mov	r9d, 2
	lea	r8, .LC31[rip]
	mov	rdx, -1
	mov	rcx, rax
	call	fb_StrCompare
	mov	DWORD PTR -216[rbp], eax
	cmp	DWORD PTR -216[rbp], 0
	js	.L191
	lea	rax, -2544[rbp]
	mov	r9d, 2
	lea	r8, .LC32[rip]
	mov	rdx, -1
	mov	rcx, rax
	call	fb_StrCompare
	mov	DWORD PTR -220[rbp], eax
	cmp	DWORD PTR -220[rbp], 0
	jg	.L192
.L113:
	lea	rax, -2448[rbp]
	add	rax, 1408
	lea	rdx, -2544[rbp]
	mov	rcx, rax
	call	_ZN9COMPONENT3ADDERK8FBSTRING
	jmp	.L114
.L81:
.L190:
	nop
	jmp	.L114
.L191:
	nop
	jmp	.L114
.L192:
	nop
.L114:
	lea	rax, -848[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	test	rax, rax
	jns	.L193
	lea	rax, -848[rbp]
	add	rax, 24
	mov	QWORD PTR [rax], 0
	jmp	.L119
.L193:
	nop
.L116:
	lea	rax, -848[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	cmp	rax, 100
	jle	.L194
	lea	rax, -848[rbp]
	add	rax, 24
	mov	QWORD PTR [rax], 100
	jmp	.L119
.L117:
.L194:
	nop
.L119:
	lea	rax, -848[rbp]
	add	rax, 40
	mov	rax, QWORD PTR [rax]
	test	rax, rax
	jns	.L195
	lea	rax, -848[rbp]
	add	rax, 40
	mov	QWORD PTR [rax], 0
	jmp	.L124
.L195:
	nop
.L121:
	lea	rax, -848[rbp]
	add	rax, 40
	mov	rax, QWORD PTR [rax]
	cmp	rax, 100
	jle	.L196
	lea	rax, -848[rbp]
	add	rax, 40
	mov	QWORD PTR [rax], 100
	jmp	.L124
.L122:
.L196:
	nop
.L124:
	lea	rax, -848[rbp]
	add	rax, 56
	mov	rax, QWORD PTR [rax]
	test	rax, rax
	jns	.L197
	lea	rax, -848[rbp]
	add	rax, 56
	mov	QWORD PTR [rax], 0
	jmp	.L129
.L197:
	nop
.L126:
	lea	rax, -848[rbp]
	add	rax, 56
	mov	rax, QWORD PTR [rax]
	cmp	rax, 100
	jle	.L198
	lea	rax, -848[rbp]
	add	rax, 56
	mov	QWORD PTR [rax], 100
	jmp	.L129
.L127:
.L198:
	nop
.L129:
	mov	QWORD PTR -24[rbp], 0
.L130:
	mov	rax, QWORD PTR -24[rbp]
	sal	rax, 7
	lea	rdx, 96[rax]
	lea	rax, -2448[rbp]
	add	rax, rdx
	mov	rax, QWORD PTR [rax]
	sal	rax, 4
	mov	rdx, rax
	lea	rax, -848[rbp]
	add	rax, rdx
	mov	rcx, rax
	call	_ZN12ONDELAYTIMER6STATUSEv
	mov	BYTE PTR -233[rbp], al
	cmp	BYTE PTR -233[rbp], 0
	je	.L199
	lea	rax, -2576[rbp]
	mov	QWORD PTR [rax], 0
	mov	QWORD PTR 8[rax], 0
	mov	QWORD PTR 16[rax], 0
	mov	rax, QWORD PTR -24[rbp]
	sal	rax, 7
	lea	rdx, 240[rax]
	lea	rax, -2448[rbp]
	add	rax, rdx
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR -24[rbp]
	sal	rax, 7
	lea	rcx, 216[rax]
	lea	rax, -2448[rbp]
	add	rax, rcx
	mov	rax, QWORD PTR [rax]
	mov	rcx, QWORD PTR -24[rbp]
	sal	rcx, 7
	lea	r8, 128[rcx]
	lea	rcx, -2448[rbp]
	add	rcx, r8
	mov	r8, rdx
	mov	rdx, rax
	call	_ZN9COMPONENT6REMOVEEu7INTEGERS0_
	mov	QWORD PTR -248[rbp], rax
	mov	rdx, QWORD PTR -248[rbp]
	lea	rax, -2576[rbp]
	mov	DWORD PTR 32[rsp], 0
	mov	r9, -1
	mov	r8, rdx
	mov	rdx, -1
	mov	rcx, rax
	call	fb_StrAssign
	mov	QWORD PTR -256[rbp], rax
	mov	rax, QWORD PTR -24[rbp]
	sal	rax, 7
	mov	rdx, rax
	lea	rax, -2448[rbp]
	lea	rcx, [rax+rdx]
	lea	rax, -2576[rbp]
	mov	rdx, rax
	call	_ZN9COMPONENT3ADDERK8FBSTRING
	lea	rax, -2576[rbp]
	mov	rcx, rax
	call	fb_StrDelete
	jmp	.L134
.L132:
.L133:
.L199:
	nop
.L134:
	add	QWORD PTR -24[rbp], 1
.L135:
	cmp	QWORD PTR -24[rbp], 10
	jg	.L136
	jmp	.L130
.L136:
	mov	QWORD PTR -32[rbp], 1
.L137:
	mov	rax, QWORD PTR -32[rbp]
	sal	rax, 4
	mov	rdx, rax
	lea	rax, -848[rbp]
	add	rax, rdx
	mov	rcx, rax
	call	_ZN12ONDELAYTIMER6STATUSEv
	mov	BYTE PTR -257[rbp], al
	cmp	BYTE PTR -257[rbp], 0
	je	.L200
	mov	rax, QWORD PTR -32[rbp]
	sal	rax, 4
	mov	rdx, rax
	lea	rax, -848[rbp]
	add	rax, rdx
	mov	rcx, rax
	call	_ZN12ONDELAYTIMER5RESETEv
	jmp	.L141
.L139:
.L140:
.L200:
	nop
.L141:
	add	QWORD PTR -32[rbp], 1
.L142:
	cmp	QWORD PTR -32[rbp], 3
	jg	.L143
	jmp	.L137
.L143:
	mov	ecx, -65536
	call	fb_Cls
	mov	QWORD PTR -40[rbp], 0
.L144:
	mov	rax, QWORD PTR -40[rbp]
	sal	rax, 7
	mov	rdx, rax
	lea	rax, -2448[rbp]
	add	rax, rdx
	mov	rcx, rax
	call	_ZN9COMPONENT6RENDEREv
.L145:
	add	QWORD PTR -40[rbp], 1
.L146:
	cmp	QWORD PTR -40[rbp], 11
	jg	.L147
	jmp	.L144
.L147:
	movzx	eax, BYTE PTR -2513[rbp]
	test	al, al
	je	.L201
	mov	r8d, 2
	mov	edx, 0
	mov	ecx, 12
	call	fb_Color
	mov	DWORD PTR 32[rsp], 0
	mov	r9d, 0
	mov	r8d, -1
	mov	edx, 20
	mov	ecx, 27
	call	fb_Locate
	mov	edx, 25
	lea	rcx, .LC33[rip]
	call	fb_StrAllocTempDescZEx
	mov	QWORD PTR -272[rbp], rax
	mov	rax, QWORD PTR -272[rbp]
	mov	r8d, 1
	mov	rdx, rax
	mov	ecx, 0
	call	fb_PrintString
	jmp	.L150
.L149:
.L201:
	nop
.L150:
	mov	DWORD PTR 32[rsp], 0
	mov	r9d, 0
	mov	r8d, -1
	mov	edx, 30
	mov	ecx, 5
	call	fb_Locate
	mov	r8d, 2
	mov	edx, 0
	mov	ecx, 15
	call	fb_Color
	mov	edx, 18
	lea	rcx, .LC34[rip]
	call	fb_StrAllocTempDescZEx
	mov	QWORD PTR -280[rbp], rax
	mov	rax, QWORD PTR -280[rbp]
	mov	rcx, rax
	call	fb_PrintUsingInit
	lea	rax, -848[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	mov	edx, 100
	sub	rdx, rax
	mov	rax, rdx
	mov	r8d, 0
	mov	rdx, rax
	mov	ecx, 0
	call	fb_PrintUsingLongint
	mov	ecx, 0
	call	fb_PrintUsingEnd
	mov	r8d, 2
	mov	edx, 0
	mov	ecx, 7
	call	fb_Color
	mov	edx, 25
	lea	rcx, .LC35[rip]
	call	fb_StrAllocTempDescZEx
	mov	QWORD PTR -288[rbp], rax
	mov	rax, QWORD PTR -288[rbp]
	mov	r8d, 1
	mov	rdx, rax
	mov	ecx, 0
	call	fb_PrintString
	mov	DWORD PTR 32[rsp], 0
	mov	r9d, 0
	mov	r8d, -1
	mov	edx, 30
	mov	ecx, 7
	call	fb_Locate
	mov	r8d, 2
	mov	edx, 0
	mov	ecx, 15
	call	fb_Color
	mov	edx, 18
	lea	rcx, .LC36[rip]
	call	fb_StrAllocTempDescZEx
	mov	QWORD PTR -296[rbp], rax
	mov	rax, QWORD PTR -296[rbp]
	mov	rcx, rax
	call	fb_PrintUsingInit
	lea	rax, -848[rbp]
	add	rax, 40
	mov	rax, QWORD PTR [rax]
	mov	edx, 100
	sub	rdx, rax
	mov	rax, rdx
	mov	r8d, 0
	mov	rdx, rax
	mov	ecx, 0
	call	fb_PrintUsingLongint
	mov	ecx, 0
	call	fb_PrintUsingEnd
	mov	r8d, 2
	mov	edx, 0
	mov	ecx, 7
	call	fb_Color
	mov	edx, 25
	lea	rcx, .LC37[rip]
	call	fb_StrAllocTempDescZEx
	mov	QWORD PTR -304[rbp], rax
	mov	rax, QWORD PTR -304[rbp]
	mov	r8d, 1
	mov	rdx, rax
	mov	ecx, 0
	call	fb_PrintString
	mov	DWORD PTR 32[rsp], 0
	mov	r9d, 0
	mov	r8d, -1
	mov	edx, 30
	mov	ecx, 9
	call	fb_Locate
	mov	r8d, 2
	mov	edx, 0
	mov	ecx, 15
	call	fb_Color
	mov	edx, 18
	lea	rcx, .LC38[rip]
	call	fb_StrAllocTempDescZEx
	mov	QWORD PTR -312[rbp], rax
	mov	rax, QWORD PTR -312[rbp]
	mov	rcx, rax
	call	fb_PrintUsingInit
	lea	rax, -848[rbp]
	add	rax, 56
	mov	rax, QWORD PTR [rax]
	mov	edx, 100
	sub	rdx, rax
	mov	rax, rdx
	mov	r8d, 0
	mov	rdx, rax
	mov	ecx, 0
	call	fb_PrintUsingLongint
	mov	ecx, 0
	call	fb_PrintUsingEnd
	mov	r8d, 2
	mov	edx, 0
	mov	ecx, 7
	call	fb_Color
	mov	edx, 25
	lea	rcx, .LC39[rip]
	call	fb_StrAllocTempDescZEx
	mov	QWORD PTR -320[rbp], rax
	mov	rax, QWORD PTR -320[rbp]
	mov	r8d, 1
	mov	rdx, rax
	mov	ecx, 0
	call	fb_PrintString
	mov	r8d, 2
	mov	edx, 0
	mov	ecx, 10
	call	fb_Color
	mov	DWORD PTR 32[rsp], 0
	mov	r9d, 0
	mov	r8d, -1
	mov	edx, 5
	mov	ecx, 48
	call	fb_Locate
	mov	edx, 18
	lea	rcx, .LC40[rip]
	call	fb_StrAllocTempDescZEx
	mov	QWORD PTR -328[rbp], rax
	mov	rax, QWORD PTR -328[rbp]
	mov	r8d, 1
	mov	rdx, rax
	mov	ecx, 0
	call	fb_PrintString
	mov	r8d, 2
	mov	edx, 0
	mov	ecx, 7
	call	fb_Color
	mov	DWORD PTR 32[rsp], 0
	mov	r9d, 0
	mov	r8d, -1
	mov	edx, 5
	mov	ecx, 50
	call	fb_Locate
	mov	edx, 11
	lea	rcx, .LC41[rip]
	call	fb_StrAllocTempDescZEx
	mov	QWORD PTR -336[rbp], rax
	mov	rax, QWORD PTR -336[rbp]
	mov	r8d, 1
	mov	rdx, rax
	mov	ecx, 0
	call	fb_PrintString
	mov	r8d, 2
	mov	edx, 0
	mov	ecx, 7
	call	fb_Color
	mov	DWORD PTR 32[rsp], 0
	mov	r9d, 0
	mov	r8d, -1
	mov	edx, 30
	mov	ecx, 40
	call	fb_Locate
	mov	edx, 19
	lea	rcx, .LC42[rip]
	call	fb_StrAllocTempDescZEx
	mov	QWORD PTR -344[rbp], rax
	mov	rax, QWORD PTR -344[rbp]
	mov	r8d, 1
	mov	rdx, rax
	mov	ecx, 0
	call	fb_PrintString
	mov	r8d, 2
	mov	edx, 0
	mov	ecx, 14
	call	fb_Color
	mov	DWORD PTR 32[rsp], 0
	mov	r9d, 0
	mov	r8d, -1
	mov	edx, 30
	mov	ecx, 42
	call	fb_Locate
	mov	edx, 33
	lea	rcx, .LC43[rip]
	call	fb_StrAllocTempDescZEx
	mov	QWORD PTR -352[rbp], rax
	mov	rax, QWORD PTR -352[rbp]
	mov	r8d, 1
	mov	rdx, rax
	mov	ecx, 0
	call	fb_PrintString
	mov	DWORD PTR 32[rsp], 0
	mov	r9d, 0
	mov	r8d, -1
	mov	edx, 30
	mov	ecx, 44
	call	fb_Locate
	mov	edx, 34
	lea	rcx, .LC44[rip]
	call	fb_StrAllocTempDescZEx
	mov	QWORD PTR -360[rbp], rax
	mov	rax, QWORD PTR -360[rbp]
	mov	r8d, 1
	mov	rdx, rax
	mov	ecx, 0
	call	fb_PrintString
	mov	DWORD PTR 32[rsp], 0
	mov	r9d, 0
	mov	r8d, -1
	mov	edx, 30
	mov	ecx, 46
	call	fb_Locate
	mov	edx, 35
	lea	rcx, .LC45[rip]
	call	fb_StrAllocTempDescZEx
	mov	QWORD PTR -368[rbp], rax
	mov	rax, QWORD PTR -368[rbp]
	mov	r8d, 1
	mov	rdx, rax
	mov	ecx, 0
	call	fb_PrintString
	mov	DWORD PTR 32[rsp], 0
	mov	r9d, 0
	mov	r8d, -1
	mov	edx, 30
	mov	ecx, 48
	call	fb_Locate
	mov	edx, 32
	lea	rcx, .LC46[rip]
	call	fb_StrAllocTempDescZEx
	mov	QWORD PTR -376[rbp], rax
	mov	rax, QWORD PTR -376[rbp]
	mov	r8d, 1
	mov	rdx, rax
	mov	ecx, 0
	call	fb_PrintString
	mov	r8d, 2
	mov	edx, 0
	mov	ecx, 7
	call	fb_Color
	mov	DWORD PTR 32[rsp], 0
	mov	r9d, 0
	mov	r8d, -1
	mov	edx, 30
	mov	ecx, 50
	call	fb_Locate
	mov	edx, 22
	lea	rcx, .LC47[rip]
	call	fb_StrAllocTempDescZEx
	mov	QWORD PTR -384[rbp], rax
	mov	rax, QWORD PTR -384[rbp]
	mov	r8d, 1
	mov	rdx, rax
	mov	ecx, 0
	call	fb_PrintString
	mov	eax, 1
	sub	rax, QWORD PTR -8[rbp]
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -8[rbp]
	mov	edx, eax
	mov	rax, QWORD PTR -8[rbp]
	mov	ecx, 1
	sub	ecx, eax
	mov	eax, ecx
	mov	ecx, eax
	call	fb_GfxPageSet
	mov	edx, 1
	mov	ecx, 25
	call	fb_SleepEx
	lea	rax, -2544[rbp]
	mov	rcx, rax
	call	fb_StrDelete
.L151:
	jmp	.L72
.L156:
.L152:
	lea	rax, -2512[rbp]
	lea	rdx, _ZN9COMPONENTD1Ev[rip]
	mov	rcx, rax
	call	fb_ArrayDestructObj
.L153:
	mov	ecx, 0
	call	fb_End
	mov	eax, DWORD PTR -772[rbp]
	leave
	ret
	.def	_ZN9COMPONENTaSERKS_;	.scl	3;	.type	32;	.endef
_ZN9COMPONENTaSERKS_:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 64
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
.L203:
	mov	rax, QWORD PTR 24[rbp]
	mov	DWORD PTR 32[rsp], 0
	mov	r9, -1
	mov	r8, rax
	mov	rdx, -1
	mov	rcx, QWORD PTR 16[rbp]
	call	fb_StrAssign
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 24[rax]
	mov	rax, QWORD PTR 24[rbp]
	mov	rax, QWORD PTR 24[rax]
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 32[rax]
	mov	rax, QWORD PTR 24[rbp]
	mov	rax, QWORD PTR 32[rax]
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 40[rax]
	mov	rax, QWORD PTR 24[rbp]
	mov	rax, QWORD PTR 40[rax]
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 48[rax]
	mov	rax, QWORD PTR 24[rbp]
	mov	rax, QWORD PTR 48[rax]
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR 24[rbp]
	lea	rdx, 56[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 56
	mov	DWORD PTR 32[rsp], 0
	mov	r9, -1
	mov	r8, rdx
	mov	rdx, -1
	mov	rcx, rax
	call	fb_StrAssign
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 80[rax]
	mov	rax, QWORD PTR 24[rbp]
	movzx	eax, BYTE PTR 80[rax]
	mov	BYTE PTR [rdx], al
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 88[rax]
	mov	rax, QWORD PTR 24[rbp]
	mov	rax, QWORD PTR 88[rax]
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 96[rax]
	mov	rax, QWORD PTR 24[rbp]
	mov	rax, QWORD PTR 96[rax]
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 104[rax]
	mov	rax, QWORD PTR 24[rbp]
	mov	rax, QWORD PTR 104[rax]
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 112[rax]
	mov	rax, QWORD PTR 24[rbp]
	mov	rax, QWORD PTR 112[rax]
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 120[rax]
	mov	rax, QWORD PTR 24[rbp]
	mov	rax, QWORD PTR 120[rax]
	mov	QWORD PTR [rdx], rax
	nop
	leave
	ret
.L204:
	.def	_ZN9COMPONENTD1Ev;	.scl	3;	.type	32;	.endef
_ZN9COMPONENTD1Ev:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR 16[rbp], rcx
.L206:
.L207:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 56
	mov	rcx, rax
	call	fb_StrDelete
	mov	rcx, QWORD PTR 16[rbp]
	call	fb_StrDelete
	nop
	leave
	ret
	.section .rdata,"dr"
	.align 4
.LC0:
	.long	1082130432
	.align 4
.LC2:
	.long	1098907648
	.align 4
.LC4:
	.long	1073741824
	.align 4
.LC5:
	.long	1077936128
	.ident	"GCC: (x86_64-win32-sjlj-rev0, Built by MinGW-W64 project) 5.2.0"
	.def	fb_StrAssign;	.scl	2;	.type	32;	.endef
	.def	fb_StrConcat;	.scl	2;	.type	32;	.endef
	.def	fb_StrLen;	.scl	2;	.type	32;	.endef
	.def	fb_StrMid;	.scl	2;	.type	32;	.endef
	.def	fb_LEFT;	.scl	2;	.type	32;	.endef
	.def	fb_CHR;	.scl	2;	.type	32;	.endef
	.def	fb_StrInstr;	.scl	2;	.type	32;	.endef
	.def	fb_StrAllocTempResult;	.scl	2;	.type	32;	.endef
	.def	fb_GfxLine;	.scl	2;	.type	32;	.endef
	.def	fb_StrInit;	.scl	2;	.type	32;	.endef
	.def	nearbyintf;	.scl	2;	.type	32;	.endef
	.def	fb_GfxDrawString;	.scl	2;	.type	32;	.endef
	.def	fb_StrDelete;	.scl	2;	.type	32;	.endef
	.def	fb_StrConcatAssign;	.scl	2;	.type	32;	.endef
	.def	fb_StrCompare;	.scl	2;	.type	32;	.endef
	.def	fb_Init;	.scl	2;	.type	32;	.endef
	.def	fb_GfxScreenRes;	.scl	2;	.type	32;	.endef
	.def	fb_GfxPageSet;	.scl	2;	.type	32;	.endef
	.def	fb_Inkey;	.scl	2;	.type	32;	.endef
	.def	fb_hStrDelTemp;	.scl	2;	.type	32;	.endef
	.def	fb_Cls;	.scl	2;	.type	32;	.endef
	.def	fb_Color;	.scl	2;	.type	32;	.endef
	.def	fb_Locate;	.scl	2;	.type	32;	.endef
	.def	fb_StrAllocTempDescZEx;	.scl	2;	.type	32;	.endef
	.def	fb_PrintString;	.scl	2;	.type	32;	.endef
	.def	fb_PrintUsingInit;	.scl	2;	.type	32;	.endef
	.def	fb_PrintUsingLongint;	.scl	2;	.type	32;	.endef
	.def	fb_PrintUsingEnd;	.scl	2;	.type	32;	.endef
	.def	fb_SleepEx;	.scl	2;	.type	32;	.endef
	.def	fb_ArrayDestructObj;	.scl	2;	.type	32;	.endef
	.def	fb_End;	.scl	2;	.type	32;	.endef
