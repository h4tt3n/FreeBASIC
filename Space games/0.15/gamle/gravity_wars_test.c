typedef   signed char       int8;
typedef unsigned char      uint8;
typedef   signed short      int16;
typedef unsigned short     uint16;
typedef   signed int        int32;
typedef unsigned int       uint32;
typedef   signed long long  int64;
typedef unsigned long long uint64;
typedef struct { char *data; int64 len; int64 size; } FBSTRING;
typedef int8 boolean;
#define fb_D2L( value ) ((int64)__builtin_nearbyint( value ))
int32 fb_Color( int32, int32, int32 );
void fb_GfxPset( void*, float, float, uint32, int32, int32 );
void fb_GfxLine( void*, float, float, float, float, uint32, int32, uint32, int32 );
void fb_GfxPaint( void*, float, float, uint32, uint32, FBSTRING*, int32, int32 );
void fb_Randomize( double, int32 );
double fb_Rnd( float );
FBSTRING* fb_StrAllocTempDescZEx( uint8*, int64 );
void fb_Init( int32, uint8**, int32 );
void fb_End( int32 );
double fb_Timer( void );
int64 REC( double, double );
static int64 XREC$;
static int64 YREC$;
static double TPOL$;
static double RPOL$;

int64 REC( double RPOL$1, double TPOL$1 )
{
	int64 fb$result$1;
	__builtin_memset( &fb$result$1, 0, 8ll );
	label$3:;
	XREC$ = fb_D2L( __builtin_cos( (TPOL$1 * 0x1.1DF46A2529D39p-6) ) * RPOL$1 );
	YREC$ = fb_D2L( __builtin_sin( (TPOL$1 * 0x1.1DF46A2529D39p-6) ) * RPOL$1 );
	label$4:;
	return fb$result$1;
}

int64 POL( double XREC$1, double YREC$1 )
{
	int64 fb$result$1;
	__builtin_memset( &fb$result$1, 0, 8ll );
	label$5:;
	RPOL$ = __builtin_sqrt( ((XREC$1 * XREC$1) + (YREC$1 * YREC$1)) );
	TPOL$ = __builtin_atan( (YREC$1 / XREC$1) ) / 0x1.1DF46A2529D39p-6;
	if( ((int64)-(XREC$1 < 0x0p+0) & (int64)-(YREC$1 > 0x0p+0)) == 0ll ) goto label$8;
	{
		TPOL$ = TPOL$ + 0x1.68p+7;
		label$8:;
	}
	if( ((int64)-(XREC$1 < 0x0p+0) & (int64)-(YREC$1 <= 0x0p+0)) == 0ll ) goto label$10;
	{
		TPOL$ = TPOL$ + -0x1.68p+7;
		label$10:;
	}
	label$6:;
	return fb$result$1;
}

void DRAWELLIPSE( float CX$1, float CY$1, float WID$1, float HGT$1, float ANGLE$1, int64 COL$1, float* NUM_LINES$1 )
{
	label$11:;
	float SINANGLE$1;
	__builtin_memset( &SINANGLE$1, 0, 4ll );
	float COSANGLE$1;
	__builtin_memset( &COSANGLE$1, 0, 4ll );
	float THETA$1;
	__builtin_memset( &THETA$1, 0, 4ll );
	float DELTATHETA$1;
	__builtin_memset( &DELTATHETA$1, 0, 4ll );
	float X$1;
	__builtin_memset( &X$1, 0, 4ll );
	float Y$1;
	__builtin_memset( &Y$1, 0, 4ll );
	float RX$1;
	__builtin_memset( &RX$1, 0, 4ll );
	float RY$1;
	__builtin_memset( &RY$1, 0, 4ll );
	float CURRENTX$1;
	__builtin_memset( &CURRENTX$1, 0, 4ll );
	float CURRENTY$1;
	__builtin_memset( &CURRENTY$1, 0, 4ll );
	ANGLE$1 = (float)((double)ANGLE$1 * 0x1.1DF46A2529D39p-6);
	SINANGLE$1 = __builtin_sinf( ANGLE$1 );
	COSANGLE$1 = __builtin_cosf( ANGLE$1 );
	THETA$1 = 0x0p+0f;
	DELTATHETA$1 = *NUM_LINES$1;
	X$1 = WID$1 * __builtin_cosf( THETA$1 );
	Y$1 = HGT$1 * __builtin_sinf( THETA$1 );
	RX$1 = (CX$1 + (X$1 * COSANGLE$1)) + (Y$1 * SINANGLE$1);
	RY$1 = (CY$1 - (X$1 * SINANGLE$1)) + (Y$1 * COSANGLE$1);
	CURRENTX$1 = RX$1;
	CURRENTY$1 = RY$1;
	fb_GfxPset( (void*)0ull, CURRENTX$1, CURRENTY$1, (uint32)COL$1, 4, 0 );
	label$13:;
	if( (double)THETA$1 >= 0x1.921FB54442D18p+2 ) goto label$14;
	{
		THETA$1 = THETA$1 + DELTATHETA$1;
		X$1 = WID$1 * __builtin_cosf( THETA$1 );
		Y$1 = HGT$1 * __builtin_sinf( THETA$1 );
		RX$1 = (CX$1 + (X$1 * COSANGLE$1)) + (Y$1 * SINANGLE$1);
		RY$1 = (CY$1 - (X$1 * SINANGLE$1)) + (Y$1 * COSANGLE$1);
		fb_GfxLine( (void*)0ull, 0x0p+0f, 0x0p+0f, RX$1, RY$1, (uint32)COL$1, 0, 65535u, 2 );
	}
	goto label$13;
	label$14:;
	label$12:;
}

void DRAWSHIP( double SHIP_X$1, double SHIP_Y$1, double SHIP_ANGLE$1, int64 SHIP_COL$1 )
{
	label$15:;
	double HEAD$1;
	HEAD$1 = 0x0p+0;
	double RGHT$1;
	RGHT$1 = 0x1.C8p+7;
	double TAIL$1;
	TAIL$1 = 0x1.68p+7;
	double L3FT$1;
	L3FT$1 = 0x1.08p+7;
	double SIZE$1;
	SIZE$1 = 0x1.p+4;
	double OLDX$1;
	__builtin_memset( &OLDX$1, 0, 8ll );
	double OLDY$1;
	__builtin_memset( &OLDY$1, 0, 8ll );
	fb_Color( (int32)SHIP_COL$1, 0, 2 );
	REC( SIZE$1, HEAD$1 - SHIP_ANGLE$1 );
	OLDX$1 = (double)XREC$;
	OLDY$1 = (double)YREC$;
	REC( SIZE$1, RGHT$1 - SHIP_ANGLE$1 );
	fb_GfxLine( (void*)0ull, (float)(SHIP_X$1 + OLDX$1), (float)(SHIP_Y$1 + OLDY$1), (float)(SHIP_X$1 + (double)XREC$), (float)(SHIP_Y$1 + (double)YREC$), 0u, 0, 65535u, -2147483648u );
	REC( SIZE$1 * 0x1.p-1, TAIL$1 - SHIP_ANGLE$1 );
	fb_GfxLine( (void*)0ull, 0x0p+0f, 0x0p+0f, (float)(SHIP_X$1 + (double)XREC$), (float)(SHIP_Y$1 + (double)YREC$), 0u, 0, 65535u, -2147483646 );
	REC( SIZE$1, L3FT$1 - SHIP_ANGLE$1 );
	fb_GfxLine( (void*)0ull, 0x0p+0f, 0x0p+0f, (float)(SHIP_X$1 + (double)XREC$), (float)(SHIP_Y$1 + (double)YREC$), 0u, 0, 65535u, -2147483646 );
	fb_GfxLine( (void*)0ull, 0x0p+0f, 0x0p+0f, (float)(SHIP_X$1 + OLDX$1), (float)(SHIP_Y$1 + OLDY$1), 0u, 0, 65535u, -2147483646 );
	FBSTRING* vr$36 = fb_StrAllocTempDescZEx( (uint8*)"", 0ll );
	fb_GfxPaint( (void*)0ull, (float)SHIP_X$1, (float)SHIP_Y$1, (uint32)SHIP_COL$1, 0u, vr$36, 0, 1073741828 );
	label$16:;
}
