	.file	"Memory_management_type_07.c"
	.intel_syntax noprefix
	.text
	.globl	_ZN3UDTC1Ev
	.def	_ZN3UDTC1Ev;	.scl	2;	.type	32;	.endef
_ZN3UDTC1Ev:
	push	rbp
	mov	rbp, rsp
	mov	QWORD PTR 16[rbp], rcx
.L2:
	mov	rax, QWORD PTR 16[rbp]
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	mov	QWORD PTR [rax], 0
	nop
	pop	rbp
	ret
.L3:
	.globl	_ZN3UDTC1Eu7INTEGER
	.def	_ZN3UDTC1Eu7INTEGER;	.scl	2;	.type	32;	.endef
_ZN3UDTC1Eu7INTEGER:
	push	rbp
	mov	rbp, rsp
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
.L5:
	mov	rax, QWORD PTR 16[rbp]
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	mov	rdx, QWORD PTR 24[rbp]
	mov	QWORD PTR [rax], rdx
	nop
	pop	rbp
	ret
.L6:
	.globl	_ZN8UDTARRAYC1Ev
	.def	_ZN8UDTARRAYC1Ev;	.scl	2;	.type	32;	.endef
_ZN8UDTARRAYC1Ev:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR 16[rbp], rcx
.L8:
	mov	rax, QWORD PTR 16[rbp]
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 8
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 16
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 24
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 32
	mov	QWORD PTR [rax], 0
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZN8UDTARRAY5CLEAREv
	nop
	leave
	ret
.L9:
	.globl	_ZN8UDTARRAYC1ERS_
	.def	_ZN8UDTARRAYC1ERS_;	.scl	2;	.type	32;	.endef
_ZN8UDTARRAYC1ERS_:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
.L11:
	mov	rax, QWORD PTR 16[rbp]
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 8
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 16
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 24
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 32
	mov	QWORD PTR [rax], 0
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZN8UDTARRAY5CLEAREv
	mov	rax, QWORD PTR 24[rbp]
	mov	rdx, rax
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZN8UDTARRAYaSERS_
	nop
	leave
	ret
.L12:
	.globl	_ZN8UDTARRAYD1Ev
	.def	_ZN8UDTARRAYD1Ev;	.scl	2;	.type	32;	.endef
_ZN8UDTARRAYD1Ev:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR 16[rbp], rcx
.L14:
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZN8UDTARRAY5CLEAREv
	nop
	leave
	ret
.L15:
	.globl	_ZN8UDTARRAYaSERS_
	.def	_ZN8UDTARRAYaSERS_;	.scl	2;	.type	32;	.endef
_ZN8UDTARRAYaSERS_:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 80
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
.L17:
	mov	rax, QWORD PTR 16[rbp]
	cmp	rax, QWORD PTR 24[rbp]
	je	.L28
	mov	rax, QWORD PTR 24[rbp]
	mov	rcx, rax
	call	_ZN8UDTARRAY8CAPACITYEv
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -16[rbp]
	mov	rdx, rax
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZN8UDTARRAY7RESERVEEu7INTEGER
	mov	rax, QWORD PTR 24[rbp]
	mov	rcx, rax
	call	_ZN8UDTARRAY5FRONTEv
	mov	QWORD PTR -24[rbp], rax
	mov	rax, QWORD PTR -24[rbp]
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR 24[rbp]
	mov	rcx, rax
	call	_ZN8UDTARRAY4BACKEv
	mov	QWORD PTR -32[rbp], rax
	mov	rax, QWORD PTR -32[rbp]
	mov	QWORD PTR -40[rbp], rax
	jmp	.L20
.L27:
.L21:
	mov	rax, QWORD PTR -8[rbp]
	mov	rdx, rax
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZN8UDTARRAY9PUSH_BACKER3UDT
.L22:
	add	QWORD PTR -8[rbp], 8
.L20:
	mov	rax, QWORD PTR -8[rbp]
	cmp	rax, QWORD PTR -40[rbp]
	ja	.L29
	jmp	.L27
.L19:
.L23:
.L24:
.L28:
	nop
.L25:
.L29:
	nop
	leave
	ret
	.globl	_ZN8UDTARRAYixEu7INTEGER
	.def	_ZN8UDTARRAYixEu7INTEGER;	.scl	2;	.type	32;	.endef
_ZN8UDTARRAYixEu7INTEGER:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
	mov	QWORD PTR -8[rbp], 0
.L31:
	mov	rax, QWORD PTR 24[rbp]
	not	rax
	shr	rax, 63
	movzx	eax, al
	neg	eax
	mov	edx, eax
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR [rax]
	cmp	rax, QWORD PTR 24[rbp]
	setg	al
	movzx	eax, al
	neg	eax
	and	eax, edx
	test	eax, eax
	je	.L37
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 32
	mov	rax, QWORD PTR [rax]
	mov	rdx, QWORD PTR 24[rbp]
	sal	rdx, 3
	add	rax, rdx
	mov	QWORD PTR -8[rbp], rax
	nop
	jmp	.L35
.L33:
.L34:
.L37:
	nop
.L35:
	mov	rax, QWORD PTR -8[rbp]
	leave
	ret
	.globl	_ZN8UDTARRAY9PUSH_BACKER3UDT
	.def	_ZN8UDTARRAY9PUSH_BACKER3UDT;	.scl	2;	.type	32;	.endef
_ZN8UDTARRAY9PUSH_BACKER3UDT:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
	mov	QWORD PTR -8[rbp], 0
.L39:
	mov	rax, QWORD PTR 16[rbp]
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	cmp	rdx, rax
	jge	.L46
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 16[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 32
	mov	rcx, QWORD PTR [rax]
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR [rax]
	sal	rax, 3
	add	rax, rcx
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	mov	rdx, QWORD PTR 24[rbp]
	mov	rdx, QWORD PTR [rdx]
	mov	QWORD PTR [rax], rdx
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR [rax]
	lea	rdx, 1[rax]
	mov	rax, QWORD PTR 16[rbp]
	mov	QWORD PTR [rax], rdx
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 16[rax]
	mov	QWORD PTR -8[rbp], rax
	jmp	.L43
.L46:
	nop
.L41:
	mov	QWORD PTR -8[rbp], 0
	nop
.L42:
.L43:
	mov	rax, QWORD PTR -8[rbp]
	leave
	ret
	.globl	_ZN8UDTARRAY4SIZEEv
	.def	_ZN8UDTARRAY4SIZEEv;	.scl	2;	.type	32;	.endef
_ZN8UDTARRAY4SIZEEv:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR -8[rbp], 0
.L48:
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR [rax]
	mov	QWORD PTR -8[rbp], rax
	nop
.L49:
	mov	rax, QWORD PTR -8[rbp]
	leave
	ret
	.globl	_ZN8UDTARRAY8CAPACITYEv
	.def	_ZN8UDTARRAY8CAPACITYEv;	.scl	2;	.type	32;	.endef
_ZN8UDTARRAY8CAPACITYEv:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR -8[rbp], 0
.L52:
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 8[rax]
	mov	QWORD PTR -8[rbp], rax
	nop
.L53:
	mov	rax, QWORD PTR -8[rbp]
	leave
	ret
	.globl	_ZN8UDTARRAY4BACKEv
	.def	_ZN8UDTARRAY4BACKEv;	.scl	2;	.type	32;	.endef
_ZN8UDTARRAY4BACKEv:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR -8[rbp], 0
.L56:
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 16[rax]
	mov	QWORD PTR -8[rbp], rax
	nop
.L57:
	mov	rax, QWORD PTR -8[rbp]
	leave
	ret
	.globl	_ZN8UDTARRAY5FRONTEv
	.def	_ZN8UDTARRAY5FRONTEv;	.scl	2;	.type	32;	.endef
_ZN8UDTARRAY5FRONTEv:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR -8[rbp], 0
.L60:
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 24[rax]
	mov	QWORD PTR -8[rbp], rax
	nop
.L61:
	mov	rax, QWORD PTR -8[rbp]
	leave
	ret
	.globl	_ZN8UDTARRAY6REMOVEEu7INTEGER
	.def	_ZN8UDTARRAY6REMOVEEu7INTEGER;	.scl	2;	.type	32;	.endef
_ZN8UDTARRAY6REMOVEEu7INTEGER:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 96
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
.L64:
	mov	rax, QWORD PTR 24[rbp]
	not	rax
	shr	rax, 63
	movzx	eax, al
	neg	eax
	mov	edx, eax
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR [rax]
	cmp	rax, QWORD PTR 24[rbp]
	setg	al
	movzx	eax, al
	neg	eax
	and	eax, edx
	test	eax, eax
	je	.L76
	lea	rax, -64[rbp]
	mov	rcx, rax
	call	_ZN8UDTARRAYC1Ev
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR [rax]
	lea	rdx, -1[rax]
	lea	rax, -64[rbp]
	mov	rcx, rax
	call	_ZN8UDTARRAY7RESERVEEu7INTEGER
	mov	QWORD PTR -8[rbp], 0
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR [rax]
	sub	rax, 1
	mov	QWORD PTR -16[rbp], rax
	jmp	.L67
.L78:
	nop
.L68:
	mov	rax, QWORD PTR -8[rbp]
	cmp	rax, QWORD PTR 24[rbp]
	je	.L77
	mov	rax, QWORD PTR -8[rbp]
	mov	rdx, rax
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZN8UDTARRAYixEu7INTEGER
	mov	QWORD PTR -24[rbp], rax
	mov	rdx, QWORD PTR -24[rbp]
	lea	rax, -64[rbp]
	mov	rcx, rax
	call	_ZN8UDTARRAY9PUSH_BACKER3UDT
	jmp	.L71
.L70:
.L77:
	nop
.L71:
	add	QWORD PTR -8[rbp], 1
.L67:
	mov	rax, QWORD PTR -8[rbp]
	cmp	rax, QWORD PTR -16[rbp]
	jle	.L78
.L72:
	lea	rax, -64[rbp]
	mov	rdx, rax
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZN8UDTARRAYaSERS_
	lea	rax, -64[rbp]
	mov	rcx, rax
	call	_ZN8UDTARRAYD1Ev
	jmp	.L74
.L66:
.L73:
.L76:
	nop
.L74:
	nop
	leave
	ret
	.globl	_ZN8UDTARRAY6REMOVEEP3UDT
	.def	_ZN8UDTARRAY6REMOVEEP3UDT;	.scl	2;	.type	32;	.endef
_ZN8UDTARRAY6REMOVEEP3UDT:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 64
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
.L80:
	mov	QWORD PTR -8[rbp], 0
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR [rax]
	sub	rax, 1
	mov	QWORD PTR -16[rbp], rax
	jmp	.L81
.L92:
	nop
.L82:
	mov	rax, QWORD PTR -8[rbp]
	mov	rdx, rax
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZN8UDTARRAYixEu7INTEGER
	mov	QWORD PTR -24[rbp], rax
	mov	rax, QWORD PTR 24[rbp]
	cmp	rax, QWORD PTR -24[rbp]
	jne	.L91
	mov	rax, QWORD PTR -8[rbp]
	mov	rdx, rax
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZN8UDTARRAY6REMOVEEu7INTEGER
	nop
.L88:
	jmp	.L93
.L85:
.L84:
.L86:
.L91:
	nop
.L87:
	add	QWORD PTR -8[rbp], 1
.L81:
	mov	rax, QWORD PTR -8[rbp]
	cmp	rax, QWORD PTR -16[rbp]
	jle	.L92
.L93:
	nop
	leave
	ret
	.globl	_ZN8UDTARRAY7RESERVEEu7INTEGER
	.def	_ZN8UDTARRAY7RESERVEEu7INTEGER;	.scl	2;	.type	32;	.endef
_ZN8UDTARRAY7RESERVEEu7INTEGER:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 64
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
.L95:
	cmp	QWORD PTR 24[rbp], 0
	jle	.L102
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZN8UDTARRAY5CLEAREv
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 8[rax]
	mov	rax, QWORD PTR 24[rbp]
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR 16[rbp]
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	sal	rax, 3
	mov	rcx, rax
	call	malloc
	mov	QWORD PTR -24[rbp], rax
	mov	rax, QWORD PTR -24[rbp]
	mov	QWORD PTR -32[rbp], rax
	mov	rax, QWORD PTR -32[rbp]
	mov	QWORD PTR -16[rbp], rax
	mov	QWORD PTR -8[rbp], 0
.L98:
	mov	rax, QWORD PTR -16[rbp]
	mov	rcx, rax
	call	_ZN3UDTC1Ev
	add	QWORD PTR -16[rbp], 8
	add	QWORD PTR -8[rbp], 1
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 8
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR -8[rbp]
	cmp	rdx, rax
	je	.L99
	jmp	.L98
.L99:
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 32[rax]
	mov	rax, QWORD PTR -32[rbp]
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 16[rax]
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 32[rax]
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 24[rax]
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 32[rax]
	mov	QWORD PTR [rdx], rax
	jmp	.L101
.L97:
.L100:
.L102:
	nop
.L101:
	nop
	leave
	ret
	.globl	_ZN8UDTARRAY6RESIZEEu7INTEGER
	.def	_ZN8UDTARRAY6RESIZEEu7INTEGER;	.scl	2;	.type	32;	.endef
_ZN8UDTARRAY6RESIZEEu7INTEGER:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 112
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
.L104:
	lea	rax, -80[rbp]
	mov	rcx, rax
	call	_ZN8UDTARRAYC1Ev
	mov	rdx, QWORD PTR 24[rbp]
	lea	rax, -80[rbp]
	mov	rcx, rax
	call	_ZN8UDTARRAY7RESERVEEu7INTEGER
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZN8UDTARRAY5FRONTEv
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -16[rbp]
	mov	QWORD PTR -8[rbp], rax
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZN8UDTARRAY4BACKEv
	mov	QWORD PTR -24[rbp], rax
	mov	rax, QWORD PTR -24[rbp]
	mov	QWORD PTR -32[rbp], rax
	jmp	.L105
.L111:
	nop
.L106:
	mov	rdx, QWORD PTR -8[rbp]
	lea	rax, -80[rbp]
	mov	rcx, rax
	call	_ZN8UDTARRAY9PUSH_BACKER3UDT
.L107:
	add	QWORD PTR -8[rbp], 8
.L105:
	mov	rax, QWORD PTR -8[rbp]
	cmp	rax, QWORD PTR -32[rbp]
	jbe	.L111
.L108:
	lea	rax, -80[rbp]
	mov	rdx, rax
	mov	rcx, QWORD PTR 16[rbp]
	call	_ZN8UDTARRAYaSERS_
	lea	rax, -80[rbp]
	mov	rcx, rax
	call	_ZN8UDTARRAYD1Ev
	nop
	leave
	ret
.L109:
	.globl	_ZN8UDTARRAY5CLEAREv
	.def	_ZN8UDTARRAY5CLEAREv;	.scl	2;	.type	32;	.endef
_ZN8UDTARRAY5CLEAREv:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR 16[rbp], rcx
.L113:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 32
	mov	rax, QWORD PTR [rax]
	test	rax, rax
	je	.L117
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 32
	mov	rax, QWORD PTR [rax]
	mov	rcx, rax
	call	free
	jmp	.L115
.L117:
	nop
.L115:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 32
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 8
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 16
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 24
	mov	QWORD PTR [rax], 0
	nop
	leave
	ret
.L116:
	.globl	_ZN8UDTARRAY7SHUFFLEEv
	.def	_ZN8UDTARRAY7SHUFFLEEv;	.scl	2;	.type	32;	.endef
_ZN8UDTARRAY7SHUFFLEEv:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 64
	mov	QWORD PTR 16[rbp], rcx
.L119:
	mov	rax, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR [rax]
	sub	rax, 1
	mov	QWORD PTR -8[rbp], rax
	jmp	.L120
.L126:
	nop
.L121:
	movss	xmm0, DWORD PTR .LC0[rip]
	call	fb_Rnd
	movq	rax, xmm0
	mov	QWORD PTR -16[rbp], rax
	pxor	xmm0, xmm0
	cvtsi2sdq	xmm0, QWORD PTR -8[rbp]
	mulsd	xmm0, QWORD PTR -16[rbp]
	call	nearbyint
	cvttsd2si	rax, xmm0
	mov	QWORD PTR -24[rbp], rax
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 32
	mov	rax, QWORD PTR [rax]
	mov	rdx, QWORD PTR -8[rbp]
	sal	rdx, 3
	add	rax, rdx
	mov	rax, QWORD PTR [rax]
	mov	QWORD PTR -32[rbp], rax
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 32
	mov	rax, QWORD PTR [rax]
	mov	rdx, QWORD PTR -24[rbp]
	sal	rdx, 3
	add	rax, rdx
	mov	rdx, QWORD PTR 16[rbp]
	add	rdx, 32
	mov	rdx, QWORD PTR [rdx]
	mov	rcx, QWORD PTR -8[rbp]
	sal	rcx, 3
	add	rdx, rcx
	mov	rax, QWORD PTR [rax]
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 32
	mov	rax, QWORD PTR [rax]
	mov	rdx, QWORD PTR -24[rbp]
	sal	rdx, 3
	add	rdx, rax
	mov	rax, QWORD PTR -32[rbp]
	mov	QWORD PTR [rdx], rax
.L122:
	sub	QWORD PTR -8[rbp], 1
.L120:
	cmp	QWORD PTR -8[rbp], 0
	jg	.L126
.L123:
.L124:
	nop
	leave
	ret
	.def	__main;	.scl	2;	.type	32;	.endef
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
main:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 304
	mov	DWORD PTR 16[rbp], ecx
	mov	QWORD PTR 24[rbp], rdx
	call	__main
	mov	DWORD PTR -156[rbp], 0
	mov	rax, QWORD PTR 24[rbp]
	mov	r8d, 0
	mov	rdx, rax
	mov	ecx, DWORD PTR 16[rbp]
	call	fb_Init
.L128:
	mov	edx, 0
	movsd	xmm0, QWORD PTR .LC1[rip]
	call	fb_Randomize
	lea	rax, -208[rbp]
	mov	rcx, rax
	call	_ZN8UDTARRAYC1Ev
	lea	rax, -208[rbp]
	mov	edx, 10
	mov	rcx, rax
	call	_ZN8UDTARRAY7RESERVEEu7INTEGER
	mov	QWORD PTR -8[rbp], 0
	lea	rax, -208[rbp]
	mov	rcx, rax
	call	_ZN8UDTARRAY8CAPACITYEv
	mov	QWORD PTR -40[rbp], rax
	mov	rax, QWORD PTR -40[rbp]
	sub	rax, 1
	mov	QWORD PTR -48[rbp], rax
	jmp	.L129
.L151:
	nop
.L130:
	mov	rdx, QWORD PTR -8[rbp]
	lea	rax, -272[rbp]
	mov	rcx, rax
	call	_ZN3UDTC1Eu7INTEGER
	lea	rdx, -272[rbp]
	lea	rax, -208[rbp]
	mov	rcx, rax
	call	_ZN8UDTARRAY9PUSH_BACKER3UDT
.L131:
	add	QWORD PTR -8[rbp], 1
.L129:
	mov	rax, QWORD PTR -8[rbp]
	cmp	rax, QWORD PTR -48[rbp]
	jle	.L151
.L132:
	lea	rdx, -208[rbp]
	lea	rax, -256[rbp]
	mov	rcx, rax
	call	_ZN8UDTARRAYC1ERS_
	lea	rax, -256[rbp]
	mov	rcx, rax
	call	_ZN8UDTARRAY5FRONTEv
	mov	QWORD PTR -56[rbp], rax
	mov	rax, QWORD PTR -56[rbp]
	mov	QWORD PTR -16[rbp], rax
	lea	rax, -256[rbp]
	mov	rcx, rax
	call	_ZN8UDTARRAY4BACKEv
	mov	QWORD PTR -64[rbp], rax
	mov	rax, QWORD PTR -64[rbp]
	mov	QWORD PTR -72[rbp], rax
	jmp	.L133
.L152:
	nop
.L134:
	mov	rax, QWORD PTR -16[rbp]
	mov	rax, QWORD PTR [rax]
	mov	r8d, 0
	mov	rdx, rax
	mov	ecx, 0
	call	fb_PrintLongint
.L135:
	add	QWORD PTR -16[rbp], 8
.L133:
	mov	rax, QWORD PTR -16[rbp]
	cmp	rax, QWORD PTR -72[rbp]
	jbe	.L152
.L136:
	mov	edx, 1
	mov	ecx, 0
	call	fb_PrintVoid
	lea	rax, -256[rbp]
	mov	rcx, rax
	call	_ZN8UDTARRAY4SIZEEv
	mov	QWORD PTR -80[rbp], rax
	mov	rax, QWORD PTR -80[rbp]
	mov	r8d, 1
	mov	rdx, rax
	mov	ecx, 0
	call	fb_PrintLongint
	mov	edx, 1
	mov	ecx, 0
	call	fb_PrintVoid
	lea	rax, -256[rbp]
	mov	edx, 9
	mov	rcx, rax
	call	_ZN8UDTARRAY6REMOVEEu7INTEGER
	lea	rax, -256[rbp]
	mov	edx, 0
	mov	rcx, rax
	call	_ZN8UDTARRAYixEu7INTEGER
	mov	QWORD PTR -88[rbp], rax
	mov	rax, QWORD PTR -88[rbp]
	mov	QWORD PTR -96[rbp], rax
	mov	rdx, QWORD PTR -96[rbp]
	lea	rax, -256[rbp]
	mov	rcx, rax
	call	_ZN8UDTARRAY6REMOVEEP3UDT
	lea	rax, -256[rbp]
	mov	rcx, rax
	call	_ZN8UDTARRAY4SIZEEv
	mov	QWORD PTR -104[rbp], rax
	mov	rax, QWORD PTR -104[rbp]
	mov	r8d, 1
	mov	rdx, rax
	mov	ecx, 0
	call	fb_PrintLongint
	mov	edx, 1
	mov	ecx, 0
	call	fb_PrintVoid
	lea	rax, -256[rbp]
	mov	rcx, rax
	call	_ZN8UDTARRAY5FRONTEv
	mov	QWORD PTR -112[rbp], rax
	mov	rax, QWORD PTR -112[rbp]
	mov	QWORD PTR -24[rbp], rax
	lea	rax, -256[rbp]
	mov	rcx, rax
	call	_ZN8UDTARRAY4BACKEv
	mov	QWORD PTR -120[rbp], rax
	mov	rax, QWORD PTR -120[rbp]
	mov	QWORD PTR -128[rbp], rax
	jmp	.L137
.L153:
	nop
.L138:
	mov	rax, QWORD PTR -24[rbp]
	mov	rax, QWORD PTR [rax]
	mov	r8d, 0
	mov	rdx, rax
	mov	ecx, 0
	call	fb_PrintLongint
.L139:
	add	QWORD PTR -24[rbp], 8
.L137:
	mov	rax, QWORD PTR -24[rbp]
	cmp	rax, QWORD PTR -128[rbp]
	jbe	.L153
.L140:
	lea	rax, -256[rbp]
	mov	rcx, rax
	call	_ZN8UDTARRAY7SHUFFLEEv
	mov	edx, 1
	mov	ecx, 0
	call	fb_PrintVoid
	lea	rax, -256[rbp]
	mov	rcx, rax
	call	_ZN8UDTARRAY5FRONTEv
	mov	QWORD PTR -136[rbp], rax
	mov	rax, QWORD PTR -136[rbp]
	mov	QWORD PTR -32[rbp], rax
	lea	rax, -256[rbp]
	mov	rcx, rax
	call	_ZN8UDTARRAY4BACKEv
	mov	QWORD PTR -144[rbp], rax
	mov	rax, QWORD PTR -144[rbp]
	mov	QWORD PTR -152[rbp], rax
	jmp	.L141
.L154:
	nop
.L142:
	mov	rax, QWORD PTR -32[rbp]
	mov	rax, QWORD PTR [rax]
	mov	r8d, 0
	mov	rdx, rax
	mov	ecx, 0
	call	fb_PrintLongint
.L143:
	add	QWORD PTR -32[rbp], 8
.L141:
	mov	rax, QWORD PTR -32[rbp]
	cmp	rax, QWORD PTR -152[rbp]
	jbe	.L154
.L144:
	mov	ecx, -1
	call	fb_Sleep
	lea	rax, -256[rbp]
	mov	rcx, rax
	call	_ZN8UDTARRAYD1Ev
	lea	rax, -208[rbp]
	mov	rcx, rax
	call	_ZN8UDTARRAYD1Ev
.L145:
	mov	ecx, 0
	call	fb_End
	mov	eax, DWORD PTR -156[rbp]
	leave
	ret
	.section .rdata,"dr"
	.align 4
.LC0:
	.long	1065353216
	.align 8
.LC1:
	.long	0
	.long	-1074790400
	.ident	"GCC: (x86_64-win32-sjlj-rev0, Built by MinGW-W64 project) 5.2.0"
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	free;	.scl	2;	.type	32;	.endef
	.def	fb_Rnd;	.scl	2;	.type	32;	.endef
	.def	nearbyint;	.scl	2;	.type	32;	.endef
	.def	fb_Init;	.scl	2;	.type	32;	.endef
	.def	fb_Randomize;	.scl	2;	.type	32;	.endef
	.def	fb_PrintLongint;	.scl	2;	.type	32;	.endef
	.def	fb_PrintVoid;	.scl	2;	.type	32;	.endef
	.def	fb_Sleep;	.scl	2;	.type	32;	.endef
	.def	fb_End;	.scl	2;	.type	32;	.endef
