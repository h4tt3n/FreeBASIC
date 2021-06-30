	.file	"Sequential_SPH_10.c"
	.intel_syntax noprefix
.lcomm SIMULATION$,1529048,32
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
	sub	rsp, 80
	mov	QWORD PTR 16[rbp], rcx
.L210:
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
	mov	DWORD PTR [rax], 0
	lea	rax, -16[rbp]
	pxor	xmm2, xmm2
	pxor	xmm1, xmm1
	mov	rcx, rax
	call	_ZN4VEC2C1EfS0_
	lea	rax, -16[rbp]
	mov	rdx, rax
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZN4VEC2aSERKS_
	lea	rax, -32[rbp]
	pxor	xmm2, xmm2
	pxor	xmm1, xmm1
	mov	rcx, rax
	call	_ZN4VEC2C1EfS0_
	mov	rax, QWORD PTR 16[rbp]
	lea	rcx, 8[rax]
	lea	rax, -32[rbp]
	mov	rdx, rax
	call	_ZN4VEC2aSERKS_
	lea	rax, -48[rbp]
	pxor	xmm2, xmm2
	pxor	xmm1, xmm1
	mov	rcx, rax
	call	_ZN4VEC2C1EfS0_
	mov	rax, QWORD PTR 16[rbp]
	lea	rcx, 16[rax]
	lea	rax, -48[rbp]
	mov	rdx, rax
	call	_ZN4VEC2aSERKS_
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 24
	pxor	xmm0, xmm0
	movss	DWORD PTR [rax], xmm0
	nop
	leave
	ret
.L211:
	.globl	_ZN16PARTICLEPAIRTYPEC1Ev
	.def	_ZN16PARTICLEPAIRTYPEC1Ev;	.scl	2;	.type	32;	.endef
_ZN16PARTICLEPAIRTYPEC1Ev:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	QWORD PTR 16[rbp], rcx
.L213:
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
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 32
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
	add	rax, 24
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 32
	mov	QWORD PTR [rax], 0
	nop
	leave
	ret
.L214:
	.globl	_ZN8GRIDTYPEC1Ev
	.def	_ZN8GRIDTYPEC1Ev;	.scl	2;	.type	32;	.endef
_ZN8GRIDTYPEC1Ev:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 64
	mov	QWORD PTR 16[rbp], rcx
.L216:
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
.L217:
	mov	rax, QWORD PTR -16[rbp]
	mov	rcx, rax
	call	_ZN8CELLTYPEC1Ev
	add	QWORD PTR -16[rbp], 264
	add	QWORD PTR -8[rbp], 1
	cmp	QWORD PTR -8[rbp], 1512
	je	.L218
	jmp	.L217
.L218:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 399232
	mov	QWORD PTR -32[rbp], rax
	mov	QWORD PTR -24[rbp], 0
.L219:
	mov	rax, QWORD PTR -32[rbp]
	mov	rcx, rax
	call	_ZN12CELLPAIRTYPEC1Ev
	add	QWORD PTR -32[rbp], 16
	add	QWORD PTR -24[rbp], 1
	cmp	QWORD PTR -24[rbp], 7103
	je	.L220
	jmp	.L219
.L220:
	mov	rax, QWORD PTR 16[rbp]
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 8
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 16
	pxor	xmm0, xmm0
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 20
	pxor	xmm0, xmm0
	movss	DWORD PTR [rax], xmm0
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
	nop
	leave
	ret
.L221:
	.globl	_ZN8GRIDTYPEC1Efu7INTEGERS0_
	.def	_ZN8GRIDTYPEC1Efu7INTEGERS0_;	.scl	2;	.type	32;	.endef
_ZN8GRIDTYPEC1Efu7INTEGERS0_:
	push	rbp
	mov	rbp, rsp
	push	rbx
	sub	rsp, 72
	mov	QWORD PTR 16[rbp], rcx
	movss	DWORD PTR 24[rbp], xmm1
	mov	QWORD PTR 32[rbp], r8
	mov	QWORD PTR 40[rbp], r9
.L223:
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
.L224:
	mov	rax, QWORD PTR -32[rbp]
	mov	rcx, rax
	call	_ZN8CELLTYPEC1Ev
	add	QWORD PTR -32[rbp], 264
	add	QWORD PTR -24[rbp], 1
	cmp	QWORD PTR -24[rbp], 1512
	je	.L225
	jmp	.L224
.L225:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 399232
	mov	QWORD PTR -48[rbp], rax
	mov	QWORD PTR -40[rbp], 0
.L226:
	mov	rax, QWORD PTR -48[rbp]
	mov	rcx, rax
	call	_ZN12CELLPAIRTYPEC1Ev
	add	QWORD PTR -48[rbp], 16
	add	QWORD PTR -40[rbp], 1
	cmp	QWORD PTR -40[rbp], 7103
	je	.L227
	jmp	.L226
.L227:
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
	mov	QWORD PTR [rax], 32
	nop
	add	rsp, 72
	pop	rbx
	pop	rbp
	ret
.L228:
	.globl	_ZN9FLUIDTYPEC1Ev
	.def	_ZN9FLUIDTYPEC1Ev;	.scl	2;	.type	32;	.endef
_ZN9FLUIDTYPEC1Ev:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 64
	mov	QWORD PTR 16[rbp], rcx
.L230:
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
.L231:
	mov	rax, QWORD PTR -16[rbp]
	mov	rcx, rax
	call	_ZN12PARTICLETYPEC1Ev
	add	QWORD PTR -16[rbp], 28
	add	QWORD PTR -8[rbp], 1
	cmp	QWORD PTR -8[rbp], 2000
	je	.L232
	jmp	.L231
.L232:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 56072
	mov	QWORD PTR -32[rbp], rax
	mov	QWORD PTR -24[rbp], 0
.L233:
	mov	rax, QWORD PTR -32[rbp]
	mov	rcx, rax
	call	_ZN16PARTICLEPAIRTYPEC1Ev
	add	QWORD PTR -32[rbp], 40
	add	QWORD PTR -24[rbp], 1
	cmp	QWORD PTR -24[rbp], 24000
	je	.L234
	jmp	.L233
.L234:
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
.L235:
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
.L237:
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
.L238:
	mov	rax, QWORD PTR -16[rbp]
	mov	rcx, rax
	call	_ZN12PARTICLETYPEC1Ev
	add	QWORD PTR -16[rbp], 28
	add	QWORD PTR -8[rbp], 1
	cmp	QWORD PTR -8[rbp], 2000
	je	.L239
	jmp	.L238
.L239:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 56072
	mov	QWORD PTR -32[rbp], rax
	mov	QWORD PTR -24[rbp], 0
.L240:
	mov	rax, QWORD PTR -32[rbp]
	mov	rcx, rax
	call	_ZN16PARTICLEPAIRTYPEC1Ev
	add	QWORD PTR -32[rbp], 40
	add	QWORD PTR -24[rbp], 1
	cmp	QWORD PTR -24[rbp], 24000
	je	.L241
	jmp	.L240
.L241:
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
	add	rax, 56
	mov	rdx, QWORD PTR 16[rbp]
	add	rdx, 72
	mov	QWORD PTR [rax], rdx
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 64
	mov	rdx, QWORD PTR 16[rbp]
	add	rdx, 56044
	mov	QWORD PTR [rax], rdx
	nop
	leave
	ret
.L242:
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
	mov	ecx, 256
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
.L244:
.L245:
	.globl	_ZN12CELLPAIRTYPEC1Ev
	.def	_ZN12CELLPAIRTYPEC1Ev;	.scl	2;	.type	32;	.endef
_ZN12CELLPAIRTYPEC1Ev:
	push	rbp
	mov	rbp, rsp
	mov	QWORD PTR 16[rbp], rcx
	mov	rax, QWORD PTR 16[rbp]
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 8
	mov	QWORD PTR [rax], 0
	nop
	pop	rbp
	ret
.L247:
.L248:
	.globl	_ZN10SCREENTYPEC1Ev
	.def	_ZN10SCREENTYPEC1Ev;	.scl	2;	.type	32;	.endef
_ZN10SCREENTYPEC1Ev:
	push	rbp
	mov	rbp, rsp
	mov	QWORD PTR 16[rbp], rcx
	mov	rax, QWORD PTR 16[rbp]
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 8
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 16
	mov	QWORD PTR [rax], 0
	nop
	pop	rbp
	ret
.L250:
.L251:
	.globl	_ZN9MOUSETYPEC1Ev
	.def	_ZN9MOUSETYPEC1Ev;	.scl	2;	.type	32;	.endef
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
.L253:
.L254:
	.globl	_ZN14SIMULATIONTYPEC1Ev
	.def	_ZN14SIMULATIONTYPEC1Ev;	.scl	2;	.type	32;	.endef
_ZN14SIMULATIONTYPEC1Ev:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR 16[rbp], rcx
.L256:
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
	add	rax, 1016088
	mov	rcx, rax
	call	_ZN8GRIDTYPEC1Ev
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 1528968
	mov	rcx, rax
	call	_ZN10SCREENTYPEC1Ev
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 1528992
	mov	rcx, rax
	call	_ZN9MOUSETYPEC1Ev
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZN14SIMULATIONTYPE13RUNSIMULATIONEv
	nop
	leave
	ret
.L257:
	.globl	_ZN14SIMULATIONTYPE13RUNSIMULATIONEv
	.def	_ZN14SIMULATIONTYPE13RUNSIMULATIONEv;	.scl	2;	.type	32;	.endef
_ZN14SIMULATIONTYPE13RUNSIMULATIONEv:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 96
	mov	QWORD PTR 16[rbp], rcx
.L259:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 1528968
	mov	QWORD PTR 72[rsp], 0
	mov	QWORD PTR 64[rsp], 0
	mov	QWORD PTR 56[rsp], 0
	mov	QWORD PTR 48[rsp], 8
	mov	QWORD PTR 40[rsp], 8
	mov	QWORD PTR 32[rsp], 8
	mov	r9d, 8
	mov	r8d, 800
	mov	edx, 1600
	mov	rcx, rax
	call	_ZN10SCREENTYPE12CREATESCREENEu7INTEGERS0_S0_S0_S0_S0_S0_S0_S0_
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZN14SIMULATIONTYPE18INITIATESIMULATIONEv
.L260:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 16
	mov	rcx, rax
	call	_ZN9FLUIDTYPE14RESETPARTICLESEv
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZN14SIMULATIONTYPE9DRAWFLUIDEv
.L261:
	mov	ecx, 1
	call	fb_Multikey
	mov	DWORD PTR -4[rbp], eax
	cmp	DWORD PTR -4[rbp], 0
	jne	.L262
	jmp	.L260
.L262:
	mov	ecx, 0
	call	fb_End
	nop
	leave
	ret
.L263:
	.globl	_ZN8GRIDTYPE16COMPUTECELLPAIRSEv
	.def	_ZN8GRIDTYPE16COMPUTECELLPAIRSEv;	.scl	2;	.type	32;	.endef
_ZN8GRIDTYPE16COMPUTECELLPAIRSEv:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR 16[rbp], rcx
.L265:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 24
	mov	QWORD PTR [rax], 0
	mov	QWORD PTR -8[rbp], 0
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 40[rax]
	mov	QWORD PTR -24[rbp], rax
	jmp	.L266
.L294:
	nop
.L267:
	mov	QWORD PTR -16[rbp], 0
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 48[rax]
	mov	QWORD PTR -32[rbp], rax
	jmp	.L268
.L293:
	nop
.L269:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 40
	mov	rax, QWORD PTR [rax]
	cmp	rax, QWORD PTR -8[rbp]
	jle	.L289
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
	lea	rdx, 399232[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rdx, rax
	mov	rax, QWORD PTR -8[rbp]
	sal	rax, 2
	lea	rcx, 0[0+rax*8]
	sub	rcx, rax
	mov	rax, QWORD PTR -16[rbp]
	add	rax, rcx
	sal	rax, 3
	mov	rcx, rax
	sal	rcx, 5
	add	rax, rcx
	lea	rcx, 64[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, rcx
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	sal	rax, 4
	lea	rdx, 399240[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rdx, rax
	mov	rax, QWORD PTR -8[rbp]
	sal	rax, 2
	lea	rcx, 0[0+rax*8]
	sub	rcx, rax
	mov	rax, QWORD PTR -16[rbp]
	add	rax, rcx
	sal	rax, 3
	mov	rcx, rax
	sal	rcx, 5
	add	rax, rcx
	lea	rcx, 7456[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, rcx
	mov	QWORD PTR [rdx], rax
	jmp	.L272
.L271:
.L289:
	nop
.L272:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 48
	mov	rax, QWORD PTR [rax]
	cmp	rax, QWORD PTR -16[rbp]
	jle	.L290
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
	lea	rdx, 399232[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rdx, rax
	mov	rax, QWORD PTR -8[rbp]
	sal	rax, 2
	lea	rcx, 0[0+rax*8]
	sub	rcx, rax
	mov	rax, QWORD PTR -16[rbp]
	add	rax, rcx
	sal	rax, 3
	mov	rcx, rax
	sal	rcx, 5
	add	rax, rcx
	lea	rcx, 64[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, rcx
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	sal	rax, 4
	lea	rdx, 399240[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rdx, rax
	mov	rax, QWORD PTR -8[rbp]
	sal	rax, 2
	lea	rcx, 0[0+rax*8]
	sub	rcx, rax
	mov	rax, QWORD PTR -16[rbp]
	add	rax, rcx
	sal	rax, 3
	mov	rcx, rax
	sal	rcx, 5
	add	rax, rcx
	lea	rcx, 328[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, rcx
	mov	QWORD PTR [rdx], rax
	jmp	.L275
.L274:
.L290:
	nop
.L275:
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
	je	.L291
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
	lea	rdx, 399232[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rdx, rax
	mov	rax, QWORD PTR -8[rbp]
	sal	rax, 2
	lea	rcx, 0[0+rax*8]
	sub	rcx, rax
	mov	rax, QWORD PTR -16[rbp]
	add	rax, rcx
	sal	rax, 3
	mov	rcx, rax
	sal	rcx, 5
	add	rax, rcx
	lea	rcx, 64[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, rcx
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	sal	rax, 4
	lea	rdx, 399240[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rdx, rax
	mov	rax, QWORD PTR -8[rbp]
	sal	rax, 2
	lea	rcx, 0[0+rax*8]
	sub	rcx, rax
	mov	rax, QWORD PTR -16[rbp]
	add	rax, rcx
	sal	rax, 3
	mov	rcx, rax
	sal	rcx, 5
	add	rax, rcx
	lea	rcx, 7720[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, rcx
	mov	QWORD PTR [rdx], rax
	jmp	.L278
.L277:
.L291:
	nop
.L278:
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
	je	.L292
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
	lea	rdx, 399232[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rdx, rax
	mov	rax, QWORD PTR -8[rbp]
	sal	rax, 2
	lea	rcx, 0[0+rax*8]
	sub	rcx, rax
	mov	rax, QWORD PTR -16[rbp]
	add	rax, rcx
	sal	rax, 3
	mov	rcx, rax
	sal	rcx, 5
	add	rax, rcx
	lea	rcx, 64[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, rcx
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	sal	rax, 4
	lea	rdx, 399240[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rdx, rax
	mov	rax, QWORD PTR -8[rbp]
	sal	rax, 2
	lea	rcx, 0[0+rax*8]
	sub	rcx, rax
	mov	rax, QWORD PTR -16[rbp]
	add	rax, rcx
	sal	rax, 3
	mov	rcx, rax
	sal	rcx, 5
	add	rax, rcx
	lea	rcx, -7064[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, rcx
	mov	QWORD PTR [rdx], rax
	jmp	.L282
.L280:
.L281:
.L292:
	nop
.L282:
	add	QWORD PTR -16[rbp], 1
.L268:
	mov	rax, QWORD PTR -16[rbp]
	cmp	rax, QWORD PTR -32[rbp]
	jle	.L293
.L283:
.L284:
	add	QWORD PTR -8[rbp], 1
.L266:
	mov	rax, QWORD PTR -8[rbp]
	cmp	rax, QWORD PTR -24[rbp]
	jle	.L294
.L285:
.L286:
	nop
	leave
	ret
	.globl	_ZN14SIMULATIONTYPE18INITIATESIMULATIONEv
	.def	_ZN14SIMULATIONTYPE18INITIATESIMULATIONEv;	.scl	2;	.type	32;	.endef
_ZN14SIMULATIONTYPE18INITIATESIMULATIONEv:
	push	rbp
	mov	rbp, rsp
	mov	eax, 1529120
	call	___chkstk_ms
	sub	rsp, rax
	mov	QWORD PTR 16[rbp], rcx
.L296:
	lea	rax, -512960[rbp]
	mov	r9d, 800
	mov	r8d, 1600
	movss	xmm1, DWORD PTR .LC6[rip]
	mov	rcx, rax
	call	_ZN8GRIDTYPEC1Efu7INTEGERS0_
	mov	rax, QWORD PTR 16[rbp]
	lea	rcx, 1016088[rax]
	lea	rax, -512960[rbp]
	mov	rdx, rax
	call	_ZN8GRIDTYPEaSERKS_
	lea	rax, -1529040[rbp]
	movss	xmm0, DWORD PTR .LC7[rip]
	movss	DWORD PTR 48[rsp], xmm0
	movss	xmm0, DWORD PTR .LC6[rip]
	movss	DWORD PTR 40[rsp], xmm0
	movss	xmm0, DWORD PTR .LC8[rip]
	movss	DWORD PTR 32[rsp], xmm0
	movss	xmm3, DWORD PTR .LC9[rip]
	movss	xmm2, DWORD PTR .LC10[rip]
	movss	xmm1, DWORD PTR .LC11[rip]
	mov	rcx, rax
	call	_ZN9FLUIDTYPEC1Effffff
	mov	rax, QWORD PTR 16[rbp]
	lea	rcx, 16[rax]
	lea	rax, -1529040[rbp]
	mov	rdx, rax
	call	_ZN9FLUIDTYPEaSERKS_
	call	fb_Timer
	movq	rax, xmm0
	mov	QWORD PTR -32[rbp], rax
	mov	rax, QWORD PTR -32[rbp]
	mov	edx, 0
	mov	QWORD PTR -1529048[rbp], rax
	movsd	xmm0, QWORD PTR -1529048[rbp]
	call	fb_Randomize
	mov	QWORD PTR -8[rbp], 0
	mov	QWORD PTR -16[rbp], 1
.L297:
	mov	QWORD PTR -24[rbp], 1
.L298:
	add	QWORD PTR -8[rbp], 1
	mov	rax, QWORD PTR -8[rbp]
	sal	rax, 2
	lea	rdx, 0[0+rax*8]
	sub	rdx, rax
	mov	rax, rdx
	lea	rdx, 60[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, rdx
	mov	QWORD PTR -40[rbp], rax
	mov	rax, QWORD PTR -40[rbp]
	add	rax, 8
	pxor	xmm0, xmm0
	cvtsi2ssq	xmm0, QWORD PTR -16[rbp]
	movss	xmm1, DWORD PTR .LC6[rip]
	mulss	xmm0, xmm1
	cvtss2sd	xmm0, xmm0
	movsd	xmm1, QWORD PTR .LC12[rip]
	mulsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR .LC13[rip]
	addsd	xmm0, xmm1
	cvtsd2ss	xmm0, xmm0
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR -40[rbp]
	add	rax, 12
	pxor	xmm0, xmm0
	cvtsi2ssq	xmm0, QWORD PTR -24[rbp]
	movss	xmm1, DWORD PTR .LC6[rip]
	mulss	xmm0, xmm1
	cvtss2sd	xmm0, xmm0
	movsd	xmm1, QWORD PTR .LC12[rip]
	mulsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR .LC14[rip]
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
	add	rax, 8
	mov	rdx, QWORD PTR -40[rbp]
	add	rdx, 8
	movss	xmm0, DWORD PTR [rdx]
	cvtss2sd	xmm1, xmm0
	movsd	xmm0, QWORD PTR -48[rbp]
	subsd	xmm0, QWORD PTR -56[rbp]
	movsd	xmm2, QWORD PTR .LC15[rip]
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
	add	rax, 12
	mov	rdx, QWORD PTR -40[rbp]
	add	rdx, 12
	movss	xmm0, DWORD PTR [rdx]
	cvtss2sd	xmm1, xmm0
	movsd	xmm0, QWORD PTR -64[rbp]
	subsd	xmm0, QWORD PTR -72[rbp]
	movsd	xmm2, QWORD PTR .LC15[rip]
	mulsd	xmm0, xmm2
	addsd	xmm0, xmm1
	cvtsd2ss	xmm0, xmm0
	movss	DWORD PTR [rax], xmm0
.L299:
	add	QWORD PTR -24[rbp], 1
.L300:
	cmp	QWORD PTR -24[rbp], 20
	jg	.L302
	jmp	.L298
.L301:
.L302:
	add	QWORD PTR -16[rbp], 1
.L303:
	cmp	QWORD PTR -16[rbp], 100
	jg	.L304
	jmp	.L297
.L304:
	mov	rax, QWORD PTR 16[rbp]
	mov	QWORD PTR [rax], 2
	nop
	leave
	ret
.L305:
	.globl	_ZN14SIMULATIONTYPE17COMPUTEBROADPHASEEP9FLUIDTYPEP8GRIDTYPE
	.def	_ZN14SIMULATIONTYPE17COMPUTEBROADPHASEEP9FLUIDTYPEP8GRIDTYPE;	.scl	2;	.type	32;	.endef
_ZN14SIMULATIONTYPE17COMPUTEBROADPHASEEP9FLUIDTYPEP8GRIDTYPE:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 64
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
	mov	QWORD PTR 32[rbp], r8
.L307:
	mov	rax, QWORD PTR 24[rbp]
	mov	rax, QWORD PTR 56[rax]
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR 24[rbp]
	mov	rax, QWORD PTR 64[rax]
	mov	QWORD PTR -16[rbp], rax
	jmp	.L308
.L323:
	nop
.L309:
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 8
	movss	xmm1, DWORD PTR [rax]
	mov	rax, QWORD PTR 32[rbp]
	add	rax, 20
	movss	xmm0, DWORD PTR [rax]
	mulss	xmm0, xmm1
	call	nearbyintf
	cvttss2si	eax, xmm0
	mov	WORD PTR -18[rbp], ax
	movzx	edx, WORD PTR -18[rbp]
	mov	rax, QWORD PTR 32[rbp]
	add	rax, 40
	mov	rax, QWORD PTR [rax]
	cmp	rdx, rax
	jg	.L320
	nop
.L311:
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 12
	movss	xmm1, DWORD PTR [rax]
	mov	rax, QWORD PTR 32[rbp]
	add	rax, 16
	movss	xmm0, DWORD PTR [rax]
	mulss	xmm0, xmm1
	call	nearbyintf
	cvttss2si	eax, xmm0
	mov	WORD PTR -20[rbp], ax
	movzx	edx, WORD PTR -20[rbp]
	mov	rax, QWORD PTR 32[rbp]
	add	rax, 48
	mov	rax, QWORD PTR [rax]
	cmp	rdx, rax
	jg	.L321
	nop
.L314:
	movzx	eax, WORD PTR -18[rbp]
	sal	rax, 2
	lea	rdx, 0[0+rax*8]
	sub	rdx, rax
	movzx	eax, WORD PTR -20[rbp]
	add	rax, rdx
	sal	rax, 3
	mov	rdx, rax
	sal	rdx, 5
	add	rax, rdx
	lea	rdx, 64[rax]
	mov	rax, QWORD PTR 32[rbp]
	add	rax, rdx
	mov	QWORD PTR -32[rbp], rax
	mov	rax, QWORD PTR -32[rbp]
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR 32[rbp]
	add	rax, 56
	mov	rax, QWORD PTR [rax]
	cmp	rdx, rax
	jge	.L322
	nop
.L316:
	mov	rax, QWORD PTR -32[rbp]
	mov	rax, QWORD PTR [rax]
	lea	rdx, 1[rax]
	mov	rax, QWORD PTR -32[rbp]
	mov	QWORD PTR [rax], rdx
	mov	rax, QWORD PTR -32[rbp]
	mov	rax, QWORD PTR [rax]
	sal	rax, 3
	mov	rdx, rax
	mov	rax, QWORD PTR -32[rbp]
	add	rdx, rax
	mov	rax, QWORD PTR -8[rbp]
	mov	QWORD PTR [rdx], rax
	jmp	.L312
.L320:
	nop
	jmp	.L312
.L321:
	nop
	jmp	.L312
.L322:
	nop
.L312:
	add	QWORD PTR -8[rbp], 28
.L308:
	mov	rax, QWORD PTR -8[rbp]
	cmp	rax, QWORD PTR -16[rbp]
	jbe	.L323
.L317:
.L318:
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
.L325:
	mov	rax, QWORD PTR 24[rbp]
	add	rax, 24
	mov	QWORD PTR [rax], 0
	mov	QWORD PTR -8[rbp], 0
	mov	rax, QWORD PTR 32[rbp]
	mov	rax, QWORD PTR 40[rax]
	mov	QWORD PTR -64[rbp], rax
	jmp	.L326
.L372:
	nop
.L327:
	mov	QWORD PTR -16[rbp], 0
	mov	rax, QWORD PTR 32[rbp]
	mov	rax, QWORD PTR 48[rax]
	mov	QWORD PTR -72[rbp], rax
	jmp	.L328
.L371:
	nop
.L329:
	mov	rax, QWORD PTR -8[rbp]
	sal	rax, 2
	lea	rdx, 0[0+rax*8]
	sub	rdx, rax
	mov	rax, QWORD PTR -16[rbp]
	add	rax, rdx
	sal	rax, 3
	mov	rdx, rax
	sal	rdx, 5
	add	rax, rdx
	lea	rdx, 64[rax]
	mov	rax, QWORD PTR 32[rbp]
	add	rax, rdx
	mov	QWORD PTR -80[rbp], rax
	mov	rax, QWORD PTR -80[rbp]
	mov	rax, QWORD PTR [rax]
	test	rax, rax
	je	.L368
	nop
.L331:
	mov	QWORD PTR -24[rbp], 1
	mov	rax, QWORD PTR -80[rbp]
	mov	rax, QWORD PTR [rax]
	sub	rax, 1
	mov	QWORD PTR -88[rbp], rax
	jmp	.L333
.L370:
	nop
.L334:
	mov	rax, QWORD PTR -24[rbp]
	add	rax, 1
	mov	QWORD PTR -32[rbp], rax
	mov	rax, QWORD PTR -80[rbp]
	mov	rax, QWORD PTR [rax]
	mov	QWORD PTR -96[rbp], rax
	jmp	.L335
.L369:
	nop
.L336:
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
.L337:
	add	QWORD PTR -32[rbp], 1
.L335:
	mov	rax, QWORD PTR -32[rbp]
	cmp	rax, QWORD PTR -96[rbp]
	jle	.L369
.L338:
.L339:
	add	QWORD PTR -24[rbp], 1
.L333:
	mov	rax, QWORD PTR -24[rbp]
	cmp	rax, QWORD PTR -88[rbp]
	jle	.L370
	jmp	.L340
.L332:
.L368:
	nop
.L340:
	add	QWORD PTR -16[rbp], 1
.L328:
	mov	rax, QWORD PTR -16[rbp]
	cmp	rax, QWORD PTR -72[rbp]
	jle	.L371
.L341:
.L342:
	add	QWORD PTR -8[rbp], 1
.L326:
	mov	rax, QWORD PTR -8[rbp]
	cmp	rax, QWORD PTR -64[rbp]
	jle	.L372
.L343:
	mov	rax, QWORD PTR 32[rbp]
	add	rax, 399248
	mov	QWORD PTR -40[rbp], rax
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 1016112
	mov	rax, QWORD PTR [rax]
	sal	rax, 4
	lea	rdx, 399232[rax]
	mov	rax, QWORD PTR 32[rbp]
	add	rax, rdx
	mov	QWORD PTR -104[rbp], rax
	jmp	.L344
.L377:
	nop
.L345:
	mov	rax, QWORD PTR -40[rbp]
	mov	rax, QWORD PTR [rax]
	mov	rax, QWORD PTR [rax]
	test	rax, rax
	je	.L373
	nop
.L347:
	mov	rax, QWORD PTR -40[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	mov	rax, QWORD PTR [rax]
	test	rax, rax
	je	.L374
	nop
.L350:
	mov	QWORD PTR -48[rbp], 1
	mov	rax, QWORD PTR -40[rbp]
	mov	rax, QWORD PTR [rax]
	mov	rax, QWORD PTR [rax]
	mov	QWORD PTR -112[rbp], rax
	jmp	.L351
.L376:
	nop
.L352:
	mov	QWORD PTR -56[rbp], 1
	mov	rax, QWORD PTR -40[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	mov	rax, QWORD PTR [rax]
	mov	QWORD PTR -120[rbp], rax
	jmp	.L353
.L375:
	nop
.L354:
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
.L355:
	add	QWORD PTR -56[rbp], 1
.L353:
	mov	rax, QWORD PTR -56[rbp]
	cmp	rax, QWORD PTR -120[rbp]
	jle	.L375
.L356:
.L357:
	add	QWORD PTR -48[rbp], 1
.L351:
	mov	rax, QWORD PTR -48[rbp]
	cmp	rax, QWORD PTR -112[rbp]
	jle	.L376
	jmp	.L358
.L348:
.L373:
	nop
	jmp	.L358
.L374:
	nop
.L358:
	add	QWORD PTR -40[rbp], 16
.L344:
	mov	rax, QWORD PTR -40[rbp]
	cmp	rax, QWORD PTR -104[rbp]
	jbe	.L377
.L359:
.L360:
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
.L379:
	mov	QWORD PTR -8[rbp], 0
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 40[rax]
	mov	QWORD PTR -24[rbp], rax
	jmp	.L380
.L392:
	nop
.L381:
	mov	QWORD PTR -16[rbp], 0
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 48[rax]
	mov	QWORD PTR -32[rbp], rax
	jmp	.L382
.L391:
	nop
.L383:
	mov	rax, QWORD PTR -8[rbp]
	sal	rax, 2
	lea	rdx, 0[0+rax*8]
	sub	rdx, rax
	mov	rax, QWORD PTR -16[rbp]
	add	rax, rdx
	sal	rax, 3
	mov	rdx, rax
	sal	rdx, 5
	add	rax, rdx
	lea	rdx, 64[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, rdx
	mov	QWORD PTR [rax], 0
.L384:
	add	QWORD PTR -16[rbp], 1
.L382:
	mov	rax, QWORD PTR -16[rbp]
	cmp	rax, QWORD PTR -32[rbp]
	jle	.L391
.L385:
.L386:
	add	QWORD PTR -8[rbp], 1
.L380:
	mov	rax, QWORD PTR -8[rbp]
	cmp	rax, QWORD PTR -24[rbp]
	jle	.L392
.L387:
.L388:
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
.L394:
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 56[rax]
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 64[rax]
	mov	QWORD PTR -16[rbp], rax
	jmp	.L395
.L401:
	nop
.L396:
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 24
	pxor	xmm0, xmm0
	movss	DWORD PTR [rax], xmm0
	lea	rax, -32[rbp]
	movss	xmm2, DWORD PTR .LC16[rip]
	pxor	xmm1, xmm1
	mov	rcx, rax
	call	_ZN4VEC2C1EfS0_
	lea	rdx, -32[rbp]
	mov	rax, QWORD PTR -8[rbp]
	mov	rcx, rax
	call	_ZN4VEC2aSERKS_
.L397:
	add	QWORD PTR -8[rbp], 28
.L395:
	mov	rax, QWORD PTR -8[rbp]
	cmp	rax, QWORD PTR -16[rbp]
	jbe	.L401
.L398:
.L399:
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
.L403:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 56072
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 24
	mov	rdx, QWORD PTR [rax]
	mov	rax, rdx
	sal	rax, 2
	add	rax, rdx
	sal	rax, 3
	lea	rdx, 56032[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, rdx
	mov	QWORD PTR -16[rbp], rax
	jmp	.L404
.L410:
	nop
.L405:
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 24
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 32
	mov	rax, QWORD PTR [rax]
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
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	lea	rdx, -96[rbp]
	mov	rcx, rax
	call	_ZN4VEC2pLERKS_
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 32
	mov	rax, QWORD PTR [rax]
	lea	rdx, -96[rbp]
	mov	rcx, rax
	call	_ZN4VEC2mIERKS_
.L406:
	add	QWORD PTR -8[rbp], 40
.L404:
	mov	rax, QWORD PTR -8[rbp]
	cmp	rax, QWORD PTR -16[rbp]
	jbe	.L410
.L407:
.L408:
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
.L412:
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 72[rax]
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 80[rax]
	mov	QWORD PTR -16[rbp], rax
	jmp	.L413
.L437:
	nop
.L414:
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 8
	movss	xmm0, DWORD PTR [rax]
	ucomiss	xmm0, DWORD PTR .LC17[rip]
	jnb	.L433
	mov	rax, QWORD PTR -8[rbp]
	movss	xmm1, DWORD PTR [rax]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 8
	movss	xmm2, DWORD PTR [rax]
	movss	xmm0, DWORD PTR .LC18[rip]
	mulss	xmm0, xmm2
	movss	xmm2, DWORD PTR .LC19[rip]
	subss	xmm0, xmm2
	subss	xmm1, xmm0
	movaps	xmm0, xmm1
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 16
	movss	xmm2, DWORD PTR [rax]
	pxor	xmm1, xmm1
	mulss	xmm1, xmm2
	subss	xmm0, xmm1
	mov	rax, QWORD PTR -8[rbp]
	movss	DWORD PTR [rax], xmm0
	jmp	.L421
.L433:
	nop
.L417:
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 8
	movss	xmm1, DWORD PTR [rax]
	movss	xmm0, DWORD PTR .LC20[rip]
	ucomiss	xmm0, xmm1
	jnb	.L434
	mov	rax, QWORD PTR -8[rbp]
	movss	xmm1, DWORD PTR [rax]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 8
	movss	xmm2, DWORD PTR [rax]
	movss	xmm0, DWORD PTR .LC18[rip]
	mulss	xmm0, xmm2
	movss	xmm2, DWORD PTR .LC21[rip]
	subss	xmm0, xmm2
	subss	xmm1, xmm0
	movaps	xmm0, xmm1
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 16
	movss	xmm2, DWORD PTR [rax]
	pxor	xmm1, xmm1
	mulss	xmm1, xmm2
	subss	xmm0, xmm1
	mov	rax, QWORD PTR -8[rbp]
	movss	DWORD PTR [rax], xmm0
	jmp	.L421
.L418:
.L434:
	nop
.L421:
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 12
	movss	xmm0, DWORD PTR [rax]
	ucomiss	xmm0, DWORD PTR .LC17[rip]
	jnb	.L435
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 4
	mov	rdx, QWORD PTR -8[rbp]
	add	rdx, 4
	movss	xmm1, DWORD PTR [rdx]
	mov	rdx, QWORD PTR -8[rbp]
	add	rdx, 12
	movss	xmm2, DWORD PTR [rdx]
	movss	xmm0, DWORD PTR .LC18[rip]
	mulss	xmm0, xmm2
	movss	xmm2, DWORD PTR .LC19[rip]
	subss	xmm0, xmm2
	subss	xmm1, xmm0
	movaps	xmm0, xmm1
	mov	rdx, QWORD PTR -8[rbp]
	add	rdx, 20
	movss	xmm2, DWORD PTR [rdx]
	pxor	xmm1, xmm1
	mulss	xmm1, xmm2
	subss	xmm0, xmm1
	movss	DWORD PTR [rax], xmm0
	jmp	.L429
.L435:
	nop
.L424:
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 12
	movss	xmm1, DWORD PTR [rax]
	movss	xmm0, DWORD PTR .LC22[rip]
	ucomiss	xmm0, xmm1
	jnb	.L436
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 4
	mov	rdx, QWORD PTR -8[rbp]
	add	rdx, 4
	movss	xmm1, DWORD PTR [rdx]
	mov	rdx, QWORD PTR -8[rbp]
	add	rdx, 12
	movss	xmm2, DWORD PTR [rdx]
	movss	xmm0, DWORD PTR .LC18[rip]
	mulss	xmm0, xmm2
	movss	xmm2, DWORD PTR .LC23[rip]
	subss	xmm0, xmm2
	subss	xmm1, xmm0
	movaps	xmm0, xmm1
	mov	rdx, QWORD PTR -8[rbp]
	add	rdx, 20
	movss	xmm2, DWORD PTR [rdx]
	pxor	xmm1, xmm1
	mulss	xmm1, xmm2
	subss	xmm0, xmm1
	movss	DWORD PTR [rax], xmm0
	jmp	.L429
.L425:
.L428:
.L436:
	nop
.L429:
	add	QWORD PTR -8[rbp], 28
.L413:
	mov	rax, QWORD PTR -8[rbp]
	cmp	rax, QWORD PTR -16[rbp]
	jbe	.L437
.L430:
.L431:
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
.L439:
	mov	rax, QWORD PTR 24[rbp]
	mov	rax, QWORD PTR 56[rax]
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR 24[rbp]
	mov	rax, QWORD PTR 64[rax]
	mov	QWORD PTR -16[rbp], rax
	jmp	.L440
.L446:
	nop
.L441:
	mov	rax, QWORD PTR -8[rbp]
	lea	rcx, 16[rax]
	mov	rax, QWORD PTR -8[rbp]
	mov	rdx, rax
	call	_ZN4VEC2pLERKS_
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 16
	movss	xmm1, DWORD PTR .LC24[rip]
	mov	rcx, rax
	call	_ZmlRK4VEC2f
	mov	QWORD PTR -48[rbp], rax
	mov	rax, QWORD PTR -48[rbp]
	mov	QWORD PTR -32[rbp], rax
	mov	rax, QWORD PTR -8[rbp]
	lea	rcx, 8[rax]
	lea	rax, -32[rbp]
	mov	rdx, rax
	call	_ZN4VEC2pLERKS_
.L442:
	add	QWORD PTR -8[rbp], 28
.L440:
	mov	rax, QWORD PTR -8[rbp]
	cmp	rax, QWORD PTR -16[rbp]
	jbe	.L446
.L443:
.L444:
	nop
	leave
	ret
	.section .rdata,"dr"
.LC29:
	.ascii "particles:     \0"
.LC30:
	.ascii "particle pairs:\0"
	.text
	.globl	_ZN14SIMULATIONTYPE9DRAWFLUIDEv
	.def	_ZN14SIMULATIONTYPE9DRAWFLUIDEv;	.scl	2;	.type	32;	.endef
_ZN14SIMULATIONTYPE9DRAWFLUIDEv:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 192
	mov	QWORD PTR 16[rbp], rcx
.L448:
	call	fb_GfxLock
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR [rax]
	cmp	rax, 1
	jne	.L481
	mov	DWORD PTR 64[rsp], 0
	mov	DWORD PTR 56[rsp], 65535
	mov	DWORD PTR 48[rsp], 2
	mov	DWORD PTR 40[rsp], 553648127
	movss	xmm0, DWORD PTR .LC25[rip]
	movss	DWORD PTR 32[rsp], xmm0
	movss	xmm3, DWORD PTR .LC26[rip]
	pxor	xmm2, xmm2
	pxor	xmm1, xmm1
	mov	ecx, 0
	call	fb_GfxLine
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 72[rax]
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 80[rax]
	mov	QWORD PTR -40[rbp], rax
	jmp	.L451
.L482:
	nop
.L452:
	pxor	xmm0, xmm0
	movss	DWORD PTR -44[rbp], xmm0
	pxor	xmm0, xmm0
	movss	DWORD PTR -48[rbp], xmm0
	pxor	xmm0, xmm0
	movss	DWORD PTR -52[rbp], xmm0
.L453:
	add	QWORD PTR -8[rbp], 28
.L451:
	mov	rax, QWORD PTR -8[rbp]
	cmp	rax, QWORD PTR -40[rbp]
	jbe	.L482
	jmp	.L455
.L450:
.L454:
.L481:
	nop
.L455:
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR [rax]
	cmp	rax, 2
	jne	.L483
	mov	ecx, -65536
	call	fb_Cls
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 72[rax]
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 80[rax]
	mov	QWORD PTR -64[rbp], rax
	jmp	.L458
.L487:
	nop
.L459:
	mov	rax, QWORD PTR -16[rbp]
	add	rax, 24
	movss	xmm1, DWORD PTR [rax]
	movss	xmm0, DWORD PTR .LC27[rip]
	mulss	xmm0, xmm1
	call	nearbyintf
	cvttss2si	rax, xmm0
	mov	QWORD PTR -24[rbp], rax
	mov	QWORD PTR -96[rbp], 0
	mov	QWORD PTR -104[rbp], 0
	cmp	QWORD PTR -24[rbp], 255
	jle	.L484
	mov	rax, QWORD PTR -24[rbp]
	sub	rax, 255
	mov	QWORD PTR -96[rbp], rax
	mov	QWORD PTR -24[rbp], 255
	jmp	.L462
.L461:
.L484:
	nop
.L462:
	mov	eax, 255
	sub	rax, QWORD PTR -24[rbp]
	mov	QWORD PTR -104[rbp], rax
	mov	rax, QWORD PTR -96[rbp]
	cmp	rax, 255
	jle	.L485
	mov	QWORD PTR -96[rbp], 255
	jmp	.L464
.L485:
	nop
.L464:
	mov	rax, QWORD PTR -104[rbp]
	cmp	rax, 255
	jle	.L486
	mov	QWORD PTR -104[rbp], 255
	jmp	.L466
.L486:
	nop
.L466:
	mov	rax, QWORD PTR -24[rbp]
	sal	eax, 16
	mov	edx, eax
	mov	rax, QWORD PTR -96[rbp]
	sal	eax, 8
	or	edx, eax
	mov	rax, QWORD PTR -104[rbp]
	or	eax, edx
	or	eax, -16777216
	mov	rdx, QWORD PTR -16[rbp]
	add	rdx, 12
	movss	xmm1, DWORD PTR [rdx]
	movss	xmm0, DWORD PTR .LC28[rip]
	addss	xmm0, xmm1
	mov	rdx, QWORD PTR -16[rbp]
	add	rdx, 8
	movss	xmm2, DWORD PTR [rdx]
	movss	xmm1, DWORD PTR .LC28[rip]
	movaps	xmm3, xmm2
	addss	xmm3, xmm1
	mov	rdx, QWORD PTR -16[rbp]
	add	rdx, 12
	movss	xmm1, DWORD PTR [rdx]
	movss	xmm2, DWORD PTR .LC28[rip]
	movaps	xmm4, xmm1
	subss	xmm4, xmm2
	mov	rdx, QWORD PTR -16[rbp]
	add	rdx, 8
	movss	xmm1, DWORD PTR [rdx]
	movss	xmm2, DWORD PTR .LC28[rip]
	subss	xmm1, xmm2
	mov	DWORD PTR 64[rsp], 0
	mov	DWORD PTR 56[rsp], 65535
	mov	DWORD PTR 48[rsp], 2
	mov	DWORD PTR 40[rsp], eax
	movss	DWORD PTR 32[rsp], xmm0
	movaps	xmm2, xmm4
	mov	ecx, 0
	call	fb_GfxLine
.L467:
	add	QWORD PTR -16[rbp], 28
.L458:
	mov	rax, QWORD PTR -16[rbp]
	cmp	rax, QWORD PTR -64[rbp]
	jbe	.L487
	jmp	.L469
.L457:
.L468:
.L483:
	nop
.L469:
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR [rax]
	cmp	rax, 3
	jne	.L488
	mov	DWORD PTR 64[rsp], 0
	mov	DWORD PTR 56[rsp], 65535
	mov	DWORD PTR 48[rsp], 2
	mov	DWORD PTR 40[rsp], -1
	movss	xmm0, DWORD PTR .LC25[rip]
	movss	DWORD PTR 32[rsp], xmm0
	movss	xmm3, DWORD PTR .LC26[rip]
	pxor	xmm2, xmm2
	pxor	xmm1, xmm1
	mov	ecx, 0
	call	fb_GfxLine
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 56088
	mov	QWORD PTR -32[rbp], rax
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 40
	mov	rdx, QWORD PTR [rax]
	mov	rax, rdx
	sal	rax, 2
	add	rax, rdx
	sal	rax, 3
	lea	rdx, 56048[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, rdx
	mov	QWORD PTR -72[rbp], rax
	jmp	.L472
.L489:
	nop
.L473:
	mov	rax, QWORD PTR -32[rbp]
	add	rax, 32
	mov	rax, QWORD PTR [rax]
	add	rax, 12
	movss	xmm0, DWORD PTR [rax]
	mov	rax, QWORD PTR -32[rbp]
	add	rax, 32
	mov	rax, QWORD PTR [rax]
	add	rax, 8
	movss	xmm3, DWORD PTR [rax]
	mov	rax, QWORD PTR -32[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	add	rax, 12
	movss	xmm2, DWORD PTR [rax]
	mov	rax, QWORD PTR -32[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	add	rax, 8
	movss	xmm1, DWORD PTR [rax]
	mov	DWORD PTR 64[rsp], 0
	mov	DWORD PTR 56[rsp], 65535
	mov	DWORD PTR 48[rsp], 0
	mov	DWORD PTR 40[rsp], 536870912
	movss	DWORD PTR 32[rsp], xmm0
	mov	ecx, 0
	call	fb_GfxLine
.L474:
	add	QWORD PTR -32[rbp], 40
.L472:
	mov	rax, QWORD PTR -32[rbp]
	cmp	rax, QWORD PTR -72[rbp]
	jbe	.L489
	jmp	.L476
.L471:
.L475:
.L488:
	nop
.L476:
	mov	DWORD PTR 32[rsp], 0
	mov	r9d, 0
	mov	r8d, -1
	mov	edx, 2
	mov	ecx, 2
	call	fb_Locate
	mov	edx, 15
	lea	rcx, .LC29[rip]
	call	fb_StrAllocTempDescZEx
	mov	QWORD PTR -80[rbp], rax
	mov	rax, QWORD PTR -80[rbp]
	mov	r8d, 0
	mov	rdx, rax
	mov	ecx, 0
	call	fb_PrintString
	mov	r8d, 1
	mov	edx, 2000
	mov	ecx, 0
	call	fb_PrintLongint
	mov	DWORD PTR 32[rsp], 0
	mov	r9d, 0
	mov	r8d, -1
	mov	edx, 2
	mov	ecx, 4
	call	fb_Locate
	mov	edx, 15
	lea	rcx, .LC30[rip]
	call	fb_StrAllocTempDescZEx
	mov	QWORD PTR -88[rbp], rax
	mov	rax, QWORD PTR -88[rbp]
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
	leave
	ret
.L477:
	.globl	_ZN14SIMULATIONTYPE9CHECKPAIREP12PARTICLETYPES1_
	.def	_ZN14SIMULATIONTYPE9CHECKPAIREP12PARTICLETYPES1_;	.scl	2;	.type	32;	.endef
_ZN14SIMULATIONTYPE9CHECKPAIREP12PARTICLETYPES1_:
	push	rbp
	mov	rbp, rsp
	add	rsp, -128
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
	mov	QWORD PTR 32[rbp], r8
.L491:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 40
	mov	rax, QWORD PTR [rax]
	cmp	rax, 23999
	jg	.L507
	nop
.L493:
	mov	rax, QWORD PTR 24[rbp]
	lea	rdx, 8[rax]
	mov	rax, QWORD PTR 32[rbp]
	add	rax, 8
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
	jnb	.L508
	jmp	.L494
.L508:
	nop
.L497:
	lea	rax, -64[rbp]
	add	rax, 4
	movss	xmm1, DWORD PTR [rax]
	movss	xmm0, DWORD PTR .LC1[rip]
	andps	xmm0, xmm1
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 48
	movss	xmm1, DWORD PTR [rax]
	ucomiss	xmm1, xmm0
	jnb	.L509
	jmp	.L494
.L509:
	nop
.L500:
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
	jnb	.L510
	jmp	.L494
.L510:
	nop
.L503:
	movss	xmm0, DWORD PTR -8[rbp]
	ucomiss	xmm0, DWORD PTR .LC31[rip]
	jnb	.L511
	jmp	.L494
.L511:
	nop
.L506:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 40
	mov	rdx, QWORD PTR 16[rbp]
	add	rdx, 40
	mov	rdx, QWORD PTR [rdx]
	add	rdx, 1
	mov	QWORD PTR [rax], rdx
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 40
	mov	rdx, QWORD PTR [rax]
	mov	rax, rdx
	sal	rax, 2
	add	rax, rdx
	sal	rax, 3
	lea	rdx, 56048[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, rdx
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -16[rbp]
	lea	rdx, 24[rax]
	mov	rax, QWORD PTR 24[rbp]
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR -16[rbp]
	lea	rdx, 32[rax]
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
	movss	xmm0, DWORD PTR -8[rbp]
	lea	rax, -64[rbp]
	movaps	xmm1, xmm0
	mov	rcx, rax
	call	_ZdvRK4VEC2f
	mov	QWORD PTR -96[rbp], rax
	mov	rax, QWORD PTR -96[rbp]
	mov	QWORD PTR -48[rbp], rax
	mov	rax, QWORD PTR -16[rbp]
	lea	rcx, 16[rax]
	lea	rax, -48[rbp]
	mov	rdx, rax
	call	_ZN4VEC2aSERKS_
	mov	rax, QWORD PTR 24[rbp]
	lea	rdx, 24[rax]
	mov	rax, QWORD PTR 24[rbp]
	add	rax, 24
	movss	xmm1, DWORD PTR [rax]
	mov	rax, QWORD PTR -16[rbp]
	movss	xmm0, DWORD PTR [rax]
	addss	xmm0, xmm1
	movss	DWORD PTR [rdx], xmm0
	mov	rax, QWORD PTR 32[rbp]
	lea	rdx, 24[rax]
	mov	rax, QWORD PTR 32[rbp]
	add	rax, 24
	movss	xmm1, DWORD PTR [rax]
	mov	rax, QWORD PTR -16[rbp]
	movss	xmm0, DWORD PTR [rax]
	addss	xmm0, xmm1
	movss	DWORD PTR [rdx], xmm0
	jmp	.L494
.L507:
	nop
.L494:
	nop
	leave
	ret
	.globl	_ZN14SIMULATIONTYPE19COMPUTEREUSABLEDATAEv
	.def	_ZN14SIMULATIONTYPE19COMPUTEREUSABLEDATAEv;	.scl	2;	.type	32;	.endef
_ZN14SIMULATIONTYPE19COMPUTEREUSABLEDATAEv:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 96
	mov	QWORD PTR 16[rbp], rcx
.L513:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 56088
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 40
	mov	rdx, QWORD PTR [rax]
	mov	rax, rdx
	sal	rax, 2
	add	rax, rdx
	sal	rax, 3
	lea	rdx, 56048[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, rdx
	mov	QWORD PTR -16[rbp], rax
	jmp	.L514
.L520:
	nop
.L515:
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	lea	rdx, 16[rax]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 32
	mov	rax, QWORD PTR [rax]
	add	rax, 16
	mov	rcx, rax
	call	_ZmiRK4VEC2S1_
	mov	QWORD PTR -64[rbp], rax
	mov	rax, QWORD PTR -64[rbp]
	mov	QWORD PTR -48[rbp], rax
	mov	rax, QWORD PTR -8[rbp]
	lea	rcx, 16[rax]
	lea	rax, -48[rbp]
	mov	rdx, rax
	call	_ZNK4VEC23DOTERKS_
	movd	eax, xmm0
	mov	DWORD PTR -20[rbp], eax
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 8
	movss	xmm0, DWORD PTR -20[rbp]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR -8[rbp]
	movss	xmm1, DWORD PTR [rax]
	mov	rax, QWORD PTR -8[rbp]
	movss	xmm0, DWORD PTR [rax]
	mulss	xmm0, xmm1
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 24
	movss	xmm1, DWORD PTR [rax]
	mulss	xmm0, xmm1
	movss	DWORD PTR -24[rbp], xmm0
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	add	rax, 24
	movss	xmm1, DWORD PTR [rax]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 32
	mov	rax, QWORD PTR [rax]
	add	rax, 24
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
	movss	DWORD PTR -28[rbp], xmm0
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 8
	movss	xmm1, DWORD PTR [rax]
	movss	xmm0, DWORD PTR .LC2[rip]
	xorps	xmm0, xmm1
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 20
	movss	xmm1, DWORD PTR [rax]
	mulss	xmm0, xmm1
	movss	DWORD PTR -32[rbp], xmm0
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 12
	movss	xmm0, DWORD PTR -24[rbp]
	addss	xmm0, DWORD PTR -28[rbp]
	addss	xmm0, DWORD PTR -32[rbp]
	movss	DWORD PTR [rax], xmm0
.L516:
	add	QWORD PTR -8[rbp], 40
.L514:
	mov	rax, QWORD PTR -8[rbp]
	cmp	rax, QWORD PTR -16[rbp]
	jbe	.L520
.L517:
.L518:
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
.L522:
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
.L523:
	.globl	_ZN14SIMULATIONTYPE11UPDATEMOUSEEv
	.def	_ZN14SIMULATIONTYPE11UPDATEMOUSEEv;	.scl	2;	.type	32;	.endef
_ZN14SIMULATIONTYPE11UPDATEMOUSEEv:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 624
	mov	QWORD PTR 16[rbp], rcx
.L525:
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 1528992[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 1529000
	mov	rcx, rax
	call	_ZN4VEC2aSERKS_
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 1529024[rax]
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 1529016[rax]
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 1529040[rax]
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 1529032[rax]
	mov	QWORD PTR [rdx], rax
	mov	QWORD PTR -104[rbp], 0
	mov	QWORD PTR -112[rbp], 0
	mov	QWORD PTR -88[rbp], 0
	mov	rax, QWORD PTR 16[rbp]
	lea	r9, 1529016[rax]
	mov	rax, QWORD PTR 16[rbp]
	lea	r8, 1529032[rax]
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
	lea	rcx, 1528992[rax]
	lea	rax, -96[rbp]
	mov	rdx, rax
	call	_ZN4VEC2aSERKS_
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 1529008
	mov	rdx, QWORD PTR 16[rbp]
	add	rdx, 1528992
	movss	xmm0, DWORD PTR [rdx]
	mov	rdx, QWORD PTR 16[rbp]
	add	rdx, 1529000
	movss	xmm1, DWORD PTR [rdx]
	subss	xmm0, xmm1
	movss	xmm1, DWORD PTR .LC32[rip]
	mulss	xmm0, xmm1
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 1529012
	mov	rdx, QWORD PTR 16[rbp]
	add	rdx, 1528996
	movss	xmm0, DWORD PTR [rdx]
	mov	rdx, QWORD PTR 16[rbp]
	add	rdx, 1529004
	movss	xmm1, DWORD PTR [rdx]
	subss	xmm0, xmm1
	movss	xmm1, DWORD PTR .LC32[rip]
	mulss	xmm0, xmm1
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 1529016
	mov	rax, QWORD PTR [rax]
	cmp	rax, 1
	jne	.L569
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 72[rax]
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 80[rax]
	mov	QWORD PTR -32[rbp], rax
	jmp	.L528
.L573:
	nop
.L529:
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 1528992[rax]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 8
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
	movss	xmm1, DWORD PTR .LC33[rip]
	ucomiss	xmm1, xmm0
	jnb	.L570
	jmp	.L540
.L570:
	nop
.L532:
	lea	rax, -208[rbp]
	add	rax, 4
	movss	xmm1, DWORD PTR [rax]
	movss	xmm0, DWORD PTR .LC1[rip]
	andps	xmm0, xmm1
	movss	xmm1, DWORD PTR .LC33[rip]
	ucomiss	xmm1, xmm0
	jnb	.L571
	jmp	.L540
.L571:
	nop
.L536:
	lea	rax, -208[rbp]
	mov	rcx, rax
	call	_ZNK4VEC213LENGTHSQUAREDEv
	movd	eax, xmm0
	mov	DWORD PTR -36[rbp], eax
	movss	xmm0, DWORD PTR -36[rbp]
	movss	DWORD PTR -40[rbp], xmm0
	movss	xmm0, DWORD PTR .LC34[rip]
	ucomiss	xmm0, DWORD PTR -40[rbp]
	jnb	.L572
	jmp	.L540
.L572:
	nop
.L539:
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 1529008[rax]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 16
	mov	rcx, rax
	call	_ZmiRK4VEC2S1_
	mov	QWORD PTR -240[rbp], rax
	mov	rax, QWORD PTR -240[rbp]
	mov	QWORD PTR -144[rbp], rax
	lea	rax, -144[rbp]
	movss	xmm1, DWORD PTR .LC32[rip]
	mov	rcx, rax
	call	_ZmlRK4VEC2f
	mov	QWORD PTR -256[rbp], rax
	mov	rax, QWORD PTR -256[rbp]
	mov	QWORD PTR -160[rbp], rax
	movss	xmm0, DWORD PTR -40[rbp]
	movss	xmm1, DWORD PTR .LC34[rip]
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
	movss	xmm1, DWORD PTR .LC24[rip]
	mov	rcx, rax
	call	_ZmlRK4VEC2f
	mov	QWORD PTR -288[rbp], rax
	mov	rax, QWORD PTR -288[rbp]
	mov	QWORD PTR -192[rbp], rax
	lea	rdx, -192[rbp]
	mov	rax, QWORD PTR -8[rbp]
	mov	rcx, rax
	call	_ZN4VEC2mIERKS_
.L540:
	add	QWORD PTR -8[rbp], 28
.L528:
	mov	rax, QWORD PTR -8[rbp]
	cmp	rax, QWORD PTR -32[rbp]
	jbe	.L573
	jmp	.L542
.L527:
.L541:
.L569:
	nop
.L542:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 1529016
	mov	rax, QWORD PTR [rax]
	cmp	rax, 2
	jne	.L574
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 72[rax]
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 80[rax]
	mov	QWORD PTR -48[rbp], rax
	jmp	.L545
.L575:
	nop
.L546:
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 1528992[rax]
	mov	rax, QWORD PTR -16[rbp]
	add	rax, 8
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
	movss	xmm1, DWORD PTR .LC35[rip]
	mov	rcx, rax
	call	_ZmlRK4VEC2f
	mov	QWORD PTR -400[rbp], rax
	mov	rax, QWORD PTR -400[rbp]
	mov	QWORD PTR -336[rbp], rax
	lea	rdx, -336[rbp]
	mov	rax, QWORD PTR -16[rbp]
	mov	rcx, rax
	call	_ZN4VEC2pLERKS_
.L547:
	add	QWORD PTR -16[rbp], 28
.L545:
	mov	rax, QWORD PTR -16[rbp]
	cmp	rax, QWORD PTR -48[rbp]
	jbe	.L575
	jmp	.L549
.L544:
.L548:
.L574:
	nop
.L549:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 1529032
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 1529040
	mov	rax, QWORD PTR [rax]
	cmp	rdx, rax
	je	.L576
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 72[rax]
	mov	QWORD PTR -24[rbp], rax
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 80[rax]
	mov	QWORD PTR -64[rbp], rax
	jmp	.L552
.L568:
.L553:
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 1528992[rax]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, 8
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
	ucomiss	xmm0, DWORD PTR .LC31[rip]
	jnb	.L577
	jmp	.L561
.L577:
	nop
.L556:
	lea	rax, -496[rbp]
	add	rax, 4
	movss	xmm1, DWORD PTR [rax]
	movss	xmm0, DWORD PTR .LC1[rip]
	andps	xmm0, xmm1
	ucomiss	xmm0, DWORD PTR .LC31[rip]
	jnb	.L578
	jmp	.L561
.L578:
	nop
.L560:
	lea	rax, -496[rbp]
	mov	rcx, rax
	call	_ZNK4VEC213LENGTHSQUAREDEv
	movd	eax, xmm0
	mov	DWORD PTR -68[rbp], eax
	movss	xmm0, DWORD PTR -68[rbp]
	movss	DWORD PTR -72[rbp], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 1529032
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 1529040
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
	movss	xmm1, DWORD PTR .LC35[rip]
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
	lea	rdx, -480[rbp]
	mov	rax, QWORD PTR -24[rbp]
	mov	rcx, rax
	call	_ZN4VEC2pLERKS_
.L561:
	add	QWORD PTR -24[rbp], 28
.L552:
	mov	rax, QWORD PTR -24[rbp]
	cmp	rax, QWORD PTR -64[rbp]
	ja	.L579
	jmp	.L568
.L551:
.L562:
.L563:
.L576:
	nop
.L564:
.L579:
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
.L581:
.L582:
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
.L585:
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
	movss	xmm0, DWORD PTR 24[rax]
	movss	DWORD PTR [rdx], xmm0
	nop
	leave
	ret
.L586:
	.def	_ZN16PARTICLEPAIRTYPEaSERKS_;	.scl	3;	.type	32;	.endef
_ZN16PARTICLEPAIRTYPEaSERKS_:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
.L588:
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
	nop
	leave
	ret
.L589:
	.def	_ZN9FLUIDTYPEaSERKS_;	.scl	3;	.type	32;	.endef
_ZN9FLUIDTYPEaSERKS_:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 80
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
.L591:
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
.L592:
	mov	rdx, QWORD PTR -24[rbp]
	mov	rax, QWORD PTR -16[rbp]
	mov	rcx, rax
	call	_ZN12PARTICLETYPEaSERKS_
	add	QWORD PTR -16[rbp], 28
	add	QWORD PTR -24[rbp], 28
	add	QWORD PTR -8[rbp], 1
	cmp	QWORD PTR -8[rbp], 2000
	je	.L593
	jmp	.L592
.L593:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 56072
	mov	QWORD PTR -40[rbp], rax
	mov	rax, QWORD PTR 24[rbp]
	add	rax, 56072
	mov	QWORD PTR -48[rbp], rax
	mov	QWORD PTR -32[rbp], 0
.L594:
	mov	rdx, QWORD PTR -48[rbp]
	mov	rax, QWORD PTR -40[rbp]
	mov	rcx, rax
	call	_ZN16PARTICLEPAIRTYPEaSERKS_
	add	QWORD PTR -40[rbp], 40
	add	QWORD PTR -48[rbp], 40
	add	QWORD PTR -32[rbp], 1
	cmp	QWORD PTR -32[rbp], 24000
	je	.L596
	jmp	.L594
.L595:
.L596:
	nop
	leave
	ret
	.def	_ZN8GRIDTYPEaSERKS_;	.scl	3;	.type	32;	.endef
_ZN8GRIDTYPEaSERKS_:
	push	rbp
	mov	rbp, rsp
	push	rdi
	push	rsi
	sub	rsp, 48
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
.L598:
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
	mov	QWORD PTR -32[rbp], rax
	mov	rax, QWORD PTR 24[rbp]
	add	rax, 64
	mov	QWORD PTR -40[rbp], rax
	mov	QWORD PTR -24[rbp], 0
.L599:
	mov	rax, QWORD PTR -32[rbp]
	mov	rdx, QWORD PTR -40[rbp]
	mov	ecx, 264
	mov	r8, QWORD PTR [rdx]
	mov	QWORD PTR [rax], r8
	mov	r8d, ecx
	add	r8, rax
	lea	r9, 8[r8]
	mov	r8d, ecx
	add	r8, rdx
	add	r8, 8
	mov	r8, QWORD PTR -16[r8]
	mov	QWORD PTR -16[r9], r8
	lea	r8, 8[rax]
	and	r8, -8
	sub	rax, r8
	sub	rdx, rax
	add	ecx, eax
	and	ecx, -8
	mov	eax, ecx
	shr	eax, 3
	mov	eax, eax
	mov	rdi, r8
	mov	rsi, rdx
	mov	rcx, rax
	rep movsq
	add	QWORD PTR -32[rbp], 264
	add	QWORD PTR -40[rbp], 264
	add	QWORD PTR -24[rbp], 1
	cmp	QWORD PTR -24[rbp], 1512
	je	.L600
	jmp	.L599
.L600:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 399232
	mov	QWORD PTR -56[rbp], rax
	mov	rax, QWORD PTR 24[rbp]
	add	rax, 399232
	mov	QWORD PTR -64[rbp], rax
	mov	QWORD PTR -48[rbp], 0
.L601:
	mov	rax, QWORD PTR -64[rbp]
	mov	rdx, QWORD PTR 8[rax]
	mov	rax, QWORD PTR [rax]
	mov	rcx, QWORD PTR -56[rbp]
	mov	QWORD PTR [rcx], rax
	mov	QWORD PTR 8[rcx], rdx
	add	QWORD PTR -56[rbp], 16
	add	QWORD PTR -64[rbp], 16
	add	QWORD PTR -48[rbp], 1
	cmp	QWORD PTR -48[rbp], 7103
	je	.L603
	jmp	.L601
.L602:
.L603:
	nop
	add	rsp, 48
	pop	rsi
	pop	rdi
	pop	rbp
	ret
	.def	_ZN9MOUSETYPEaSERKS_;	.scl	3;	.type	32;	.endef
_ZN9MOUSETYPEaSERKS_:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
.L605:
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
.L606:
	.def	_ZN14SIMULATIONTYPEaSERKS_;	.scl	3;	.type	32;	.endef
_ZN14SIMULATIONTYPEaSERKS_:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
.L608:
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
	lea	rdx, 1016088[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 1016088
	mov	rcx, rax
	call	_ZN8GRIDTYPEaSERKS_
	mov	rax, QWORD PTR 24[rbp]
	lea	rdx, 1528968[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 1528968
	mov	rcx, QWORD PTR [rdx]
	mov	QWORD PTR [rax], rcx
	mov	rcx, QWORD PTR 8[rdx]
	mov	QWORD PTR 8[rax], rcx
	mov	rdx, QWORD PTR 16[rdx]
	mov	QWORD PTR 16[rax], rdx
	mov	rax, QWORD PTR 24[rbp]
	lea	rdx, 1528992[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 1528992
	mov	rcx, rax
	call	_ZN9MOUSETYPEaSERKS_
	nop
	leave
	ret
.L609:
	.def	_GLOBAL__I;	.scl	3;	.type	32;	.endef
_GLOBAL__I:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
.L611:
	lea	rcx, SIMULATION$[rip]
	call	_ZN14SIMULATIONTYPEC1Ev
	nop
	leave
	ret
.L612:
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
	.long	1178304512
	.align 4
.LC8:
	.long	1097859072
	.align 4
.LC9:
	.long	1053609165
	.align 4
.LC10:
	.long	970045207
	.align 4
.LC11:
	.long	1025758986
	.align 8
.LC12:
	.long	0
	.long	1071644672
	.align 8
.LC13:
	.long	0
	.long	1078181888
	.align 8
.LC14:
	.long	0
	.long	1082639360
	.align 8
.LC15:
	.long	-755914244
	.long	1062232653
	.align 4
.LC16:
	.long	1092616192
	.align 4
.LC17:
	.long	1111228416
	.align 4
.LC18:
	.long	1112014848
	.align 4
.LC19:
	.long	1158864896
	.align 4
.LC20:
	.long	1153572864
	.align 4
.LC21:
	.long	1201121536
	.align 4
.LC22:
	.long	1144799232
	.align 4
.LC23:
	.long	1192432128
	.align 4
.LC24:
	.long	1008981770
	.align 4
.LC25:
	.long	1145569280
	.align 4
.LC26:
	.long	1153957888
	.align 4
.LC27:
	.long	1024528657
	.align 4
.LC28:
	.long	1073741824
	.align 4
.LC31:
	.long	1082130432
	.align 4
.LC32:
	.long	1120403456
	.align 4
.LC33:
	.long	1107296256
	.align 4
.LC34:
	.long	1149239296
	.align 4
.LC35:
	.long	1167867904
	.ident	"GCC: (x86_64-win32-sjlj-rev0, Built by MinGW-W64 project) 5.2.0"
	.def	fb_Rnd;	.scl	2;	.type	32;	.endef
	.def	sinf;	.scl	2;	.type	32;	.endef
	.def	cosf;	.scl	2;	.type	32;	.endef
	.def	sin;	.scl	2;	.type	32;	.endef
	.def	cos;	.scl	2;	.type	32;	.endef
	.def	atan2f;	.scl	2;	.type	32;	.endef
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
