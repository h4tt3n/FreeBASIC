	.file	"Asteroid_lander.c"
	.intel_syntax noprefix
.lcomm ACTIVE$,1,1
.lcomm K$,2,2
.lcomm L$,2,2
.lcomm M$,2,2
.lcomm N$,2,2
.lcomm SCRN_WID$,8,8
.lcomm SCRN_HGT$,8,8
.lcomm SCRN_BPP$,8,8
.lcomm SCRN_RATE$,8,8
.lcomm SCRN_FULL$,8,8
.lcomm SCRN_X_MID$,8,8
.lcomm SCRN_Y_MID$,8,8
.lcomm DIST_SQARED$,4,4
.lcomm DISTANCE$,4,4
.lcomm FORCE$,4,4
.lcomm SCRN_X$,4,4
.lcomm SCRN_Y$,4,4
.lcomm POS_FACTOR$,4,4
.lcomm COL$,4,4
.lcomm ANGLE$,4,4
.lcomm SIN_ANG$,4,4
.lcomm COS_ANG$,4,4
.lcomm X$,4,4
.lcomm Y$,4,4
.lcomm CHK$,4,4
.lcomm DIST1$,4,4
.lcomm DIST2$,4,4
.lcomm ASTR_X1$,4,4
.lcomm ASTR_Y1$,4,4
.lcomm ASTR_X2$,4,4
.lcomm ASTR_Y2$,4,4
.lcomm SHIP_X$,4,4
.lcomm SHIP_Y$,4,4
.lcomm COLLISION$,4,4
.lcomm DIST$,8,8
.lcomm CONTROLS$,4,1
.lcomm SHIP$,27480,32
.lcomm ASTEROID$,2744,32
	.text
	.globl	INITIALIZE_OPENGL_2D
	.def	INITIALIZE_OPENGL_2D;	.scl	2;	.type	32;	.endef
INITIALIZE_OPENGL_2D:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
.L2:
	mov	rax, QWORD PTR SCRN_FULL$[rip]
	or	eax, 2
	mov	rdx, QWORD PTR SCRN_BPP$[rip]
	mov	r8d, edx
	mov	rdx, QWORD PTR SCRN_HGT$[rip]
	mov	r10d, edx
	mov	rdx, QWORD PTR SCRN_WID$[rip]
	mov	ecx, edx
	mov	DWORD PTR 40[rsp], 0
	mov	DWORD PTR 32[rsp], eax
	mov	r9d, 1
	mov	edx, r10d
	call	fb_GfxScreenRes
	mov	ecx, 5889
	call	glMatrixMode
	call	glLoadIdentity
	mov	rax, QWORD PTR SCRN_HGT$[rip]
	mov	edx, eax
	mov	rax, QWORD PTR SCRN_WID$[rip]
	mov	r9d, edx
	mov	r8d, eax
	mov	edx, 0
	mov	ecx, 0
	call	glViewport
	mov	rax, QWORD PTR SCRN_HGT$[rip]
	pxor	xmm2, xmm2
	cvtsi2sdq	xmm2, rax
	mov	rax, QWORD PTR SCRN_WID$[rip]
	pxor	xmm1, xmm1
	cvtsi2sdq	xmm1, rax
	movsd	xmm0, QWORD PTR .LC0[rip]
	movsd	QWORD PTR 40[rsp], xmm0
	movsd	xmm0, QWORD PTR .LC1[rip]
	movsd	QWORD PTR 32[rsp], xmm0
	pxor	xmm3, xmm3
	pxor	xmm0, xmm0
	call	glOrtho
	mov	ecx, 5888
	call	glMatrixMode
	mov	ecx, 2884
	call	glEnable
	mov	ecx, 1029
	call	glCullFace
	mov	ecx, 3553
	call	glEnable
	call	glLoadIdentity
	mov	ecx, 2929
	call	glEnable
	mov	ecx, 513
	call	glDepthFunc
	mov	ecx, 3008
	call	glEnable
	movss	xmm1, DWORD PTR .LC3[rip]
	mov	ecx, 516
	call	glAlphaFunc
	mov	ecx, 3042
	call	glEnable
	mov	edx, 771
	mov	ecx, 770
	call	glBlendFunc
	nop
	leave
	ret
.L3:
	.globl	FIND_DIST
	.def	FIND_DIST;	.scl	2;	.type	32;	.endef
FIND_DIST:
	push	rbp
	mov	rbp, rsp
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
.L5:
	lea	rax, DIST$[rip]
	mov	rdx, QWORD PTR 16[rbp]
	add	rdx, 4
	movss	xmm0, DWORD PTR [rdx]
	mov	rdx, QWORD PTR 24[rbp]
	add	rdx, 4
	movss	xmm1, DWORD PTR [rdx]
	subss	xmm0, xmm1
	movss	DWORD PTR [rax], xmm0
	lea	rax, DIST$[rip+4]
	mov	rdx, QWORD PTR 16[rbp]
	add	rdx, 8
	movss	xmm0, DWORD PTR [rdx]
	mov	rdx, QWORD PTR 24[rbp]
	add	rdx, 8
	movss	xmm1, DWORD PTR [rdx]
	subss	xmm0, xmm1
	movss	DWORD PTR [rax], xmm0
	lea	rax, DIST$[rip]
	movss	xmm1, DWORD PTR [rax]
	lea	rax, DIST$[rip]
	movss	xmm0, DWORD PTR [rax]
	mulss	xmm1, xmm0
	lea	rax, DIST$[rip+4]
	movss	xmm2, DWORD PTR [rax]
	lea	rax, DIST$[rip+4]
	movss	xmm0, DWORD PTR [rax]
	mulss	xmm0, xmm2
	addss	xmm0, xmm1
	movss	DWORD PTR DIST_SQARED$[rip], xmm0
	movss	xmm0, DWORD PTR DIST_SQARED$[rip]
	sqrtss	xmm0, xmm0
	movss	DWORD PTR DISTANCE$[rip], xmm0
	nop
	pop	rbp
	ret
.L6:
	.globl	G_FORCE_1WAY
	.def	G_FORCE_1WAY;	.scl	2;	.type	32;	.endef
G_FORCE_1WAY:
	push	rbp
	mov	rbp, rsp
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
.L8:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 32
	movss	xmm0, DWORD PTR [rax]
	movss	xmm1, DWORD PTR DIST_SQARED$[rip]
	divss	xmm0, xmm1
	movss	DWORD PTR FORCE$[rip], xmm0
	mov	rax, QWORD PTR 24[rbp]
	lea	rdx, 12[rax]
	mov	rax, QWORD PTR 24[rbp]
	add	rax, 12
	movss	xmm1, DWORD PTR [rax]
	lea	rax, DIST$[rip]
	movss	xmm0, DWORD PTR [rax]
	movss	xmm2, DWORD PTR DISTANCE$[rip]
	divss	xmm0, xmm2
	movss	xmm2, DWORD PTR FORCE$[rip]
	mulss	xmm0, xmm2
	addss	xmm0, xmm1
	movss	DWORD PTR [rdx], xmm0
	mov	rax, QWORD PTR 24[rbp]
	lea	rdx, 16[rax]
	mov	rax, QWORD PTR 24[rbp]
	add	rax, 16
	movss	xmm1, DWORD PTR [rax]
	lea	rax, DIST$[rip+4]
	movss	xmm0, DWORD PTR [rax]
	movss	xmm2, DWORD PTR DISTANCE$[rip]
	divss	xmm0, xmm2
	movss	xmm2, DWORD PTR FORCE$[rip]
	mulss	xmm0, xmm2
	addss	xmm0, xmm1
	movss	DWORD PTR [rdx], xmm0
	nop
	pop	rbp
	ret
.L9:
	.globl	G_FORCE_2WAY
	.def	G_FORCE_2WAY;	.scl	2;	.type	32;	.endef
G_FORCE_2WAY:
	push	rbp
	mov	rbp, rsp
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
.L11:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 32
	movss	xmm0, DWORD PTR [rax]
	movss	xmm1, DWORD PTR DIST_SQARED$[rip]
	divss	xmm0, xmm1
	movss	DWORD PTR FORCE$[rip], xmm0
	mov	rax, QWORD PTR 24[rbp]
	lea	rdx, 12[rax]
	mov	rax, QWORD PTR 24[rbp]
	add	rax, 12
	movss	xmm1, DWORD PTR [rax]
	lea	rax, DIST$[rip]
	movss	xmm0, DWORD PTR [rax]
	movss	xmm2, DWORD PTR DISTANCE$[rip]
	divss	xmm0, xmm2
	movss	xmm2, DWORD PTR FORCE$[rip]
	mulss	xmm0, xmm2
	addss	xmm0, xmm1
	movss	DWORD PTR [rdx], xmm0
	mov	rax, QWORD PTR 24[rbp]
	lea	rdx, 16[rax]
	mov	rax, QWORD PTR 24[rbp]
	add	rax, 16
	movss	xmm1, DWORD PTR [rax]
	lea	rax, DIST$[rip+4]
	movss	xmm0, DWORD PTR [rax]
	movss	xmm2, DWORD PTR DISTANCE$[rip]
	divss	xmm0, xmm2
	movss	xmm2, DWORD PTR FORCE$[rip]
	mulss	xmm0, xmm2
	addss	xmm0, xmm1
	movss	DWORD PTR [rdx], xmm0
	mov	rax, QWORD PTR 24[rbp]
	add	rax, 32
	movss	xmm0, DWORD PTR [rax]
	movss	xmm1, DWORD PTR DIST_SQARED$[rip]
	divss	xmm0, xmm1
	movss	DWORD PTR FORCE$[rip], xmm0
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 12[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 12
	movss	xmm1, DWORD PTR [rax]
	lea	rax, DIST$[rip]
	movss	xmm0, DWORD PTR [rax]
	movss	xmm2, DWORD PTR DISTANCE$[rip]
	divss	xmm0, xmm2
	movss	xmm2, DWORD PTR FORCE$[rip]
	mulss	xmm0, xmm2
	subss	xmm1, xmm0
	movaps	xmm0, xmm1
	movss	DWORD PTR [rdx], xmm0
	mov	rax, QWORD PTR 16[rbp]
	lea	rdx, 16[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 16
	movss	xmm1, DWORD PTR [rax]
	lea	rax, DIST$[rip+4]
	movss	xmm0, DWORD PTR [rax]
	movss	xmm2, DWORD PTR DISTANCE$[rip]
	divss	xmm0, xmm2
	movss	xmm2, DWORD PTR FORCE$[rip]
	mulss	xmm0, xmm2
	subss	xmm1, xmm0
	movaps	xmm0, xmm1
	movss	DWORD PTR [rdx], xmm0
	nop
	pop	rbp
	ret
.L12:
	.globl	UPDATE_POS
	.def	UPDATE_POS;	.scl	2;	.type	32;	.endef
UPDATE_POS:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	mov	QWORD PTR 16[rbp], rcx
.L14:
	mov	rax, QWORD PTR 16[rbp]
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 4
	mov	rdx, QWORD PTR -8[rbp]
	add	rdx, 4
	movss	xmm1, DWORD PTR [rdx]
	mov	rdx, QWORD PTR -8[rbp]
	add	rdx, 12
	movss	xmm0, DWORD PTR [rdx]
	addss	xmm0, xmm1
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 8
	mov	rdx, QWORD PTR -8[rbp]
	add	rdx, 8
	movss	xmm1, DWORD PTR [rdx]
	mov	rdx, QWORD PTR -8[rbp]
	add	rdx, 16
	movss	xmm0, DWORD PTR [rdx]
	addss	xmm0, xmm1
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 20
	mov	rdx, QWORD PTR SCRN_X_MID$[rip]
	pxor	xmm0, xmm0
	cvtsi2ssq	xmm0, rdx
	mov	rdx, QWORD PTR -8[rbp]
	add	rdx, 4
	movss	xmm1, DWORD PTR [rdx]
	addss	xmm0, xmm1
	movzx	edx, BYTE PTR ACTIVE$[rip]
	movzx	edx, dl
	imul	rdx, rdx, 9160
	lea	rcx, -9152[rdx]
	lea	rdx, SHIP$[rip]
	add	rdx, rcx
	movss	xmm2, DWORD PTR [rdx]
	movss	xmm1, DWORD PTR POS_FACTOR$[rip]
	mulss	xmm1, xmm2
	subss	xmm0, xmm1
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 24
	mov	rdx, QWORD PTR SCRN_Y_MID$[rip]
	pxor	xmm0, xmm0
	cvtsi2ssq	xmm0, rdx
	mov	rdx, QWORD PTR -8[rbp]
	add	rdx, 8
	movss	xmm1, DWORD PTR [rdx]
	addss	xmm0, xmm1
	movzx	edx, BYTE PTR ACTIVE$[rip]
	movzx	edx, dl
	imul	rdx, rdx, 9160
	lea	rcx, -9148[rdx]
	lea	rdx, SHIP$[rip]
	add	rdx, rcx
	movss	xmm2, DWORD PTR [rdx]
	movss	xmm1, DWORD PTR POS_FACTOR$[rip]
	mulss	xmm1, xmm2
	subss	xmm0, xmm1
	movss	DWORD PTR [rax], xmm0
	nop
	leave
	ret
.L15:
	.globl	UPDATE_SHIP_ANGLE
	.def	UPDATE_SHIP_ANGLE;	.scl	2;	.type	32;	.endef
UPDATE_SHIP_ANGLE:
	push	rbp
	mov	rbp, rsp
	push	rbx
	sub	rsp, 56
	mov	QWORD PTR 16[rbp], rcx
.L17:
	mov	rax, QWORD PTR 16[rbp]
	mov	QWORD PTR -24[rbp], rax
	mov	rax, QWORD PTR -24[rbp]
	lea	rbx, 144[rax]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, 136
	movss	xmm1, DWORD PTR [rax]
	movss	xmm0, DWORD PTR .LC4[rip]
	mulss	xmm0, xmm1
	call	cosf
	movd	eax, xmm0
	mov	DWORD PTR [rbx], eax
	mov	rax, QWORD PTR -24[rbp]
	lea	rbx, 140[rax]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, 136
	movss	xmm1, DWORD PTR [rax]
	movss	xmm0, DWORD PTR .LC4[rip]
	mulss	xmm0, xmm1
	call	sinf
	movd	eax, xmm0
	mov	DWORD PTR [rbx], eax
	mov	WORD PTR M$[rip], 1
.L18:
	movzx	eax, WORD PTR M$[rip]
	movzx	edx, ax
	mov	rax, rdx
	sal	rax, 2
	add	rax, rdx
	sal	rax, 2
	lea	rdx, 20[rax]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	mov	QWORD PTR -32[rbp], rax
	mov	rax, QWORD PTR -32[rbp]
	lea	rdx, 8[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 144
	movss	xmm1, DWORD PTR [rax]
	mov	rax, QWORD PTR -32[rbp]
	movss	xmm0, DWORD PTR [rax]
	mulss	xmm0, xmm1
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 140
	movss	xmm2, DWORD PTR [rax]
	mov	rax, QWORD PTR -32[rbp]
	add	rax, 4
	movss	xmm1, DWORD PTR [rax]
	mulss	xmm1, xmm2
	subss	xmm0, xmm1
	movss	DWORD PTR [rdx], xmm0
	mov	rax, QWORD PTR -32[rbp]
	lea	rdx, 12[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 144
	movss	xmm1, DWORD PTR [rax]
	mov	rax, QWORD PTR -32[rbp]
	add	rax, 4
	movss	xmm0, DWORD PTR [rax]
	mulss	xmm1, xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 140
	movss	xmm2, DWORD PTR [rax]
	mov	rax, QWORD PTR -32[rbp]
	movss	xmm0, DWORD PTR [rax]
	mulss	xmm0, xmm2
	addss	xmm0, xmm1
	movss	DWORD PTR [rdx], xmm0
.L19:
	movzx	eax, WORD PTR M$[rip]
	add	eax, 1
	mov	WORD PTR M$[rip], ax
.L20:
	movzx	eax, WORD PTR M$[rip]
	cmp	ax, 4
	ja	.L23
	jmp	.L18
.L21:
.L22:
.L23:
	nop
	add	rsp, 56
	pop	rbx
	pop	rbp
	ret
	.globl	UPDATE_ASTEROID_ANGLE
	.def	UPDATE_ASTEROID_ANGLE;	.scl	2;	.type	32;	.endef
UPDATE_ASTEROID_ANGLE:
	push	rbp
	mov	rbp, rsp
	push	rbx
	sub	rsp, 72
	mov	QWORD PTR 16[rbp], rcx
.L25:
	mov	rax, QWORD PTR 16[rbp]
	mov	QWORD PTR -24[rbp], rax
	mov	rax, QWORD PTR -24[rbp]
	add	rax, 1356
	mov	rdx, QWORD PTR -24[rbp]
	add	rdx, 1356
	movss	xmm1, DWORD PTR [rdx]
	mov	rdx, QWORD PTR -24[rbp]
	add	rdx, 1368
	movss	xmm0, DWORD PTR [rdx]
	addss	xmm0, xmm1
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR -24[rbp]
	lea	rbx, 1364[rax]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, 1356
	movss	xmm1, DWORD PTR [rax]
	movss	xmm0, DWORD PTR .LC4[rip]
	mulss	xmm0, xmm1
	call	cosf
	movd	eax, xmm0
	mov	DWORD PTR [rbx], eax
	mov	rax, QWORD PTR -24[rbp]
	lea	rbx, 1360[rax]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, 1356
	movss	xmm1, DWORD PTR [rax]
	movss	xmm0, DWORD PTR .LC4[rip]
	mulss	xmm0, xmm1
	call	sinf
	movd	eax, xmm0
	mov	DWORD PTR [rbx], eax
	mov	WORD PTR M$[rip], 0
	mov	rax, QWORD PTR -24[rbp]
	add	rax, 40
	movzx	eax, BYTE PTR [rax]
	movzx	eax, al
	mov	WORD PTR -26[rbp], ax
	jmp	.L26
.L32:
	nop
.L27:
	movzx	eax, WORD PTR M$[rip]
	movzx	edx, ax
	mov	rax, rdx
	sal	rax, 2
	add	rax, rdx
	sal	rax, 2
	lea	rdx, 44[rax]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	mov	QWORD PTR -40[rbp], rax
	mov	rax, QWORD PTR -40[rbp]
	lea	rdx, 8[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 1364
	movss	xmm1, DWORD PTR [rax]
	mov	rax, QWORD PTR -40[rbp]
	movss	xmm0, DWORD PTR [rax]
	mulss	xmm1, xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 1360
	movss	xmm2, DWORD PTR [rax]
	mov	rax, QWORD PTR -40[rbp]
	add	rax, 4
	movss	xmm0, DWORD PTR [rax]
	mulss	xmm0, xmm2
	addss	xmm0, xmm1
	movss	DWORD PTR [rdx], xmm0
	mov	rax, QWORD PTR -40[rbp]
	lea	rdx, 12[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 1364
	movss	xmm1, DWORD PTR [rax]
	mov	rax, QWORD PTR -40[rbp]
	add	rax, 4
	movss	xmm0, DWORD PTR [rax]
	mulss	xmm0, xmm1
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 1360
	movss	xmm2, DWORD PTR [rax]
	mov	rax, QWORD PTR -40[rbp]
	movss	xmm1, DWORD PTR [rax]
	mulss	xmm1, xmm2
	subss	xmm0, xmm1
	movss	DWORD PTR [rdx], xmm0
.L28:
	movzx	eax, WORD PTR M$[rip]
	add	eax, 1
	mov	WORD PTR M$[rip], ax
.L26:
	movzx	eax, WORD PTR M$[rip]
	cmp	ax, WORD PTR -26[rbp]
	jbe	.L32
.L29:
.L30:
	nop
	add	rsp, 72
	pop	rbx
	pop	rbp
	ret
	.globl	DRAW_PARTICLE
	.def	DRAW_PARTICLE;	.scl	2;	.type	32;	.endef
DRAW_PARTICLE:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 64
	mov	QWORD PTR 16[rbp], rcx
.L34:
	mov	rax, QWORD PTR 16[rbp]
	mov	QWORD PTR -8[rbp], rax
	call	glLoadIdentity
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 28
	movss	xmm1, DWORD PTR [rax]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 24
	movss	xmm0, DWORD PTR [rax]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 20
	mov	eax, DWORD PTR [rax]
	movaps	xmm2, xmm1
	movaps	xmm1, xmm0
	mov	DWORD PTR -20[rbp], eax
	movss	xmm0, DWORD PTR -20[rbp]
	call	glTranslatef
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 2
	movzx	eax, BYTE PTR [rax]
	movzx	ecx, al
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 1
	movzx	eax, BYTE PTR [rax]
	movzx	edx, al
	mov	rax, QWORD PTR -8[rbp]
	movzx	eax, BYTE PTR [rax]
	movzx	eax, al
	mov	r8d, ecx
	mov	ecx, eax
	call	glColor3ub
	movss	xmm0, DWORD PTR .LC5[rip]
	call	glPointSize
	mov	ecx, 0
	call	glBegin
	pxor	xmm1, xmm1
	pxor	xmm0, xmm0
	call	glVertex2f
	call	glEnd
	nop
	leave
	ret
.L35:
	.globl	DRAW_SHIP
	.def	DRAW_SHIP;	.scl	2;	.type	32;	.endef
DRAW_SHIP:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 64
	mov	QWORD PTR 16[rbp], rcx
.L37:
	mov	rax, QWORD PTR 16[rbp]
	mov	QWORD PTR -8[rbp], rax
	call	glLoadIdentity
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 32
	movss	xmm1, DWORD PTR [rax]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 28
	movss	xmm0, DWORD PTR [rax]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 24
	mov	eax, DWORD PTR [rax]
	movaps	xmm2, xmm1
	movaps	xmm1, xmm0
	mov	DWORD PTR -20[rbp], eax
	movss	xmm0, DWORD PTR -20[rbp]
	call	glTranslatef
	mov	ecx, 9
	call	glBegin
	mov	WORD PTR K$[rip], 1
.L38:
	movzx	eax, WORD PTR K$[rip]
	movzx	edx, ax
	mov	rax, rdx
	sal	rax, 2
	add	rax, rdx
	sal	rax, 2
	lea	rdx, 20[rax]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rdx
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -16[rbp]
	add	rax, 18
	movzx	eax, BYTE PTR [rax]
	movzx	ecx, al
	mov	rax, QWORD PTR -16[rbp]
	add	rax, 17
	movzx	eax, BYTE PTR [rax]
	movzx	edx, al
	mov	rax, QWORD PTR -16[rbp]
	add	rax, 16
	movzx	eax, BYTE PTR [rax]
	movzx	eax, al
	mov	r8d, ecx
	mov	ecx, eax
	call	glColor3ub
	mov	rax, QWORD PTR -16[rbp]
	add	rax, 12
	movss	xmm0, DWORD PTR [rax]
	mov	rax, QWORD PTR -16[rbp]
	add	rax, 8
	mov	eax, DWORD PTR [rax]
	movaps	xmm1, xmm0
	mov	DWORD PTR -20[rbp], eax
	movss	xmm0, DWORD PTR -20[rbp]
	call	glVertex2f
.L39:
	movzx	eax, WORD PTR K$[rip]
	add	eax, 1
	mov	WORD PTR K$[rip], ax
.L40:
	movzx	eax, WORD PTR K$[rip]
	cmp	ax, 4
	ja	.L41
	jmp	.L38
.L41:
	call	glEnd
	nop
	leave
	ret
.L42:
	.globl	DRAW_ASTEROID
	.def	DRAW_ASTEROID;	.scl	2;	.type	32;	.endef
DRAW_ASTEROID:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 112
	mov	QWORD PTR 16[rbp], rcx
.L44:
	mov	rax, QWORD PTR 16[rbp]
	mov	QWORD PTR -8[rbp], rax
	call	glLoadIdentity
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 32
	movss	xmm1, DWORD PTR [rax]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 28
	movss	xmm0, DWORD PTR [rax]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 24
	mov	eax, DWORD PTR [rax]
	movaps	xmm2, xmm1
	movaps	xmm1, xmm0
	mov	DWORD PTR -68[rbp], eax
	movss	xmm0, DWORD PTR -68[rbp]
	call	glTranslatef
	mov	ecx, 5
	call	glBegin
	mov	WORD PTR K$[rip], 1
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 40
	movzx	eax, BYTE PTR [rax]
	movzx	eax, al
	sub	eax, 1
	mov	WORD PTR -10[rbp], ax
	jmp	.L45
.L51:
	nop
.L46:
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 44
	mov	QWORD PTR -24[rbp], rax
	mov	rax, QWORD PTR -24[rbp]
	add	rax, 18
	movzx	eax, BYTE PTR [rax]
	movzx	ecx, al
	mov	rax, QWORD PTR -24[rbp]
	add	rax, 17
	movzx	eax, BYTE PTR [rax]
	movzx	edx, al
	mov	rax, QWORD PTR -24[rbp]
	add	rax, 16
	movzx	eax, BYTE PTR [rax]
	movzx	eax, al
	mov	r8d, ecx
	mov	ecx, eax
	call	glColor3ub
	mov	rax, QWORD PTR -24[rbp]
	add	rax, 12
	movss	xmm0, DWORD PTR [rax]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, 8
	mov	eax, DWORD PTR [rax]
	movaps	xmm1, xmm0
	mov	DWORD PTR -68[rbp], eax
	movss	xmm0, DWORD PTR -68[rbp]
	call	glVertex2f
	movzx	eax, WORD PTR K$[rip]
	movzx	edx, ax
	mov	rax, rdx
	sal	rax, 2
	add	rax, rdx
	sal	rax, 2
	lea	rdx, 44[rax]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rdx
	mov	QWORD PTR -32[rbp], rax
	mov	rax, QWORD PTR -32[rbp]
	add	rax, 18
	movzx	eax, BYTE PTR [rax]
	movzx	ecx, al
	mov	rax, QWORD PTR -32[rbp]
	add	rax, 17
	movzx	eax, BYTE PTR [rax]
	movzx	edx, al
	mov	rax, QWORD PTR -32[rbp]
	add	rax, 16
	movzx	eax, BYTE PTR [rax]
	movzx	eax, al
	mov	r8d, ecx
	mov	ecx, eax
	call	glColor3ub
	mov	rax, QWORD PTR -32[rbp]
	add	rax, 12
	movss	xmm0, DWORD PTR [rax]
	mov	rax, QWORD PTR -32[rbp]
	add	rax, 8
	mov	eax, DWORD PTR [rax]
	movaps	xmm1, xmm0
	mov	DWORD PTR -68[rbp], eax
	movss	xmm0, DWORD PTR -68[rbp]
	call	glVertex2f
	movzx	eax, WORD PTR K$[rip]
	movzx	edx, ax
	mov	rax, rdx
	sal	rax, 2
	add	rax, rdx
	sal	rax, 2
	lea	rdx, 64[rax]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rdx
	mov	QWORD PTR -40[rbp], rax
	mov	rax, QWORD PTR -40[rbp]
	add	rax, 18
	movzx	eax, BYTE PTR [rax]
	movzx	ecx, al
	mov	rax, QWORD PTR -40[rbp]
	add	rax, 17
	movzx	eax, BYTE PTR [rax]
	movzx	edx, al
	mov	rax, QWORD PTR -40[rbp]
	add	rax, 16
	movzx	eax, BYTE PTR [rax]
	movzx	eax, al
	mov	r8d, ecx
	mov	ecx, eax
	call	glColor3ub
	mov	rax, QWORD PTR -40[rbp]
	add	rax, 12
	movss	xmm0, DWORD PTR [rax]
	mov	rax, QWORD PTR -40[rbp]
	add	rax, 8
	mov	eax, DWORD PTR [rax]
	movaps	xmm1, xmm0
	mov	DWORD PTR -68[rbp], eax
	movss	xmm0, DWORD PTR -68[rbp]
	call	glVertex2f
.L47:
	movzx	eax, WORD PTR K$[rip]
	add	eax, 1
	mov	WORD PTR K$[rip], ax
.L45:
	movzx	eax, WORD PTR K$[rip]
	cmp	ax, WORD PTR -10[rbp]
	jbe	.L51
.L48:
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 44
	mov	QWORD PTR -48[rbp], rax
	mov	rax, QWORD PTR -48[rbp]
	add	rax, 18
	movzx	eax, BYTE PTR [rax]
	movzx	ecx, al
	mov	rax, QWORD PTR -48[rbp]
	add	rax, 17
	movzx	eax, BYTE PTR [rax]
	movzx	edx, al
	mov	rax, QWORD PTR -48[rbp]
	add	rax, 16
	movzx	eax, BYTE PTR [rax]
	movzx	eax, al
	mov	r8d, ecx
	mov	ecx, eax
	call	glColor3ub
	mov	rax, QWORD PTR -48[rbp]
	add	rax, 12
	movss	xmm0, DWORD PTR [rax]
	mov	rax, QWORD PTR -48[rbp]
	add	rax, 8
	mov	eax, DWORD PTR [rax]
	movaps	xmm1, xmm0
	mov	DWORD PTR -68[rbp], eax
	movss	xmm0, DWORD PTR -68[rbp]
	call	glVertex2f
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 64
	mov	QWORD PTR -56[rbp], rax
	mov	rax, QWORD PTR -56[rbp]
	add	rax, 18
	movzx	eax, BYTE PTR [rax]
	movzx	ecx, al
	mov	rax, QWORD PTR -56[rbp]
	add	rax, 17
	movzx	eax, BYTE PTR [rax]
	movzx	edx, al
	mov	rax, QWORD PTR -56[rbp]
	add	rax, 16
	movzx	eax, BYTE PTR [rax]
	movzx	eax, al
	mov	r8d, ecx
	mov	ecx, eax
	call	glColor3ub
	mov	rax, QWORD PTR -56[rbp]
	add	rax, 12
	movss	xmm0, DWORD PTR [rax]
	mov	rax, QWORD PTR -56[rbp]
	add	rax, 8
	mov	eax, DWORD PTR [rax]
	movaps	xmm1, xmm0
	mov	DWORD PTR -68[rbp], eax
	movss	xmm0, DWORD PTR -68[rbp]
	call	glVertex2f
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 40
	movzx	eax, BYTE PTR [rax]
	movzx	edx, al
	mov	rax, rdx
	sal	rax, 2
	add	rax, rdx
	sal	rax, 2
	lea	rdx, 44[rax]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rdx
	mov	QWORD PTR -64[rbp], rax
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 18
	movzx	eax, BYTE PTR [rax]
	movzx	ecx, al
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 17
	movzx	eax, BYTE PTR [rax]
	movzx	edx, al
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 16
	movzx	eax, BYTE PTR [rax]
	movzx	eax, al
	mov	r8d, ecx
	mov	ecx, eax
	call	glColor3ub
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 12
	movss	xmm0, DWORD PTR [rax]
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 8
	mov	eax, DWORD PTR [rax]
	movaps	xmm1, xmm0
	mov	DWORD PTR -68[rbp], eax
	movss	xmm0, DWORD PTR -68[rbp]
	call	glVertex2f
	call	glEnd
	nop
	leave
	ret
.L49:
	.globl	BURST
	.def	BURST;	.scl	2;	.type	32;	.endef
BURST:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 80
.L53:
	movzx	eax, BYTE PTR ACTIVE$[rip]
	movzx	eax, al
	imul	rax, rax, 9160
	lea	rdx, -9160[rax]
	lea	rax, SHIP$[rip]
	add	rax, rdx
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 120
	movss	xmm0, DWORD PTR [rax]
	cvtss2sd	xmm0, xmm0
	movsd	xmm1, QWORD PTR .LC7[rip]
	ucomisd	xmm1, xmm0
	ja	.L67
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 120
	mov	rdx, QWORD PTR -8[rbp]
	add	rdx, 120
	movss	xmm0, DWORD PTR [rdx]
	cvtss2sd	xmm0, xmm0
	movsd	xmm1, QWORD PTR .LC7[rip]
	subsd	xmm0, xmm1
	cvtsd2ss	xmm0, xmm0
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 16
	mov	rdx, QWORD PTR -8[rbp]
	add	rdx, 16
	movss	xmm2, DWORD PTR [rdx]
	mov	rdx, QWORD PTR -8[rbp]
	add	rdx, 140
	movss	xmm1, DWORD PTR [rdx]
	mov	rdx, QWORD PTR -8[rbp]
	add	rdx, 152
	movss	xmm0, DWORD PTR [rdx]
	mulss	xmm0, xmm1
	mov	rdx, QWORD PTR -8[rbp]
	add	rdx, 36
	movss	xmm3, DWORD PTR [rdx]
	mov	rdx, QWORD PTR -8[rbp]
	add	rdx, 120
	movss	xmm1, DWORD PTR [rdx]
	addss	xmm1, xmm3
	divss	xmm0, xmm1
	addss	xmm0, xmm2
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 20
	mov	rdx, QWORD PTR -8[rbp]
	add	rdx, 20
	movss	xmm2, DWORD PTR [rdx]
	mov	rdx, QWORD PTR -8[rbp]
	add	rdx, 144
	movss	xmm1, DWORD PTR [rdx]
	mov	rdx, QWORD PTR -8[rbp]
	add	rdx, 152
	movss	xmm0, DWORD PTR [rdx]
	mulss	xmm0, xmm1
	mov	rdx, QWORD PTR -8[rbp]
	add	rdx, 36
	movss	xmm3, DWORD PTR [rdx]
	mov	rdx, QWORD PTR -8[rbp]
	add	rdx, 120
	movss	xmm1, DWORD PTR [rdx]
	addss	xmm1, xmm3
	divss	xmm0, xmm1
	subss	xmm2, xmm0
	movaps	xmm0, xmm2
	movss	DWORD PTR [rax], xmm0
	mov	WORD PTR K$[rip], 1
.L57:
	movzx	eax, WORD PTR K$[rip]
	movzx	eax, ax
	sal	rax, 2
	mov	rdx, rax
	sal	rdx, 4
	sub	rdx, rax
	mov	rax, rdx
	lea	rdx, 100[rax]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L68
	movss	xmm0, DWORD PTR .LC5[rip]
	call	fb_Rnd
	movq	rax, xmm0
	mov	QWORD PTR -16[rbp], rax
	movss	xmm0, DWORD PTR .LC5[rip]
	call	fb_Rnd
	movq	rax, xmm0
	mov	QWORD PTR -24[rbp], rax
	movzx	eax, WORD PTR K$[rip]
	movzx	eax, ax
	sal	rax, 2
	mov	rdx, rax
	sal	rdx, 4
	sub	rdx, rax
	mov	rax, rdx
	lea	rdx, 116[rax]
	mov	rax, QWORD PTR -8[rbp]
	add	rdx, rax
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 16
	movss	xmm0, DWORD PTR [rax]
	cvtss2sd	xmm0, xmm0
	movzx	eax, WORD PTR K$[rip]
	movzx	eax, ax
	sal	rax, 2
	mov	rcx, rax
	sal	rcx, 4
	sub	rcx, rax
	mov	rax, rcx
	lea	rcx, 144[rax]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rcx
	movss	xmm2, DWORD PTR [rax]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 140
	movss	xmm1, DWORD PTR [rax]
	mulss	xmm1, xmm2
	cvtss2sd	xmm1, xmm1
	subsd	xmm0, xmm1
	movsd	xmm2, QWORD PTR -16[rbp]
	movsd	xmm1, QWORD PTR .LC8[rip]
	mulsd	xmm1, xmm2
	subsd	xmm0, xmm1
	movapd	xmm1, xmm0
	movsd	xmm2, QWORD PTR -24[rbp]
	movsd	xmm0, QWORD PTR .LC8[rip]
	mulsd	xmm0, xmm2
	addsd	xmm0, xmm1
	cvtsd2ss	xmm0, xmm0
	movss	DWORD PTR [rdx], xmm0
	movss	xmm0, DWORD PTR .LC5[rip]
	call	fb_Rnd
	movq	rax, xmm0
	mov	QWORD PTR -32[rbp], rax
	movss	xmm0, DWORD PTR .LC5[rip]
	call	fb_Rnd
	movq	rax, xmm0
	mov	QWORD PTR -40[rbp], rax
	movzx	eax, WORD PTR K$[rip]
	movzx	eax, ax
	sal	rax, 2
	mov	rdx, rax
	sal	rdx, 4
	sub	rdx, rax
	mov	rax, rdx
	lea	rdx, 120[rax]
	mov	rax, QWORD PTR -8[rbp]
	add	rdx, rax
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 20
	movss	xmm0, DWORD PTR [rax]
	cvtss2sd	xmm1, xmm0
	movzx	eax, WORD PTR K$[rip]
	movzx	eax, ax
	sal	rax, 2
	mov	rcx, rax
	sal	rcx, 4
	sub	rcx, rax
	mov	rax, rcx
	lea	rcx, 144[rax]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rcx
	movss	xmm2, DWORD PTR [rax]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 144
	movss	xmm0, DWORD PTR [rax]
	mulss	xmm0, xmm2
	cvtss2sd	xmm0, xmm0
	addsd	xmm1, xmm0
	movsd	xmm2, QWORD PTR -32[rbp]
	movsd	xmm0, QWORD PTR .LC8[rip]
	mulsd	xmm0, xmm2
	addsd	xmm0, xmm1
	movsd	xmm2, QWORD PTR -40[rbp]
	movsd	xmm1, QWORD PTR .LC8[rip]
	mulsd	xmm1, xmm2
	subsd	xmm0, xmm1
	cvtsd2ss	xmm0, xmm0
	movss	DWORD PTR [rdx], xmm0
	movzx	eax, WORD PTR K$[rip]
	movzx	eax, ax
	sal	rax, 2
	mov	rdx, rax
	sal	rdx, 4
	sub	rdx, rax
	mov	rax, rdx
	lea	rdx, 108[rax]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rdx
	mov	rdx, QWORD PTR -8[rbp]
	add	rdx, 8
	movss	xmm1, DWORD PTR [rdx]
	mov	rdx, QWORD PTR -8[rbp]
	add	rdx, 88
	movss	xmm0, DWORD PTR [rdx]
	addss	xmm0, xmm1
	movss	DWORD PTR [rax], xmm0
	movzx	eax, WORD PTR K$[rip]
	movzx	eax, ax
	sal	rax, 2
	mov	rdx, rax
	sal	rdx, 4
	sub	rdx, rax
	mov	rax, rdx
	lea	rdx, 112[rax]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rdx
	mov	rdx, QWORD PTR -8[rbp]
	add	rdx, 12
	movss	xmm1, DWORD PTR [rdx]
	mov	rdx, QWORD PTR -8[rbp]
	add	rdx, 92
	movss	xmm0, DWORD PTR [rdx]
	addss	xmm0, xmm1
	movss	DWORD PTR [rax], xmm0
	movzx	eax, WORD PTR K$[rip]
	movzx	eax, ax
	sal	rax, 2
	mov	rdx, rax
	sal	rdx, 4
	sub	rdx, rax
	mov	rax, rdx
	lea	rdx, 154[rax]
	mov	rax, QWORD PTR -8[rbp]
	add	rdx, rax
	movzx	eax, WORD PTR K$[rip]
	movzx	eax, ax
	sal	rax, 2
	mov	rcx, rax
	sal	rcx, 4
	sub	rcx, rax
	mov	rax, rcx
	lea	rcx, 152[rax]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rcx
	movzx	eax, WORD PTR [rax]
	mov	WORD PTR [rdx], ax
	movzx	eax, WORD PTR K$[rip]
	movzx	eax, ax
	sal	rax, 2
	mov	rdx, rax
	sal	rdx, 4
	sub	rdx, rax
	mov	rax, rdx
	lea	rdx, 100[rax]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rdx
	mov	BYTE PTR [rax], 1
	nop
.L60:
	jmp	.L69
.L59:
.L61:
.L68:
	nop
.L62:
	movzx	eax, WORD PTR K$[rip]
	add	eax, 1
	mov	WORD PTR K$[rip], ax
.L63:
	movzx	eax, WORD PTR K$[rip]
	cmp	ax, 30
	ja	.L69
	jmp	.L57
.L67:
	nop
.L56:
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 120
	pxor	xmm0, xmm0
	movss	DWORD PTR [rax], xmm0
	jmp	.L65
.L64:
.L69:
	nop
.L65:
	nop
	leave
	ret
	.globl	DRAW_BURST
	.def	DRAW_BURST;	.scl	2;	.type	32;	.endef
DRAW_BURST:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 64
.L71:
	movzx	eax, BYTE PTR ACTIVE$[rip]
	movzx	eax, al
	imul	rax, rax, 9160
	lea	rdx, -9160[rax]
	lea	rax, SHIP$[rip]
	add	rax, rdx
	mov	QWORD PTR -8[rbp], rax
	mov	WORD PTR K$[rip], 1
.L72:
	movzx	eax, WORD PTR K$[rip]
	movzx	eax, ax
	sal	rax, 2
	mov	rdx, rax
	sal	rdx, 4
	sub	rdx, rax
	mov	rax, rdx
	lea	rdx, 100[rax]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rdx
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -16[rbp]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 1
	jne	.L84
	mov	rax, QWORD PTR -16[rbp]
	add	rax, 54
	movzx	eax, WORD PTR [rax]
	test	ax, ax
	je	.L85
	mov	rax, QWORD PTR -16[rbp]
	add	rax, 54
	mov	rdx, QWORD PTR -16[rbp]
	add	rdx, 54
	movzx	edx, WORD PTR [rdx]
	sub	edx, 1
	mov	WORD PTR [rax], dx
	mov	rax, QWORD PTR -16[rbp]
	add	rax, 54
	movzx	eax, WORD PTR [rax]
	movzx	eax, ax
	pxor	xmm0, xmm0
	cvtsi2sdq	xmm0, rax
	mov	rax, QWORD PTR -16[rbp]
	add	rax, 52
	movzx	eax, WORD PTR [rax]
	movzx	eax, ax
	pxor	xmm1, xmm1
	cvtsi2sdq	xmm1, rax
	divsd	xmm0, xmm1
	cvtsd2ss	xmm0, xmm0
	movss	DWORD PTR COL$[rip], xmm0
	mov	rax, QWORD PTR -16[rbp]
	add	rax, 4
	mov	rcx, rax
	call	DRAW_PARTICLE
	jmp	.L79
.L85:
	nop
.L76:
	mov	rax, QWORD PTR -16[rbp]
	mov	BYTE PTR [rax], 0
	mov	rax, QWORD PTR -16[rbp]
	add	rax, 4
	mov	QWORD PTR -24[rbp], rax
	mov	rax, QWORD PTR -24[rbp]
	mov	BYTE PTR [rax], -1
	mov	rax, QWORD PTR -24[rbp]
	add	rax, 1
	mov	BYTE PTR [rax], -1
	mov	rax, QWORD PTR -24[rbp]
	add	rax, 2
	mov	BYTE PTR [rax], -1
	jmp	.L79
.L74:
.L77:
.L78:
.L84:
	nop
.L79:
	movzx	eax, WORD PTR K$[rip]
	add	eax, 1
	mov	WORD PTR K$[rip], ax
.L80:
	movzx	eax, WORD PTR K$[rip]
	cmp	ax, 30
	ja	.L86
	jmp	.L72
.L81:
.L82:
.L86:
	nop
	leave
	ret
	.globl	DRAW_ELLIPSE
	.def	DRAW_ELLIPSE;	.scl	2;	.type	32;	.endef
DRAW_ELLIPSE:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 112
	movaps	XMMWORD PTR -16[rbp], xmm6
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
	mov	QWORD PTR 32[rbp], r8
	mov	QWORD PTR 40[rbp], r9
.L88:
	lea	rax, -20[rbp]
	mov	DWORD PTR [rax], 0
	lea	rax, -24[rbp]
	mov	DWORD PTR [rax], 0
	lea	rax, -28[rbp]
	mov	DWORD PTR [rax], 0
	lea	rax, -32[rbp]
	mov	DWORD PTR [rax], 0
	lea	rax, -36[rbp]
	mov	DWORD PTR [rax], 0
	lea	rax, -40[rbp]
	mov	DWORD PTR [rax], 0
	lea	rax, -44[rbp]
	mov	DWORD PTR [rax], 0
	lea	rax, -48[rbp]
	mov	DWORD PTR [rax], 0
	mov	BYTE PTR -49[rbp], 0
	mov	BYTE PTR -50[rbp], 0
	mov	BYTE PTR -51[rbp], 0
	mov	rax, QWORD PTR 48[rbp]
	movss	xmm1, DWORD PTR [rax]
	movss	xmm0, DWORD PTR .LC9[rip]
	xorps	xmm0, xmm1
	call	sinf
	movd	eax, xmm0
	mov	DWORD PTR -20[rbp], eax
	mov	rax, QWORD PTR 48[rbp]
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR -68[rbp], eax
	movss	xmm0, DWORD PTR -68[rbp]
	call	cosf
	movd	eax, xmm0
	mov	DWORD PTR -24[rbp], eax
	pxor	xmm0, xmm0
	movss	DWORD PTR -28[rbp], xmm0
	mov	rax, QWORD PTR 64[rbp]
	mov	rax, QWORD PTR [rax]
	pxor	xmm0, xmm0
	cvtsi2sdq	xmm0, rax
	movsd	xmm1, QWORD PTR .LC10[rip]
	divsd	xmm1, xmm0
	movapd	xmm0, xmm1
	cvtsd2ss	xmm0, xmm0
	movss	DWORD PTR -32[rbp], xmm0
	call	glLoadIdentity
	mov	rax, QWORD PTR 24[rbp]
	movss	xmm0, DWORD PTR [rax]
	mov	rax, QWORD PTR 16[rbp]
	mov	eax, DWORD PTR [rax]
	pxor	xmm2, xmm2
	movaps	xmm1, xmm0
	mov	DWORD PTR -68[rbp], eax
	movss	xmm0, DWORD PTR -68[rbp]
	call	glTranslatef
	mov	r8d, 16
	mov	edx, 16
	mov	ecx, 128
	call	glColor3ub
	mov	ecx, 2
	call	glBegin
.L89:
	mov	rax, QWORD PTR 32[rbp]
	movss	xmm6, DWORD PTR [rax]
	mov	eax, DWORD PTR -28[rbp]
	mov	DWORD PTR -68[rbp], eax
	movss	xmm0, DWORD PTR -68[rbp]
	call	cosf
	mulss	xmm0, xmm6
	movss	DWORD PTR -36[rbp], xmm0
	mov	rax, QWORD PTR 40[rbp]
	movss	xmm6, DWORD PTR [rax]
	mov	eax, DWORD PTR -28[rbp]
	mov	DWORD PTR -68[rbp], eax
	movss	xmm0, DWORD PTR -68[rbp]
	call	sinf
	mulss	xmm0, xmm6
	movss	DWORD PTR -40[rbp], xmm0
	movss	xmm1, DWORD PTR -36[rbp]
	movss	xmm0, DWORD PTR -24[rbp]
	mulss	xmm1, xmm0
	movss	xmm2, DWORD PTR -40[rbp]
	movss	xmm0, DWORD PTR -20[rbp]
	mulss	xmm0, xmm2
	addss	xmm0, xmm1
	movss	DWORD PTR -44[rbp], xmm0
	movss	xmm1, DWORD PTR -36[rbp]
	movss	xmm0, DWORD PTR .LC9[rip]
	xorps	xmm0, xmm1
	movss	xmm1, DWORD PTR -20[rbp]
	mulss	xmm1, xmm0
	movss	xmm2, DWORD PTR -40[rbp]
	movss	xmm0, DWORD PTR -24[rbp]
	mulss	xmm0, xmm2
	addss	xmm0, xmm1
	movss	DWORD PTR -48[rbp], xmm0
	movss	xmm1, DWORD PTR -28[rbp]
	movss	xmm0, DWORD PTR -32[rbp]
	addss	xmm0, xmm1
	movss	DWORD PTR -28[rbp], xmm0
	movss	xmm0, DWORD PTR -48[rbp]
	mov	eax, DWORD PTR -44[rbp]
	movaps	xmm1, xmm0
	mov	DWORD PTR -68[rbp], eax
	movss	xmm0, DWORD PTR -68[rbp]
	call	glVertex2f
.L90:
	movss	xmm1, DWORD PTR -28[rbp]
	movss	xmm0, DWORD PTR .LC11[rip]
	ucomiss	xmm0, xmm1
	jb	.L95
	jmp	.L89
.L95:
.L91:
	call	glEnd
	nop
	movaps	xmm6, XMMWORD PTR -16[rbp]
	leave
	ret
.L93:
	.globl	ASTR_SHIP_COLDETEC1
	.def	ASTR_SHIP_COLDETEC1;	.scl	2;	.type	32;	.endef
ASTR_SHIP_COLDETEC1:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
	mov	QWORD PTR -8[rbp], 0
.L97:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 1352
	movss	xmm1, DWORD PTR [rax]
	mov	rax, QWORD PTR 24[rbp]
	add	rax, 124
	movss	xmm0, DWORD PTR [rax]
	addss	xmm0, xmm1
	movss	xmm1, DWORD PTR DISTANCE$[rip]
	ucomiss	xmm1, xmm0
	ja	.L104
	mov	QWORD PTR -8[rbp], 1
	jmp	.L102
.L104:
	nop
.L100:
	mov	QWORD PTR -8[rbp], 0
	nop
.L101:
.L102:
	mov	rax, QWORD PTR -8[rbp]
	leave
	ret
	.globl	ASTR_SHIP_COLDETEC2
	.def	ASTR_SHIP_COLDETEC2;	.scl	2;	.type	32;	.endef
ASTR_SHIP_COLDETEC2:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 80
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
	mov	QWORD PTR -48[rbp], 0
.L106:
	mov	WORD PTR M$[rip], 2
.L107:
	mov	WORD PTR N$[rip], 1
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 40
	movzx	eax, BYTE PTR [rax]
	movzx	eax, al
	sub	eax, 1
	mov	WORD PTR -2[rbp], ax
	jmp	.L108
.L133:
	nop
.L109:
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 8
	movss	xmm1, DWORD PTR [rax]
	movzx	eax, WORD PTR N$[rip]
	movzx	edx, ax
	mov	rax, rdx
	sal	rax, 2
	add	rax, rdx
	sal	rax, 2
	lea	rdx, 52[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, rdx
	movss	xmm0, DWORD PTR [rax]
	addss	xmm0, xmm1
	movss	DWORD PTR ASTR_X1$[rip], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 12
	movss	xmm1, DWORD PTR [rax]
	movzx	eax, WORD PTR N$[rip]
	movzx	edx, ax
	mov	rax, rdx
	sal	rax, 2
	add	rax, rdx
	sal	rax, 2
	lea	rdx, 56[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, rdx
	movss	xmm0, DWORD PTR [rax]
	addss	xmm0, xmm1
	movss	DWORD PTR ASTR_Y1$[rip], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 8
	movss	xmm1, DWORD PTR [rax]
	movzx	eax, WORD PTR N$[rip]
	movzx	edx, ax
	mov	rax, rdx
	sal	rax, 2
	add	rax, rdx
	sal	rax, 2
	lea	rdx, 72[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, rdx
	movss	xmm0, DWORD PTR [rax]
	addss	xmm0, xmm1
	movss	DWORD PTR ASTR_X2$[rip], xmm0
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 12
	movss	xmm1, DWORD PTR [rax]
	movzx	eax, WORD PTR N$[rip]
	movzx	edx, ax
	mov	rax, rdx
	sal	rax, 2
	add	rax, rdx
	sal	rax, 2
	lea	rdx, 76[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, rdx
	movss	xmm0, DWORD PTR [rax]
	addss	xmm0, xmm1
	movss	DWORD PTR ASTR_Y2$[rip], xmm0
	mov	rax, QWORD PTR 24[rbp]
	add	rax, 8
	movss	xmm1, DWORD PTR [rax]
	movzx	eax, WORD PTR M$[rip]
	movzx	edx, ax
	mov	rax, rdx
	sal	rax, 2
	add	rax, rdx
	sal	rax, 2
	lea	rdx, 28[rax]
	mov	rax, QWORD PTR 24[rbp]
	add	rax, rdx
	movss	xmm0, DWORD PTR [rax]
	addss	xmm0, xmm1
	movss	DWORD PTR SHIP_X$[rip], xmm0
	mov	rax, QWORD PTR 24[rbp]
	add	rax, 12
	movss	xmm1, DWORD PTR [rax]
	movzx	eax, WORD PTR M$[rip]
	movzx	edx, ax
	mov	rax, rdx
	sal	rax, 2
	add	rax, rdx
	sal	rax, 2
	lea	rdx, 32[rax]
	mov	rax, QWORD PTR 24[rbp]
	add	rax, rdx
	movss	xmm0, DWORD PTR [rax]
	addss	xmm0, xmm1
	movss	DWORD PTR SHIP_Y$[rip], xmm0
	lea	rax, DIST$[rip]
	movss	xmm0, DWORD PTR ASTR_X1$[rip]
	movss	xmm1, DWORD PTR ASTR_X2$[rip]
	subss	xmm0, xmm1
	movss	DWORD PTR [rax], xmm0
	lea	rax, DIST$[rip+4]
	movss	xmm0, DWORD PTR ASTR_Y1$[rip]
	movss	xmm1, DWORD PTR ASTR_Y2$[rip]
	subss	xmm0, xmm1
	movss	DWORD PTR [rax], xmm0
	lea	rax, DIST$[rip]
	movss	xmm1, DWORD PTR [rax]
	lea	rax, DIST$[rip]
	movss	xmm0, DWORD PTR [rax]
	mulss	xmm1, xmm0
	lea	rax, DIST$[rip+4]
	movss	xmm2, DWORD PTR [rax]
	lea	rax, DIST$[rip+4]
	movss	xmm0, DWORD PTR [rax]
	mulss	xmm0, xmm2
	addss	xmm0, xmm1
	movss	DWORD PTR CHK$[rip], xmm0
	lea	rax, DIST$[rip]
	movss	xmm1, DWORD PTR [rax]
	movss	xmm0, DWORD PTR ASTR_Y1$[rip]
	movss	xmm2, DWORD PTR SHIP_Y$[rip]
	subss	xmm0, xmm2
	mulss	xmm0, xmm1
	movss	xmm1, DWORD PTR ASTR_X1$[rip]
	movss	xmm2, DWORD PTR SHIP_X$[rip]
	subss	xmm1, xmm2
	lea	rax, DIST$[rip+4]
	movss	xmm2, DWORD PTR [rax]
	mulss	xmm1, xmm2
	subss	xmm0, xmm1
	movss	xmm1, DWORD PTR CHK$[rip]
	sqrtss	xmm1, xmm1
	divss	xmm0, xmm1
	movss	DWORD PTR DISTANCE$[rip], xmm0
	movss	xmm0, DWORD PTR DISTANCE$[rip]
	ucomiss	xmm0, DWORD PTR .LC12[rip]
	jnb	.L130
	movss	xmm0, DWORD PTR ASTR_X2$[rip]
	movss	xmm1, DWORD PTR SHIP_X$[rip]
	subss	xmm0, xmm1
	cvtss2sd	xmm0, xmm0
	movsd	xmm1, QWORD PTR .LC13[rip]
	call	pow
	movq	rax, xmm0
	mov	QWORD PTR -16[rbp], rax
	movss	xmm0, DWORD PTR ASTR_Y2$[rip]
	movss	xmm1, DWORD PTR SHIP_Y$[rip]
	subss	xmm0, xmm1
	cvtss2sd	xmm0, xmm0
	movsd	xmm1, QWORD PTR .LC13[rip]
	call	pow
	movq	rax, xmm0
	mov	QWORD PTR -24[rbp], rax
	movsd	xmm0, QWORD PTR -16[rbp]
	addsd	xmm0, QWORD PTR -24[rbp]
	cvtsd2ss	xmm0, xmm0
	movss	DWORD PTR DIST1$[rip], xmm0
	movss	xmm0, DWORD PTR DIST1$[rip]
	movss	xmm1, DWORD PTR CHK$[rip]
	ucomiss	xmm0, xmm1
	ja	.L131
	movss	xmm0, DWORD PTR ASTR_X1$[rip]
	movss	xmm1, DWORD PTR SHIP_X$[rip]
	subss	xmm0, xmm1
	cvtss2sd	xmm0, xmm0
	movsd	xmm1, QWORD PTR .LC13[rip]
	call	pow
	movq	rax, xmm0
	mov	QWORD PTR -32[rbp], rax
	movss	xmm0, DWORD PTR ASTR_Y1$[rip]
	movss	xmm1, DWORD PTR SHIP_Y$[rip]
	subss	xmm0, xmm1
	cvtss2sd	xmm0, xmm0
	movsd	xmm1, QWORD PTR .LC13[rip]
	call	pow
	movq	rax, xmm0
	mov	QWORD PTR -40[rbp], rax
	movsd	xmm0, QWORD PTR -32[rbp]
	addsd	xmm0, QWORD PTR -40[rbp]
	cvtsd2ss	xmm0, xmm0
	movss	DWORD PTR DIST2$[rip], xmm0
	movss	xmm0, DWORD PTR DIST2$[rip]
	movss	xmm1, DWORD PTR CHK$[rip]
	ucomiss	xmm0, xmm1
	ja	.L132
	mov	QWORD PTR -48[rbp], 1
	jmp	.L127
.L132:
	nop
.L117:
	mov	QWORD PTR -48[rbp], 0
	jmp	.L127
.L112:
.L119:
.L120:
.L121:
.L122:
.L130:
	nop
	jmp	.L123
.L131:
	nop
.L123:
	movzx	eax, WORD PTR N$[rip]
	add	eax, 1
	mov	WORD PTR N$[rip], ax
.L108:
	movzx	eax, WORD PTR N$[rip]
	cmp	ax, WORD PTR -2[rbp]
	jbe	.L133
.L124:
.L125:
	movzx	eax, WORD PTR M$[rip]
	add	eax, 1
	mov	WORD PTR M$[rip], ax
.L126:
	movzx	eax, WORD PTR M$[rip]
	cmp	ax, 3
	ja	.L127
	jmp	.L107
.L118:
.L127:
	mov	rax, QWORD PTR -48[rbp]
	leave
	ret
	.globl	DRAW_TRAJECTORY
	.def	DRAW_TRAJECTORY;	.scl	2;	.type	32;	.endef
DRAW_TRAJECTORY:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	QWORD PTR 16[rbp], rcx
.L135:
	mov	WORD PTR -2[rbp], 0
	lea	rax, -8[rbp]
	mov	DWORD PTR [rax], 0
	mov	WORD PTR -2[rbp], 1
	movzx	eax, WORD PTR -2[rbp]
	movzx	eax, ax
	imul	rax, rax, 1372
	lea	rdx, -1368[rax]
	lea	rax, ASTEROID$[rip]
	add	rdx, rax
	mov	rax, QWORD PTR 16[rbp]
	add	rax, 4
	mov	rcx, rax
	call	FIND_DIST
	nop
	leave
	ret
.L136:
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC37:
	.ascii "\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
main:
	push	rbp
	mov	rbp, rsp
	push	rbx
	sub	rsp, 456
	movaps	XMMWORD PTR -48[rbp], xmm6
	movaps	XMMWORD PTR -32[rbp], xmm7
	mov	DWORD PTR 16[rbp], ecx
	mov	QWORD PTR 24[rbp], rdx
	call	__main
	mov	DWORD PTR -372[rbp], 0
	mov	rax, QWORD PTR 24[rbp]
	mov	r8d, 0
	mov	rdx, rax
	mov	ecx, DWORD PTR 16[rbp]
	call	fb_Init
.L138:
	call	fb_Timer
	movq	rax, xmm0
	mov	QWORD PTR -56[rbp], rax
	mov	rax, QWORD PTR -56[rbp]
	mov	edx, 0
	mov	QWORD PTR -392[rbp], rax
	movsd	xmm0, QWORD PTR -392[rbp]
	call	fb_Randomize
	lea	rax, CONTROLS$[rip]
	mov	BYTE PTR [rax], 75
	lea	rax, CONTROLS$[rip+1]
	mov	BYTE PTR [rax], 77
	lea	rax, CONTROLS$[rip+2]
	mov	BYTE PTR [rax], 72
	lea	rax, CONTROLS$[rip+3]
	mov	BYTE PTR [rax], 1
	lea	rax, ASTEROID$[rip]
	mov	QWORD PTR -64[rbp], rax
	mov	rax, QWORD PTR -64[rbp]
	mov	BYTE PTR [rax], 1
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 1352
	movss	xmm0, DWORD PTR .LC14[rip]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 40
	mov	BYTE PTR [rax], 24
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 4
	mov	QWORD PTR -72[rbp], rax
	mov	rax, QWORD PTR -72[rbp]
	add	rax, 4
	pxor	xmm0, xmm0
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR -72[rbp]
	add	rax, 8
	pxor	xmm0, xmm0
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR -72[rbp]
	add	rax, 28
	movss	xmm0, DWORD PTR .LC5[rip]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR -72[rbp]
	add	rax, 32
	movss	xmm0, DWORD PTR .LC15[rip]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 44
	mov	QWORD PTR -80[rbp], rax
	mov	rax, QWORD PTR -80[rbp]
	pxor	xmm0, xmm0
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR -80[rbp]
	add	rax, 4
	pxor	xmm0, xmm0
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR -80[rbp]
	add	rax, 16
	mov	BYTE PTR [rax], -112
	mov	rax, QWORD PTR -80[rbp]
	add	rax, 17
	mov	BYTE PTR [rax], -112
	mov	rax, QWORD PTR -80[rbp]
	add	rax, 18
	mov	BYTE PTR [rax], -112
	movss	xmm0, DWORD PTR .LC5[rip]
	call	fb_Rnd
	movq	rax, xmm0
	mov	QWORD PTR -88[rbp], rax
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 1356
	movsd	xmm1, QWORD PTR -88[rbp]
	movsd	xmm0, QWORD PTR .LC16[rip]
	mulsd	xmm0, xmm1
	cvtsd2ss	xmm0, xmm0
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR -64[rbp]
	lea	rbx, 1360[rax]
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 1356
	movss	xmm1, DWORD PTR [rax]
	movss	xmm0, DWORD PTR .LC4[rip]
	mulss	xmm0, xmm1
	call	sinf
	movd	eax, xmm0
	mov	DWORD PTR [rbx], eax
	mov	rax, QWORD PTR -64[rbp]
	lea	rbx, 1364[rax]
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 1356
	movss	xmm1, DWORD PTR [rax]
	movss	xmm0, DWORD PTR .LC4[rip]
	mulss	xmm0, xmm1
	call	cosf
	movd	eax, xmm0
	mov	DWORD PTR [rbx], eax
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 1368
	movss	xmm0, DWORD PTR .LC17[rip]
	movss	DWORD PTR [rax], xmm0
	mov	WORD PTR L$[rip], 1
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 40
	movzx	eax, BYTE PTR [rax]
	movzx	eax, al
	mov	WORD PTR -90[rbp], ax
	jmp	.L139
.L196:
	nop
.L140:
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 40
	movzx	eax, BYTE PTR [rax]
	movzx	eax, al
	lea	rdx, 1[rax]
	movzx	eax, WORD PTR L$[rip]
	movzx	eax, ax
	sub	rdx, rax
	mov	rax, rdx
	pxor	xmm0, xmm0
	cvtsi2sdq	xmm0, rax
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 40
	movzx	eax, BYTE PTR [rax]
	movzx	eax, al
	pxor	xmm1, xmm1
	cvtsi2sdq	xmm1, rax
	divsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR .LC10[rip]
	mulsd	xmm0, xmm1
	cvtsd2ss	xmm0, xmm0
	movss	DWORD PTR ANGLE$[rip], xmm0
	movss	xmm0, DWORD PTR .LC5[rip]
	call	fb_Rnd
	movq	rax, xmm0
	mov	QWORD PTR -104[rbp], rax
	lea	rax, ASTEROID$[rip+1352]
	movss	xmm0, DWORD PTR [rax]
	movss	xmm1, DWORD PTR .LC18[rip]
	subss	xmm0, xmm1
	cvtss2sd	xmm1, xmm0
	movsd	xmm2, QWORD PTR -104[rbp]
	movsd	xmm0, QWORD PTR .LC19[rip]
	mulsd	xmm0, xmm2
	addsd	xmm0, xmm1
	cvtsd2ss	xmm0, xmm0
	movss	DWORD PTR COL$[rip], xmm0
	mov	eax, DWORD PTR ANGLE$[rip]
	mov	DWORD PTR -392[rbp], eax
	movss	xmm0, DWORD PTR -392[rbp]
	call	cosf
	movaps	xmm1, xmm0
	movss	xmm0, DWORD PTR COL$[rip]
	mulss	xmm0, xmm1
	movss	DWORD PTR X$[rip], xmm0
	movss	xmm1, DWORD PTR COL$[rip]
	movss	xmm0, DWORD PTR .LC20[rip]
	movaps	xmm6, xmm1
	addss	xmm6, xmm0
	mov	eax, DWORD PTR ANGLE$[rip]
	mov	DWORD PTR -392[rbp], eax
	movss	xmm0, DWORD PTR -392[rbp]
	call	sinf
	mulss	xmm0, xmm6
	movss	DWORD PTR Y$[rip], xmm0
	movzx	eax, WORD PTR L$[rip]
	movzx	edx, ax
	mov	rax, rdx
	sal	rax, 2
	add	rax, rdx
	sal	rax, 2
	lea	rdx, 44[rax]
	mov	rax, QWORD PTR -64[rbp]
	add	rax, rdx
	mov	QWORD PTR -112[rbp], rax
	lea	rax, ASTEROID$[rip+1364]
	movss	xmm1, DWORD PTR [rax]
	movss	xmm0, DWORD PTR X$[rip]
	mulss	xmm1, xmm0
	lea	rax, ASTEROID$[rip+1360]
	movss	xmm2, DWORD PTR [rax]
	movss	xmm0, DWORD PTR Y$[rip]
	mulss	xmm0, xmm2
	addss	xmm0, xmm1
	mov	rax, QWORD PTR -112[rbp]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR -112[rbp]
	lea	rdx, 4[rax]
	movss	xmm1, DWORD PTR X$[rip]
	movss	xmm0, DWORD PTR .LC9[rip]
	xorps	xmm0, xmm1
	lea	rax, ASTEROID$[rip+1360]
	movss	xmm1, DWORD PTR [rax]
	mulss	xmm1, xmm0
	lea	rax, ASTEROID$[rip+1364]
	movss	xmm2, DWORD PTR [rax]
	movss	xmm0, DWORD PTR Y$[rip]
	mulss	xmm0, xmm2
	addss	xmm0, xmm1
	movss	DWORD PTR [rdx], xmm0
	mov	rax, QWORD PTR -112[rbp]
	add	rax, 16
	mov	BYTE PTR [rax], 96
	mov	rax, QWORD PTR -112[rbp]
	add	rax, 17
	mov	BYTE PTR [rax], 96
	mov	rax, QWORD PTR -112[rbp]
	add	rax, 18
	mov	BYTE PTR [rax], 96
.L141:
	movzx	eax, WORD PTR L$[rip]
	add	eax, 1
	mov	WORD PTR L$[rip], ax
.L139:
	movzx	eax, WORD PTR L$[rip]
	cmp	ax, WORD PTR -90[rbp]
	jbe	.L196
.L142:
	lea	rax, ASTEROID$[rip+1372]
	mov	QWORD PTR -120[rbp], rax
	mov	rax, QWORD PTR -120[rbp]
	mov	BYTE PTR [rax], 1
	mov	rax, QWORD PTR -120[rbp]
	add	rax, 1352
	movss	xmm0, DWORD PTR .LC20[rip]
	movss	DWORD PTR [rax], xmm0
	movss	xmm0, DWORD PTR .LC5[rip]
	call	fb_Rnd
	movq	rax, xmm0
	mov	QWORD PTR -128[rbp], rax
	mov	rax, QWORD PTR -120[rbp]
	add	rax, 1344
	movsd	xmm1, QWORD PTR -128[rbp]
	movsd	xmm0, QWORD PTR .LC10[rip]
	mulsd	xmm0, xmm1
	cvtsd2ss	xmm0, xmm0
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR -120[rbp]
	add	rax, 1348
	movss	xmm0, DWORD PTR .LC21[rip]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR -120[rbp]
	add	rax, 40
	mov	BYTE PTR [rax], 12
	mov	rax, QWORD PTR -120[rbp]
	add	rax, 4
	mov	QWORD PTR -136[rbp], rax
	mov	rax, QWORD PTR -136[rbp]
	lea	rbx, 4[rax]
	lea	rax, ASTEROID$[rip+8]
	movss	xmm6, DWORD PTR [rax]
	lea	rax, ASTEROID$[rip+2720]
	movss	xmm7, DWORD PTR [rax]
	lea	rax, ASTEROID$[rip+2716]
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR -392[rbp], eax
	movss	xmm0, DWORD PTR -392[rbp]
	call	sinf
	mulss	xmm0, xmm7
	subss	xmm6, xmm0
	movaps	xmm0, xmm6
	movss	DWORD PTR [rbx], xmm0
	mov	rax, QWORD PTR -136[rbp]
	lea	rbx, 8[rax]
	lea	rax, ASTEROID$[rip+12]
	movss	xmm6, DWORD PTR [rax]
	lea	rax, ASTEROID$[rip+2720]
	movss	xmm7, DWORD PTR [rax]
	lea	rax, ASTEROID$[rip+2716]
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR -392[rbp], eax
	movss	xmm0, DWORD PTR -392[rbp]
	call	cosf
	mulss	xmm0, xmm7
	subss	xmm6, xmm0
	movaps	xmm0, xmm6
	movss	DWORD PTR [rbx], xmm0
	mov	rax, QWORD PTR -136[rbp]
	lea	rbx, 12[rax]
	lea	rax, ASTEROID$[rip+36]
	movss	xmm0, DWORD PTR [rax]
	lea	rax, ASTEROID$[rip+2720]
	movss	xmm1, DWORD PTR [rax]
	divss	xmm0, xmm1
	sqrtss	xmm0, xmm0
	cvtss2sd	xmm6, xmm0
	lea	rax, ASTEROID$[rip+2716]
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR -392[rbp], eax
	movss	xmm0, DWORD PTR -392[rbp]
	call	cosf
	cvtss2sd	xmm0, xmm0
	mulsd	xmm0, xmm6
	movsd	xmm1, QWORD PTR .LC22[rip]
	mulsd	xmm0, xmm1
	cvtsd2ss	xmm0, xmm0
	movss	DWORD PTR [rbx], xmm0
	mov	rax, QWORD PTR -136[rbp]
	lea	rbx, 16[rax]
	lea	rax, ASTEROID$[rip+36]
	movss	xmm0, DWORD PTR [rax]
	lea	rax, ASTEROID$[rip+2720]
	movss	xmm1, DWORD PTR [rax]
	divss	xmm0, xmm1
	sqrtss	xmm0, xmm0
	cvtss2sd	xmm6, xmm0
	lea	rax, ASTEROID$[rip+2716]
	movss	xmm1, DWORD PTR [rax]
	movss	xmm0, DWORD PTR .LC9[rip]
	xorps	xmm0, xmm1
	call	sinf
	cvtss2sd	xmm0, xmm0
	mulsd	xmm0, xmm6
	movsd	xmm1, QWORD PTR .LC22[rip]
	mulsd	xmm0, xmm1
	cvtsd2ss	xmm0, xmm0
	movss	DWORD PTR [rbx], xmm0
	mov	rax, QWORD PTR -136[rbp]
	add	rax, 28
	movss	xmm0, DWORD PTR .LC5[rip]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR -136[rbp]
	add	rax, 32
	movss	xmm0, DWORD PTR .LC23[rip]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR -120[rbp]
	add	rax, 44
	mov	QWORD PTR -144[rbp], rax
	mov	rax, QWORD PTR -144[rbp]
	pxor	xmm0, xmm0
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR -144[rbp]
	add	rax, 4
	pxor	xmm0, xmm0
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR -144[rbp]
	add	rax, 16
	mov	BYTE PTR [rax], -128
	mov	rax, QWORD PTR -144[rbp]
	add	rax, 17
	mov	BYTE PTR [rax], 96
	mov	rax, QWORD PTR -144[rbp]
	add	rax, 18
	mov	BYTE PTR [rax], 96
	movss	xmm0, DWORD PTR .LC5[rip]
	call	fb_Rnd
	movq	rax, xmm0
	mov	QWORD PTR -152[rbp], rax
	mov	rax, QWORD PTR -120[rbp]
	add	rax, 1356
	movsd	xmm1, QWORD PTR -152[rbp]
	movsd	xmm0, QWORD PTR .LC16[rip]
	mulsd	xmm0, xmm1
	cvtsd2ss	xmm0, xmm0
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR -120[rbp]
	lea	rbx, 1360[rax]
	mov	rax, QWORD PTR -120[rbp]
	add	rax, 1356
	movss	xmm1, DWORD PTR [rax]
	movss	xmm0, DWORD PTR .LC4[rip]
	mulss	xmm0, xmm1
	call	sinf
	movd	eax, xmm0
	mov	DWORD PTR [rbx], eax
	mov	rax, QWORD PTR -120[rbp]
	lea	rbx, 1364[rax]
	mov	rax, QWORD PTR -120[rbp]
	add	rax, 1356
	movss	xmm1, DWORD PTR [rax]
	movss	xmm0, DWORD PTR .LC4[rip]
	mulss	xmm0, xmm1
	call	cosf
	movd	eax, xmm0
	mov	DWORD PTR [rbx], eax
	mov	rax, QWORD PTR -120[rbp]
	add	rax, 1368
	movss	xmm0, DWORD PTR .LC24[rip]
	movss	DWORD PTR [rax], xmm0
	mov	WORD PTR L$[rip], 1
	mov	rax, QWORD PTR -120[rbp]
	add	rax, 40
	movzx	eax, BYTE PTR [rax]
	movzx	eax, al
	mov	WORD PTR -154[rbp], ax
	jmp	.L143
.L197:
	nop
.L144:
	mov	rax, QWORD PTR -120[rbp]
	add	rax, 40
	movzx	eax, BYTE PTR [rax]
	movzx	eax, al
	lea	rdx, 1[rax]
	movzx	eax, WORD PTR L$[rip]
	movzx	eax, ax
	sub	rdx, rax
	mov	rax, rdx
	pxor	xmm0, xmm0
	cvtsi2sdq	xmm0, rax
	mov	rax, QWORD PTR -120[rbp]
	add	rax, 40
	movzx	eax, BYTE PTR [rax]
	movzx	eax, al
	pxor	xmm1, xmm1
	cvtsi2sdq	xmm1, rax
	divsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR .LC10[rip]
	mulsd	xmm0, xmm1
	cvtsd2ss	xmm0, xmm0
	movss	DWORD PTR ANGLE$[rip], xmm0
	movss	xmm0, DWORD PTR .LC5[rip]
	call	fb_Rnd
	movq	rax, xmm0
	mov	QWORD PTR -168[rbp], rax
	lea	rax, ASTEROID$[rip+2724]
	movss	xmm0, DWORD PTR [rax]
	movss	xmm1, DWORD PTR .LC25[rip]
	subss	xmm0, xmm1
	cvtss2sd	xmm1, xmm0
	movsd	xmm2, QWORD PTR -168[rbp]
	movsd	xmm0, QWORD PTR .LC26[rip]
	mulsd	xmm0, xmm2
	addsd	xmm0, xmm1
	cvtsd2ss	xmm0, xmm0
	movss	DWORD PTR COL$[rip], xmm0
	mov	eax, DWORD PTR ANGLE$[rip]
	mov	DWORD PTR -392[rbp], eax
	movss	xmm0, DWORD PTR -392[rbp]
	call	cosf
	movaps	xmm1, xmm0
	movss	xmm0, DWORD PTR COL$[rip]
	mulss	xmm0, xmm1
	movss	DWORD PTR X$[rip], xmm0
	movss	xmm1, DWORD PTR COL$[rip]
	movss	xmm0, DWORD PTR .LC27[rip]
	movaps	xmm6, xmm1
	addss	xmm6, xmm0
	mov	eax, DWORD PTR ANGLE$[rip]
	mov	DWORD PTR -392[rbp], eax
	movss	xmm0, DWORD PTR -392[rbp]
	call	sinf
	mulss	xmm0, xmm6
	movss	DWORD PTR Y$[rip], xmm0
	movzx	eax, WORD PTR L$[rip]
	movzx	edx, ax
	mov	rax, rdx
	sal	rax, 2
	add	rax, rdx
	sal	rax, 2
	lea	rdx, 44[rax]
	mov	rax, QWORD PTR -120[rbp]
	add	rax, rdx
	mov	QWORD PTR -176[rbp], rax
	lea	rax, ASTEROID$[rip+2736]
	movss	xmm1, DWORD PTR [rax]
	movss	xmm0, DWORD PTR X$[rip]
	mulss	xmm1, xmm0
	lea	rax, ASTEROID$[rip+2732]
	movss	xmm2, DWORD PTR [rax]
	movss	xmm0, DWORD PTR Y$[rip]
	mulss	xmm0, xmm2
	addss	xmm0, xmm1
	mov	rax, QWORD PTR -176[rbp]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR -176[rbp]
	lea	rdx, 4[rax]
	movss	xmm1, DWORD PTR X$[rip]
	movss	xmm0, DWORD PTR .LC9[rip]
	xorps	xmm0, xmm1
	lea	rax, ASTEROID$[rip+2732]
	movss	xmm1, DWORD PTR [rax]
	mulss	xmm1, xmm0
	lea	rax, ASTEROID$[rip+2736]
	movss	xmm2, DWORD PTR [rax]
	movss	xmm0, DWORD PTR Y$[rip]
	mulss	xmm0, xmm2
	addss	xmm0, xmm1
	movss	DWORD PTR [rdx], xmm0
	mov	rax, QWORD PTR -176[rbp]
	add	rax, 16
	mov	BYTE PTR [rax], 96
	mov	rax, QWORD PTR -176[rbp]
	add	rax, 17
	mov	BYTE PTR [rax], 72
	mov	rax, QWORD PTR -176[rbp]
	add	rax, 18
	mov	BYTE PTR [rax], 72
.L145:
	movzx	eax, WORD PTR L$[rip]
	add	eax, 1
	mov	WORD PTR L$[rip], ax
.L143:
	movzx	eax, WORD PTR L$[rip]
	cmp	ax, WORD PTR -154[rbp]
	jbe	.L197
.L146:
	lea	rax, SHIP$[rip]
	mov	QWORD PTR -184[rbp], rax
	mov	rax, QWORD PTR -184[rbp]
	mov	BYTE PTR [rax], 1
	movss	xmm0, DWORD PTR .LC5[rip]
	call	fb_Rnd
	movq	rax, xmm0
	mov	QWORD PTR -192[rbp], rax
	mov	rax, QWORD PTR -184[rbp]
	sub	rax, -128
	movsd	xmm1, QWORD PTR -192[rbp]
	movsd	xmm0, QWORD PTR .LC10[rip]
	mulsd	xmm0, xmm1
	cvtsd2ss	xmm0, xmm0
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR -184[rbp]
	add	rax, 132
	movss	xmm0, DWORD PTR .LC28[rip]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR -184[rbp]
	add	rax, 4
	mov	QWORD PTR -200[rbp], rax
	mov	rax, QWORD PTR -200[rbp]
	lea	rbx, 4[rax]
	lea	rax, ASTEROID$[rip+1380]
	movss	xmm6, DWORD PTR [rax]
	lea	rax, SHIP$[rip+132]
	movss	xmm7, DWORD PTR [rax]
	lea	rax, SHIP$[rip+128]
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR -392[rbp], eax
	movss	xmm0, DWORD PTR -392[rbp]
	call	sinf
	mulss	xmm0, xmm7
	addss	xmm0, xmm6
	movss	DWORD PTR [rbx], xmm0
	mov	rax, QWORD PTR -200[rbp]
	lea	rbx, 8[rax]
	lea	rax, ASTEROID$[rip+1384]
	movss	xmm6, DWORD PTR [rax]
	lea	rax, SHIP$[rip+132]
	movss	xmm7, DWORD PTR [rax]
	lea	rax, SHIP$[rip+128]
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR -392[rbp], eax
	movss	xmm0, DWORD PTR -392[rbp]
	call	cosf
	mulss	xmm0, xmm7
	addss	xmm0, xmm6
	movss	DWORD PTR [rbx], xmm0
	mov	rax, QWORD PTR -200[rbp]
	lea	rbx, 12[rax]
	lea	rax, ASTEROID$[rip+1388]
	movss	xmm6, DWORD PTR [rax]
	lea	rax, ASTEROID$[rip+1408]
	movss	xmm0, DWORD PTR [rax]
	lea	rax, SHIP$[rip+132]
	movss	xmm1, DWORD PTR [rax]
	divss	xmm0, xmm1
	sqrtss	xmm0, xmm0
	movaps	xmm7, xmm0
	lea	rax, SHIP$[rip+128]
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR -392[rbp], eax
	movss	xmm0, DWORD PTR -392[rbp]
	call	cosf
	mulss	xmm0, xmm7
	addss	xmm0, xmm6
	movss	DWORD PTR [rbx], xmm0
	mov	rax, QWORD PTR -200[rbp]
	lea	rbx, 16[rax]
	lea	rax, ASTEROID$[rip+1392]
	movss	xmm6, DWORD PTR [rax]
	lea	rax, ASTEROID$[rip+1408]
	movss	xmm0, DWORD PTR [rax]
	lea	rax, SHIP$[rip+132]
	movss	xmm1, DWORD PTR [rax]
	divss	xmm0, xmm1
	sqrtss	xmm0, xmm0
	movaps	xmm7, xmm0
	lea	rax, SHIP$[rip+128]
	movss	xmm1, DWORD PTR [rax]
	movss	xmm0, DWORD PTR .LC9[rip]
	xorps	xmm0, xmm1
	call	sinf
	mulss	xmm0, xmm7
	addss	xmm0, xmm6
	movss	DWORD PTR [rbx], xmm0
	mov	rax, QWORD PTR -200[rbp]
	add	rax, 32
	movss	xmm0, DWORD PTR .LC18[rip]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR -184[rbp]
	add	rax, 40
	mov	QWORD PTR -208[rbp], rax
	mov	rax, QWORD PTR -208[rbp]
	pxor	xmm0, xmm0
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR -208[rbp]
	add	rax, 4
	movss	xmm0, DWORD PTR .LC29[rip]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR -208[rbp]
	add	rax, 16
	mov	BYTE PTR [rax], -12
	mov	rax, QWORD PTR -208[rbp]
	add	rax, 17
	mov	BYTE PTR [rax], -12
	mov	rax, QWORD PTR -208[rbp]
	add	rax, 18
	mov	BYTE PTR [rax], -12
	mov	rax, QWORD PTR -184[rbp]
	add	rax, 60
	mov	QWORD PTR -216[rbp], rax
	mov	rax, QWORD PTR -216[rbp]
	movss	xmm0, DWORD PTR .LC30[rip]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR -216[rbp]
	add	rax, 4
	movss	xmm0, DWORD PTR .LC25[rip]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR -216[rbp]
	add	rax, 16
	mov	BYTE PTR [rax], -64
	mov	rax, QWORD PTR -216[rbp]
	add	rax, 17
	mov	BYTE PTR [rax], -64
	mov	rax, QWORD PTR -216[rbp]
	add	rax, 18
	mov	BYTE PTR [rax], -64
	mov	rax, QWORD PTR -184[rbp]
	add	rax, 80
	mov	QWORD PTR -224[rbp], rax
	mov	rax, QWORD PTR -224[rbp]
	pxor	xmm0, xmm0
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR -224[rbp]
	add	rax, 4
	movss	xmm0, DWORD PTR .LC31[rip]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR -224[rbp]
	add	rax, 16
	mov	BYTE PTR [rax], -128
	mov	rax, QWORD PTR -224[rbp]
	add	rax, 17
	mov	BYTE PTR [rax], -128
	mov	rax, QWORD PTR -224[rbp]
	add	rax, 18
	mov	BYTE PTR [rax], -128
	mov	rax, QWORD PTR -184[rbp]
	add	rax, 100
	mov	QWORD PTR -232[rbp], rax
	mov	rax, QWORD PTR -232[rbp]
	movss	xmm0, DWORD PTR .LC18[rip]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR -232[rbp]
	add	rax, 4
	movss	xmm0, DWORD PTR .LC25[rip]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR -232[rbp]
	add	rax, 16
	mov	BYTE PTR [rax], -64
	mov	rax, QWORD PTR -232[rbp]
	add	rax, 17
	mov	BYTE PTR [rax], -64
	mov	rax, QWORD PTR -232[rbp]
	add	rax, 18
	mov	BYTE PTR [rax], -64
	mov	rax, QWORD PTR -184[rbp]
	add	rax, 120
	movss	xmm0, DWORD PTR .LC27[rip]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR -184[rbp]
	add	rax, 124
	movss	xmm0, DWORD PTR .LC32[rip]
	movss	DWORD PTR [rax], xmm0
	movss	xmm0, DWORD PTR .LC5[rip]
	call	fb_Rnd
	movq	rax, xmm0
	mov	QWORD PTR -240[rbp], rax
	mov	rax, QWORD PTR -184[rbp]
	sub	rax, -128
	movsd	xmm1, QWORD PTR -240[rbp]
	movsd	xmm0, QWORD PTR .LC10[rip]
	mulsd	xmm0, xmm1
	cvtsd2ss	xmm0, xmm0
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR -184[rbp]
	add	rax, 132
	movss	xmm0, DWORD PTR .LC15[rip]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR -184[rbp]
	add	rax, 148
	movss	xmm0, DWORD PTR .LC31[rip]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR -184[rbp]
	add	rax, 152
	movss	xmm0, DWORD PTR .LC33[rip]
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR -184[rbp]
	add	rax, 156
	mov	BYTE PTR [rax], 0
	mov	WORD PTR L$[rip], 1
.L147:
	movzx	eax, WORD PTR L$[rip]
	movzx	eax, ax
	sal	rax, 2
	mov	rdx, rax
	sal	rdx, 4
	sub	rdx, rax
	mov	rax, rdx
	lea	rdx, 100[rax]
	mov	rax, QWORD PTR -184[rbp]
	add	rax, rdx
	mov	QWORD PTR -248[rbp], rax
	movss	xmm0, DWORD PTR .LC5[rip]
	call	fb_Rnd
	movq	rax, xmm0
	mov	QWORD PTR -256[rbp], rax
	mov	rax, QWORD PTR -248[rbp]
	add	rax, 44
	movsd	xmm0, QWORD PTR -256[rbp]
	addsd	xmm0, xmm0
	movsd	xmm1, QWORD PTR .LC34[rip]
	addsd	xmm0, xmm1
	cvtsd2ss	xmm0, xmm0
	movss	DWORD PTR [rax], xmm0
	mov	rax, QWORD PTR -248[rbp]
	mov	BYTE PTR [rax], 0
	movss	xmm0, DWORD PTR .LC5[rip]
	call	fb_Rnd
	movq	rax, xmm0
	mov	QWORD PTR -264[rbp], rax
	mov	rax, QWORD PTR -248[rbp]
	lea	rbx, 52[rax]
	movsd	xmm1, QWORD PTR -264[rbp]
	movsd	xmm0, QWORD PTR .LC35[rip]
	mulsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR .LC36[rip]
	addsd	xmm0, xmm1
	call	nearbyint
	cvttsd2si	eax, xmm0
	mov	WORD PTR [rbx], ax
	mov	rax, QWORD PTR -248[rbp]
	add	rax, 4
	mov	QWORD PTR -272[rbp], rax
	mov	rax, QWORD PTR -272[rbp]
	mov	BYTE PTR [rax], -1
	mov	rax, QWORD PTR -272[rbp]
	add	rax, 1
	mov	BYTE PTR [rax], -1
	mov	rax, QWORD PTR -272[rbp]
	add	rax, 2
	mov	BYTE PTR [rax], -1
.L148:
	movzx	eax, WORD PTR L$[rip]
	add	eax, 1
	mov	WORD PTR L$[rip], ax
.L149:
	movzx	eax, WORD PTR L$[rip]
	cmp	ax, 30
	ja	.L150
	jmp	.L147
.L150:
	mov	edx, 0
	lea	rcx, .LC37[rip]
	call	fb_StrAllocTempDescZEx
	mov	QWORD PTR -280[rbp], rax
	mov	QWORD PTR -368[rbp], 0
	mov	QWORD PTR -360[rbp], 0
	mov	QWORD PTR -352[rbp], 0
	lea	rdx, -352[rbp]
	mov	rax, QWORD PTR -280[rbp]
	mov	QWORD PTR 48[rsp], rax
	lea	rax, -368[rbp]
	mov	QWORD PTR 40[rsp], rax
	lea	rax, -360[rbp]
	mov	QWORD PTR 32[rsp], rax
	mov	r9, rdx
	lea	r8, SCRN_BPP$[rip]
	lea	rdx, SCRN_HGT$[rip]
	lea	rcx, SCRN_WID$[rip]
	call	fb_GfxScreenInfo
	mov	rax, QWORD PTR SCRN_WID$[rip]
	shr	rax, 63
	mov	rdx, rax
	mov	rax, QWORD PTR SCRN_WID$[rip]
	add	rax, rdx
	sar	rax
	mov	QWORD PTR SCRN_X_MID$[rip], rax
	mov	rax, QWORD PTR SCRN_HGT$[rip]
	shr	rax, 63
	mov	rdx, rax
	mov	rax, QWORD PTR SCRN_HGT$[rip]
	add	rax, rdx
	sar	rax
	mov	QWORD PTR SCRN_Y_MID$[rip], rax
	movss	xmm0, DWORD PTR .LC38[rip]
	movss	DWORD PTR POS_FACTOR$[rip], xmm0
	mov	QWORD PTR SCRN_FULL$[rip], 1
	mov	BYTE PTR ACTIVE$[rip], 1
	movzx	eax, BYTE PTR ACTIVE$[rip]
	movzx	eax, al
	imul	rax, rax, 9160
	lea	rdx, -9160[rax]
	lea	rax, SHIP$[rip]
	add	rax, rdx
	mov	rcx, rax
	call	UPDATE_SHIP_ANGLE
	lea	rax, ASTEROID$[rip+1372]
	mov	rcx, rax
	call	UPDATE_ASTEROID_ANGLE
	call	INITIALIZE_OPENGL_2D
	mov	r9d, -1
	mov	r8d, 0
	mov	edx, -2147483648
	mov	ecx, -2147483648
	call	fb_SetMouse
.L151:
	movzx	eax, BYTE PTR ACTIVE$[rip]
	movzx	eax, al
	imul	rax, rax, 9160
	lea	rdx, -9160[rax]
	lea	rax, SHIP$[rip]
	add	rax, rdx
	mov	QWORD PTR -288[rbp], rax
	lea	rax, CONTROLS$[rip]
	movzx	eax, BYTE PTR [rax]
	movzx	eax, al
	mov	ecx, eax
	call	fb_Multikey
	mov	DWORD PTR -292[rbp], eax
	cmp	DWORD PTR -292[rbp], 0
	je	.L198
	mov	rax, QWORD PTR -288[rbp]
	add	rax, 136
	mov	rdx, QWORD PTR -288[rbp]
	add	rdx, 136
	movss	xmm0, DWORD PTR [rdx]
	movss	xmm1, DWORD PTR .LC31[rip]
	subss	xmm0, xmm1
	movss	DWORD PTR [rax], xmm0
	movzx	eax, BYTE PTR ACTIVE$[rip]
	movzx	eax, al
	imul	rax, rax, 9160
	lea	rdx, -9160[rax]
	lea	rax, SHIP$[rip]
	add	rax, rdx
	mov	rcx, rax
	call	UPDATE_SHIP_ANGLE
	jmp	.L154
.L153:
.L198:
	nop
.L154:
	lea	rax, CONTROLS$[rip+1]
	movzx	eax, BYTE PTR [rax]
	movzx	eax, al
	mov	ecx, eax
	call	fb_Multikey
	mov	DWORD PTR -296[rbp], eax
	cmp	DWORD PTR -296[rbp], 0
	je	.L199
	mov	rax, QWORD PTR -288[rbp]
	add	rax, 136
	mov	rdx, QWORD PTR -288[rbp]
	add	rdx, 136
	movss	xmm1, DWORD PTR [rdx]
	movss	xmm0, DWORD PTR .LC31[rip]
	addss	xmm0, xmm1
	movss	DWORD PTR [rax], xmm0
	movzx	eax, BYTE PTR ACTIVE$[rip]
	movzx	eax, al
	imul	rax, rax, 9160
	lea	rdx, -9160[rax]
	lea	rax, SHIP$[rip]
	add	rax, rdx
	mov	rcx, rax
	call	UPDATE_SHIP_ANGLE
	jmp	.L157
.L156:
.L199:
	nop
.L157:
	lea	rax, CONTROLS$[rip+2]
	movzx	eax, BYTE PTR [rax]
	movzx	eax, al
	mov	ecx, eax
	call	fb_Multikey
	mov	DWORD PTR -300[rbp], eax
	cmp	DWORD PTR -300[rbp], 0
	je	.L200
	call	BURST
	jmp	.L160
.L159:
.L200:
	nop
.L160:
	mov	WORD PTR K$[rip], 1
.L161:
	movzx	eax, WORD PTR K$[rip]
	add	eax, 1
	mov	WORD PTR L$[rip], ax
	jmp	.L162
.L202:
	nop
.L163:
	movzx	eax, WORD PTR L$[rip]
	movzx	eax, ax
	imul	rax, rax, 1372
	lea	rdx, -1368[rax]
	lea	rax, ASTEROID$[rip]
	add	rdx, rax
	movzx	eax, WORD PTR K$[rip]
	movzx	eax, ax
	imul	rax, rax, 1372
	lea	rcx, -1368[rax]
	lea	rax, ASTEROID$[rip]
	add	rax, rcx
	mov	rcx, rax
	call	FIND_DIST
	movzx	eax, WORD PTR K$[rip]
	cmp	ax, 1
	jne	.L201
	movzx	eax, WORD PTR L$[rip]
	movzx	eax, ax
	imul	rax, rax, 1372
	lea	rdx, -1368[rax]
	lea	rax, ASTEROID$[rip]
	add	rdx, rax
	movzx	eax, WORD PTR K$[rip]
	movzx	eax, ax
	imul	rax, rax, 1372
	lea	rcx, -1368[rax]
	lea	rax, ASTEROID$[rip]
	add	rax, rcx
	mov	rcx, rax
	call	G_FORCE_1WAY
	jmp	.L167
.L201:
	nop
.L165:
	movzx	eax, WORD PTR L$[rip]
	movzx	eax, ax
	imul	rax, rax, 1372
	lea	rdx, -1368[rax]
	lea	rax, ASTEROID$[rip]
	add	rdx, rax
	movzx	eax, WORD PTR K$[rip]
	movzx	eax, ax
	imul	rax, rax, 1372
	lea	rcx, -1368[rax]
	lea	rax, ASTEROID$[rip]
	add	rax, rcx
	mov	rcx, rax
	call	G_FORCE_2WAY
.L166:
.L167:
	movzx	eax, WORD PTR L$[rip]
	add	eax, 1
	mov	WORD PTR L$[rip], ax
.L162:
	movzx	eax, WORD PTR L$[rip]
	cmp	ax, 2
	jbe	.L202
.L168:
	movzx	eax, BYTE PTR ACTIVE$[rip]
	movzx	eax, al
	imul	rax, rax, 9160
	lea	rdx, -9156[rax]
	lea	rax, SHIP$[rip]
	add	rdx, rax
	movzx	eax, WORD PTR K$[rip]
	movzx	eax, ax
	imul	rax, rax, 1372
	lea	rcx, -1368[rax]
	lea	rax, ASTEROID$[rip]
	add	rax, rcx
	mov	rcx, rax
	call	FIND_DIST
	movzx	eax, BYTE PTR ACTIVE$[rip]
	movzx	eax, al
	imul	rax, rax, 9160
	lea	rdx, -9156[rax]
	lea	rax, SHIP$[rip]
	add	rdx, rax
	movzx	eax, WORD PTR K$[rip]
	movzx	eax, ax
	imul	rax, rax, 1372
	lea	rcx, -1368[rax]
	lea	rax, ASTEROID$[rip]
	add	rax, rcx
	mov	rcx, rax
	call	G_FORCE_1WAY
	movzx	eax, BYTE PTR ACTIVE$[rip]
	movzx	eax, al
	imul	rax, rax, 9160
	lea	rdx, -9160[rax]
	lea	rax, SHIP$[rip]
	add	rdx, rax
	movzx	eax, WORD PTR K$[rip]
	movzx	eax, ax
	imul	rax, rax, 1372
	lea	rcx, -1372[rax]
	lea	rax, ASTEROID$[rip]
	add	rax, rcx
	mov	rcx, rax
	call	ASTR_SHIP_COLDETEC1
	mov	QWORD PTR -312[rbp], rax
	pxor	xmm0, xmm0
	cvtsi2ssq	xmm0, QWORD PTR -312[rbp]
	movss	DWORD PTR COLLISION$[rip], xmm0
	movss	xmm0, DWORD PTR COLLISION$[rip]
	movss	xmm1, DWORD PTR .LC5[rip]
	ucomiss	xmm0, xmm1
	jp	.L203
	movss	xmm1, DWORD PTR .LC5[rip]
	ucomiss	xmm0, xmm1
	jne	.L203
	movzx	eax, BYTE PTR ACTIVE$[rip]
	movzx	eax, al
	imul	rax, rax, 9160
	lea	rdx, -9160[rax]
	lea	rax, SHIP$[rip]
	add	rdx, rax
	movzx	eax, WORD PTR K$[rip]
	movzx	eax, ax
	imul	rax, rax, 1372
	lea	rcx, -1372[rax]
	lea	rax, ASTEROID$[rip]
	add	rax, rcx
	mov	rcx, rax
	call	ASTR_SHIP_COLDETEC2
	mov	QWORD PTR -320[rbp], rax
	pxor	xmm0, xmm0
	cvtsi2ssq	xmm0, QWORD PTR -320[rbp]
	movss	DWORD PTR COLLISION$[rip], xmm0
	jmp	.L173
.L171:
.L172:
.L203:
	nop
.L173:
	movzx	eax, WORD PTR K$[rip]
	add	eax, 1
	mov	WORD PTR K$[rip], ax
.L174:
	movzx	eax, WORD PTR K$[rip]
	cmp	ax, 2
	ja	.L175
	jmp	.L161
.L175:
	movzx	eax, BYTE PTR ACTIVE$[rip]
	movzx	eax, al
	imul	rax, rax, 9160
	lea	rdx, -9160[rax]
	lea	rax, SHIP$[rip]
	add	rax, rdx
	mov	QWORD PTR -328[rbp], rax
	mov	rax, QWORD PTR -328[rbp]
	add	rax, 4
	mov	rcx, rax
	call	UPDATE_POS
	mov	WORD PTR K$[rip], 1
.L176:
	movzx	eax, WORD PTR K$[rip]
	movzx	eax, ax
	sal	rax, 2
	mov	rdx, rax
	sal	rdx, 4
	sub	rdx, rax
	mov	rax, rdx
	lea	rdx, 100[rax]
	mov	rax, QWORD PTR -328[rbp]
	add	rax, rdx
	mov	QWORD PTR -336[rbp], rax
	mov	rax, QWORD PTR -336[rbp]
	add	rax, 4
	mov	rcx, rax
	call	UPDATE_POS
.L177:
	movzx	eax, WORD PTR K$[rip]
	add	eax, 1
	mov	WORD PTR K$[rip], ax
.L178:
	movzx	eax, WORD PTR K$[rip]
	cmp	ax, 30
	ja	.L179
	jmp	.L176
.L179:
	mov	WORD PTR K$[rip], 1
.L180:
	movzx	eax, WORD PTR K$[rip]
	movzx	eax, ax
	imul	rax, rax, 1372
	lea	rdx, -1372[rax]
	lea	rax, ASTEROID$[rip]
	add	rax, rdx
	mov	rcx, rax
	call	UPDATE_ASTEROID_ANGLE
	movzx	eax, WORD PTR K$[rip]
	movzx	eax, ax
	imul	rax, rax, 1372
	lea	rdx, -1368[rax]
	lea	rax, ASTEROID$[rip]
	add	rax, rdx
	mov	rcx, rax
	call	UPDATE_POS
.L181:
	movzx	eax, WORD PTR K$[rip]
	add	eax, 1
	mov	WORD PTR K$[rip], ax
.L182:
	movzx	eax, WORD PTR K$[rip]
	cmp	ax, 2
	ja	.L183
	jmp	.L180
.L183:
	mov	ecx, 16640
	call	glClear
	call	DRAW_BURST
	movzx	eax, BYTE PTR ACTIVE$[rip]
	movzx	eax, al
	imul	rax, rax, 9160
	lea	rdx, -9160[rax]
	lea	rax, SHIP$[rip]
	add	rax, rdx
	mov	rcx, rax
	call	DRAW_SHIP
	mov	WORD PTR K$[rip], 1
.L184:
	movzx	eax, WORD PTR K$[rip]
	movzx	eax, ax
	imul	rax, rax, 1372
	lea	rdx, -1372[rax]
	lea	rax, ASTEROID$[rip]
	add	rax, rdx
	mov	rcx, rax
	call	DRAW_ASTEROID
.L185:
	movzx	eax, WORD PTR K$[rip]
	add	eax, 1
	mov	WORD PTR K$[rip], ax
.L186:
	movzx	eax, WORD PTR K$[rip]
	cmp	ax, 2
	ja	.L187
	jmp	.L184
.L187:
	call	glFlush
	mov	edx, -1
	mov	ecx, -1
	call	fb_GfxFlip
	call	fb_GfxWaitVSync
.L188:
	lea	rax, CONTROLS$[rip+3]
	movzx	eax, BYTE PTR [rax]
	movzx	eax, al
	mov	ecx, eax
	call	fb_Multikey
	mov	DWORD PTR -340[rbp], eax
	cmp	DWORD PTR -340[rbp], 0
	jne	.L189
	jmp	.L151
.L189:
	mov	ecx, 0
	call	fb_End
.L190:
	mov	ecx, 0
	call	fb_End
	mov	eax, DWORD PTR -372[rbp]
	movaps	xmm6, XMMWORD PTR -48[rbp]
	movaps	xmm7, XMMWORD PTR -32[rbp]
	add	rsp, 456
	pop	rbx
	pop	rbp
	ret
	.section .rdata,"dr"
	.align 8
.LC0:
	.long	0
	.long	1080033280
	.align 8
.LC1:
	.long	0
	.long	-1067450368
	.align 4
.LC3:
	.long	1036831949
	.align 4
.LC4:
	.long	1016003125
	.align 4
.LC5:
	.long	1065353216
	.align 8
.LC7:
	.long	1202590843
	.long	1065646817
	.align 8
.LC8:
	.long	858993459
	.long	1070805811
	.align 16
.LC9:
	.long	-2147483648
	.long	0
	.long	0
	.long	0
	.align 8
.LC10:
	.long	1610612736
	.long	1075388923
	.align 4
.LC11:
	.long	1086918619
	.align 4
.LC12:
	.long	1073741824
	.align 8
.LC13:
	.long	0
	.long	1073741824
	.align 4
.LC14:
	.long	1126170624
	.align 4
.LC15:
	.long	1140457472
	.align 8
.LC16:
	.long	0
	.long	1081507840
	.align 4
.LC17:
	.long	-1119040307
	.align 4
.LC18:
	.long	1092616192
	.align 8
.LC19:
	.long	0
	.long	1077149696
	.align 4
.LC20:
	.long	1109393408
	.align 4
.LC21:
	.long	1139802112
	.align 8
.LC22:
	.long	-343597384
	.long	1072609361
	.align 4
.LC23:
	.long	1112014848
	.align 4
.LC24:
	.long	1050253722
	.align 4
.LC25:
	.long	1090519040
	.align 8
.LC26:
	.long	0
	.long	1076887552
	.align 4
.LC27:
	.long	1101004800
	.align 4
.LC28:
	.long	1117782016
	.align 4
.LC29:
	.long	-1050673152
	.align 4
.LC30:
	.long	-1054867456
	.align 4
.LC31:
	.long	1086324736
	.align 4
.LC32:
	.long	1096810496
	.align 4
.LC33:
	.long	1069547520
	.align 8
.LC34:
	.long	0
	.long	1072693248
	.align 8
.LC35:
	.long	0
	.long	1074790400
	.align 8
.LC36:
	.long	0
	.long	1075838976
	.align 4
.LC38:
	.long	1053004044
	.ident	"GCC: (x86_64-win32-sjlj-rev0, Built by MinGW-W64 project) 5.2.0"
	.def	fb_GfxScreenRes;	.scl	2;	.type	32;	.endef
	.def	glMatrixMode;	.scl	2;	.type	32;	.endef
	.def	glLoadIdentity;	.scl	2;	.type	32;	.endef
	.def	glViewport;	.scl	2;	.type	32;	.endef
	.def	glOrtho;	.scl	2;	.type	32;	.endef
	.def	glEnable;	.scl	2;	.type	32;	.endef
	.def	glCullFace;	.scl	2;	.type	32;	.endef
	.def	glDepthFunc;	.scl	2;	.type	32;	.endef
	.def	glAlphaFunc;	.scl	2;	.type	32;	.endef
	.def	glBlendFunc;	.scl	2;	.type	32;	.endef
	.def	cosf;	.scl	2;	.type	32;	.endef
	.def	sinf;	.scl	2;	.type	32;	.endef
	.def	glTranslatef;	.scl	2;	.type	32;	.endef
	.def	glColor3ub;	.scl	2;	.type	32;	.endef
	.def	glPointSize;	.scl	2;	.type	32;	.endef
	.def	glBegin;	.scl	2;	.type	32;	.endef
	.def	glVertex2f;	.scl	2;	.type	32;	.endef
	.def	glEnd;	.scl	2;	.type	32;	.endef
	.def	fb_Rnd;	.scl	2;	.type	32;	.endef
	.def	pow;	.scl	2;	.type	32;	.endef
	.def	fb_Init;	.scl	2;	.type	32;	.endef
	.def	fb_Timer;	.scl	2;	.type	32;	.endef
	.def	fb_Randomize;	.scl	2;	.type	32;	.endef
	.def	nearbyint;	.scl	2;	.type	32;	.endef
	.def	fb_StrAllocTempDescZEx;	.scl	2;	.type	32;	.endef
	.def	fb_GfxScreenInfo;	.scl	2;	.type	32;	.endef
	.def	fb_SetMouse;	.scl	2;	.type	32;	.endef
	.def	fb_Multikey;	.scl	2;	.type	32;	.endef
	.def	glClear;	.scl	2;	.type	32;	.endef
	.def	glFlush;	.scl	2;	.type	32;	.endef
	.def	fb_GfxFlip;	.scl	2;	.type	32;	.endef
	.def	fb_GfxWaitVSync;	.scl	2;	.type	32;	.endef
	.def	fb_End;	.scl	2;	.type	32;	.endef
