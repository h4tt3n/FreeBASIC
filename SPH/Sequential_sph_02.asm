	.file	"Sequential_sph_02.c"
	.intel_syntax noprefix
.lcomm SIMULATION$,3530568,32
	.text
	.globl	_ZN4VEC2C1Ev
	.def	_ZN4VEC2C1Ev;	.scl	2;	.type	32;	.endef
_ZN4VEC2C1Ev:
	push	rbp
	mov	rbp, rsp
	mov	QWORD PTR 16[rbp], rcx
.L2:
	mov	rax, QWORD PTR 16[rbp]
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 4
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	pxor	xmm0, xmm0
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 4
	pxor	xmm0, xmm0
	movss	DWORD PTR [rax], xmm0
	nop
	pop	rbp
	ret
.L3:
	.globl	_ZN4VEC2C1ERKS_
	.def	_ZN4VEC2C1ERKS_;	.scl	2;	.type	32;	.endef
_ZN4VEC2C1ERKS_:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
.L5:
	mov	rax, QWORD PTR 16[rbp]
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 4
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR 24[rbp]
	mov	rdx, rax
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZN4VEC2aSERKS_
	nop
	leave
	ret
.L6:
	.globl	_ZN4VEC2C1EfS0_
	.def	_ZN4VEC2C1EfS0_;	.scl	2;	.type	32;	.endef
_ZN4VEC2C1EfS0_:
	push	rbp
	mov	rbp, rsp
	mov	QWORD PTR 16[rbp], rcx
	movss	DWORD PTR 24[rbp], xmm1
	movss	DWORD PTR 32[rbp], xmm2
.L8:
	mov	rax, QWORD PTR 16[rbp]
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 4
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	movss	xmm0, DWORD PTR 24[rbp]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 4
	movss	xmm0, DWORD PTR 32[rbp]
	movss	DWORD PTR [rax], xmm0
	nop
	pop	rbp
	ret
.L9:
	.globl	_ZN4VEC2aSERKS_
	.def	_ZN4VEC2aSERKS_;	.scl	2;	.type	32;	.endef
_ZN4VEC2aSERKS_:
	push	rbp
	mov	rbp, rsp
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
.L11:
	mov	rax, QWORD PTR 16[rbp]
	cmp	rax, QWORD PTR 24[rbp]
	je	.L16
	mov	rax, QWORD PTR 24[rbp]
	movss	xmm0, DWORD PTR [rax]
	mov	rax, QWORD PTR 16[rbp]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 4[rax]
	mov	rax, QWORD PTR 24[rbp]
	movss	xmm0, DWORD PTR 4[rax]
	movss	DWORD PTR [rdx], xmm0
	jmp	.L15
.L13:
.L14:
.L16:
	nop
.L15:
	nop
	pop	rbp
	ret
	.globl	_ZN4VEC2pLERKS_
	.def	_ZN4VEC2pLERKS_;	.scl	2;	.type	32;	.endef
_ZN4VEC2pLERKS_:
	push	rbp
	mov	rbp, rsp
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
.L18:
	mov	rax, QWORD PTR 16[rbp]
	movss	xmm1, DWORD PTR [rax]
	mov	rax, QWORD PTR 24[rbp]
	movss	xmm0, DWORD PTR [rax]
	addss	xmm0, xmm1
	mov	rax, QWORD PTR 16[rbp]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 4
	mov	rdx, QWORD PTR 16[rbp]
	add	rdx, 4
	movss	xmm1, DWORD PTR [rdx]
	mov	rdx, QWORD PTR 24[rbp]
	add	rdx, 4
	movss	xmm0, DWORD PTR [rdx]
	addss	xmm0, xmm1
	movss	DWORD PTR [rax], xmm0
	nop
	pop	rbp
	ret
.L19:
	.globl	_ZN4VEC2mIERKS_
	.def	_ZN4VEC2mIERKS_;	.scl	2;	.type	32;	.endef
_ZN4VEC2mIERKS_:
	push	rbp
	mov	rbp, rsp
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
.L21:
	mov	rax, QWORD PTR 16[rbp]
	movss	xmm0, DWORD PTR [rax]
	mov	rax, QWORD PTR 24[rbp]
	movss	xmm1, DWORD PTR [rax]
	subss	xmm0, xmm1
	mov	rax, QWORD PTR 16[rbp]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 4
	mov	rdx, QWORD PTR 16[rbp]
	add	rdx, 4
	movss	xmm0, DWORD PTR [rdx]
	mov	rdx, QWORD PTR 24[rbp]
	add	rdx, 4
	movss	xmm1, DWORD PTR [rdx]
	subss	xmm0, xmm1
	movss	DWORD PTR [rax], xmm0
	nop
	pop	rbp
	ret
.L22:
	.globl	_ZN4VEC2mLERKS_
	.def	_ZN4VEC2mLERKS_;	.scl	2;	.type	32;	.endef
_ZN4VEC2mLERKS_:
	push	rbp
	mov	rbp, rsp
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
.L24:
	mov	rax, QWORD PTR 16[rbp]
	movss	xmm1, DWORD PTR [rax]
	mov	rax, QWORD PTR 24[rbp]
	movss	xmm0, DWORD PTR [rax]
	mulss	xmm0, xmm1
	mov	rax, QWORD PTR 16[rbp]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 4
	mov	rdx, QWORD PTR 16[rbp]
	add	rdx, 4
	movss	xmm1, DWORD PTR [rdx]
	mov	rdx, QWORD PTR 24[rbp]
	add	rdx, 4
	movss	xmm0, DWORD PTR [rdx]
	mulss	xmm0, xmm1
	movss	DWORD PTR [rax], xmm0
	nop
	pop	rbp
	ret
.L25:
	.globl	_ZN4VEC2mLEf
	.def	_ZN4VEC2mLEf;	.scl	2;	.type	32;	.endef
_ZN4VEC2mLEf:
	push	rbp
	mov	rbp, rsp
	mov	QWORD PTR 16[rbp], rcx
	movss	DWORD PTR 24[rbp], xmm1
.L27:
	mov	rax, QWORD PTR 16[rbp]
	movss	xmm0, DWORD PTR [rax]
	mulss	xmm0, DWORD PTR 24[rbp]
	mov	rax, QWORD PTR 16[rbp]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 4
	mov	rdx, QWORD PTR 16[rbp]
	add	rdx, 4
	movss	xmm0, DWORD PTR [rdx]
	mulss	xmm0, DWORD PTR 24[rbp]
	movss	DWORD PTR [rax], xmm0
	nop
	pop	rbp
	ret
.L28:
	.globl	_ZN4VEC2dVEf
	.def	_ZN4VEC2dVEf;	.scl	2;	.type	32;	.endef
_ZN4VEC2dVEf:
	push	rbp
	mov	rbp, rsp
	mov	QWORD PTR 16[rbp], rcx
	movss	DWORD PTR 24[rbp], xmm1
.L30:
	mov	rax, QWORD PTR 16[rbp]
	movss	xmm0, DWORD PTR [rax]
	divss	xmm0, DWORD PTR 24[rbp]
	mov	rax, QWORD PTR 16[rbp]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 4
	mov	rdx, QWORD PTR 16[rbp]
	add	rdx, 4
	movss	xmm0, DWORD PTR [rdx]
	divss	xmm0, DWORD PTR 24[rbp]
	movss	DWORD PTR [rax], xmm0
	nop
	pop	rbp
	ret
.L31:
	.globl	_ZNK4VEC28ABSOLUTEEv
	.def	_ZNK4VEC28ABSOLUTEEv;	.scl	2;	.type	32;	.endef
_ZNK4VEC28ABSOLUTEEv:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	QWORD PTR 16[rbp], rcx
.L33:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 4
	movss	xmm1, DWORD PTR [rax]
	movss	xmm0, DWORD PTR .LC1[rip]
	movaps	xmm2, xmm1
	andps	xmm2, xmm0
	mov	rax, QWORD PTR 16[rbp]
	movss	xmm1, DWORD PTR [rax]
	movss	xmm0, DWORD PTR .LC1[rip]
	andps	xmm0, xmm1
	lea	rax, -16[rbp]
	movaps	xmm1, xmm0
	mov	rcx, rax
	call	_ZN4VEC2C1EfS0_
	nop
.L34:
	mov	rax, QWORD PTR -16[rbp]
	leave
	ret
	.globl	_ZNK4VEC24PERPEv
	.def	_ZNK4VEC24PERPEv;	.scl	2;	.type	32;	.endef
_ZNK4VEC24PERPEv:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	QWORD PTR 16[rbp], rcx
.L37:
	mov	rax, QWORD PTR 16[rbp]
	movss	xmm1, DWORD PTR [rax]
	movss	xmm0, DWORD PTR .LC2[rip]
	xorps	xmm0, xmm1
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 4
	movss	xmm1, DWORD PTR [rax]
	lea	rax, -16[rbp]
	movaps	xmm2, xmm0
	mov	rcx, rax
	call	_ZN4VEC2C1EfS0_
	nop
.L38:
	mov	rax, QWORD PTR -16[rbp]
	leave
	ret
	.globl	_ZNK4VEC24UNITEv
	.def	_ZNK4VEC24UNITEv;	.scl	2;	.type	32;	.endef
_ZNK4VEC24UNITEv:
	push	rbp
	mov	rbp, rsp
	add	rsp, -128
	mov	QWORD PTR 16[rbp], rcx
.L41:
	lea	rax, -32[rbp]
	pxor	xmm2, xmm2
	pxor	xmm1, xmm1
	mov	rcx, rax
	call	_ZN4VEC2C1EfS0_
	mov	rax, QWORD PTR -32[rbp]
	mov	rdx, rax
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZneRK4VEC2S0_
	mov	QWORD PTR -8[rbp], rax
	cmp	QWORD PTR -8[rbp], 0
	je	.L48
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZNK4VEC26LENGTHEv
	movd	eax, xmm0
	mov	DWORD PTR -12[rbp], eax
	movss	xmm0, DWORD PTR -12[rbp]
	movaps	xmm1, xmm0
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZdvRK4VEC2f
	mov	QWORD PTR -96[rbp], rax
	mov	rax, QWORD PTR -96[rbp]
	mov	QWORD PTR -48[rbp], rax
	lea	rdx, -48[rbp]
	lea	rax, -64[rbp]
	mov	rcx, rax
	call	_ZN4VEC2C1ERKS_
	jmp	.L44
.L48:
	nop
.L43:
	lea	rax, -64[rbp]
	pxor	xmm2, xmm2
	pxor	xmm1, xmm1
	mov	rcx, rax
	call	_ZN4VEC2C1EfS0_
.L44:
	lea	rdx, -64[rbp]
	lea	rax, -80[rbp]
	mov	rcx, rax
	call	_ZN4VEC2C1ERKS_
	nop
.L45:
	mov	rax, QWORD PTR -80[rbp]
	leave
	ret
	.globl	_ZNK4VEC26LENGTHEv
	.def	_ZNK4VEC26LENGTHEv;	.scl	2;	.type	32;	.endef
_ZNK4VEC26LENGTHEv:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	QWORD PTR 16[rbp], rcx
	lea	rax, -12[rbp]
	mov	DWORD PTR [rax], 0
.L50:
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZNK4VEC213LENGTHSQUAREDEv
	movd	eax, xmm0
	mov	DWORD PTR -4[rbp], eax
	movss	xmm0, DWORD PTR -4[rbp]
	movss	DWORD PTR -8[rbp], xmm0
	sqrtss	xmm0, DWORD PTR -8[rbp]
	movss	DWORD PTR -12[rbp], xmm0
	nop
.L51:
	movss	xmm0, DWORD PTR -12[rbp]
	leave
	ret
	.globl	_ZNK4VEC213LENGTHSQUAREDEv
	.def	_ZNK4VEC213LENGTHSQUAREDEv;	.scl	2;	.type	32;	.endef
_ZNK4VEC213LENGTHSQUAREDEv:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	mov	QWORD PTR 16[rbp], rcx
	lea	rax, -4[rbp]
	mov	DWORD PTR [rax], 0
.L54:
	mov	rax, QWORD PTR 16[rbp]
	movss	xmm1, DWORD PTR [rax]
	mov	rax, QWORD PTR 16[rbp]
	movss	xmm0, DWORD PTR [rax]
	mulss	xmm1, xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 4
	movss	xmm2, DWORD PTR [rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 4
	movss	xmm0, DWORD PTR [rax]
	mulss	xmm0, xmm2
	addss	xmm0, xmm1
	movss	DWORD PTR -4[rbp], xmm0
	nop
.L55:
	movss	xmm0, DWORD PTR -4[rbp]
	leave
	ret
	.globl	_ZNK4VEC23DOTEf
	.def	_ZNK4VEC23DOTEf;	.scl	2;	.type	32;	.endef
_ZNK4VEC23DOTEf:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	QWORD PTR 16[rbp], rcx
	movss	DWORD PTR 24[rbp], xmm1
.L58:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 4
	movss	xmm0, DWORD PTR [rax]
	movaps	xmm1, xmm0
	mulss	xmm1, DWORD PTR 24[rbp]
	mov	rax, QWORD PTR 16[rbp]
	movss	xmm0, DWORD PTR [rax]
	mulss	xmm0, DWORD PTR 24[rbp]
	lea	rax, -16[rbp]
	movaps	xmm2, xmm1
	movaps	xmm1, xmm0
	mov	rcx, rax
	call	_ZN4VEC2C1EfS0_
	nop
.L59:
	mov	rax, QWORD PTR -16[rbp]
	leave
	ret
	.globl	_ZNK4VEC23DOTERKS_
	.def	_ZNK4VEC23DOTERKS_;	.scl	2;	.type	32;	.endef
_ZNK4VEC23DOTERKS_:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
	lea	rax, -4[rbp]
	mov	DWORD PTR [rax], 0
.L62:
	mov	rax, QWORD PTR 16[rbp]
	movss	xmm1, DWORD PTR [rax]
	mov	rax, QWORD PTR 24[rbp]
	movss	xmm0, DWORD PTR [rax]
	mulss	xmm1, xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 4
	movss	xmm2, DWORD PTR [rax]
	mov	rax, QWORD PTR 24[rbp]
	add	rax, 4
	movss	xmm0, DWORD PTR [rax]
	mulss	xmm0, xmm2
	addss	xmm0, xmm1
	movss	DWORD PTR -4[rbp], xmm0
	nop
.L63:
	movss	xmm0, DWORD PTR -4[rbp]
	leave
	ret
	.globl	_ZNK4VEC27PERPDOTEf
	.def	_ZNK4VEC27PERPDOTEf;	.scl	2;	.type	32;	.endef
_ZNK4VEC27PERPDOTEf:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	QWORD PTR 16[rbp], rcx
	movss	DWORD PTR 24[rbp], xmm1
.L66:
	mov	rax, QWORD PTR 16[rbp]
	movss	xmm2, DWORD PTR [rax]
	movss	xmm1, DWORD PTR 24[rbp]
	movss	xmm0, DWORD PTR .LC2[rip]
	xorps	xmm0, xmm1
	mulss	xmm2, xmm0
	movaps	xmm1, xmm2
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 4
	movss	xmm0, DWORD PTR [rax]
	mulss	xmm0, DWORD PTR 24[rbp]
	lea	rax, -16[rbp]
	movaps	xmm2, xmm1
	movaps	xmm1, xmm0
	mov	rcx, rax
	call	_ZN4VEC2C1EfS0_
	nop
.L67:
	mov	rax, QWORD PTR -16[rbp]
	leave
	ret
	.globl	_ZNK4VEC27PERPDOTERKS_
	.def	_ZNK4VEC27PERPDOTERKS_;	.scl	2;	.type	32;	.endef
_ZNK4VEC27PERPDOTERKS_:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
	lea	rax, -4[rbp]
	mov	DWORD PTR [rax], 0
.L70:
	mov	rax, QWORD PTR 16[rbp]
	movss	xmm1, DWORD PTR [rax]
	mov	rax, QWORD PTR 24[rbp]
	add	rax, 4
	movss	xmm0, DWORD PTR [rax]
	mulss	xmm0, xmm1
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 4
	movss	xmm2, DWORD PTR [rax]
	mov	rax, QWORD PTR 24[rbp]
	movss	xmm1, DWORD PTR [rax]
	mulss	xmm1, xmm2
	subss	xmm0, xmm1
	movss	DWORD PTR -4[rbp], xmm0
	nop
.L71:
	movss	xmm0, DWORD PTR -4[rbp]
	leave
	ret
	.globl	_ZNK4VEC27PROJECTERKS_
	.def	_ZNK4VEC27PROJECTERKS_;	.scl	2;	.type	32;	.endef
_ZNK4VEC27PROJECTERKS_:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 80
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
.L74:
	mov	rax, QWORD PTR 24[rbp]
	mov	rdx, QWORD PTR 16[rbp]
	mov	rcx, rax
	call	_ZNK4VEC23DOTERKS_
	movd	eax, xmm0
	mov	DWORD PTR -4[rbp], eax
	mov	rdx, QWORD PTR 16[rbp]
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZNK4VEC23DOTERKS_
	movd	eax, xmm0
	mov	DWORD PTR -8[rbp], eax
	movss	xmm0, DWORD PTR -4[rbp]
	divss	xmm0, DWORD PTR -8[rbp]
	mov	rdx, QWORD PTR 16[rbp]
	call	_ZmlfRK4VEC2
	mov	QWORD PTR -48[rbp], rax
	mov	rax, QWORD PTR -48[rbp]
	mov	QWORD PTR -16[rbp], rax
	lea	rdx, -16[rbp]
	lea	rax, -32[rbp]
	mov	rcx, rax
	call	_ZN4VEC2C1ERKS_
	nop
.L75:
	mov	rax, QWORD PTR -32[rbp]
	leave
	ret
	.globl	_ZNK4VEC29COMPONENTERKS_
	.def	_ZNK4VEC29COMPONENTERKS_;	.scl	2;	.type	32;	.endef
_ZNK4VEC29COMPONENTERKS_:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 80
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
.L78:
	mov	rax, QWORD PTR 24[rbp]
	mov	rdx, rax
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZNK4VEC23DOTERKS_
	movd	eax, xmm0
	mov	DWORD PTR -4[rbp], eax
	mov	rdx, QWORD PTR 24[rbp]
	mov	rax, QWORD PTR 24[rbp]
	mov	rcx, rax
	call	_ZNK4VEC23DOTERKS_
	movd	eax, xmm0
	mov	DWORD PTR -8[rbp], eax
	movss	xmm0, DWORD PTR -4[rbp]
	divss	xmm0, DWORD PTR -8[rbp]
	mov	rax, QWORD PTR 24[rbp]
	mov	rdx, rax
	call	_ZmlfRK4VEC2
	mov	QWORD PTR -48[rbp], rax
	mov	rax, QWORD PTR -48[rbp]
	mov	QWORD PTR -16[rbp], rax
	lea	rdx, -16[rbp]
	lea	rax, -32[rbp]
	mov	rcx, rax
	call	_ZN4VEC2C1ERKS_
	nop
.L79:
	mov	rax, QWORD PTR -32[rbp]
	leave
	ret
	.globl	_ZNK4VEC215RANDOMIZECIRCLEEf
	.def	_ZNK4VEC215RANDOMIZECIRCLEEf;	.scl	2;	.type	32;	.endef
_ZNK4VEC215RANDOMIZECIRCLEEf:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 160
	movaps	XMMWORD PTR -16[rbp], xmm6
	mov	QWORD PTR 16[rbp], rcx
	movss	DWORD PTR 24[rbp], xmm1
.L82:
	movss	xmm0, DWORD PTR .LC3[rip]
	call	fb_Rnd
	movq	rax, xmm0
	mov	QWORD PTR -24[rbp], rax
	movsd	xmm1, QWORD PTR -24[rbp]
	movsd	xmm0, QWORD PTR .LC4[rip]
	mulsd	xmm0, xmm1
	cvtsd2ss	xmm3, xmm0
	movss	DWORD PTR -28[rbp], xmm3
	movss	xmm0, DWORD PTR .LC3[rip]
	call	fb_Rnd
	movq	rax, xmm0
	mov	QWORD PTR -40[rbp], rax
	cvtss2sd	xmm0, DWORD PTR 24[rbp]
	movapd	xmm1, xmm0
	mulsd	xmm1, QWORD PTR -40[rbp]
	cvtss2sd	xmm0, DWORD PTR 24[rbp]
	mulsd	xmm0, xmm1
	sqrtsd	xmm0, xmm0
	cvtsd2ss	xmm4, xmm0
	movss	DWORD PTR -44[rbp], xmm4
	mov	eax, DWORD PTR -28[rbp]
	mov	DWORD PTR -116[rbp], eax
	movss	xmm0, DWORD PTR -116[rbp]
	call	sinf
	movaps	xmm6, xmm0
	mov	eax, DWORD PTR -28[rbp]
	mov	DWORD PTR -116[rbp], eax
	movss	xmm0, DWORD PTR -116[rbp]
	call	cosf
	lea	rax, -64[rbp]
	movaps	xmm2, xmm6
	movaps	xmm1, xmm0
	mov	rcx, rax
	call	_ZN4VEC2C1EfS0_
	movss	xmm0, DWORD PTR -44[rbp]
	lea	rax, -64[rbp]
	movaps	xmm1, xmm0
	mov	rcx, rax
	call	_ZmlRK4VEC2f
	mov	QWORD PTR -112[rbp], rax
	mov	rax, QWORD PTR -112[rbp]
	mov	QWORD PTR -80[rbp], rax
	lea	rdx, -80[rbp]
	lea	rax, -96[rbp]
	mov	rcx, rax
	call	_ZN4VEC2C1ERKS_
	nop
.L83:
	mov	rax, QWORD PTR -96[rbp]
	movaps	xmm6, XMMWORD PTR -16[rbp]
	leave
	ret
	.globl	_ZNK4VEC215RANDOMIZESQUAREEf
	.def	_ZNK4VEC215RANDOMIZESQUAREEf;	.scl	2;	.type	32;	.endef
_ZNK4VEC215RANDOMIZESQUAREEf:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 80
	mov	QWORD PTR 16[rbp], rcx
	movss	DWORD PTR 24[rbp], xmm1
.L86:
	movss	xmm0, DWORD PTR .LC3[rip]
	call	fb_Rnd
	movq	rax, xmm0
	mov	QWORD PTR -8[rbp], rax
	movss	xmm0, DWORD PTR .LC3[rip]
	call	fb_Rnd
	movq	rax, xmm0
	mov	QWORD PTR -16[rbp], rax
	movss	xmm0, DWORD PTR .LC3[rip]
	call	fb_Rnd
	movq	rax, xmm0
	mov	QWORD PTR -24[rbp], rax
	movss	xmm0, DWORD PTR .LC3[rip]
	call	fb_Rnd
	movq	rax, xmm0
	mov	QWORD PTR -32[rbp], rax
	movsd	xmm0, QWORD PTR -8[rbp]
	movapd	xmm1, xmm0
	subsd	xmm1, QWORD PTR -16[rbp]
	cvtss2sd	xmm0, DWORD PTR 24[rbp]
	mulsd	xmm0, xmm1
	cvtsd2ss	xmm2, xmm0
	movsd	xmm0, QWORD PTR -24[rbp]
	movapd	xmm1, xmm0
	subsd	xmm1, QWORD PTR -32[rbp]
	cvtss2sd	xmm0, DWORD PTR 24[rbp]
	mulsd	xmm0, xmm1
	cvtsd2ss	xmm0, xmm0
	lea	rax, -48[rbp]
	movaps	xmm1, xmm0
	mov	rcx, rax
	call	_ZN4VEC2C1EfS0_
	nop
.L87:
	mov	rax, QWORD PTR -48[rbp]
	leave
	ret
	.globl	_ZNK4VEC26ROTATEERKS_
	.def	_ZNK4VEC26ROTATEERKS_;	.scl	2;	.type	32;	.endef
_ZNK4VEC26ROTATEERKS_:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
.L90:
	mov	rax, QWORD PTR 24[rbp]
	mov	rdx, rax
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZNK4VEC27PERPDOTERKS_
	movd	eax, xmm0
	mov	DWORD PTR -4[rbp], eax
	mov	rax, QWORD PTR 24[rbp]
	mov	rdx, rax
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZNK4VEC23DOTERKS_
	movd	eax, xmm0
	mov	DWORD PTR -8[rbp], eax
	movss	xmm1, DWORD PTR -4[rbp]
	movss	xmm0, DWORD PTR -8[rbp]
	lea	rax, -16[rbp]
	movaps	xmm2, xmm1
	movaps	xmm1, xmm0
	mov	rcx, rax
	call	_ZN4VEC2C1EfS0_
	nop
.L91:
	mov	rax, QWORD PTR -16[rbp]
	leave
	ret
	.globl	_ZngRK4VEC2
	.def	_ZngRK4VEC2;	.scl	2;	.type	32;	.endef
_ZngRK4VEC2:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	QWORD PTR 16[rbp], rcx
.L94:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 4
	movss	xmm1, DWORD PTR [rax]
	movss	xmm0, DWORD PTR .LC2[rip]
	movaps	xmm2, xmm1
	xorps	xmm2, xmm0
	mov	rax, QWORD PTR 16[rbp]
	movss	xmm1, DWORD PTR [rax]
	movss	xmm0, DWORD PTR .LC2[rip]
	xorps	xmm0, xmm1
	lea	rax, -16[rbp]
	movaps	xmm1, xmm0
	mov	rcx, rax
	call	_ZN4VEC2C1EfS0_
	nop
.L95:
	mov	rax, QWORD PTR -16[rbp]
	leave
	ret
	.globl	_ZplRK4VEC2S1_
	.def	_ZplRK4VEC2S1_;	.scl	2;	.type	32;	.endef
_ZplRK4VEC2S1_:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
.L98:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 4
	movss	xmm1, DWORD PTR [rax]
	mov	rax, QWORD PTR 24[rbp]
	add	rax, 4
	movss	xmm0, DWORD PTR [rax]
	movaps	xmm2, xmm1
	addss	xmm2, xmm0
	mov	rax, QWORD PTR 16[rbp]
	movss	xmm1, DWORD PTR [rax]
	mov	rax, QWORD PTR 24[rbp]
	movss	xmm0, DWORD PTR [rax]
	addss	xmm0, xmm1
	lea	rax, -16[rbp]
	movaps	xmm1, xmm0
	mov	rcx, rax
	call	_ZN4VEC2C1EfS0_
	nop
.L99:
	mov	rax, QWORD PTR -16[rbp]
	leave
	ret
	.globl	_ZmiRK4VEC2S1_
	.def	_ZmiRK4VEC2S1_;	.scl	2;	.type	32;	.endef
_ZmiRK4VEC2S1_:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
.L102:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 4
	movss	xmm0, DWORD PTR [rax]
	mov	rax, QWORD PTR 24[rbp]
	add	rax, 4
	movss	xmm1, DWORD PTR [rax]
	movaps	xmm2, xmm0
	subss	xmm2, xmm1
	mov	rax, QWORD PTR 16[rbp]
	movss	xmm0, DWORD PTR [rax]
	mov	rax, QWORD PTR 24[rbp]
	movss	xmm1, DWORD PTR [rax]
	subss	xmm0, xmm1
	lea	rax, -16[rbp]
	movaps	xmm1, xmm0
	mov	rcx, rax
	call	_ZN4VEC2C1EfS0_
	nop
.L103:
	mov	rax, QWORD PTR -16[rbp]
	leave
	ret
	.globl	_ZmlfRK4VEC2
	.def	_ZmlfRK4VEC2;	.scl	2;	.type	32;	.endef
_ZmlfRK4VEC2:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	movss	DWORD PTR 16[rbp], xmm0
	mov	QWORD PTR 24[rbp], rdx
.L106:
	mov	rax, QWORD PTR 24[rbp]
	add	rax, 4
	movss	xmm0, DWORD PTR [rax]
	movaps	xmm1, xmm0
	mulss	xmm1, DWORD PTR 16[rbp]
	mov	rax, QWORD PTR 24[rbp]
	movss	xmm0, DWORD PTR [rax]
	mulss	xmm0, DWORD PTR 16[rbp]
	lea	rax, -16[rbp]
	movaps	xmm2, xmm1
	movaps	xmm1, xmm0
	mov	rcx, rax
	call	_ZN4VEC2C1EfS0_
	nop
.L107:
	mov	rax, QWORD PTR -16[rbp]
	leave
	ret
	.globl	_ZmlRK4VEC2f
	.def	_ZmlRK4VEC2f;	.scl	2;	.type	32;	.endef
_ZmlRK4VEC2f:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	QWORD PTR 16[rbp], rcx
	movss	DWORD PTR 24[rbp], xmm1
.L110:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 4
	movss	xmm0, DWORD PTR [rax]
	movaps	xmm1, xmm0
	mulss	xmm1, DWORD PTR 24[rbp]
	mov	rax, QWORD PTR 16[rbp]
	movss	xmm0, DWORD PTR [rax]
	mulss	xmm0, DWORD PTR 24[rbp]
	lea	rax, -16[rbp]
	movaps	xmm2, xmm1
	movaps	xmm1, xmm0
	mov	rcx, rax
	call	_ZN4VEC2C1EfS0_
	nop
.L111:
	mov	rax, QWORD PTR -16[rbp]
	leave
	ret
	.globl	_ZmlRK4VEC2S1_
	.def	_ZmlRK4VEC2S1_;	.scl	2;	.type	32;	.endef
_ZmlRK4VEC2S1_:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
.L114:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 4
	movss	xmm1, DWORD PTR [rax]
	mov	rax, QWORD PTR 24[rbp]
	add	rax, 4
	movss	xmm0, DWORD PTR [rax]
	movaps	xmm2, xmm1
	mulss	xmm2, xmm0
	mov	rax, QWORD PTR 16[rbp]
	movss	xmm1, DWORD PTR [rax]
	mov	rax, QWORD PTR 24[rbp]
	movss	xmm0, DWORD PTR [rax]
	mulss	xmm0, xmm1
	lea	rax, -16[rbp]
	movaps	xmm1, xmm0
	mov	rcx, rax
	call	_ZN4VEC2C1EfS0_
	nop
.L115:
	mov	rax, QWORD PTR -16[rbp]
	leave
	ret
	.globl	_ZdvRK4VEC2f
	.def	_ZdvRK4VEC2f;	.scl	2;	.type	32;	.endef
_ZdvRK4VEC2f:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	QWORD PTR 16[rbp], rcx
	movss	DWORD PTR 24[rbp], xmm1
.L118:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 4
	movss	xmm0, DWORD PTR [rax]
	movaps	xmm1, xmm0
	divss	xmm1, DWORD PTR 24[rbp]
	mov	rax, QWORD PTR 16[rbp]
	movss	xmm0, DWORD PTR [rax]
	divss	xmm0, DWORD PTR 24[rbp]
	lea	rax, -16[rbp]
	movaps	xmm2, xmm1
	movaps	xmm1, xmm0
	mov	rcx, rax
	call	_ZN4VEC2C1EfS0_
	nop
.L119:
	mov	rax, QWORD PTR -16[rbp]
	leave
	ret
	.globl	_ZeqRK4VEC2S0_
	.def	_ZeqRK4VEC2S0_;	.scl	2;	.type	32;	.endef
_ZeqRK4VEC2S0_:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
	mov	QWORD PTR -8[rbp], 0
.L122:
	mov	rax, QWORD PTR 16[rbp]
	movss	xmm0, DWORD PTR [rax]
	lea	rax, 24[rbp]
	movss	xmm1, DWORD PTR [rax]
	ucomiss	xmm0, xmm1
	setnp	al
	mov	edx, 0
	ucomiss	xmm0, xmm1
	cmovne	eax, edx
	movzx	eax, al
	neg	eax
	mov	edx, eax
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 4
	movss	xmm0, DWORD PTR [rax]
	lea	rax, 24[rbp]
	add	rax, 4
	movss	xmm1, DWORD PTR [rax]
	ucomiss	xmm0, xmm1
	setnp	al
	mov	ecx, 0
	ucomiss	xmm0, xmm1
	cmovne	eax, ecx
	movzx	eax, al
	neg	eax
	and	eax, edx
	cdqe
	mov	QWORD PTR -8[rbp], rax
	nop
.L123:
	mov	rax, QWORD PTR -8[rbp]
	leave
	ret
	.globl	_ZneRK4VEC2S0_
	.def	_ZneRK4VEC2S0_;	.scl	2;	.type	32;	.endef
_ZneRK4VEC2S0_:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
	mov	QWORD PTR -8[rbp], 0
.L126:
	mov	rax, QWORD PTR 16[rbp]
	movss	xmm0, DWORD PTR [rax]
	lea	rax, 24[rbp]
	movss	xmm1, DWORD PTR [rax]
	ucomiss	xmm0, xmm1
	setp	al
	mov	edx, 1
	ucomiss	xmm0, xmm1
	cmovne	eax, edx
	movzx	eax, al
	neg	eax
	mov	edx, eax
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 4
	movss	xmm0, DWORD PTR [rax]
	lea	rax, 24[rbp]
	add	rax, 4
	movss	xmm1, DWORD PTR [rax]
	ucomiss	xmm0, xmm1
	setp	al
	mov	ecx, 1
	ucomiss	xmm0, xmm1
	cmovne	eax, ecx
	movzx	eax, al
	neg	eax
	or	eax, edx
	cdqe
	mov	QWORD PTR -8[rbp], rax
	nop
.L127:
	mov	rax, QWORD PTR -8[rbp]
	leave
	ret
	.globl	_ZltRK4VEC2S0_
	.def	_ZltRK4VEC2S0_;	.scl	2;	.type	32;	.endef
_ZltRK4VEC2S0_:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
	mov	QWORD PTR -8[rbp], 0
.L130:
	mov	rax, QWORD PTR 16[rbp]
	movss	xmm1, DWORD PTR [rax]
	lea	rax, 24[rbp]
	movss	xmm0, DWORD PTR [rax]
	ucomiss	xmm0, xmm1
	seta	al
	movzx	eax, al
	neg	eax
	mov	edx, eax
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 4
	movss	xmm1, DWORD PTR [rax]
	lea	rax, 24[rbp]
	add	rax, 4
	movss	xmm0, DWORD PTR [rax]
	ucomiss	xmm0, xmm1
	seta	al
	movzx	eax, al
	neg	eax
	and	eax, edx
	cdqe
	mov	QWORD PTR -8[rbp], rax
	nop
.L131:
	mov	rax, QWORD PTR -8[rbp]
	leave
	ret
	.globl	_ZgtRK4VEC2S0_
	.def	_ZgtRK4VEC2S0_;	.scl	2;	.type	32;	.endef
_ZgtRK4VEC2S0_:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
	mov	QWORD PTR -8[rbp], 0
.L134:
	mov	rax, QWORD PTR 16[rbp]
	movss	xmm0, DWORD PTR [rax]
	lea	rax, 24[rbp]
	movss	xmm1, DWORD PTR [rax]
	ucomiss	xmm0, xmm1
	seta	al
	movzx	eax, al
	neg	eax
	mov	edx, eax
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 4
	movss	xmm0, DWORD PTR [rax]
	lea	rax, 24[rbp]
	add	rax, 4
	movss	xmm1, DWORD PTR [rax]
	ucomiss	xmm0, xmm1
	seta	al
	movzx	eax, al
	neg	eax
	and	eax, edx
	cdqe
	mov	QWORD PTR -8[rbp], rax
	nop
.L135:
	mov	rax, QWORD PTR -8[rbp]
	leave
	ret
	.globl	_Z8ABSOLUTERK4VEC2
	.def	_Z8ABSOLUTERK4VEC2;	.scl	2;	.type	32;	.endef
_Z8ABSOLUTERK4VEC2:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 80
	mov	QWORD PTR 16[rbp], rcx
.L138:
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZNK4VEC28ABSOLUTEEv
	mov	QWORD PTR -48[rbp], rax
	mov	rax, QWORD PTR -48[rbp]
	mov	QWORD PTR -16[rbp], rax
	lea	rdx, -16[rbp]
	lea	rax, -32[rbp]
	mov	rcx, rax
	call	_ZN4VEC2C1ERKS_
	nop
.L139:
	mov	rax, QWORD PTR -32[rbp]
	leave
	ret
	.globl	PERP
	.def	PERP;	.scl	2;	.type	32;	.endef
PERP:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 80
	mov	QWORD PTR 16[rbp], rcx
.L142:
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZNK4VEC24PERPEv
	mov	QWORD PTR -48[rbp], rax
	mov	rax, QWORD PTR -48[rbp]
	mov	QWORD PTR -16[rbp], rax
	lea	rdx, -16[rbp]
	lea	rax, -32[rbp]
	mov	rcx, rax
	call	_ZN4VEC2C1ERKS_
	nop
.L143:
	mov	rax, QWORD PTR -32[rbp]
	leave
	ret
	.globl	UNIT
	.def	UNIT;	.scl	2;	.type	32;	.endef
UNIT:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 80
	mov	QWORD PTR 16[rbp], rcx
.L146:
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZNK4VEC24UNITEv
	mov	QWORD PTR -48[rbp], rax
	mov	rax, QWORD PTR -48[rbp]
	mov	QWORD PTR -16[rbp], rax
	lea	rdx, -16[rbp]
	lea	rax, -32[rbp]
	mov	rcx, rax
	call	_ZN4VEC2C1ERKS_
	nop
.L147:
	mov	rax, QWORD PTR -32[rbp]
	leave
	ret
	.globl	LENGTH
	.def	LENGTH;	.scl	2;	.type	32;	.endef
LENGTH:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	QWORD PTR 16[rbp], rcx
	lea	rax, -8[rbp]
	mov	DWORD PTR [rax], 0
.L150:
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZNK4VEC26LENGTHEv
	movd	eax, xmm0
	mov	DWORD PTR -4[rbp], eax
	movss	xmm0, DWORD PTR -4[rbp]
	movss	DWORD PTR -8[rbp], xmm0
	nop
.L151:
	movss	xmm0, DWORD PTR -8[rbp]
	leave
	ret
	.globl	LENGTHSQUARED
	.def	LENGTHSQUARED;	.scl	2;	.type	32;	.endef
LENGTHSQUARED:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	QWORD PTR 16[rbp], rcx
	lea	rax, -8[rbp]
	mov	DWORD PTR [rax], 0
.L154:
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZNK4VEC213LENGTHSQUAREDEv
	movd	eax, xmm0
	mov	DWORD PTR -4[rbp], eax
	movss	xmm0, DWORD PTR -4[rbp]
	movss	DWORD PTR -8[rbp], xmm0
	nop
.L155:
	movss	xmm0, DWORD PTR -8[rbp]
	leave
	ret
	.globl	_Z3DOTRK4VEC2S1_
	.def	_Z3DOTRK4VEC2S1_;	.scl	2;	.type	32;	.endef
_Z3DOTRK4VEC2S1_:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
	lea	rax, -8[rbp]
	mov	DWORD PTR [rax], 0
.L158:
	mov	rax, QWORD PTR 24[rbp]
	mov	rdx, rax
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZNK4VEC23DOTERKS_
	movd	eax, xmm0
	mov	DWORD PTR -4[rbp], eax
	movss	xmm0, DWORD PTR -4[rbp]
	movss	DWORD PTR -8[rbp], xmm0
	nop
.L159:
	movss	xmm0, DWORD PTR -8[rbp]
	leave
	ret
	.globl	_Z3DOTRK4VEC2f
	.def	_Z3DOTRK4VEC2f;	.scl	2;	.type	32;	.endef
_Z3DOTRK4VEC2f:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 80
	mov	QWORD PTR 16[rbp], rcx
	movss	DWORD PTR 24[rbp], xmm1
.L162:
	movss	xmm0, DWORD PTR 24[rbp]
	movaps	xmm1, xmm0
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZNK4VEC23DOTEf
	mov	QWORD PTR -48[rbp], rax
	mov	rax, QWORD PTR -48[rbp]
	mov	QWORD PTR -16[rbp], rax
	lea	rdx, -16[rbp]
	lea	rax, -32[rbp]
	mov	rcx, rax
	call	_ZN4VEC2C1ERKS_
	nop
.L163:
	mov	rax, QWORD PTR -32[rbp]
	leave
	ret
	.globl	_Z3DOTfRK4VEC2
	.def	_Z3DOTfRK4VEC2;	.scl	2;	.type	32;	.endef
_Z3DOTfRK4VEC2:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 80
	movss	DWORD PTR 16[rbp], xmm0
	mov	QWORD PTR 24[rbp], rdx
.L166:
	movss	xmm1, DWORD PTR 16[rbp]
	movss	xmm0, DWORD PTR .LC2[rip]
	xorps	xmm0, xmm1
	mov	rax, QWORD PTR 24[rbp]
	movaps	xmm1, xmm0
	mov	rcx, rax
	call	_ZNK4VEC23DOTEf
	mov	QWORD PTR -48[rbp], rax
	mov	rax, QWORD PTR -48[rbp]
	mov	QWORD PTR -16[rbp], rax
	lea	rdx, -16[rbp]
	lea	rax, -32[rbp]
	mov	rcx, rax
	call	_ZN4VEC2C1ERKS_
	nop
.L167:
	mov	rax, QWORD PTR -32[rbp]
	leave
	ret
	.globl	_Z7PERPDOTRK4VEC2S1_
	.def	_Z7PERPDOTRK4VEC2S1_;	.scl	2;	.type	32;	.endef
_Z7PERPDOTRK4VEC2S1_:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
	lea	rax, -8[rbp]
	mov	DWORD PTR [rax], 0
.L170:
	mov	rax, QWORD PTR 24[rbp]
	mov	rdx, rax
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZNK4VEC27PERPDOTERKS_
	movd	eax, xmm0
	mov	DWORD PTR -4[rbp], eax
	movss	xmm0, DWORD PTR -4[rbp]
	movss	DWORD PTR -8[rbp], xmm0
	nop
.L171:
	movss	xmm0, DWORD PTR -8[rbp]
	leave
	ret
	.globl	_Z7PERPDOTRK4VEC2f
	.def	_Z7PERPDOTRK4VEC2f;	.scl	2;	.type	32;	.endef
_Z7PERPDOTRK4VEC2f:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 80
	mov	QWORD PTR 16[rbp], rcx
	movss	DWORD PTR 24[rbp], xmm1
.L174:
	movss	xmm0, DWORD PTR 24[rbp]
	movaps	xmm1, xmm0
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZNK4VEC27PERPDOTEf
	mov	QWORD PTR -48[rbp], rax
	mov	rax, QWORD PTR -48[rbp]
	mov	QWORD PTR -16[rbp], rax
	lea	rdx, -16[rbp]
	lea	rax, -32[rbp]
	mov	rcx, rax
	call	_ZN4VEC2C1ERKS_
	nop
.L175:
	mov	rax, QWORD PTR -32[rbp]
	leave
	ret
	.globl	_Z7PERPDOTfRK4VEC2
	.def	_Z7PERPDOTfRK4VEC2;	.scl	2;	.type	32;	.endef
_Z7PERPDOTfRK4VEC2:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 80
	movss	DWORD PTR 16[rbp], xmm0
	mov	QWORD PTR 24[rbp], rdx
.L178:
	movss	xmm1, DWORD PTR 16[rbp]
	movss	xmm0, DWORD PTR .LC2[rip]
	xorps	xmm0, xmm1
	mov	rax, QWORD PTR 24[rbp]
	movaps	xmm1, xmm0
	mov	rcx, rax
	call	_ZNK4VEC27PERPDOTEf
	mov	QWORD PTR -48[rbp], rax
	mov	rax, QWORD PTR -48[rbp]
	mov	QWORD PTR -16[rbp], rax
	lea	rdx, -16[rbp]
	lea	rax, -32[rbp]
	mov	rcx, rax
	call	_ZN4VEC2C1ERKS_
	nop
.L179:
	mov	rax, QWORD PTR -32[rbp]
	leave
	ret
	.globl	PROJECT
	.def	PROJECT;	.scl	2;	.type	32;	.endef
PROJECT:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 80
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
.L182:
	mov	rax, QWORD PTR 24[rbp]
	mov	rdx, rax
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZNK4VEC27PROJECTERKS_
	mov	QWORD PTR -48[rbp], rax
	mov	rax, QWORD PTR -48[rbp]
	mov	QWORD PTR -16[rbp], rax
	lea	rdx, -16[rbp]
	lea	rax, -32[rbp]
	mov	rcx, rax
	call	_ZN4VEC2C1ERKS_
	nop
.L183:
	mov	rax, QWORD PTR -32[rbp]
	leave
	ret
	.globl	COMPONENT
	.def	COMPONENT;	.scl	2;	.type	32;	.endef
COMPONENT:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 80
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
.L186:
	mov	rax, QWORD PTR 24[rbp]
	mov	rdx, rax
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZNK4VEC29COMPONENTERKS_
	mov	QWORD PTR -48[rbp], rax
	mov	rax, QWORD PTR -48[rbp]
	mov	QWORD PTR -16[rbp], rax
	lea	rdx, -16[rbp]
	lea	rax, -32[rbp]
	mov	rcx, rax
	call	_ZN4VEC2C1ERKS_
	nop
.L187:
	mov	rax, QWORD PTR -32[rbp]
	leave
	ret
	.globl	RANDOMIZECIRCLE
	.def	RANDOMIZECIRCLE;	.scl	2;	.type	32;	.endef
RANDOMIZECIRCLE:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 80
	mov	QWORD PTR 16[rbp], rcx
	movss	DWORD PTR 24[rbp], xmm1
.L190:
	movss	xmm0, DWORD PTR 24[rbp]
	movaps	xmm1, xmm0
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZNK4VEC215RANDOMIZECIRCLEEf
	mov	QWORD PTR -48[rbp], rax
	mov	rax, QWORD PTR -48[rbp]
	mov	QWORD PTR -16[rbp], rax
	lea	rdx, -16[rbp]
	lea	rax, -32[rbp]
	mov	rcx, rax
	call	_ZN4VEC2C1ERKS_
	nop
.L191:
	mov	rax, QWORD PTR -32[rbp]
	leave
	ret
	.globl	RANDOMIZESQUARE
	.def	RANDOMIZESQUARE;	.scl	2;	.type	32;	.endef
RANDOMIZESQUARE:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 80
	mov	QWORD PTR 16[rbp], rcx
	movss	DWORD PTR 24[rbp], xmm1
.L194:
	movss	xmm0, DWORD PTR 24[rbp]
	movaps	xmm1, xmm0
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZNK4VEC215RANDOMIZESQUAREEf
	mov	QWORD PTR -48[rbp], rax
	mov	rax, QWORD PTR -48[rbp]
	mov	QWORD PTR -16[rbp], rax
	lea	rdx, -16[rbp]
	lea	rax, -32[rbp]
	mov	rcx, rax
	call	_ZN4VEC2C1ERKS_
	nop
.L195:
	mov	rax, QWORD PTR -32[rbp]
	leave
	ret
	.globl	_Z6ROTATERK4VEC2S1_
	.def	_Z6ROTATERK4VEC2S1_;	.scl	2;	.type	32;	.endef
_Z6ROTATERK4VEC2S1_:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 80
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
.L198:
	mov	rax, QWORD PTR 24[rbp]
	mov	rdx, rax
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZNK4VEC26ROTATEERKS_
	mov	QWORD PTR -48[rbp], rax
	mov	rax, QWORD PTR -48[rbp]
	mov	QWORD PTR -16[rbp], rax
	lea	rdx, -16[rbp]
	lea	rax, -32[rbp]
	mov	rcx, rax
	call	_ZN4VEC2C1ERKS_
	nop
.L199:
	mov	rax, QWORD PTR -32[rbp]
	leave
	ret
	.globl	ANGLETOUNIT
	.def	ANGLETOUNIT;	.scl	2;	.type	32;	.endef
ANGLETOUNIT:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 64
	movaps	XMMWORD PTR -16[rbp], xmm6
	movss	DWORD PTR 16[rbp], xmm0
.L202:
	cvtss2sd	xmm0, DWORD PTR 16[rbp]
	call	sin
	cvtsd2ss	xmm6, xmm0
	cvtss2sd	xmm0, DWORD PTR 16[rbp]
	call	cos
	cvtsd2ss	xmm0, xmm0
	lea	rax, -32[rbp]
	movaps	xmm2, xmm6
	movaps	xmm1, xmm0
	mov	rcx, rax
	call	_ZN4VEC2C1EfS0_
	nop
.L203:
	mov	rax, QWORD PTR -32[rbp]
	movaps	xmm6, XMMWORD PTR -16[rbp]
	leave
	ret
	.globl	UNITTOANGLE
	.def	UNITTOANGLE;	.scl	2;	.type	32;	.endef
UNITTOANGLE:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 64
	mov	QWORD PTR 16[rbp], rcx
	lea	rax, -8[rbp]
	mov	DWORD PTR [rax], 0
.L206:
	mov	rax, QWORD PTR 16[rbp]
	movss	xmm0, DWORD PTR [rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 4
	mov	eax, DWORD PTR [rax]
	movaps	xmm1, xmm0
	mov	DWORD PTR -20[rbp], eax
	movss	xmm0, DWORD PTR -20[rbp]
	call	atan2f
	movd	eax, xmm0
	mov	DWORD PTR -4[rbp], eax
	movss	xmm0, DWORD PTR -4[rbp]
	movss	DWORD PTR -8[rbp], xmm0
	nop
.L207:
	movss	xmm0, DWORD PTR -8[rbp]
	leave
	ret
	.globl	_ZN12PARTICLETYPEC1Ev
	.def	_ZN12PARTICLETYPEC1Ev;	.scl	2;	.type	32;	.endef
_ZN12PARTICLETYPEC1Ev:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 96
	mov	QWORD PTR 16[rbp], rcx
.L210:
	mov	rax, QWORD PTR 16[rbp]
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 4
	mov	rcx, rax
	call	_ZN4VEC2C1Ev
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 12
	mov	rcx, rax
	call	_ZN4VEC2C1Ev
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 20
	mov	rcx, rax
	call	_ZN4VEC2C1Ev
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 28
	mov	rcx, rax
	call	_ZN4VEC2C1Ev
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 36
	mov	DWORD PTR [rax], 0
	lea	rax, -16[rbp]
	pxor	xmm2, xmm2
	pxor	xmm1, xmm1
	mov	rcx, rax
	call	_ZN4VEC2C1EfS0_
	mov	rax, QWORD PTR 16[rbp]
	lea	rcx, 4[rax]
	lea	rax, -16[rbp]
	mov	rdx, rax
	call	_ZN4VEC2aSERKS_
	lea	rax, -32[rbp]
	pxor	xmm2, xmm2
	pxor	xmm1, xmm1
	mov	rcx, rax
	call	_ZN4VEC2C1EfS0_
	mov	rax, QWORD PTR 16[rbp]
	lea	rcx, 12[rax]
	lea	rax, -32[rbp]
	mov	rdx, rax
	call	_ZN4VEC2aSERKS_
	lea	rax, -48[rbp]
	pxor	xmm2, xmm2
	pxor	xmm1, xmm1
	mov	rcx, rax
	call	_ZN4VEC2C1EfS0_
	mov	rax, QWORD PTR 16[rbp]
	lea	rcx, 20[rax]
	lea	rax, -48[rbp]
	mov	rdx, rax
	call	_ZN4VEC2aSERKS_
	lea	rax, -64[rbp]
	pxor	xmm2, xmm2
	pxor	xmm1, xmm1
	mov	rcx, rax
	call	_ZN4VEC2C1EfS0_
	mov	rax, QWORD PTR 16[rbp]
	lea	rcx, 28[rax]
	lea	rax, -64[rbp]
	mov	rdx, rax
	call	_ZN4VEC2aSERKS_
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 36
	pxor	xmm0, xmm0
	movss	DWORD PTR [rax], xmm0
	nop
	leave
	ret
.L211:
	.globl	_ZN12PARTICLETYPEC1ERS_
	.def	_ZN12PARTICLETYPEC1ERS_;	.scl	2;	.type	32;	.endef
_ZN12PARTICLETYPEC1ERS_:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
	mov	rax, QWORD PTR 16[rbp]
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 4
	mov	rcx, rax
	call	_ZN4VEC2C1Ev
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 12
	mov	rcx, rax
	call	_ZN4VEC2C1Ev
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 20
	mov	rcx, rax
	call	_ZN4VEC2C1Ev
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 28
	mov	rcx, rax
	call	_ZN4VEC2C1Ev
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 36
	mov	DWORD PTR [rax], 0
	nop
	leave
	ret
.L213:
.L214:
	.globl	_ZN12PARTICLETYPEaSERS_
	.def	_ZN12PARTICLETYPEaSERS_;	.scl	2;	.type	32;	.endef
_ZN12PARTICLETYPEaSERS_:
	push	rbp
	mov	rbp, rsp
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
	nop
	pop	rbp
	ret
.L216:
.L217:
	.globl	_ZN16PARTICLEPAIRTYPEC1Ev
	.def	_ZN16PARTICLEPAIRTYPEC1Ev;	.scl	2;	.type	32;	.endef
_ZN16PARTICLEPAIRTYPEC1Ev:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	QWORD PTR 16[rbp], rcx
.L219:
	mov	rax, QWORD PTR 16[rbp]
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 4
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 8
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 12
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 16
	mov	rcx, rax
	call	_ZN4VEC2C1Ev
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 24
	mov	rcx, rax
	call	_ZN4VEC2C1Ev
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 32
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 40
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	pxor	xmm0, xmm0
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 4
	pxor	xmm0, xmm0
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 8
	pxor	xmm0, xmm0
	movss	DWORD PTR [rax], xmm0
	lea	rax, -16[rbp]
	pxor	xmm2, xmm2
	pxor	xmm1, xmm1
	mov	rcx, rax
	call	_ZN4VEC2C1EfS0_
	mov	rax, QWORD PTR 16[rbp]
	lea	rcx, 16[rax]
	lea	rax, -16[rbp]
	mov	rdx, rax
	call	_ZN4VEC2aSERKS_
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 32
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 40
	mov	QWORD PTR [rax], 0
	nop
	leave
	ret
.L220:
	.globl	_ZN16PARTICLEPAIRTYPEC1ERS_
	.def	_ZN16PARTICLEPAIRTYPEC1ERS_;	.scl	2;	.type	32;	.endef
_ZN16PARTICLEPAIRTYPEC1ERS_:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
	mov	rax, QWORD PTR 16[rbp]
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 4
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 8
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 12
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 16
	mov	rcx, rax
	call	_ZN4VEC2C1Ev
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 24
	mov	rcx, rax
	call	_ZN4VEC2C1Ev
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 32
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 40
	mov	QWORD PTR [rax], 0
	nop
	leave
	ret
.L222:
.L223:
	.globl	_ZN16PARTICLEPAIRTYPEaSERS_
	.def	_ZN16PARTICLEPAIRTYPEaSERS_;	.scl	2;	.type	32;	.endef
_ZN16PARTICLEPAIRTYPEaSERS_:
	push	rbp
	mov	rbp, rsp
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
	nop
	pop	rbp
	ret
.L225:
.L226:
	.globl	_ZN8GRIDTYPEC1Ev
	.def	_ZN8GRIDTYPEC1Ev;	.scl	2;	.type	32;	.endef
_ZN8GRIDTYPEC1Ev:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	QWORD PTR 16[rbp], rcx
	mov	rax, QWORD PTR 16[rbp]
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 8
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 16
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 20
	mov	DWORD PTR [rax], 0
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
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 64
	mov	QWORD PTR -16[rbp], rax
	mov	QWORD PTR -8[rbp], 0
.L228:
	mov	rax, QWORD PTR -16[rbp]
	mov	rcx, rax
	call	_ZN8CELLTYPEC1Ev
	add	QWORD PTR -16[rbp], 520
	add	QWORD PTR -8[rbp], 1
	cmp	QWORD PTR -8[rbp], 374
	je	.L229
	jmp	.L228
.L229:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 194544
	mov	edx, 26256
	mov	r8, rdx
	mov	edx, 0
	mov	rcx, rax
	call	memset
	nop
	leave
	ret
.L230:
.L231:
	.globl	_ZN8GRIDTYPEC1ERS_
	.def	_ZN8GRIDTYPEC1ERS_;	.scl	2;	.type	32;	.endef
_ZN8GRIDTYPEC1ERS_:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
.L233:
	mov	rax, QWORD PTR 16[rbp]
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 8
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 16
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 20
	mov	DWORD PTR [rax], 0
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
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 64
	mov	QWORD PTR -16[rbp], rax
	mov	QWORD PTR -8[rbp], 0
.L234:
	mov	rax, QWORD PTR -16[rbp]
	mov	rcx, rax
	call	_ZN8CELLTYPEC1Ev
	add	QWORD PTR -16[rbp], 520
	add	QWORD PTR -8[rbp], 1
	cmp	QWORD PTR -8[rbp], 374
	je	.L235
	jmp	.L234
.L235:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 194544
	mov	edx, 26256
	mov	r8, rdx
	mov	edx, 0
	mov	rcx, rax
	call	memset
	mov	rax, QWORD PTR 24[rbp]
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR 16[rbp]
	mov	QWORD PTR [rax], rdx
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 8[rax]
	mov	rax, QWORD PTR 24[rbp]
	mov	rax, QWORD PTR 8[rax]
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 16[rax]
	mov	rax, QWORD PTR 24[rbp]
	movss	xmm0, DWORD PTR 16[rax]
	movss	DWORD PTR [rdx], xmm0
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 20[rax]
	mov	rax, QWORD PTR 24[rbp]
	movss	xmm0, DWORD PTR 20[rax]
	movss	DWORD PTR [rdx], xmm0
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
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 56[rax]
	mov	rax, QWORD PTR 24[rbp]
	mov	rax, QWORD PTR 56[rax]
	mov	QWORD PTR [rdx], rax
	nop
	leave
	ret
.L236:
	.globl	_ZN8GRIDTYPEC1Efu7INTEGERS0_
	.def	_ZN8GRIDTYPEC1Efu7INTEGERS0_;	.scl	2;	.type	32;	.endef
_ZN8GRIDTYPEC1Efu7INTEGERS0_:
	push	rbp
	mov	rbp, rsp
	push	rbx
	sub	rsp, 56
	mov	QWORD PTR 16[rbp], rcx
	movss	DWORD PTR 24[rbp], xmm1
	mov	QWORD PTR 32[rbp], r8
	mov	QWORD PTR 40[rbp], r9
.L238:
	mov	rax, QWORD PTR 16[rbp]
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 8
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 16
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 20
	mov	DWORD PTR [rax], 0
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
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 64
	mov	QWORD PTR -32[rbp], rax
	mov	QWORD PTR -24[rbp], 0
.L239:
	mov	rax, QWORD PTR -32[rbp]
	mov	rcx, rax
	call	_ZN8CELLTYPEC1Ev
	add	QWORD PTR -32[rbp], 520
	add	QWORD PTR -24[rbp], 1
	cmp	QWORD PTR -24[rbp], 374
	je	.L240
	jmp	.L239
.L240:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 194544
	mov	edx, 26256
	mov	r8, rdx
	mov	edx, 0
	mov	rcx, rax
	call	memset
	mov	rax, QWORD PTR 16[rbp]
	lea	rbx, 40[rax]
	pxor	xmm0, xmm0
	cvtsi2sdq	xmm0, QWORD PTR 32[rbp]
	cvtss2sd	xmm1, DWORD PTR 24[rbp]
	divsd	xmm0, xmm1
	call	nearbyint
	cvttsd2si	rax, xmm0
	mov	QWORD PTR [rbx], rax
	mov	rax, QWORD PTR 16[rbp]
	lea	rbx, 48[rax]
	pxor	xmm0, xmm0
	cvtsi2sdq	xmm0, QWORD PTR 40[rbp]
	cvtss2sd	xmm1, DWORD PTR 24[rbp]
	divsd	xmm0, xmm1
	call	nearbyint
	cvttsd2si	rax, xmm0
	mov	QWORD PTR [rbx], rax
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 32[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 40
	mov	rcx, QWORD PTR [rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 48
	mov	rax, QWORD PTR [rax]
	imul	rax, rcx
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR 16[rbp]
	lea	rbx, 8[rax]
	pxor	xmm0, xmm0
	cvtsi2sdq	xmm0, QWORD PTR 32[rbp]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 40
	mov	rax, QWORD PTR [rax]
	pxor	xmm1, xmm1
	cvtsi2sdq	xmm1, rax
	divsd	xmm0, xmm1
	call	nearbyint
	cvttsd2si	rax, xmm0
	mov	QWORD PTR [rbx], rax
	pxor	xmm0, xmm0
	cvtsi2sdq	xmm0, QWORD PTR 40[rbp]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 48
	mov	rax, QWORD PTR [rax]
	pxor	xmm1, xmm1
	cvtsi2sdq	xmm1, rax
	divsd	xmm0, xmm1
	call	nearbyint
	cvttsd2si	rdx, xmm0
	mov	rax, QWORD PTR 16[rbp]
	mov	QWORD PTR [rax], rdx
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 20
	mov	rdx, QWORD PTR 16[rbp]
	add	rdx, 8
	mov	rdx, QWORD PTR [rdx]
	pxor	xmm0, xmm0
	cvtsi2sdq	xmm0, rdx
	movsd	xmm1, QWORD PTR .LC5[rip]
	divsd	xmm1, xmm0
	movapd	xmm0, xmm1
	cvtsd2ss	xmm0, xmm0
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 16[rax]
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR [rax]
	pxor	xmm0, xmm0
	cvtsi2sdq	xmm0, rax
	movsd	xmm1, QWORD PTR .LC5[rip]
	divsd	xmm1, xmm0
	movapd	xmm0, xmm1
	cvtsd2ss	xmm0, xmm0
	movss	DWORD PTR [rdx], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 24
	mov	rdx, QWORD PTR 16[rbp]
	add	rdx, 32
	mov	rdx, QWORD PTR [rdx]
	sal	rdx, 2
	mov	QWORD PTR [rax], rdx
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 56
	mov	QWORD PTR [rax], 64
	nop
	add	rsp, 56
	pop	rbx
	pop	rbp
	ret
.L241:
	.globl	_ZN9FLUIDTYPEC1Ev
	.def	_ZN9FLUIDTYPEC1Ev;	.scl	2;	.type	32;	.endef
_ZN9FLUIDTYPEC1Ev:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 64
	mov	QWORD PTR 16[rbp], rcx
.L243:
	mov	rax, QWORD PTR 16[rbp]
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 4
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 8
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 16
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 24
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 32
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 36
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 40
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 44
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 48
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 52
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 56
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 64
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 72
	mov	QWORD PTR -16[rbp], rax
	mov	QWORD PTR -8[rbp], 0
.L244:
	mov	rax, QWORD PTR -16[rbp]
	mov	rcx, rax
	call	_ZN12PARTICLETYPEC1Ev
	add	QWORD PTR -16[rbp], 40
	add	QWORD PTR -8[rbp], 1
	cmp	QWORD PTR -8[rbp], 2100
	je	.L245
	jmp	.L244
.L245:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 84072
	mov	QWORD PTR -32[rbp], rax
	mov	QWORD PTR -24[rbp], 0
.L246:
	mov	rax, QWORD PTR -32[rbp]
	mov	rcx, rax
	call	_ZN16PARTICLEPAIRTYPEC1Ev
	add	QWORD PTR -32[rbp], 48
	add	QWORD PTR -24[rbp], 1
	cmp	QWORD PTR -24[rbp], 67200
	je	.L247
	jmp	.L246
.L247:
	mov	rax, QWORD PTR 16[rbp]
	pxor	xmm0, xmm0
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 4
	pxor	xmm0, xmm0
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 8
	pxor	xmm0, xmm0
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 16
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 24
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 32
	pxor	xmm0, xmm0
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 36
	pxor	xmm0, xmm0
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 40
	pxor	xmm0, xmm0
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 44
	pxor	xmm0, xmm0
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 48
	pxor	xmm0, xmm0
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 52
	pxor	xmm0, xmm0
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 56
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 64
	mov	QWORD PTR [rax], 0
	nop
	leave
	ret
.L248:
	.globl	_ZN9FLUIDTYPEC1ERS_
	.def	_ZN9FLUIDTYPEC1ERS_;	.scl	2;	.type	32;	.endef
_ZN9FLUIDTYPEC1ERS_:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 64
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
.L250:
	mov	rax, QWORD PTR 16[rbp]
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 4
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 8
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 16
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 24
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 32
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 36
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 40
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 44
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 48
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 52
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 56
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 64
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 72
	mov	QWORD PTR -16[rbp], rax
	mov	QWORD PTR -8[rbp], 0
.L251:
	mov	rax, QWORD PTR -16[rbp]
	mov	rcx, rax
	call	_ZN12PARTICLETYPEC1Ev
	add	QWORD PTR -16[rbp], 40
	add	QWORD PTR -8[rbp], 1
	cmp	QWORD PTR -8[rbp], 2100
	je	.L252
	jmp	.L251
.L252:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 84072
	mov	QWORD PTR -32[rbp], rax
	mov	QWORD PTR -24[rbp], 0
.L253:
	mov	rax, QWORD PTR -32[rbp]
	mov	rcx, rax
	call	_ZN16PARTICLEPAIRTYPEC1Ev
	add	QWORD PTR -32[rbp], 48
	add	QWORD PTR -24[rbp], 1
	cmp	QWORD PTR -24[rbp], 67200
	je	.L254
	jmp	.L253
.L254:
	mov	rax, QWORD PTR 24[rbp]
	movss	xmm0, DWORD PTR [rax]
	mov	rax, QWORD PTR 16[rbp]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 4[rax]
	mov	rax, QWORD PTR 24[rbp]
	movss	xmm0, DWORD PTR 4[rax]
	movss	DWORD PTR [rdx], xmm0
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 8[rax]
	mov	rax, QWORD PTR 24[rbp]
	movss	xmm0, DWORD PTR 8[rax]
	movss	DWORD PTR [rdx], xmm0
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 16[rax]
	mov	rax, QWORD PTR 24[rbp]
	mov	rax, QWORD PTR 16[rax]
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 24[rax]
	mov	rax, QWORD PTR 24[rbp]
	mov	rax, QWORD PTR 24[rax]
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 32[rax]
	mov	rax, QWORD PTR 24[rbp]
	movss	xmm0, DWORD PTR 32[rax]
	movss	DWORD PTR [rdx], xmm0
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 36[rax]
	mov	rax, QWORD PTR 24[rbp]
	movss	xmm0, DWORD PTR 36[rax]
	movss	DWORD PTR [rdx], xmm0
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 40[rax]
	mov	rax, QWORD PTR 24[rbp]
	movss	xmm0, DWORD PTR 40[rax]
	movss	DWORD PTR [rdx], xmm0
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 44[rax]
	mov	rax, QWORD PTR 24[rbp]
	movss	xmm0, DWORD PTR 44[rax]
	movss	DWORD PTR [rdx], xmm0
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 48[rax]
	mov	rax, QWORD PTR 24[rbp]
	movss	xmm0, DWORD PTR 48[rax]
	movss	DWORD PTR [rdx], xmm0
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 52[rax]
	mov	rax, QWORD PTR 24[rbp]
	movss	xmm0, DWORD PTR 52[rax]
	movss	DWORD PTR [rdx], xmm0
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 56[rax]
	mov	rax, QWORD PTR 24[rbp]
	mov	rax, QWORD PTR 56[rax]
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 64[rax]
	mov	rax, QWORD PTR 24[rbp]
	mov	rax, QWORD PTR 64[rax]
	mov	QWORD PTR [rdx], rax
	nop
	leave
	ret
.L255:
	.globl	_ZN9FLUIDTYPEC1Effffff
	.def	_ZN9FLUIDTYPEC1Effffff;	.scl	2;	.type	32;	.endef
_ZN9FLUIDTYPEC1Effffff:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 64
	mov	QWORD PTR 16[rbp], rcx
	movss	DWORD PTR 24[rbp], xmm1
	movss	DWORD PTR 32[rbp], xmm2
	movss	DWORD PTR 40[rbp], xmm3
.L257:
	mov	rax, QWORD PTR 16[rbp]
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 4
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 8
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 16
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 24
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 32
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 36
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 40
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 44
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 48
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 52
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 56
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 64
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 72
	mov	QWORD PTR -16[rbp], rax
	mov	QWORD PTR -8[rbp], 0
.L258:
	mov	rax, QWORD PTR -16[rbp]
	mov	rcx, rax
	call	_ZN12PARTICLETYPEC1Ev
	add	QWORD PTR -16[rbp], 40
	add	QWORD PTR -8[rbp], 1
	cmp	QWORD PTR -8[rbp], 2100
	je	.L259
	jmp	.L258
.L259:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 84072
	mov	QWORD PTR -32[rbp], rax
	mov	QWORD PTR -24[rbp], 0
.L260:
	mov	rax, QWORD PTR -32[rbp]
	mov	rcx, rax
	call	_ZN16PARTICLEPAIRTYPEC1Ev
	add	QWORD PTR -32[rbp], 48
	add	QWORD PTR -24[rbp], 1
	cmp	QWORD PTR -24[rbp], 67200
	je	.L261
	jmp	.L260
.L261:
	mov	rax, QWORD PTR 16[rbp]
	movss	xmm0, DWORD PTR 24[rbp]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 4
	movss	xmm0, DWORD PTR 40[rbp]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 8
	movss	xmm0, DWORD PTR 32[rbp]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 40
	movss	xmm0, DWORD PTR 48[rbp]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 44
	movss	xmm0, DWORD PTR 56[rbp]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 52
	movss	xmm0, DWORD PTR 64[rbp]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 32
	mov	rdx, QWORD PTR 16[rbp]
	add	rdx, 40
	movss	xmm0, DWORD PTR [rdx]
	addss	xmm0, xmm0
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 36
	mov	rdx, QWORD PTR 16[rbp]
	add	rdx, 32
	movss	xmm1, DWORD PTR [rdx]
	mov	rdx, QWORD PTR 16[rbp]
	add	rdx, 32
	movss	xmm0, DWORD PTR [rdx]
	mulss	xmm0, xmm1
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 48
	mov	rdx, QWORD PTR 16[rbp]
	add	rdx, 44
	movss	xmm1, DWORD PTR [rdx]
	mov	rdx, QWORD PTR 16[rbp]
	add	rdx, 44
	movss	xmm0, DWORD PTR [rdx]
	mulss	xmm0, xmm1
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 56
	mov	rdx, QWORD PTR 16[rbp]
	add	rdx, 72
	mov	QWORD PTR [rax], rdx
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 64
	mov	rdx, QWORD PTR 16[rbp]
	add	rdx, 84032
	mov	QWORD PTR [rax], rdx
	nop
	leave
	ret
.L262:
	.globl	_ZN8CELLTYPEC1Ev
	.def	_ZN8CELLTYPEC1Ev;	.scl	2;	.type	32;	.endef
_ZN8CELLTYPEC1Ev:
	push	rbp
	mov	rbp, rsp
	push	rdi
	mov	QWORD PTR 16[rbp], rcx
	mov	rax, QWORD PTR 16[rbp]
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 8
	mov	ecx, 512
	mov	r8d, 0
	mov	QWORD PTR [rax], r8
	mov	edx, ecx
	add	rdx, rax
	add	rdx, 8
	mov	QWORD PTR -16[rdx], r8
	lea	rdx, 8[rax]
	and	rdx, -8
	sub	rax, rdx
	add	ecx, eax
	and	ecx, -8
	mov	eax, ecx
	shr	eax, 3
	mov	ecx, eax
	mov	rdi, rdx
	mov	rax, r8
	rep stosq
	nop
	pop	rdi
	pop	rbp
	ret
.L264:
.L265:
	.globl	_ZN8CELLTYPEC1ERS_
	.def	_ZN8CELLTYPEC1ERS_;	.scl	2;	.type	32;	.endef
_ZN8CELLTYPEC1ERS_:
	push	rbp
	mov	rbp, rsp
	push	rdi
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
	mov	rax, QWORD PTR 16[rbp]
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 8
	mov	ecx, 512
	mov	r8d, 0
	mov	QWORD PTR [rax], r8
	mov	edx, ecx
	add	rdx, rax
	add	rdx, 8
	mov	QWORD PTR -16[rdx], r8
	lea	rdx, 8[rax]
	and	rdx, -8
	sub	rax, rdx
	add	ecx, eax
	and	ecx, -8
	mov	eax, ecx
	shr	eax, 3
	mov	ecx, eax
	mov	rdi, rdx
	mov	rax, r8
	rep stosq
	nop
	pop	rdi
	pop	rbp
	ret
.L267:
.L268:
	.globl	_ZN8CELLTYPEaSERS_
	.def	_ZN8CELLTYPEaSERS_;	.scl	2;	.type	32;	.endef
_ZN8CELLTYPEaSERS_:
	push	rbp
	mov	rbp, rsp
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
	nop
	pop	rbp
	ret
.L270:
.L271:
	.globl	_ZN14SIMULATIONTYPEC1Ev
	.def	_ZN14SIMULATIONTYPEC1Ev;	.scl	2;	.type	32;	.endef
_ZN14SIMULATIONTYPEC1Ev:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR 16[rbp], rcx
.L273:
	mov	rax, QWORD PTR 16[rbp]
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 8
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 16
	mov	rcx, rax
	call	_ZN9FLUIDTYPEC1Ev
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 3309688
	mov	rcx, rax
	call	_ZN8GRIDTYPEC1Ev
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 3530488
	mov	QWORD PTR [rax], 0
	mov	QWORD PTR 8[rax], 0
	mov	QWORD PTR 16[rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 3530512
	mov	rcx, rax
	call	_ZN9MOUSETYPEC1Ev
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZN14SIMULATIONTYPE13RUNSIMULATIONEv
	nop
	leave
	ret
.L274:
	.globl	_ZN14SIMULATIONTYPE13RUNSIMULATIONEv
	.def	_ZN14SIMULATIONTYPE13RUNSIMULATIONEv;	.scl	2;	.type	32;	.endef
_ZN14SIMULATIONTYPE13RUNSIMULATIONEv:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 112
	mov	QWORD PTR 16[rbp], rcx
.L276:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 3530488
	mov	QWORD PTR 72[rsp], 0
	mov	QWORD PTR 64[rsp], 0
	mov	QWORD PTR 56[rsp], 0
	mov	QWORD PTR 48[rsp], 8
	mov	QWORD PTR 40[rsp], 8
	mov	QWORD PTR 32[rsp], 8
	mov	r9d, 8
	mov	r8d, 1000
	mov	edx, 300
	mov	rcx, rax
	call	_ZN10SCREENTYPE12CREATESCREENEu7INTEGERS0_S0_S0_S0_S0_S0_S0_S0_
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZN14SIMULATIONTYPE18INITIATESIMULATIONEv
.L277:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 16
	mov	rcx, rax
	call	_ZN9FLUIDTYPE14RESETPARTICLESEv
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 3309688
	mov	rcx, rax
	call	_ZN8GRIDTYPE10RESETCELLSEv
	mov	ecx, 59
	call	fb_Multikey
	mov	DWORD PTR -12[rbp], eax
	cmp	DWORD PTR -12[rbp], 0
	je	.L295
	mov	rax, QWORD PTR 16[rbp]
	mov	QWORD PTR [rax], 1
	jmp	.L279
.L295:
	nop
.L279:
	mov	ecx, 60
	call	fb_Multikey
	mov	DWORD PTR -16[rbp], eax
	cmp	DWORD PTR -16[rbp], 0
	je	.L296
	mov	rax, QWORD PTR 16[rbp]
	mov	QWORD PTR [rax], 2
	jmp	.L281
.L296:
	nop
.L281:
	mov	ecx, 61
	call	fb_Multikey
	mov	DWORD PTR -20[rbp], eax
	cmp	DWORD PTR -20[rbp], 0
	je	.L297
	mov	rax, QWORD PTR 16[rbp]
	mov	QWORD PTR [rax], 3
	jmp	.L283
.L297:
	nop
.L283:
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZN14SIMULATIONTYPE11UPDATEMOUSEEv
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 3309688[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 16
	mov	r8, rdx
	mov	rdx, rax
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZN14SIMULATIONTYPE17COMPUTEBROADPHASEEP9FLUIDTYPEP8GRIDTYPE
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 3309688[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 16
	mov	r8, rdx
	mov	rdx, rax
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZN14SIMULATIONTYPE20COMPUTEPARTICLEPAIRSEP9FLUIDTYPEP8GRIDTYPE
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZN14SIMULATIONTYPE19COMPUTEREUSABLEDATAEv
	mov	ecx, 57
	call	fb_Multikey
	mov	DWORD PTR -24[rbp], eax
	cmp	DWORD PTR -24[rbp], 0
	je	.L298
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 16
	mov	rcx, rax
	call	_ZN9FLUIDTYPE16COMPUTEWARMSTARTEv
	jmp	.L286
.L298:
	nop
.L285:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 16
	mov	rcx, rax
	call	_ZN9FLUIDTYPE14CLEARWARMSTARTEv
.L286:
	mov	QWORD PTR -8[rbp], 1
.L287:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 16
	mov	rcx, rax
	call	_ZN9FLUIDTYPE24COMPUTECORRECTIVEIMPULSEEv
.L288:
	add	QWORD PTR -8[rbp], 1
.L289:
	cmp	QWORD PTR -8[rbp], 4
	jg	.L290
	jmp	.L287
.L290:
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZN14SIMULATIONTYPE21COMPUTEBORDERIMPULSESEv
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 16
	mov	rdx, rax
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZN14SIMULATIONTYPE15COMPUTENEWSTATEEP9FLUIDTYPE
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZN14SIMULATIONTYPE9DRAWFLUIDEv
.L291:
	mov	ecx, 1
	call	fb_Multikey
	mov	DWORD PTR -28[rbp], eax
	cmp	DWORD PTR -28[rbp], 0
	jne	.L292
	jmp	.L277
.L292:
	mov	ecx, 0
	call	fb_End
	nop
	leave
	ret
.L293:
	.globl	_ZN8GRIDTYPE16COMPUTECELLPAIRSEv
	.def	_ZN8GRIDTYPE16COMPUTECELLPAIRSEv;	.scl	2;	.type	32;	.endef
_ZN8GRIDTYPE16COMPUTECELLPAIRSEv:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR 16[rbp], rcx
.L300:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 24
	mov	QWORD PTR [rax], 0
	mov	QWORD PTR -8[rbp], 0
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 40[rax]
	mov	QWORD PTR -24[rbp], rax
	jmp	.L301
.L329:
	nop
.L302:
	mov	QWORD PTR -16[rbp], 0
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 48[rax]
	mov	QWORD PTR -32[rbp], rax
	jmp	.L303
.L328:
	nop
.L304:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 40
	mov	rax, QWORD PTR [rax]
	cmp	rax, QWORD PTR -8[rbp]
	jle	.L324
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 24
	mov	rdx, QWORD PTR 16[rbp]
	add	rdx, 24
	mov	rdx, QWORD PTR [rdx]
	add	rdx, 1
	mov	QWORD PTR [rax], rdx
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	sal	rax, 4
	lea	rdx, 194544[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rdx, rax
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rax
	mov	rcx, rax
	sal	rcx, 4
	add	rcx, rax
	mov	rax, QWORD PTR -16[rbp]
	add	rax, rcx
	sal	rax, 3
	mov	rcx, rax
	sal	rcx, 6
	add	rax, rcx
	lea	rcx, 64[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, rcx
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	sal	rax, 4
	lea	rdx, 194552[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rdx, rax
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rax
	mov	rcx, rax
	sal	rcx, 4
	add	rcx, rax
	mov	rax, QWORD PTR -16[rbp]
	add	rax, rcx
	sal	rax, 3
	mov	rcx, rax
	sal	rcx, 6
	add	rax, rcx
	lea	rcx, 17744[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, rcx
	mov	QWORD PTR [rdx], rax
	jmp	.L307
.L306:
.L324:
	nop
.L307:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 48
	mov	rax, QWORD PTR [rax]
	cmp	rax, QWORD PTR -16[rbp]
	jle	.L325
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 24
	mov	rdx, QWORD PTR 16[rbp]
	add	rdx, 24
	mov	rdx, QWORD PTR [rdx]
	add	rdx, 1
	mov	QWORD PTR [rax], rdx
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	sal	rax, 4
	lea	rdx, 194544[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rdx, rax
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rax
	mov	rcx, rax
	sal	rcx, 4
	add	rcx, rax
	mov	rax, QWORD PTR -16[rbp]
	add	rax, rcx
	sal	rax, 3
	mov	rcx, rax
	sal	rcx, 6
	add	rax, rcx
	lea	rcx, 64[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, rcx
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	sal	rax, 4
	lea	rdx, 194552[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rdx, rax
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rax
	mov	rcx, rax
	sal	rcx, 4
	add	rcx, rax
	mov	rax, QWORD PTR -16[rbp]
	add	rax, rcx
	sal	rax, 3
	mov	rcx, rax
	sal	rcx, 6
	add	rax, rcx
	lea	rcx, 584[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, rcx
	mov	QWORD PTR [rdx], rax
	jmp	.L310
.L309:
.L325:
	nop
.L310:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 40
	mov	rax, QWORD PTR [rax]
	cmp	rax, QWORD PTR -8[rbp]
	setg	al
	movzx	eax, al
	neg	eax
	mov	edx, eax
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 48
	mov	rax, QWORD PTR [rax]
	cmp	rax, QWORD PTR -16[rbp]
	setg	al
	movzx	eax, al
	neg	eax
	and	eax, edx
	test	eax, eax
	je	.L326
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 24
	mov	rdx, QWORD PTR 16[rbp]
	add	rdx, 24
	mov	rdx, QWORD PTR [rdx]
	add	rdx, 1
	mov	QWORD PTR [rax], rdx
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	sal	rax, 4
	lea	rdx, 194544[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rdx, rax
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rax
	mov	rcx, rax
	sal	rcx, 4
	add	rcx, rax
	mov	rax, QWORD PTR -16[rbp]
	add	rax, rcx
	sal	rax, 3
	mov	rcx, rax
	sal	rcx, 6
	add	rax, rcx
	lea	rcx, 64[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, rcx
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	sal	rax, 4
	lea	rdx, 194552[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rdx, rax
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rax
	mov	rcx, rax
	sal	rcx, 4
	add	rcx, rax
	mov	rax, QWORD PTR -16[rbp]
	add	rax, rcx
	sal	rax, 3
	mov	rcx, rax
	sal	rcx, 6
	add	rax, rcx
	lea	rcx, 18264[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, rcx
	mov	QWORD PTR [rdx], rax
	jmp	.L313
.L312:
.L326:
	nop
.L313:
	cmp	QWORD PTR -8[rbp], 0
	setg	al
	movzx	eax, al
	neg	eax
	mov	edx, eax
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 48
	mov	rax, QWORD PTR [rax]
	cmp	rax, QWORD PTR -16[rbp]
	setg	al
	movzx	eax, al
	neg	eax
	and	eax, edx
	test	eax, eax
	je	.L327
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 24
	mov	rdx, QWORD PTR 16[rbp]
	add	rdx, 24
	mov	rdx, QWORD PTR [rdx]
	add	rdx, 1
	mov	QWORD PTR [rax], rdx
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	sal	rax, 4
	lea	rdx, 194544[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rdx, rax
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rax
	mov	rcx, rax
	sal	rcx, 4
	add	rcx, rax
	mov	rax, QWORD PTR -16[rbp]
	add	rax, rcx
	sal	rax, 3
	mov	rcx, rax
	sal	rcx, 6
	add	rax, rcx
	lea	rcx, 64[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, rcx
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	sal	rax, 4
	lea	rdx, 194552[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rdx, rax
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rax
	mov	rcx, rax
	sal	rcx, 4
	add	rcx, rax
	mov	rax, QWORD PTR -16[rbp]
	add	rax, rcx
	sal	rax, 3
	mov	rcx, rax
	sal	rcx, 6
	add	rax, rcx
	lea	rcx, -17096[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, rcx
	mov	QWORD PTR [rdx], rax
	jmp	.L317
.L315:
.L316:
.L327:
	nop
.L317:
	add	QWORD PTR -16[rbp], 1
.L303:
	mov	rax, QWORD PTR -16[rbp]
	cmp	rax, QWORD PTR -32[rbp]
	jle	.L328
.L318:
.L319:
	add	QWORD PTR -8[rbp], 1
.L301:
	mov	rax, QWORD PTR -8[rbp]
	cmp	rax, QWORD PTR -24[rbp]
	jle	.L329
.L320:
.L321:
	nop
	leave
	ret
	.globl	_ZN14SIMULATIONTYPE18INITIATESIMULATIONEv
	.def	_ZN14SIMULATIONTYPE18INITIATESIMULATIONEv;	.scl	2;	.type	32;	.endef
_ZN14SIMULATIONTYPE18INITIATESIMULATIONEv:
	push	rbp
	mov	rbp, rsp
	mov	eax, 220928
	call	___chkstk_ms
	sub	rsp, rax
	mov	QWORD PTR 16[rbp], rcx
.L331:
	lea	rax, -220880[rbp]
	mov	r9d, 1000
	mov	r8d, 300
	movss	xmm1, DWORD PTR .LC6[rip]
	mov	rcx, rax
	call	_ZN8GRIDTYPEC1Efu7INTEGERS0_
	mov	rax, QWORD PTR 16[rbp]
	lea	rcx, 3309688[rax]
	lea	rax, -220880[rbp]
	mov	rdx, rax
	call	_ZN8GRIDTYPEaSERKS_
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 3309688
	mov	rcx, rax
	call	_ZN8GRIDTYPE16COMPUTECELLPAIRSEv
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 16
	movss	xmm0, DWORD PTR .LC7[rip]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 24
	movss	xmm0, DWORD PTR .LC8[rip]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 20
	movss	xmm0, DWORD PTR .LC9[rip]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 56
	movss	xmm0, DWORD PTR .LC10[rip]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 60
	movss	xmm0, DWORD PTR .LC11[rip]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 68
	movss	xmm0, DWORD PTR .LC12[rip]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 64
	mov	rdx, QWORD PTR 16[rbp]
	add	rdx, 60
	movss	xmm1, DWORD PTR [rdx]
	mov	rdx, QWORD PTR 16[rbp]
	add	rdx, 60
	movss	xmm0, DWORD PTR [rdx]
	mulss	xmm0, xmm1
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 48
	mov	rdx, QWORD PTR 16[rbp]
	add	rdx, 56
	movss	xmm0, DWORD PTR [rdx]
	addss	xmm0, xmm0
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 52
	mov	rdx, QWORD PTR 16[rbp]
	add	rdx, 48
	movss	xmm1, DWORD PTR [rdx]
	mov	rdx, QWORD PTR 16[rbp]
	add	rdx, 48
	movss	xmm0, DWORD PTR [rdx]
	mulss	xmm0, xmm1
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 72
	mov	rdx, QWORD PTR 16[rbp]
	add	rdx, 88
	mov	QWORD PTR [rax], rdx
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 80
	mov	rdx, QWORD PTR 16[rbp]
	add	rdx, 84048
	mov	QWORD PTR [rax], rdx
	call	fb_Timer
	movq	rax, xmm0
	mov	QWORD PTR -32[rbp], rax
	mov	rax, QWORD PTR -32[rbp]
	mov	edx, 0
	mov	QWORD PTR -220888[rbp], rax
	movsd	xmm0, QWORD PTR -220888[rbp]
	call	fb_Randomize
	mov	QWORD PTR -8[rbp], 0
	mov	QWORD PTR -16[rbp], 1
.L332:
	mov	QWORD PTR -24[rbp], 1
.L333:
	add	QWORD PTR -8[rbp], 1
	mov	rdx, QWORD PTR -8[rbp]
	mov	rax, rdx
	sal	rax, 2
	add	rax, rdx
	sal	rax, 3
	lea	rdx, 48[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, rdx
	mov	QWORD PTR -40[rbp], rax
	mov	rax, QWORD PTR -40[rbp]
	add	rax, 12
	pxor	xmm0, xmm0
	cvtsi2ssq	xmm0, QWORD PTR -16[rbp]
	movss	xmm1, DWORD PTR .LC10[rip]
	mulss	xmm0, xmm1
	cvtss2sd	xmm0, xmm0
	movsd	xmm1, QWORD PTR .LC13[rip]
	mulsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR .LC14[rip]
	addsd	xmm0, xmm1
	cvtsd2ss	xmm0, xmm0
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR -40[rbp]
	add	rax, 16
	pxor	xmm0, xmm0
	cvtsi2ssq	xmm0, QWORD PTR -24[rbp]
	movss	xmm1, DWORD PTR .LC10[rip]
	mulss	xmm0, xmm1
	cvtss2sd	xmm0, xmm0
	movsd	xmm1, QWORD PTR .LC13[rip]
	mulsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR .LC15[rip]
	subsd	xmm1, xmm0
	movapd	xmm0, xmm1
	cvtsd2ss	xmm0, xmm0
	movss	DWORD PTR [rax], xmm0
	movss	xmm0, DWORD PTR .LC3[rip]
	call	fb_Rnd
	movq	rax, xmm0
	mov	QWORD PTR -48[rbp], rax
	movss	xmm0, DWORD PTR .LC3[rip]
	call	fb_Rnd
	movq	rax, xmm0
	mov	QWORD PTR -56[rbp], rax
	mov	rax, QWORD PTR -40[rbp]
	add	rax, 12
	mov	rdx, QWORD PTR -40[rbp]
	add	rdx, 12
	movss	xmm0, DWORD PTR [rdx]
	cvtss2sd	xmm1, xmm0
	movsd	xmm0, QWORD PTR -48[rbp]
	subsd	xmm0, QWORD PTR -56[rbp]
	movsd	xmm2, QWORD PTR .LC16[rip]
	mulsd	xmm0, xmm2
	addsd	xmm0, xmm1
	cvtsd2ss	xmm0, xmm0
	movss	DWORD PTR [rax], xmm0
	movss	xmm0, DWORD PTR .LC3[rip]
	call	fb_Rnd
	movq	rax, xmm0
	mov	QWORD PTR -64[rbp], rax
	movss	xmm0, DWORD PTR .LC3[rip]
	call	fb_Rnd
	movq	rax, xmm0
	mov	QWORD PTR -72[rbp], rax
	mov	rax, QWORD PTR -40[rbp]
	add	rax, 16
	mov	rdx, QWORD PTR -40[rbp]
	add	rdx, 16
	movss	xmm0, DWORD PTR [rdx]
	cvtss2sd	xmm1, xmm0
	movsd	xmm0, QWORD PTR -64[rbp]
	subsd	xmm0, QWORD PTR -72[rbp]
	movsd	xmm2, QWORD PTR .LC16[rip]
	mulsd	xmm0, xmm2
	addsd	xmm0, xmm1
	cvtsd2ss	xmm0, xmm0
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR -40[rbp]
	lea	rdx, 20[rax]
	mov	rax, QWORD PTR -40[rbp]
	movss	xmm0, DWORD PTR 12[rax]
	movss	DWORD PTR [rdx], xmm0
	mov	rax, QWORD PTR -40[rbp]
	lea	rdx, 24[rax]
	mov	rax, QWORD PTR -40[rbp]
	movss	xmm0, DWORD PTR 16[rax]
	movss	DWORD PTR [rdx], xmm0
.L334:
	add	QWORD PTR -24[rbp], 1
.L335:
	cmp	QWORD PTR -24[rbp], 70
	jg	.L337
	jmp	.L333
.L336:
.L337:
	add	QWORD PTR -16[rbp], 1
.L338:
	cmp	QWORD PTR -16[rbp], 30
	jg	.L339
	jmp	.L332
.L339:
	mov	rax, QWORD PTR 16[rbp]
	mov	QWORD PTR [rax], 2
	nop
	leave
	ret
.L340:
	.globl	_ZN14SIMULATIONTYPE17COMPUTEBROADPHASEEP9FLUIDTYPEP8GRIDTYPE
	.def	_ZN14SIMULATIONTYPE17COMPUTEBROADPHASEEP9FLUIDTYPEP8GRIDTYPE;	.scl	2;	.type	32;	.endef
_ZN14SIMULATIONTYPE17COMPUTEBROADPHASEEP9FLUIDTYPEP8GRIDTYPE:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 80
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
	mov	QWORD PTR 32[rbp], r8
.L342:
	mov	rax, QWORD PTR 24[rbp]
	mov	rax, QWORD PTR 56[rax]
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR 24[rbp]
	mov	rax, QWORD PTR 64[rax]
	mov	QWORD PTR -16[rbp], rax
	jmp	.L343
.L358:
	nop
.L344:
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 12
	movss	xmm1, DWORD PTR [rax]
	mov	rax, QWORD PTR 32[rbp]
	add	rax, 20
	movss	xmm0, DWORD PTR [rax]
	mulss	xmm0, xmm1
	call	nearbyintf
	cvttss2si	rax, xmm0
	mov	QWORD PTR -24[rbp], rax
	mov	rax, QWORD PTR -24[rbp]
	shr	rax, 63
	movzx	eax, al
	neg	eax
	mov	edx, eax
	mov	rax, QWORD PTR 32[rbp]
	add	rax, 40
	mov	rax, QWORD PTR [rax]
	cmp	rax, QWORD PTR -24[rbp]
	setl	al
	movzx	eax, al
	neg	eax
	or	eax, edx
	test	eax, eax
	jne	.L355
	nop
.L346:
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 16
	movss	xmm1, DWORD PTR [rax]
	mov	rax, QWORD PTR 32[rbp]
	add	rax, 16
	movss	xmm0, DWORD PTR [rax]
	mulss	xmm0, xmm1
	call	nearbyintf
	cvttss2si	rax, xmm0
	mov	QWORD PTR -32[rbp], rax
	mov	rax, QWORD PTR -32[rbp]
	shr	rax, 63
	movzx	eax, al
	neg	eax
	mov	edx, eax
	mov	rax, QWORD PTR 32[rbp]
	add	rax, 48
	mov	rax, QWORD PTR [rax]
	cmp	rax, QWORD PTR -32[rbp]
	setl	al
	movzx	eax, al
	neg	eax
	or	eax, edx
	test	eax, eax
	jne	.L356
	nop
.L349:
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rax
	mov	rdx, rax
	sal	rdx, 4
	add	rdx, rax
	mov	rax, QWORD PTR -32[rbp]
	add	rax, rdx
	sal	rax, 3
	mov	rdx, rax
	sal	rdx, 6
	add	rax, rdx
	lea	rdx, 64[rax]
	mov	rax, QWORD PTR 32[rbp]
	add	rax, rdx
	mov	QWORD PTR -40[rbp], rax
	mov	rax, QWORD PTR -40[rbp]
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR 32[rbp]
	add	rax, 56
	mov	rax, QWORD PTR [rax]
	cmp	rdx, rax
	jge	.L357
	nop
.L351:
	mov	rax, QWORD PTR -40[rbp]
	mov	rax, QWORD PTR [rax]
	lea	rdx, 1[rax]
	mov	rax, QWORD PTR -40[rbp]
	mov	QWORD PTR [rax], rdx
	mov	rax, QWORD PTR -40[rbp]
	mov	rax, QWORD PTR [rax]
	sal	rax, 3
	mov	rdx, rax
	mov	rax, QWORD PTR -40[rbp]
	add	rdx, rax
	mov	rax, QWORD PTR -8[rbp]
	mov	QWORD PTR [rdx], rax
	jmp	.L347
.L355:
	nop
	jmp	.L347
.L356:
	nop
	jmp	.L347
.L357:
	nop
.L347:
	add	QWORD PTR -8[rbp], 40
.L343:
	mov	rax, QWORD PTR -8[rbp]
	cmp	rax, QWORD PTR -16[rbp]
	jbe	.L358
.L352:
.L353:
	nop
	leave
	ret
	.globl	_ZN14SIMULATIONTYPE20COMPUTEPARTICLEPAIRSEP9FLUIDTYPEP8GRIDTYPE
	.def	_ZN14SIMULATIONTYPE20COMPUTEPARTICLEPAIRSEP9FLUIDTYPEP8GRIDTYPE;	.scl	2;	.type	32;	.endef
_ZN14SIMULATIONTYPE20COMPUTEPARTICLEPAIRSEP9FLUIDTYPEP8GRIDTYPE:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 160
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
	mov	QWORD PTR 32[rbp], r8
.L360:
	mov	rax, QWORD PTR 24[rbp]
	add	rax, 24
	mov	QWORD PTR [rax], 0
	mov	QWORD PTR -8[rbp], 0
	mov	rax, QWORD PTR 32[rbp]
	mov	rax, QWORD PTR 40[rax]
	mov	QWORD PTR -64[rbp], rax
	jmp	.L361
.L407:
	nop
.L362:
	mov	QWORD PTR -16[rbp], 0
	mov	rax, QWORD PTR 32[rbp]
	mov	rax, QWORD PTR 48[rax]
	mov	QWORD PTR -72[rbp], rax
	jmp	.L363
.L406:
	nop
.L364:
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rax
	mov	rdx, rax
	sal	rdx, 4
	add	rdx, rax
	mov	rax, QWORD PTR -16[rbp]
	add	rax, rdx
	sal	rax, 3
	mov	rdx, rax
	sal	rdx, 6
	add	rax, rdx
	lea	rdx, 64[rax]
	mov	rax, QWORD PTR 32[rbp]
	add	rax, rdx
	mov	QWORD PTR -80[rbp], rax
	mov	rax, QWORD PTR -80[rbp]
	mov	rax, QWORD PTR [rax]
	test	rax, rax
	je	.L403
	nop
.L366:
	mov	QWORD PTR -24[rbp], 1
	mov	rax, QWORD PTR -80[rbp]
	mov	rax, QWORD PTR [rax]
	sub	rax, 1
	mov	QWORD PTR -88[rbp], rax
	jmp	.L368
.L405:
	nop
.L369:
	mov	rax, QWORD PTR -24[rbp]
	add	rax, 1
	mov	QWORD PTR -32[rbp], rax
	mov	rax, QWORD PTR -80[rbp]
	mov	rax, QWORD PTR [rax]
	mov	QWORD PTR -96[rbp], rax
	jmp	.L370
.L404:
	nop
.L371:
	mov	rax, QWORD PTR -32[rbp]
	sal	rax, 3
	mov	rdx, rax
	mov	rax, QWORD PTR -80[rbp]
	add	rax, rdx
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR -24[rbp]
	sal	rax, 3
	mov	rcx, rax
	mov	rax, QWORD PTR -80[rbp]
	add	rax, rcx
	mov	rax, QWORD PTR [rax]
	mov	r8, rdx
	mov	rdx, rax
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZN14SIMULATIONTYPE9CHECKPAIREP12PARTICLETYPES1_
.L372:
	add	QWORD PTR -32[rbp], 1
.L370:
	mov	rax, QWORD PTR -32[rbp]
	cmp	rax, QWORD PTR -96[rbp]
	jle	.L404
.L373:
.L374:
	add	QWORD PTR -24[rbp], 1
.L368:
	mov	rax, QWORD PTR -24[rbp]
	cmp	rax, QWORD PTR -88[rbp]
	jle	.L405
	jmp	.L375
.L367:
.L403:
	nop
.L375:
	add	QWORD PTR -16[rbp], 1
.L363:
	mov	rax, QWORD PTR -16[rbp]
	cmp	rax, QWORD PTR -72[rbp]
	jle	.L406
.L376:
.L377:
	add	QWORD PTR -8[rbp], 1
.L361:
	mov	rax, QWORD PTR -8[rbp]
	cmp	rax, QWORD PTR -64[rbp]
	jle	.L407
.L378:
	mov	rax, QWORD PTR 32[rbp]
	add	rax, 194560
	mov	QWORD PTR -40[rbp], rax
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 3309712
	mov	rax, QWORD PTR [rax]
	sal	rax, 4
	lea	rdx, 194544[rax]
	mov	rax, QWORD PTR 32[rbp]
	add	rax, rdx
	mov	QWORD PTR -104[rbp], rax
	jmp	.L379
.L412:
	nop
.L380:
	mov	rax, QWORD PTR -40[rbp]
	mov	rax, QWORD PTR [rax]
	mov	rax, QWORD PTR [rax]
	test	rax, rax
	je	.L408
	nop
.L382:
	mov	rax, QWORD PTR -40[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	mov	rax, QWORD PTR [rax]
	test	rax, rax
	je	.L409
	nop
.L385:
	mov	QWORD PTR -48[rbp], 1
	mov	rax, QWORD PTR -40[rbp]
	mov	rax, QWORD PTR [rax]
	mov	rax, QWORD PTR [rax]
	mov	QWORD PTR -112[rbp], rax
	jmp	.L386
.L411:
	nop
.L387:
	mov	QWORD PTR -56[rbp], 1
	mov	rax, QWORD PTR -40[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	mov	rax, QWORD PTR [rax]
	mov	QWORD PTR -120[rbp], rax
	jmp	.L388
.L410:
	nop
.L389:
	mov	rax, QWORD PTR -40[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	mov	rdx, QWORD PTR -56[rbp]
	sal	rdx, 3
	add	rax, rdx
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR -40[rbp]
	mov	rax, QWORD PTR [rax]
	mov	rcx, QWORD PTR -48[rbp]
	sal	rcx, 3
	add	rax, rcx
	mov	rax, QWORD PTR [rax]
	mov	r8, rdx
	mov	rdx, rax
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZN14SIMULATIONTYPE9CHECKPAIREP12PARTICLETYPES1_
.L390:
	add	QWORD PTR -56[rbp], 1
.L388:
	mov	rax, QWORD PTR -56[rbp]
	cmp	rax, QWORD PTR -120[rbp]
	jle	.L410
.L391:
.L392:
	add	QWORD PTR -48[rbp], 1
.L386:
	mov	rax, QWORD PTR -48[rbp]
	cmp	rax, QWORD PTR -112[rbp]
	jle	.L411
	jmp	.L393
.L383:
.L408:
	nop
	jmp	.L393
.L409:
	nop
.L393:
	add	QWORD PTR -40[rbp], 16
.L379:
	mov	rax, QWORD PTR -40[rbp]
	cmp	rax, QWORD PTR -104[rbp]
	jbe	.L412
.L394:
.L395:
	nop
	leave
	ret
	.globl	_ZN8GRIDTYPE10RESETCELLSEv
	.def	_ZN8GRIDTYPE10RESETCELLSEv;	.scl	2;	.type	32;	.endef
_ZN8GRIDTYPE10RESETCELLSEv:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR 16[rbp], rcx
.L414:
	mov	QWORD PTR -8[rbp], 0
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 40[rax]
	mov	QWORD PTR -24[rbp], rax
	jmp	.L415
.L427:
	nop
.L416:
	mov	QWORD PTR -16[rbp], 0
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 48[rax]
	mov	QWORD PTR -32[rbp], rax
	jmp	.L417
.L426:
	nop
.L418:
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rax
	mov	rdx, rax
	sal	rdx, 4
	add	rdx, rax
	mov	rax, QWORD PTR -16[rbp]
	add	rax, rdx
	sal	rax, 3
	mov	rdx, rax
	sal	rdx, 6
	add	rax, rdx
	lea	rdx, 64[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, rdx
	mov	QWORD PTR [rax], 0
.L419:
	add	QWORD PTR -16[rbp], 1
.L417:
	mov	rax, QWORD PTR -16[rbp]
	cmp	rax, QWORD PTR -32[rbp]
	jle	.L426
.L420:
.L421:
	add	QWORD PTR -8[rbp], 1
.L415:
	mov	rax, QWORD PTR -8[rbp]
	cmp	rax, QWORD PTR -24[rbp]
	jle	.L427
.L422:
.L423:
	nop
	leave
	ret
	.globl	_ZN9FLUIDTYPE14RESETPARTICLESEv
	.def	_ZN9FLUIDTYPE14RESETPARTICLESEv;	.scl	2;	.type	32;	.endef
_ZN9FLUIDTYPE14RESETPARTICLESEv:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 64
	mov	QWORD PTR 16[rbp], rcx
.L429:
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 56[rax]
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 64[rax]
	mov	QWORD PTR -16[rbp], rax
	jmp	.L430
.L436:
	nop
.L431:
	mov	rax, QWORD PTR -8[rbp]
	pxor	xmm0, xmm0
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 36
	pxor	xmm0, xmm0
	movss	DWORD PTR [rax], xmm0
	lea	rax, -32[rbp]
	movss	xmm2, DWORD PTR .LC17[rip]
	pxor	xmm1, xmm1
	mov	rcx, rax
	call	_ZN4VEC2C1EfS0_
	mov	rax, QWORD PTR -8[rbp]
	lea	rcx, 4[rax]
	lea	rax, -32[rbp]
	mov	rdx, rax
	call	_ZN4VEC2aSERKS_
.L432:
	add	QWORD PTR -8[rbp], 40
.L430:
	mov	rax, QWORD PTR -8[rbp]
	cmp	rax, QWORD PTR -16[rbp]
	jbe	.L436
.L433:
.L434:
	nop
	leave
	ret
	.globl	_ZN9FLUIDTYPE24COMPUTECORRECTIVEIMPULSEEv
	.def	_ZN9FLUIDTYPE24COMPUTECORRECTIVEIMPULSEEv;	.scl	2;	.type	32;	.endef
_ZN9FLUIDTYPE24COMPUTECORRECTIVEIMPULSEEv:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 160
	mov	QWORD PTR 16[rbp], rcx
.L438:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 84072
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 24
	mov	rdx, QWORD PTR [rax]
	mov	rax, rdx
	add	rax, rax
	add	rax, rdx
	sal	rax, 4
	lea	rdx, 84024[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, rdx
	mov	QWORD PTR -16[rbp], rax
	jmp	.L439
.L445:
	nop
.L440:
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 32
	mov	rax, QWORD PTR [rax]
	lea	rdx, 4[rax]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 40
	mov	rax, QWORD PTR [rax]
	add	rax, 4
	mov	rcx, rax
	call	_ZmiRK4VEC2S1_
	mov	QWORD PTR -80[rbp], rax
	mov	rax, QWORD PTR -80[rbp]
	mov	QWORD PTR -32[rbp], rax
	lea	rdx, -32[rbp]
	lea	rax, -64[rbp]
	mov	rcx, rax
	call	_ZN4VEC2C1ERKS_
	mov	rax, QWORD PTR -8[rbp]
	lea	rcx, 16[rax]
	lea	rax, -64[rbp]
	mov	rdx, rax
	call	_ZNK4VEC23DOTERKS_
	movd	eax, xmm0
	mov	DWORD PTR -20[rbp], eax
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 12
	movss	xmm1, DWORD PTR [rax]
	movss	xmm0, DWORD PTR -20[rbp]
	subss	xmm0, xmm1
	movss	DWORD PTR -24[rbp], xmm0
	mov	rax, QWORD PTR -8[rbp]
	lea	rdx, 16[rax]
	mov	eax, DWORD PTR -24[rbp]
	mov	DWORD PTR -116[rbp], eax
	movss	xmm0, DWORD PTR -116[rbp]
	call	_ZmlfRK4VEC2
	mov	QWORD PTR -112[rbp], rax
	mov	rax, QWORD PTR -112[rbp]
	mov	QWORD PTR -48[rbp], rax
	lea	rdx, -48[rbp]
	lea	rax, -96[rbp]
	mov	rcx, rax
	call	_ZN4VEC2C1ERKS_
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 32
	mov	rax, QWORD PTR [rax]
	lea	rcx, 4[rax]
	lea	rax, -96[rbp]
	mov	rdx, rax
	call	_ZN4VEC2pLERKS_
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 40
	mov	rax, QWORD PTR [rax]
	lea	rcx, 4[rax]
	lea	rax, -96[rbp]
	mov	rdx, rax
	call	_ZN4VEC2mIERKS_
	mov	rax, QWORD PTR -8[rbp]
	lea	rcx, 24[rax]
	lea	rax, -96[rbp]
	mov	rdx, rax
	call	_ZN4VEC2pLERKS_
.L441:
	add	QWORD PTR -8[rbp], 48
.L439:
	mov	rax, QWORD PTR -8[rbp]
	cmp	rax, QWORD PTR -16[rbp]
	jbe	.L445
.L442:
.L443:
	nop
	leave
	ret
	.globl	_ZN9FLUIDTYPE16COMPUTEWARMSTARTEv
	.def	_ZN9FLUIDTYPE16COMPUTEWARMSTARTEv;	.scl	2;	.type	32;	.endef
_ZN9FLUIDTYPE16COMPUTEWARMSTARTEv:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 112
	mov	QWORD PTR 16[rbp], rcx
.L447:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 84072
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 24
	mov	rdx, QWORD PTR [rax]
	mov	rax, rdx
	add	rax, rax
	add	rax, rdx
	sal	rax, 4
	lea	rdx, 84024[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, rdx
	mov	QWORD PTR -16[rbp], rax
	jmp	.L448
.L459:
	nop
.L449:
	mov	rax, QWORD PTR -8[rbp]
	lea	rdx, 24[rax]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 16
	mov	rcx, rax
	call	_ZNK4VEC23DOTERKS_
	movd	eax, xmm0
	mov	DWORD PTR -20[rbp], eax
	movss	xmm0, DWORD PTR -20[rbp]
	movss	DWORD PTR -24[rbp], xmm0
	movss	xmm0, DWORD PTR -24[rbp]
	pxor	xmm1, xmm1
	ucomiss	xmm0, xmm1
	jnb	.L458
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 16
	movss	xmm1, DWORD PTR -24[rbp]
	movss	xmm0, DWORD PTR .LC18[rip]
	mulss	xmm0, xmm1
	mov	rdx, rax
	call	_ZmlfRK4VEC2
	mov	QWORD PTR -80[rbp], rax
	mov	rax, QWORD PTR -80[rbp]
	mov	QWORD PTR -48[rbp], rax
	lea	rdx, -48[rbp]
	lea	rax, -64[rbp]
	mov	rcx, rax
	call	_ZN4VEC2C1ERKS_
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 32
	mov	rax, QWORD PTR [rax]
	lea	rcx, 4[rax]
	lea	rax, -64[rbp]
	mov	rdx, rax
	call	_ZN4VEC2pLERKS_
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 40
	mov	rax, QWORD PTR [rax]
	lea	rcx, 4[rax]
	lea	rax, -64[rbp]
	mov	rdx, rax
	call	_ZN4VEC2mIERKS_
	jmp	.L453
.L452:
.L458:
	nop
.L453:
	lea	rax, -32[rbp]
	pxor	xmm2, xmm2
	pxor	xmm1, xmm1
	mov	rcx, rax
	call	_ZN4VEC2C1EfS0_
	mov	rax, QWORD PTR -8[rbp]
	lea	rcx, 24[rax]
	lea	rax, -32[rbp]
	mov	rdx, rax
	call	_ZN4VEC2aSERKS_
.L454:
	add	QWORD PTR -8[rbp], 48
.L448:
	mov	rax, QWORD PTR -8[rbp]
	cmp	rax, QWORD PTR -16[rbp]
	jbe	.L459
.L455:
.L456:
	nop
	leave
	ret
	.globl	_ZN9FLUIDTYPE14CLEARWARMSTARTEv
	.def	_ZN9FLUIDTYPE14CLEARWARMSTARTEv;	.scl	2;	.type	32;	.endef
_ZN9FLUIDTYPE14CLEARWARMSTARTEv:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 64
	mov	QWORD PTR 16[rbp], rcx
.L461:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 84072
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 24
	mov	rdx, QWORD PTR [rax]
	mov	rax, rdx
	add	rax, rax
	add	rax, rdx
	sal	rax, 4
	lea	rdx, 84024[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, rdx
	mov	QWORD PTR -16[rbp], rax
	jmp	.L462
.L468:
	nop
.L463:
	lea	rax, -32[rbp]
	pxor	xmm2, xmm2
	pxor	xmm1, xmm1
	mov	rcx, rax
	call	_ZN4VEC2C1EfS0_
	mov	rax, QWORD PTR -8[rbp]
	lea	rcx, 24[rax]
	lea	rax, -32[rbp]
	mov	rdx, rax
	call	_ZN4VEC2aSERKS_
.L464:
	add	QWORD PTR -8[rbp], 48
.L462:
	mov	rax, QWORD PTR -8[rbp]
	cmp	rax, QWORD PTR -16[rbp]
	jbe	.L468
.L465:
.L466:
	nop
	leave
	ret
	.globl	_ZN14SIMULATIONTYPE21COMPUTEBORDERIMPULSESEv
	.def	_ZN14SIMULATIONTYPE21COMPUTEBORDERIMPULSESEv;	.scl	2;	.type	32;	.endef
_ZN14SIMULATIONTYPE21COMPUTEBORDERIMPULSESEv:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	mov	QWORD PTR 16[rbp], rcx
.L470:
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 72[rax]
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 80[rax]
	mov	QWORD PTR -16[rbp], rax
	jmp	.L471
.L495:
	nop
.L472:
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 12
	movss	xmm0, DWORD PTR [rax]
	ucomiss	xmm0, DWORD PTR .LC19[rip]
	jnb	.L491
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 4
	mov	rdx, QWORD PTR -8[rbp]
	add	rdx, 4
	movss	xmm1, DWORD PTR [rdx]
	mov	rdx, QWORD PTR -8[rbp]
	add	rdx, 12
	movss	xmm2, DWORD PTR [rdx]
	movss	xmm0, DWORD PTR .LC20[rip]
	mulss	xmm0, xmm2
	movss	xmm2, DWORD PTR .LC21[rip]
	subss	xmm0, xmm2
	subss	xmm1, xmm0
	movaps	xmm0, xmm1
	mov	rdx, QWORD PTR -8[rbp]
	add	rdx, 28
	movss	xmm2, DWORD PTR [rdx]
	movss	xmm1, DWORD PTR .LC22[rip]
	mulss	xmm1, xmm2
	subss	xmm0, xmm1
	movss	DWORD PTR [rax], xmm0
	jmp	.L479
.L491:
	nop
.L475:
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 12
	movss	xmm1, DWORD PTR [rax]
	movss	xmm0, DWORD PTR .LC23[rip]
	ucomiss	xmm0, xmm1
	jnb	.L492
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 4
	mov	rdx, QWORD PTR -8[rbp]
	add	rdx, 4
	movss	xmm1, DWORD PTR [rdx]
	mov	rdx, QWORD PTR -8[rbp]
	add	rdx, 12
	movss	xmm2, DWORD PTR [rdx]
	movss	xmm0, DWORD PTR .LC20[rip]
	mulss	xmm0, xmm2
	movss	xmm2, DWORD PTR .LC24[rip]
	subss	xmm0, xmm2
	subss	xmm1, xmm0
	movaps	xmm0, xmm1
	mov	rdx, QWORD PTR -8[rbp]
	add	rdx, 28
	movss	xmm2, DWORD PTR [rdx]
	movss	xmm1, DWORD PTR .LC22[rip]
	mulss	xmm1, xmm2
	subss	xmm0, xmm1
	movss	DWORD PTR [rax], xmm0
	jmp	.L479
.L476:
.L492:
	nop
.L479:
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 16
	movss	xmm0, DWORD PTR [rax]
	ucomiss	xmm0, DWORD PTR .LC19[rip]
	jnb	.L493
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 8
	mov	rdx, QWORD PTR -8[rbp]
	add	rdx, 8
	movss	xmm1, DWORD PTR [rdx]
	mov	rdx, QWORD PTR -8[rbp]
	add	rdx, 16
	movss	xmm2, DWORD PTR [rdx]
	movss	xmm0, DWORD PTR .LC20[rip]
	mulss	xmm0, xmm2
	movss	xmm2, DWORD PTR .LC21[rip]
	subss	xmm0, xmm2
	subss	xmm1, xmm0
	movaps	xmm0, xmm1
	mov	rdx, QWORD PTR -8[rbp]
	add	rdx, 32
	movss	xmm2, DWORD PTR [rdx]
	movss	xmm1, DWORD PTR .LC22[rip]
	mulss	xmm1, xmm2
	subss	xmm0, xmm1
	movss	DWORD PTR [rax], xmm0
	jmp	.L487
.L493:
	nop
.L482:
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 16
	movss	xmm1, DWORD PTR [rax]
	movss	xmm0, DWORD PTR .LC25[rip]
	ucomiss	xmm0, xmm1
	jnb	.L494
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 8
	mov	rdx, QWORD PTR -8[rbp]
	add	rdx, 8
	movss	xmm1, DWORD PTR [rdx]
	mov	rdx, QWORD PTR -8[rbp]
	add	rdx, 16
	movss	xmm2, DWORD PTR [rdx]
	movss	xmm0, DWORD PTR .LC20[rip]
	mulss	xmm0, xmm2
	movss	xmm2, DWORD PTR .LC26[rip]
	subss	xmm0, xmm2
	subss	xmm1, xmm0
	movaps	xmm0, xmm1
	mov	rdx, QWORD PTR -8[rbp]
	add	rdx, 32
	movss	xmm2, DWORD PTR [rdx]
	movss	xmm1, DWORD PTR .LC22[rip]
	mulss	xmm1, xmm2
	subss	xmm0, xmm1
	movss	DWORD PTR [rax], xmm0
	jmp	.L487
.L483:
.L486:
.L494:
	nop
.L487:
	add	QWORD PTR -8[rbp], 40
.L471:
	mov	rax, QWORD PTR -8[rbp]
	cmp	rax, QWORD PTR -16[rbp]
	jbe	.L495
.L488:
.L489:
	nop
	leave
	ret
	.globl	_ZN14SIMULATIONTYPE15COMPUTENEWSTATEEP9FLUIDTYPE
	.def	_ZN14SIMULATIONTYPE15COMPUTENEWSTATEEP9FLUIDTYPE;	.scl	2;	.type	32;	.endef
_ZN14SIMULATIONTYPE15COMPUTENEWSTATEEP9FLUIDTYPE:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 80
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
.L497:
	mov	rax, QWORD PTR 24[rbp]
	mov	rax, QWORD PTR 56[rax]
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR 24[rbp]
	mov	rax, QWORD PTR 64[rax]
	mov	QWORD PTR -16[rbp], rax
	jmp	.L498
.L504:
	nop
.L499:
	mov	rax, QWORD PTR -8[rbp]
	lea	rdx, 12[rax]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 20
	mov	rcx, rax
	call	_ZN4VEC2aSERKS_
	mov	rax, QWORD PTR -8[rbp]
	lea	rdx, 4[rax]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 28
	mov	rcx, rax
	call	_ZN4VEC2pLERKS_
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 28
	movss	xmm1, DWORD PTR .LC7[rip]
	mov	rcx, rax
	call	_ZmlRK4VEC2f
	mov	QWORD PTR -48[rbp], rax
	mov	rax, QWORD PTR -48[rbp]
	mov	QWORD PTR -32[rbp], rax
	mov	rax, QWORD PTR -8[rbp]
	lea	rcx, 12[rax]
	lea	rax, -32[rbp]
	mov	rdx, rax
	call	_ZN4VEC2pLERKS_
.L500:
	add	QWORD PTR -8[rbp], 40
.L498:
	mov	rax, QWORD PTR -8[rbp]
	cmp	rax, QWORD PTR -16[rbp]
	jbe	.L504
.L501:
.L502:
	nop
	leave
	ret
	.section .rdata,"dr"
.LC33:
	.ascii "particles:     \0"
.LC34:
	.ascii "particle pairs:\0"
	.text
	.globl	_ZN14SIMULATIONTYPE9DRAWFLUIDEv
	.def	_ZN14SIMULATIONTYPE9DRAWFLUIDEv;	.scl	2;	.type	32;	.endef
_ZN14SIMULATIONTYPE9DRAWFLUIDEv:
	push	rbp
	mov	rbp, rsp
	push	rbx
	sub	rsp, 216
	mov	QWORD PTR 16[rbp], rcx
.L506:
	call	fb_GfxLock
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR [rax]
	cmp	rax, 1
	jne	.L545
	mov	DWORD PTR 64[rsp], 0
	mov	DWORD PTR 56[rsp], 65535
	mov	DWORD PTR 48[rsp], 2
	mov	DWORD PTR 40[rsp], 553648127
	movss	xmm0, DWORD PTR .LC27[rip]
	movss	DWORD PTR 32[rsp], xmm0
	movss	xmm3, DWORD PTR .LC28[rip]
	pxor	xmm2, xmm2
	pxor	xmm1, xmm1
	mov	ecx, 0
	call	fb_GfxLine
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 72[rax]
	mov	QWORD PTR -24[rbp], rax
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 80[rax]
	mov	QWORD PTR -56[rbp], rax
	jmp	.L509
.L546:
	nop
.L510:
	pxor	xmm0, xmm0
	movss	DWORD PTR -60[rbp], xmm0
	pxor	xmm0, xmm0
	movss	DWORD PTR -64[rbp], xmm0
	pxor	xmm0, xmm0
	movss	DWORD PTR -68[rbp], xmm0
	mov	eax, DWORD PTR -60[rbp]
	mov	DWORD PTR -132[rbp], eax
	movss	xmm0, DWORD PTR -132[rbp]
	call	nearbyintf
	ucomiss	xmm0, DWORD PTR .LC29[rip]
	jnb	.L511
	cvttss2si	rax, xmm0
	jmp	.L512
.L511:
	movss	xmm1, DWORD PTR .LC29[rip]
	subss	xmm0, xmm1
	cvttss2si	rax, xmm0
	movabs	rdx, -9223372036854775808
	xor	rax, rdx
.L512:
	sal	eax, 16
	mov	ebx, eax
	mov	eax, DWORD PTR -64[rbp]
	mov	DWORD PTR -132[rbp], eax
	movss	xmm0, DWORD PTR -132[rbp]
	call	nearbyintf
	ucomiss	xmm0, DWORD PTR .LC29[rip]
	jnb	.L513
	cvttss2si	rax, xmm0
	jmp	.L514
.L513:
	movss	xmm1, DWORD PTR .LC29[rip]
	subss	xmm0, xmm1
	cvttss2si	rax, xmm0
	movabs	rdx, -9223372036854775808
	xor	rax, rdx
.L514:
	sal	eax, 8
	or	ebx, eax
	mov	eax, DWORD PTR -68[rbp]
	mov	DWORD PTR -132[rbp], eax
	movss	xmm0, DWORD PTR -132[rbp]
	call	nearbyintf
	ucomiss	xmm0, DWORD PTR .LC29[rip]
	jnb	.L515
	cvttss2si	rax, xmm0
	jmp	.L516
.L515:
	movss	xmm1, DWORD PTR .LC29[rip]
	subss	xmm0, xmm1
	cvttss2si	rax, xmm0
	movabs	rdx, -9223372036854775808
	xor	rax, rdx
.L516:
	or	eax, ebx
	or	eax, -1073741824
	mov	rdx, QWORD PTR -24[rbp]
	add	rdx, 16
	movss	xmm0, DWORD PTR [rdx]
	mov	rdx, QWORD PTR -24[rbp]
	add	rdx, 12
	movss	xmm3, DWORD PTR [rdx]
	mov	rdx, QWORD PTR -24[rbp]
	add	rdx, 24
	movss	xmm2, DWORD PTR [rdx]
	mov	rdx, QWORD PTR -24[rbp]
	add	rdx, 20
	movss	xmm1, DWORD PTR [rdx]
	mov	DWORD PTR 64[rsp], 0
	mov	DWORD PTR 56[rsp], 65535
	mov	DWORD PTR 48[rsp], 0
	mov	DWORD PTR 40[rsp], eax
	movss	DWORD PTR 32[rsp], xmm0
	mov	ecx, 0
	call	fb_GfxLine
.L517:
	add	QWORD PTR -24[rbp], 40
.L509:
	mov	rax, QWORD PTR -24[rbp]
	cmp	rax, QWORD PTR -56[rbp]
	jbe	.L546
	jmp	.L519
.L508:
.L518:
.L545:
	nop
.L519:
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR [rax]
	cmp	rax, 2
	jne	.L547
	mov	ecx, -65536
	call	fb_Cls
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 72[rax]
	mov	QWORD PTR -32[rbp], rax
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 80[rax]
	mov	QWORD PTR -80[rbp], rax
	jmp	.L522
.L551:
	nop
.L523:
	mov	rax, QWORD PTR -32[rbp]
	add	rax, 36
	movss	xmm1, DWORD PTR [rax]
	movss	xmm0, DWORD PTR .LC30[rip]
	mulss	xmm0, xmm1
	call	nearbyintf
	cvttss2si	rax, xmm0
	mov	QWORD PTR -40[rbp], rax
	mov	QWORD PTR -112[rbp], 0
	mov	QWORD PTR -120[rbp], 0
	cmp	QWORD PTR -40[rbp], 255
	jle	.L548
	mov	rax, QWORD PTR -40[rbp]
	sub	rax, 255
	mov	QWORD PTR -112[rbp], rax
	mov	QWORD PTR -40[rbp], 255
	jmp	.L526
.L525:
.L548:
	nop
.L526:
	mov	eax, 255
	sub	rax, QWORD PTR -40[rbp]
	mov	QWORD PTR -120[rbp], rax
	mov	rax, QWORD PTR -112[rbp]
	cmp	rax, 255
	jle	.L549
	mov	QWORD PTR -112[rbp], 255
	jmp	.L528
.L549:
	nop
.L528:
	mov	rax, QWORD PTR -120[rbp]
	cmp	rax, 255
	jle	.L550
	mov	QWORD PTR -120[rbp], 255
	jmp	.L530
.L550:
	nop
.L530:
	mov	rax, QWORD PTR -40[rbp]
	sal	eax, 16
	mov	edx, eax
	mov	rax, QWORD PTR -112[rbp]
	sal	eax, 8
	or	edx, eax
	mov	rax, QWORD PTR -120[rbp]
	or	eax, edx
	or	eax, -16777216
	mov	rdx, QWORD PTR -32[rbp]
	add	rdx, 16
	movss	xmm1, DWORD PTR [rdx]
	movss	xmm0, DWORD PTR .LC31[rip]
	addss	xmm1, xmm0
	mov	rdx, QWORD PTR -32[rbp]
	add	rdx, 12
	movss	xmm2, DWORD PTR [rdx]
	movss	xmm0, DWORD PTR .LC31[rip]
	movaps	xmm3, xmm2
	addss	xmm3, xmm0
	mov	rdx, QWORD PTR -32[rbp]
	add	rdx, 16
	movss	xmm0, DWORD PTR [rdx]
	cvtss2sd	xmm0, xmm0
	movsd	xmm2, QWORD PTR .LC32[rip]
	subsd	xmm0, xmm2
	cvtsd2ss	xmm4, xmm0
	mov	rdx, QWORD PTR -32[rbp]
	add	rdx, 12
	movss	xmm0, DWORD PTR [rdx]
	cvtss2sd	xmm0, xmm0
	movsd	xmm2, QWORD PTR .LC32[rip]
	subsd	xmm0, xmm2
	cvtsd2ss	xmm0, xmm0
	mov	DWORD PTR 64[rsp], 0
	mov	DWORD PTR 56[rsp], 65535
	mov	DWORD PTR 48[rsp], 2
	mov	DWORD PTR 40[rsp], eax
	movss	DWORD PTR 32[rsp], xmm1
	movaps	xmm2, xmm4
	movaps	xmm1, xmm0
	mov	ecx, 0
	call	fb_GfxLine
.L531:
	add	QWORD PTR -32[rbp], 40
.L522:
	mov	rax, QWORD PTR -32[rbp]
	cmp	rax, QWORD PTR -80[rbp]
	jbe	.L551
	jmp	.L533
.L521:
.L532:
.L547:
	nop
.L533:
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR [rax]
	cmp	rax, 3
	jne	.L552
	mov	DWORD PTR 64[rsp], 0
	mov	DWORD PTR 56[rsp], 65535
	mov	DWORD PTR 48[rsp], 2
	mov	DWORD PTR 40[rsp], -1
	movss	xmm0, DWORD PTR .LC27[rip]
	movss	DWORD PTR 32[rsp], xmm0
	movss	xmm3, DWORD PTR .LC28[rip]
	pxor	xmm2, xmm2
	pxor	xmm1, xmm1
	mov	ecx, 0
	call	fb_GfxLine
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 84088
	mov	QWORD PTR -48[rbp], rax
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 40
	mov	rdx, QWORD PTR [rax]
	mov	rax, rdx
	add	rax, rax
	add	rax, rdx
	sal	rax, 4
	lea	rdx, 84040[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, rdx
	mov	QWORD PTR -88[rbp], rax
	jmp	.L536
.L553:
	nop
.L537:
	mov	rax, QWORD PTR -48[rbp]
	add	rax, 40
	mov	rax, QWORD PTR [rax]
	add	rax, 16
	movss	xmm0, DWORD PTR [rax]
	mov	rax, QWORD PTR -48[rbp]
	add	rax, 40
	mov	rax, QWORD PTR [rax]
	add	rax, 12
	movss	xmm3, DWORD PTR [rax]
	mov	rax, QWORD PTR -48[rbp]
	add	rax, 32
	mov	rax, QWORD PTR [rax]
	add	rax, 16
	movss	xmm2, DWORD PTR [rax]
	mov	rax, QWORD PTR -48[rbp]
	add	rax, 32
	mov	rax, QWORD PTR [rax]
	add	rax, 12
	movss	xmm1, DWORD PTR [rax]
	mov	DWORD PTR 64[rsp], 0
	mov	DWORD PTR 56[rsp], 65535
	mov	DWORD PTR 48[rsp], 0
	mov	DWORD PTR 40[rsp], 536870912
	movss	DWORD PTR 32[rsp], xmm0
	mov	ecx, 0
	call	fb_GfxLine
.L538:
	add	QWORD PTR -48[rbp], 48
.L536:
	mov	rax, QWORD PTR -48[rbp]
	cmp	rax, QWORD PTR -88[rbp]
	jbe	.L553
	jmp	.L540
.L535:
.L539:
.L552:
	nop
.L540:
	mov	DWORD PTR 32[rsp], 0
	mov	r9d, 0
	mov	r8d, -1
	mov	edx, 2
	mov	ecx, 2
	call	fb_Locate
	mov	edx, 15
	lea	rcx, .LC33[rip]
	call	fb_StrAllocTempDescZEx
	mov	QWORD PTR -96[rbp], rax
	mov	rax, QWORD PTR -96[rbp]
	mov	r8d, 0
	mov	rdx, rax
	mov	ecx, 0
	call	fb_PrintString
	mov	r8d, 1
	mov	edx, 2100
	mov	ecx, 0
	call	fb_PrintLongint
	mov	DWORD PTR 32[rsp], 0
	mov	r9d, 0
	mov	r8d, -1
	mov	edx, 2
	mov	ecx, 4
	call	fb_Locate
	mov	edx, 15
	lea	rcx, .LC34[rip]
	call	fb_StrAllocTempDescZEx
	mov	QWORD PTR -104[rbp], rax
	mov	rax, QWORD PTR -104[rbp]
	mov	r8d, 0
	mov	rdx, rax
	mov	ecx, 0
	call	fb_PrintString
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 40
	mov	rax, QWORD PTR [rax]
	mov	r8d, 1
	mov	rdx, rax
	mov	ecx, 0
	call	fb_PrintLongint
	mov	edx, -1
	mov	ecx, -1
	call	fb_GfxUnlock
	nop
	add	rsp, 216
	pop	rbx
	pop	rbp
	ret
.L541:
	.globl	_ZN14SIMULATIONTYPE9CHECKPAIREP12PARTICLETYPES1_
	.def	_ZN14SIMULATIONTYPE9CHECKPAIREP12PARTICLETYPES1_;	.scl	2;	.type	32;	.endef
_ZN14SIMULATIONTYPE9CHECKPAIREP12PARTICLETYPES1_:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 176
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
	mov	QWORD PTR 32[rbp], r8
.L555:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 40
	mov	rax, QWORD PTR [rax]
	cmp	rax, 67199
	jg	.L578
	nop
.L557:
	mov	rax, QWORD PTR 24[rbp]
	movss	xmm1, DWORD PTR [rax]
	movss	xmm0, DWORD PTR .LC35[rip]
	ucomiss	xmm0, xmm1
	ja	.L579
	jmp	.L558
.L579:
	nop
.L561:
	mov	rax, QWORD PTR 32[rbp]
	movss	xmm1, DWORD PTR [rax]
	movss	xmm0, DWORD PTR .LC35[rip]
	ucomiss	xmm0, xmm1
	ja	.L580
	jmp	.L558
.L580:
	nop
.L564:
	mov	rax, QWORD PTR 24[rbp]
	lea	rdx, 12[rax]
	mov	rax, QWORD PTR 32[rbp]
	add	rax, 12
	mov	rcx, rax
	call	_ZmiRK4VEC2S1_
	mov	QWORD PTR -80[rbp], rax
	mov	rax, QWORD PTR -80[rbp]
	mov	QWORD PTR -32[rbp], rax
	lea	rdx, -32[rbp]
	lea	rax, -64[rbp]
	mov	rcx, rax
	call	_ZN4VEC2C1ERKS_
	lea	rax, -64[rbp]
	movss	xmm1, DWORD PTR [rax]
	movss	xmm0, DWORD PTR .LC1[rip]
	andps	xmm0, xmm1
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 48
	movss	xmm1, DWORD PTR [rax]
	ucomiss	xmm1, xmm0
	jnb	.L581
	jmp	.L558
.L581:
	nop
.L567:
	lea	rax, -64[rbp]
	add	rax, 4
	movss	xmm1, DWORD PTR [rax]
	movss	xmm0, DWORD PTR .LC1[rip]
	andps	xmm0, xmm1
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 48
	movss	xmm1, DWORD PTR [rax]
	ucomiss	xmm1, xmm0
	jnb	.L582
	jmp	.L558
.L582:
	nop
.L570:
	lea	rax, -64[rbp]
	mov	rcx, rax
	call	_ZNK4VEC213LENGTHSQUAREDEv
	movd	eax, xmm0
	mov	DWORD PTR -4[rbp], eax
	movss	xmm0, DWORD PTR -4[rbp]
	movss	DWORD PTR -8[rbp], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 52
	movss	xmm0, DWORD PTR [rax]
	ucomiss	xmm0, DWORD PTR -8[rbp]
	jnb	.L583
	jmp	.L558
.L583:
	nop
.L573:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 40
	mov	rdx, QWORD PTR 16[rbp]
	add	rdx, 40
	mov	rdx, QWORD PTR [rdx]
	add	rdx, 1
	mov	QWORD PTR [rax], rdx
	mov	rax, QWORD PTR 24[rbp]
	movss	xmm1, DWORD PTR [rax]
	movss	xmm0, DWORD PTR .LC3[rip]
	addss	xmm0, xmm1
	mov	rax, QWORD PTR 24[rbp]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 32[rbp]
	movss	xmm1, DWORD PTR [rax]
	movss	xmm0, DWORD PTR .LC3[rip]
	addss	xmm0, xmm1
	mov	rax, QWORD PTR 32[rbp]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 40
	mov	rdx, QWORD PTR [rax]
	mov	rax, rdx
	add	rax, rax
	add	rax, rdx
	sal	rax, 4
	lea	rdx, 84040[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, rdx
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -16[rbp]
	lea	rdx, 32[rax]
	mov	rax, QWORD PTR 24[rbp]
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR -16[rbp]
	lea	rdx, 40[rax]
	mov	rax, QWORD PTR 32[rbp]
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR -16[rbp]
	add	rax, 4
	movss	xmm0, DWORD PTR -8[rbp]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 64
	movss	xmm0, DWORD PTR [rax]
	subss	xmm0, DWORD PTR -8[rbp]
	mov	rax, QWORD PTR -16[rbp]
	movss	DWORD PTR [rax], xmm0
	movss	xmm0, DWORD PTR .LC3[rip]
	ucomiss	xmm0, DWORD PTR -8[rbp]
	jnb	.L584
	movss	xmm0, DWORD PTR -8[rbp]
	lea	rax, -64[rbp]
	movaps	xmm1, xmm0
	mov	rcx, rax
	call	_ZdvRK4VEC2f
	mov	QWORD PTR -128[rbp], rax
	mov	rax, QWORD PTR -128[rbp]
	mov	QWORD PTR -112[rbp], rax
	mov	rax, QWORD PTR -16[rbp]
	lea	rcx, 16[rax]
	lea	rax, -112[rbp]
	mov	rdx, rax
	call	_ZN4VEC2aSERKS_
	jmp	.L577
.L584:
	nop
.L576:
	lea	rax, -144[rbp]
	pxor	xmm2, xmm2
	pxor	xmm1, xmm1
	mov	rcx, rax
	call	_ZN4VEC2C1EfS0_
	mov	rax, QWORD PTR -16[rbp]
	lea	rcx, 16[rax]
	lea	rax, -144[rbp]
	mov	rdx, rax
	call	_ZN4VEC2aSERKS_
.L577:
	mov	rax, QWORD PTR -16[rbp]
	add	rax, 32
	mov	rax, QWORD PTR [rax]
	lea	rdx, 28[rax]
	mov	rax, QWORD PTR -16[rbp]
	add	rax, 40
	mov	rax, QWORD PTR [rax]
	add	rax, 28
	mov	rcx, rax
	call	_ZmiRK4VEC2S1_
	mov	QWORD PTR -96[rbp], rax
	mov	rax, QWORD PTR -96[rbp]
	mov	QWORD PTR -48[rbp], rax
	mov	rax, QWORD PTR -16[rbp]
	lea	rcx, 16[rax]
	lea	rax, -48[rbp]
	mov	rdx, rax
	call	_ZNK4VEC23DOTERKS_
	movd	eax, xmm0
	mov	DWORD PTR -20[rbp], eax
	mov	rax, QWORD PTR -16[rbp]
	add	rax, 8
	movss	xmm0, DWORD PTR -20[rbp]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 24[rbp]
	lea	rdx, 36[rax]
	mov	rax, QWORD PTR 24[rbp]
	add	rax, 36
	movss	xmm1, DWORD PTR [rax]
	mov	rax, QWORD PTR -16[rbp]
	movss	xmm0, DWORD PTR [rax]
	addss	xmm0, xmm1
	movss	DWORD PTR [rdx], xmm0
	mov	rax, QWORD PTR 32[rbp]
	lea	rdx, 36[rax]
	mov	rax, QWORD PTR 32[rbp]
	add	rax, 36
	movss	xmm1, DWORD PTR [rax]
	mov	rax, QWORD PTR -16[rbp]
	movss	xmm0, DWORD PTR [rax]
	addss	xmm0, xmm1
	movss	DWORD PTR [rdx], xmm0
	jmp	.L558
.L578:
	nop
.L558:
	nop
	leave
	ret
	.globl	_ZN14SIMULATIONTYPE19COMPUTEREUSABLEDATAEv
	.def	_ZN14SIMULATIONTYPE19COMPUTEREUSABLEDATAEv;	.scl	2;	.type	32;	.endef
_ZN14SIMULATIONTYPE19COMPUTEREUSABLEDATAEv:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR 16[rbp], rcx
.L586:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 84088
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 40
	mov	rdx, QWORD PTR [rax]
	mov	rax, rdx
	add	rax, rax
	add	rax, rdx
	sal	rax, 4
	lea	rdx, 84040[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, rdx
	mov	QWORD PTR -16[rbp], rax
	jmp	.L587
.L593:
	nop
.L588:
	mov	rax, QWORD PTR -8[rbp]
	movss	xmm1, DWORD PTR [rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 24
	movss	xmm0, DWORD PTR [rax]
	mulss	xmm0, xmm1
	movss	DWORD PTR -20[rbp], xmm0
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 32
	mov	rax, QWORD PTR [rax]
	add	rax, 36
	movss	xmm1, DWORD PTR [rax]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 40
	mov	rax, QWORD PTR [rax]
	add	rax, 36
	movss	xmm0, DWORD PTR [rax]
	addss	xmm0, xmm1
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 68
	movss	xmm1, DWORD PTR [rax]
	subss	xmm0, xmm1
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 16
	movss	xmm1, DWORD PTR [rax]
	mulss	xmm0, xmm1
	movss	DWORD PTR -24[rbp], xmm0
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 8
	movss	xmm1, DWORD PTR [rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 20
	movss	xmm0, DWORD PTR [rax]
	mulss	xmm0, xmm1
	movss	DWORD PTR -28[rbp], xmm0
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 12
	movss	xmm0, DWORD PTR -20[rbp]
	addss	xmm0, DWORD PTR -24[rbp]
	subss	xmm0, DWORD PTR -28[rbp]
	movss	DWORD PTR [rax], xmm0
.L589:
	add	QWORD PTR -8[rbp], 48
.L587:
	mov	rax, QWORD PTR -8[rbp]
	cmp	rax, QWORD PTR -16[rbp]
	jbe	.L593
.L590:
.L591:
	nop
	leave
	ret
	.globl	_ZN10SCREENTYPE12CREATESCREENEu7INTEGERS0_S0_S0_S0_S0_S0_S0_S0_
	.def	_ZN10SCREENTYPE12CREATESCREENEu7INTEGERS0_S0_S0_S0_S0_S0_S0_S0_;	.scl	2;	.type	32;	.endef
_ZN10SCREENTYPE12CREATESCREENEu7INTEGERS0_S0_S0_S0_S0_S0_S0_S0_:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
	mov	QWORD PTR 32[rbp], r8
	mov	QWORD PTR 40[rbp], r9
.L595:
	mov	rax, QWORD PTR 32[rbp]
	mov	edx, eax
	mov	rax, QWORD PTR 24[rbp]
	mov	DWORD PTR 40[rsp], 0
	mov	DWORD PTR 32[rsp], 64
	mov	r9d, 1
	mov	r8d, 24
	mov	ecx, eax
	call	fb_GfxScreenRes
	mov	r8d, 0
	mov	edx, -16777216
	mov	ecx, -1
	call	fb_Color
	nop
	leave
	ret
.L596:
	.globl	_ZN14SIMULATIONTYPE11UPDATEMOUSEEv
	.def	_ZN14SIMULATIONTYPE11UPDATEMOUSEEv;	.scl	2;	.type	32;	.endef
_ZN14SIMULATIONTYPE11UPDATEMOUSEEv:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 624
	mov	QWORD PTR 16[rbp], rcx
.L598:
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 3530512[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 3530520
	mov	rcx, rax
	call	_ZN4VEC2aSERKS_
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 3530544[rax]
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 3530536[rax]
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 3530560[rax]
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 3530552[rax]
	mov	QWORD PTR [rdx], rax
	mov	QWORD PTR -104[rbp], 0
	mov	QWORD PTR -112[rbp], 0
	mov	QWORD PTR -88[rbp], 0
	mov	rax, QWORD PTR 16[rbp]
	lea	r9, 3530536[rax]
	mov	rax, QWORD PTR 16[rbp]
	lea	r8, 3530552[rax]
	lea	rdx, -112[rbp]
	lea	rax, -104[rbp]
	lea	rcx, -88[rbp]
	mov	QWORD PTR 32[rsp], rcx
	mov	rcx, rax
	call	fb_GetMouse64
	mov	rax, QWORD PTR -112[rbp]
	pxor	xmm1, xmm1
	cvtsi2ssq	xmm1, rax
	mov	rax, QWORD PTR -104[rbp]
	pxor	xmm0, xmm0
	cvtsi2ssq	xmm0, rax
	lea	rax, -96[rbp]
	movaps	xmm2, xmm1
	movaps	xmm1, xmm0
	mov	rcx, rax
	call	_ZN4VEC2C1EfS0_
	mov	rax, QWORD PTR 16[rbp]
	lea	rcx, 3530512[rax]
	lea	rax, -96[rbp]
	mov	rdx, rax
	call	_ZN4VEC2aSERKS_
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 3530528
	mov	rdx, QWORD PTR 16[rbp]
	add	rdx, 3530512
	movss	xmm0, DWORD PTR [rdx]
	mov	rdx, QWORD PTR 16[rbp]
	add	rdx, 3530520
	movss	xmm1, DWORD PTR [rdx]
	subss	xmm0, xmm1
	movss	xmm1, DWORD PTR .LC36[rip]
	mulss	xmm0, xmm1
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 3530532
	mov	rdx, QWORD PTR 16[rbp]
	add	rdx, 3530516
	movss	xmm0, DWORD PTR [rdx]
	mov	rdx, QWORD PTR 16[rbp]
	add	rdx, 3530524
	movss	xmm1, DWORD PTR [rdx]
	subss	xmm0, xmm1
	movss	xmm1, DWORD PTR .LC36[rip]
	mulss	xmm0, xmm1
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 3530536
	mov	rax, QWORD PTR [rax]
	cmp	rax, 1
	jne	.L642
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 72[rax]
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 80[rax]
	mov	QWORD PTR -32[rbp], rax
	jmp	.L601
.L646:
	nop
.L602:
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 3530512[rax]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 12
	mov	rcx, rax
	call	_ZmiRK4VEC2S1_
	mov	QWORD PTR -224[rbp], rax
	mov	rax, QWORD PTR -224[rbp]
	mov	QWORD PTR -128[rbp], rax
	lea	rdx, -128[rbp]
	lea	rax, -208[rbp]
	mov	rcx, rax
	call	_ZN4VEC2C1ERKS_
	lea	rax, -208[rbp]
	movss	xmm1, DWORD PTR [rax]
	movss	xmm0, DWORD PTR .LC1[rip]
	andps	xmm0, xmm1
	movss	xmm1, DWORD PTR .LC35[rip]
	ucomiss	xmm1, xmm0
	jnb	.L643
	jmp	.L613
.L643:
	nop
.L605:
	lea	rax, -208[rbp]
	add	rax, 4
	movss	xmm1, DWORD PTR [rax]
	movss	xmm0, DWORD PTR .LC1[rip]
	andps	xmm0, xmm1
	movss	xmm1, DWORD PTR .LC35[rip]
	ucomiss	xmm1, xmm0
	jnb	.L644
	jmp	.L613
.L644:
	nop
.L609:
	lea	rax, -208[rbp]
	mov	rcx, rax
	call	_ZNK4VEC213LENGTHSQUAREDEv
	movd	eax, xmm0
	mov	DWORD PTR -36[rbp], eax
	movss	xmm0, DWORD PTR -36[rbp]
	movss	DWORD PTR -40[rbp], xmm0
	movss	xmm0, DWORD PTR .LC37[rip]
	ucomiss	xmm0, DWORD PTR -40[rbp]
	jnb	.L645
	jmp	.L613
.L645:
	nop
.L612:
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 3530528[rax]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 28
	mov	rcx, rax
	call	_ZmiRK4VEC2S1_
	mov	QWORD PTR -240[rbp], rax
	mov	rax, QWORD PTR -240[rbp]
	mov	QWORD PTR -144[rbp], rax
	lea	rax, -144[rbp]
	movss	xmm1, DWORD PTR .LC36[rip]
	mov	rcx, rax
	call	_ZmlRK4VEC2f
	mov	QWORD PTR -256[rbp], rax
	mov	rax, QWORD PTR -256[rbp]
	mov	QWORD PTR -160[rbp], rax
	movss	xmm0, DWORD PTR -40[rbp]
	movss	xmm1, DWORD PTR .LC37[rip]
	divss	xmm0, xmm1
	movss	xmm1, DWORD PTR .LC3[rip]
	subss	xmm1, xmm0
	movaps	xmm0, xmm1
	lea	rax, -160[rbp]
	movaps	xmm1, xmm0
	mov	rcx, rax
	call	_ZmlRK4VEC2f
	mov	QWORD PTR -272[rbp], rax
	mov	rax, QWORD PTR -272[rbp]
	mov	QWORD PTR -176[rbp], rax
	lea	rax, -176[rbp]
	movss	xmm1, DWORD PTR .LC7[rip]
	mov	rcx, rax
	call	_ZmlRK4VEC2f
	mov	QWORD PTR -288[rbp], rax
	mov	rax, QWORD PTR -288[rbp]
	mov	QWORD PTR -192[rbp], rax
	mov	rax, QWORD PTR -8[rbp]
	lea	rcx, 4[rax]
	lea	rax, -192[rbp]
	mov	rdx, rax
	call	_ZN4VEC2mIERKS_
.L613:
	add	QWORD PTR -8[rbp], 40
.L601:
	mov	rax, QWORD PTR -8[rbp]
	cmp	rax, QWORD PTR -32[rbp]
	jbe	.L646
	jmp	.L615
.L600:
.L614:
.L642:
	nop
.L615:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 3530536
	mov	rax, QWORD PTR [rax]
	cmp	rax, 2
	jne	.L647
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 72[rax]
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 80[rax]
	mov	QWORD PTR -48[rbp], rax
	jmp	.L618
.L648:
	nop
.L619:
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 3530512[rax]
	mov	rax, QWORD PTR -16[rbp]
	add	rax, 12
	mov	rcx, rax
	call	_ZmiRK4VEC2S1_
	mov	QWORD PTR -368[rbp], rax
	mov	rax, QWORD PTR -368[rbp]
	mov	QWORD PTR -304[rbp], rax
	lea	rdx, -304[rbp]
	lea	rax, -352[rbp]
	mov	rcx, rax
	call	_ZN4VEC2C1ERKS_
	lea	rax, -352[rbp]
	mov	rcx, rax
	call	_ZNK4VEC213LENGTHSQUAREDEv
	movd	eax, xmm0
	mov	DWORD PTR -52[rbp], eax
	movss	xmm0, DWORD PTR -52[rbp]
	movss	DWORD PTR -56[rbp], xmm0
	movss	xmm0, DWORD PTR -56[rbp]
	lea	rax, -352[rbp]
	movaps	xmm1, xmm0
	mov	rcx, rax
	call	_ZdvRK4VEC2f
	mov	QWORD PTR -384[rbp], rax
	mov	rax, QWORD PTR -384[rbp]
	mov	QWORD PTR -320[rbp], rax
	lea	rax, -320[rbp]
	movss	xmm1, DWORD PTR .LC38[rip]
	mov	rcx, rax
	call	_ZmlRK4VEC2f
	mov	QWORD PTR -400[rbp], rax
	mov	rax, QWORD PTR -400[rbp]
	mov	QWORD PTR -336[rbp], rax
	mov	rax, QWORD PTR -16[rbp]
	lea	rcx, 4[rax]
	lea	rax, -336[rbp]
	mov	rdx, rax
	call	_ZN4VEC2pLERKS_
.L620:
	add	QWORD PTR -16[rbp], 40
.L618:
	mov	rax, QWORD PTR -16[rbp]
	cmp	rax, QWORD PTR -48[rbp]
	jbe	.L648
	jmp	.L622
.L617:
.L621:
.L647:
	nop
.L622:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 3530552
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 3530560
	mov	rax, QWORD PTR [rax]
	cmp	rdx, rax
	je	.L649
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 72[rax]
	mov	QWORD PTR -24[rbp], rax
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 80[rax]
	mov	QWORD PTR -64[rbp], rax
	jmp	.L625
.L641:
.L626:
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 3530512[rax]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, 12
	mov	rcx, rax
	call	_ZmiRK4VEC2S1_
	mov	QWORD PTR -512[rbp], rax
	mov	rax, QWORD PTR -512[rbp]
	mov	QWORD PTR -416[rbp], rax
	lea	rdx, -416[rbp]
	lea	rax, -496[rbp]
	mov	rcx, rax
	call	_ZN4VEC2C1ERKS_
	lea	rax, -496[rbp]
	movss	xmm1, DWORD PTR [rax]
	movss	xmm0, DWORD PTR .LC1[rip]
	andps	xmm0, xmm1
	movss	xmm1, DWORD PTR .LC3[rip]
	ucomiss	xmm0, xmm1
	jnb	.L650
	jmp	.L634
.L650:
	nop
.L629:
	lea	rax, -496[rbp]
	add	rax, 4
	movss	xmm1, DWORD PTR [rax]
	movss	xmm0, DWORD PTR .LC1[rip]
	andps	xmm0, xmm1
	movss	xmm1, DWORD PTR .LC3[rip]
	ucomiss	xmm0, xmm1
	jnb	.L651
	jmp	.L634
.L651:
	nop
.L633:
	lea	rax, -496[rbp]
	mov	rcx, rax
	call	_ZNK4VEC213LENGTHSQUAREDEv
	movd	eax, xmm0
	mov	DWORD PTR -68[rbp], eax
	movss	xmm0, DWORD PTR -68[rbp]
	movss	DWORD PTR -72[rbp], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 3530552
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 3530560
	mov	rax, QWORD PTR [rax]
	sub	rdx, rax
	mov	rax, rdx
	mov	rcx, rax
	call	fb_SGNl
	mov	DWORD PTR -76[rbp], eax
	pxor	xmm0, xmm0
	cvtsi2ss	xmm0, DWORD PTR -76[rbp]
	movss	DWORD PTR -80[rbp], xmm0
	movss	xmm0, DWORD PTR -72[rbp]
	lea	rax, -496[rbp]
	movaps	xmm1, xmm0
	mov	rcx, rax
	call	_ZdvRK4VEC2f
	mov	QWORD PTR -528[rbp], rax
	mov	rax, QWORD PTR -528[rbp]
	mov	QWORD PTR -432[rbp], rax
	lea	rax, -432[rbp]
	mov	rcx, rax
	call	_ZNK4VEC24PERPEv
	mov	QWORD PTR -544[rbp], rax
	mov	rax, QWORD PTR -544[rbp]
	mov	QWORD PTR -448[rbp], rax
	lea	rax, -448[rbp]
	movss	xmm1, DWORD PTR .LC39[rip]
	mov	rcx, rax
	call	_ZmlRK4VEC2f
	mov	QWORD PTR -560[rbp], rax
	mov	rax, QWORD PTR -560[rbp]
	mov	QWORD PTR -464[rbp], rax
	movss	xmm0, DWORD PTR -80[rbp]
	lea	rax, -464[rbp]
	movaps	xmm1, xmm0
	mov	rcx, rax
	call	_ZmlRK4VEC2f
	mov	QWORD PTR -576[rbp], rax
	mov	rax, QWORD PTR -576[rbp]
	mov	QWORD PTR -480[rbp], rax
	mov	rax, QWORD PTR -24[rbp]
	lea	rcx, 4[rax]
	lea	rax, -480[rbp]
	mov	rdx, rax
	call	_ZN4VEC2pLERKS_
.L634:
	add	QWORD PTR -24[rbp], 40
.L625:
	mov	rax, QWORD PTR -24[rbp]
	cmp	rax, QWORD PTR -64[rbp]
	ja	.L652
	jmp	.L641
.L624:
.L635:
.L636:
.L649:
	nop
.L637:
.L652:
	nop
	leave
	ret
	.def	__main;	.scl	2;	.type	32;	.endef
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
main:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	DWORD PTR 16[rbp], ecx
	mov	QWORD PTR 24[rbp], rdx
	call	__main
	mov	DWORD PTR -4[rbp], 0
	mov	rax, QWORD PTR 24[rbp]
	mov	r8d, 0
	mov	rdx, rax
	mov	ecx, DWORD PTR 16[rbp]
	call	fb_Init
.L654:
.L655:
	mov	ecx, 0
	call	fb_End
	mov	eax, DWORD PTR -4[rbp]
	leave
	ret
	.def	_ZN12PARTICLETYPEaSERKS_;	.scl	3;	.type	32;	.endef
_ZN12PARTICLETYPEaSERKS_:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
.L658:
	mov	rax, QWORD PTR 24[rbp]
	movss	xmm0, DWORD PTR [rax]
	mov	rax, QWORD PTR 16[rbp]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 24[rbp]
	lea	rdx, 4[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 4
	mov	rcx, rax
	call	_ZN4VEC2aSERKS_
	mov	rax, QWORD PTR 24[rbp]
	lea	rdx, 12[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 12
	mov	rcx, rax
	call	_ZN4VEC2aSERKS_
	mov	rax, QWORD PTR 24[rbp]
	lea	rdx, 20[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 20
	mov	rcx, rax
	call	_ZN4VEC2aSERKS_
	mov	rax, QWORD PTR 24[rbp]
	lea	rdx, 28[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 28
	mov	rcx, rax
	call	_ZN4VEC2aSERKS_
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 36[rax]
	mov	rax, QWORD PTR 24[rbp]
	movss	xmm0, DWORD PTR 36[rax]
	movss	DWORD PTR [rdx], xmm0
	nop
	leave
	ret
.L659:
	.def	_ZN16PARTICLEPAIRTYPEaSERKS_;	.scl	3;	.type	32;	.endef
_ZN16PARTICLEPAIRTYPEaSERKS_:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
.L661:
	mov	rax, QWORD PTR 24[rbp]
	movss	xmm0, DWORD PTR [rax]
	mov	rax, QWORD PTR 16[rbp]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 4[rax]
	mov	rax, QWORD PTR 24[rbp]
	movss	xmm0, DWORD PTR 4[rax]
	movss	DWORD PTR [rdx], xmm0
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 8[rax]
	mov	rax, QWORD PTR 24[rbp]
	movss	xmm0, DWORD PTR 8[rax]
	movss	DWORD PTR [rdx], xmm0
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 12[rax]
	mov	rax, QWORD PTR 24[rbp]
	movss	xmm0, DWORD PTR 12[rax]
	movss	DWORD PTR [rdx], xmm0
	mov	rax, QWORD PTR 24[rbp]
	lea	rdx, 16[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 16
	mov	rcx, rax
	call	_ZN4VEC2aSERKS_
	mov	rax, QWORD PTR 24[rbp]
	lea	rdx, 24[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 24
	mov	rcx, rax
	call	_ZN4VEC2aSERKS_
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
	nop
	leave
	ret
.L662:
	.def	_ZN9FLUIDTYPEaSERKS_;	.scl	3;	.type	32;	.endef
_ZN9FLUIDTYPEaSERKS_:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 80
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
.L664:
	mov	rax, QWORD PTR 24[rbp]
	movss	xmm0, DWORD PTR [rax]
	mov	rax, QWORD PTR 16[rbp]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 4[rax]
	mov	rax, QWORD PTR 24[rbp]
	movss	xmm0, DWORD PTR 4[rax]
	movss	DWORD PTR [rdx], xmm0
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 8[rax]
	mov	rax, QWORD PTR 24[rbp]
	movss	xmm0, DWORD PTR 8[rax]
	movss	DWORD PTR [rdx], xmm0
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 16[rax]
	mov	rax, QWORD PTR 24[rbp]
	mov	rax, QWORD PTR 16[rax]
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 24[rax]
	mov	rax, QWORD PTR 24[rbp]
	mov	rax, QWORD PTR 24[rax]
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 32[rax]
	mov	rax, QWORD PTR 24[rbp]
	movss	xmm0, DWORD PTR 32[rax]
	movss	DWORD PTR [rdx], xmm0
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 36[rax]
	mov	rax, QWORD PTR 24[rbp]
	movss	xmm0, DWORD PTR 36[rax]
	movss	DWORD PTR [rdx], xmm0
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 40[rax]
	mov	rax, QWORD PTR 24[rbp]
	movss	xmm0, DWORD PTR 40[rax]
	movss	DWORD PTR [rdx], xmm0
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 44[rax]
	mov	rax, QWORD PTR 24[rbp]
	movss	xmm0, DWORD PTR 44[rax]
	movss	DWORD PTR [rdx], xmm0
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 48[rax]
	mov	rax, QWORD PTR 24[rbp]
	movss	xmm0, DWORD PTR 48[rax]
	movss	DWORD PTR [rdx], xmm0
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 52[rax]
	mov	rax, QWORD PTR 24[rbp]
	movss	xmm0, DWORD PTR 52[rax]
	movss	DWORD PTR [rdx], xmm0
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 56[rax]
	mov	rax, QWORD PTR 24[rbp]
	mov	rax, QWORD PTR 56[rax]
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 64[rax]
	mov	rax, QWORD PTR 24[rbp]
	mov	rax, QWORD PTR 64[rax]
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 72
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR 24[rbp]
	add	rax, 72
	mov	QWORD PTR -24[rbp], rax
	mov	QWORD PTR -8[rbp], 0
.L665:
	mov	rdx, QWORD PTR -24[rbp]
	mov	rax, QWORD PTR -16[rbp]
	mov	rcx, rax
	call	_ZN12PARTICLETYPEaSERS_
	add	QWORD PTR -16[rbp], 40
	add	QWORD PTR -24[rbp], 40
	add	QWORD PTR -8[rbp], 1
	cmp	QWORD PTR -8[rbp], 2100
	je	.L666
	jmp	.L665
.L666:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 84072
	mov	QWORD PTR -40[rbp], rax
	mov	rax, QWORD PTR 24[rbp]
	add	rax, 84072
	mov	QWORD PTR -48[rbp], rax
	mov	QWORD PTR -32[rbp], 0
.L667:
	mov	rdx, QWORD PTR -48[rbp]
	mov	rax, QWORD PTR -40[rbp]
	mov	rcx, rax
	call	_ZN16PARTICLEPAIRTYPEaSERS_
	add	QWORD PTR -40[rbp], 48
	add	QWORD PTR -48[rbp], 48
	add	QWORD PTR -32[rbp], 1
	cmp	QWORD PTR -32[rbp], 67200
	je	.L669
	jmp	.L667
.L668:
.L669:
	nop
	leave
	ret
	.def	_ZN8GRIDTYPEaSERKS_;	.scl	3;	.type	32;	.endef
_ZN8GRIDTYPEaSERKS_:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 80
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
.L671:
	mov	rax, QWORD PTR 24[rbp]
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR 16[rbp]
	mov	QWORD PTR [rax], rdx
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 8[rax]
	mov	rax, QWORD PTR 24[rbp]
	mov	rax, QWORD PTR 8[rax]
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 16[rax]
	mov	rax, QWORD PTR 24[rbp]
	movss	xmm0, DWORD PTR 16[rax]
	movss	DWORD PTR [rdx], xmm0
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 20[rax]
	mov	rax, QWORD PTR 24[rbp]
	movss	xmm0, DWORD PTR 20[rax]
	movss	DWORD PTR [rdx], xmm0
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
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 56[rax]
	mov	rax, QWORD PTR 24[rbp]
	mov	rax, QWORD PTR 56[rax]
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 64
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR 24[rbp]
	add	rax, 64
	mov	QWORD PTR -24[rbp], rax
	mov	QWORD PTR -8[rbp], 0
.L672:
	mov	rdx, QWORD PTR -24[rbp]
	mov	rax, QWORD PTR -16[rbp]
	mov	rcx, rax
	call	_ZN8CELLTYPEaSERS_
	add	QWORD PTR -16[rbp], 520
	add	QWORD PTR -24[rbp], 520
	add	QWORD PTR -8[rbp], 1
	cmp	QWORD PTR -8[rbp], 374
	je	.L673
	jmp	.L672
.L673:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 194544
	mov	QWORD PTR -40[rbp], rax
	mov	rax, QWORD PTR 24[rbp]
	add	rax, 194544
	mov	QWORD PTR -48[rbp], rax
	mov	QWORD PTR -32[rbp], 0
.L674:
	mov	rax, QWORD PTR -48[rbp]
	mov	rdx, QWORD PTR 8[rax]
	mov	rax, QWORD PTR [rax]
	mov	rcx, QWORD PTR -40[rbp]
	mov	QWORD PTR [rcx], rax
	mov	QWORD PTR 8[rcx], rdx
	add	QWORD PTR -40[rbp], 16
	add	QWORD PTR -48[rbp], 16
	add	QWORD PTR -32[rbp], 1
	cmp	QWORD PTR -32[rbp], 1641
	je	.L676
	jmp	.L674
.L675:
.L676:
	nop
	leave
	ret
	.def	_ZN9MOUSETYPEC1Ev;	.scl	3;	.type	32;	.endef
_ZN9MOUSETYPEC1Ev:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR 16[rbp], rcx
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZN4VEC2C1Ev
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 8
	mov	rcx, rax
	call	_ZN4VEC2C1Ev
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 16
	mov	rcx, rax
	call	_ZN4VEC2C1Ev
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
	nop
	leave
	ret
.L678:
.L679:
	.def	_ZN9MOUSETYPEaSERKS_;	.scl	3;	.type	32;	.endef
_ZN9MOUSETYPEaSERKS_:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
.L681:
	mov	rax, QWORD PTR 24[rbp]
	mov	rdx, rax
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZN4VEC2aSERKS_
	mov	rax, QWORD PTR 24[rbp]
	lea	rdx, 8[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 8
	mov	rcx, rax
	call	_ZN4VEC2aSERKS_
	mov	rax, QWORD PTR 24[rbp]
	lea	rdx, 16[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 16
	mov	rcx, rax
	call	_ZN4VEC2aSERKS_
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
	nop
	leave
	ret
.L682:
	.def	_ZN14SIMULATIONTYPEaSERKS_;	.scl	3;	.type	32;	.endef
_ZN14SIMULATIONTYPEaSERKS_:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
.L684:
	mov	rax, QWORD PTR 24[rbp]
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR 16[rbp]
	mov	QWORD PTR [rax], rdx
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 8[rax]
	mov	rax, QWORD PTR 24[rbp]
	movss	xmm0, DWORD PTR 8[rax]
	movss	DWORD PTR [rdx], xmm0
	mov	rax, QWORD PTR 24[rbp]
	lea	rdx, 16[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 16
	mov	rcx, rax
	call	_ZN9FLUIDTYPEaSERKS_
	mov	rax, QWORD PTR 24[rbp]
	lea	rdx, 3309688[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 3309688
	mov	rcx, rax
	call	_ZN8GRIDTYPEaSERKS_
	mov	rax, QWORD PTR 24[rbp]
	lea	rdx, 3530488[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 3530488
	mov	rcx, QWORD PTR [rdx]
	mov	QWORD PTR [rax], rcx
	mov	rcx, QWORD PTR 8[rdx]
	mov	QWORD PTR 8[rax], rcx
	mov	rdx, QWORD PTR 16[rdx]
	mov	QWORD PTR 16[rax], rdx
	mov	rax, QWORD PTR 24[rbp]
	lea	rdx, 3530512[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 3530512
	mov	rcx, rax
	call	_ZN9MOUSETYPEaSERKS_
	nop
	leave
	ret
.L685:
	.def	_GLOBAL__I;	.scl	3;	.type	32;	.endef
_GLOBAL__I:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
.L687:
	lea	rcx, SIMULATION$[rip]
	call	_ZN14SIMULATIONTYPEC1Ev
	nop
	leave
	ret
.L688:
	.section	.ctors,"w"
	.align 8
	.quad	_GLOBAL__I
	.section .rdata,"dr"
	.align 16
.LC1:
	.long	2147483647
	.long	0
	.long	0
	.long	0
	.align 16
.LC2:
	.long	-2147483648
	.long	0
	.long	0
	.long	0
	.align 4
.LC3:
	.long	1065353216
	.align 8
.LC4:
	.long	1413754136
	.long	1075388923
	.align 8
.LC5:
	.long	0
	.long	1072693248
	.align 4
.LC6:
	.long	1106247680
	.align 4
.LC7:
	.long	1008981770
	.align 4
.LC8:
	.long	1045220557
	.align 4
.LC9:
	.long	1053609165
	.align 4
.LC10:
	.long	1097859072
	.align 4
.LC11:
	.long	1105199104
	.align 4
.LC12:
	.long	1177280512
	.align 8
.LC13:
	.long	858993459
	.long	1071854387
	.align 8
.LC14:
	.long	0
	.long	1080188928
	.align 8
.LC15:
	.long	0
	.long	1082828800
	.align 8
.LC16:
	.long	-755914244
	.long	1062232653
	.align 4
.LC17:
	.long	1082130432
	.align 4
.LC18:
	.long	1092616192
	.align 4
.LC19:
	.long	1111228416
	.align 4
.LC20:
	.long	1112014848
	.align 4
.LC21:
	.long	1158864896
	.align 4
.LC22:
	.long	1048576000
	.align 4
.LC23:
	.long	1132265472
	.align 4
.LC24:
	.long	1178970112
	.align 4
.LC25:
	.long	1148076032
	.align 4
.LC26:
	.long	1194992128
	.align 4
.LC27:
	.long	1148846080
	.align 4
.LC28:
	.long	1133903872
	.align 4
.LC29:
	.long	1593835520
	.align 4
.LC30:
	.long	1019078604
	.align 4
.LC31:
	.long	1069547520
	.align 8
.LC32:
	.long	0
	.long	1073217536
	.align 4
.LC35:
	.long	1107296256
	.align 4
.LC36:
	.long	1120403456
	.align 4
.LC37:
	.long	1149239296
	.align 4
.LC38:
	.long	1176256512
	.align 4
.LC39:
	.long	1167867904
	.ident	"GCC: (x86_64-win32-sjlj-rev0, Built by MinGW-W64 project) 5.2.0"
	.def	fb_Rnd;	.scl	2;	.type	32;	.endef
	.def	sinf;	.scl	2;	.type	32;	.endef
	.def	cosf;	.scl	2;	.type	32;	.endef
	.def	sin;	.scl	2;	.type	32;	.endef
	.def	cos;	.scl	2;	.type	32;	.endef
	.def	atan2f;	.scl	2;	.type	32;	.endef
	.def	memset;	.scl	2;	.type	32;	.endef
	.def	nearbyint;	.scl	2;	.type	32;	.endef
	.def	fb_Multikey;	.scl	2;	.type	32;	.endef
	.def	fb_End;	.scl	2;	.type	32;	.endef
	.def	fb_Timer;	.scl	2;	.type	32;	.endef
	.def	fb_Randomize;	.scl	2;	.type	32;	.endef
	.def	nearbyintf;	.scl	2;	.type	32;	.endef
	.def	fb_GfxLock;	.scl	2;	.type	32;	.endef
	.def	fb_GfxLine;	.scl	2;	.type	32;	.endef
	.def	fb_Cls;	.scl	2;	.type	32;	.endef
	.def	fb_Locate;	.scl	2;	.type	32;	.endef
	.def	fb_StrAllocTempDescZEx;	.scl	2;	.type	32;	.endef
	.def	fb_PrintString;	.scl	2;	.type	32;	.endef
	.def	fb_PrintLongint;	.scl	2;	.type	32;	.endef
	.def	fb_GfxUnlock;	.scl	2;	.type	32;	.endef
	.def	fb_GfxScreenRes;	.scl	2;	.type	32;	.endef
	.def	fb_Color;	.scl	2;	.type	32;	.endef
	.def	fb_GetMouse64;	.scl	2;	.type	32;	.endef
	.def	fb_SGNl;	.scl	2;	.type	32;	.endef
	.def	fb_Init;	.scl	2;	.type	32;	.endef
