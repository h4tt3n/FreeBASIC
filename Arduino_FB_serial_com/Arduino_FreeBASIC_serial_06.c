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
struct $12ONDELAYTIMER {
	int64 TIME1;
	int64 DURATION;
};
#define __FB_STATIC_ASSERT( expr ) extern int __$fb_structsizecheck[(expr) ? 1 : -1]
__FB_STATIC_ASSERT( sizeof( struct $12ONDELAYTIMER ) == 16 );
typedef int64 $10TIMER_ENUM;
typedef int64 $10STYLE_ENUM;
struct $9COMPONENT {
	FBSTRING TITLE;
	int64 ROW1;
	int64 COL1;
	int64 ROWS;
	int64 COLS;
	FBSTRING TEXT;
	boolean SCROLL;
	int64 MAXREMOVECHAR;
	$10TIMER_ENUM TIMERID;
	$10STYLE_ENUM STYLE;
	int64 EOLCHAR;
	int64 BORDERCOLOR;
};
__FB_STATIC_ASSERT( sizeof( struct $9COMPONENT ) == 128 );
struct $16__FB_ARRAYDIMTB$ {
	int64 ELEMENTS;
	int64 LBOUND;
	int64 UBOUND;
};
__FB_STATIC_ASSERT( sizeof( struct $16__FB_ARRAYDIMTB$ ) == 24 );
struct $8FBARRAY1I12ONDELAYTIMERE {
	struct $12ONDELAYTIMER* DATA;
	struct $12ONDELAYTIMER* PTR;
	int64 SIZE;
	int64 ELEMENT_LEN;
	int64 DIMENSIONS;
	struct $16__FB_ARRAYDIMTB$ DIMTB[1];
};
__FB_STATIC_ASSERT( sizeof( struct $8FBARRAY1I12ONDELAYTIMERE ) == 64 );
struct $8FBARRAY1I9COMPONENTE {
	struct $9COMPONENT* DATA;
	struct $9COMPONENT* PTR;
	int64 SIZE;
	int64 ELEMENT_LEN;
	int64 DIMENSIONS;
	struct $16__FB_ARRAYDIMTB$ DIMTB[1];
};
__FB_STATIC_ASSERT( sizeof( struct $8FBARRAY1I9COMPONENTE ) == 64 );
struct $7FBARRAYIvE {
	void* DATA;
	void* PTR;
	int64 SIZE;
	int64 ELEMENT_LEN;
	int64 DIMENSIONS;
	struct $16__FB_ARRAYDIMTB$ DIMTB[8];
};
__FB_STATIC_ASSERT( sizeof( struct $7FBARRAYIvE ) == 232 );
#define fb_F2L( value ) ((int64)__builtin_nearbyintf( value ))
void fb_ArrayDestructObj( struct $7FBARRAYIvE*, void* );
int32 fb_Locate( int32, int32, int32, int32, int32 );
void fb_Cls( int32 );
int32 fb_Color( int32, int32, int32 );
FBSTRING* fb_Inkey( void );
void fb_GfxLine( void*, float, float, float, float, uint32, int32, uint32, int32 );
int64 fb_GfxDrawString( void*, float, float, int32, FBSTRING*, uint32, void*, int32, void*, void*, void* );
int32 fb_GfxScreenRes( int32, int32, int32, int32, int32, int32 );
int32 fb_GfxPageSet( int32, int32 );
void fb_PrintString( int32, FBSTRING*, int32 );
int32 fb_PrintUsingInit( FBSTRING* );
int32 fb_PrintUsingLongint( int32, int64, int32 );
int32 fb_PrintUsingEnd( int32 );
FBSTRING* fb_StrInit( void*, int64, void*, int64, int32 );
FBSTRING* fb_StrAssign( void*, int64, void*, int64, int32 );
void fb_StrDelete( FBSTRING* );
int32 fb_hStrDelTemp( FBSTRING* );
FBSTRING* fb_StrConcat( FBSTRING*, void*, int64, void*, int64 );
int32 fb_StrCompare( void*, int64, void*, int64 );
FBSTRING* fb_StrConcatAssign( void*, int64, void*, int64, int32 );
FBSTRING* fb_StrAllocTempResult( FBSTRING* );
FBSTRING* fb_StrAllocTempDescZEx( uint8*, int64 );
FBSTRING* fb_StrMid( FBSTRING*, int64, int64 );
int64 fb_StrLen( void*, int64 );
FBSTRING* fb_CHR( int32, ... );
int64 fb_StrInstr( int64, FBSTRING*, FBSTRING* );
FBSTRING* fb_LEFT( FBSTRING*, int64 );
void fb_Init( int32, uint8**, int32 );
void fb_End( int32 );
int32 fb_SleepEx( int32, int32 );
void _ZN12ONDELAYTIMER8NEXTTICKEv( void );
void _ZN12ONDELAYTIMERC1Eu7INTEGER( struct $12ONDELAYTIMER*, int64 );
boolean _ZN12ONDELAYTIMER6STATUSEv( struct $12ONDELAYTIMER* );
void _ZN12ONDELAYTIMER5RESETEv( struct $12ONDELAYTIMER* );
void _ZN9COMPONENTC1ER8FBSTRINGu7INTEGERS2_S2_S2_S2_10TIMER_ENUM10STYLE_ENUM( struct $9COMPONENT*, FBSTRING*, int64, int64, int64, int64, int64, $10TIMER_ENUM, $10STYLE_ENUM );
void _ZN9COMPONENT3ADDERK8FBSTRING( struct $9COMPONENT*, FBSTRING* );
FBSTRING* _ZN9COMPONENT6REMOVEEu7INTEGERS0_( struct $9COMPONENT*, int64, int64 );
void _ZN9COMPONENT6RENDEREv( struct $9COMPONENT* );
static void _ZN9COMPONENTaSERKS_( struct $9COMPONENT*, struct $9COMPONENT* );
static void _ZN9COMPONENTD1Ev( struct $9COMPONENT* );
extern int64 _ZN12ONDELAYTIMER6TIME0$E;
int64 _ZN12ONDELAYTIMER6TIME0$E;

void _ZN12ONDELAYTIMERC1Eu7INTEGER( struct $12ONDELAYTIMER* THIS$1, int64 IN_DURATION$1 )
{
	label$2:;
	__builtin_memset( (int64*)THIS$1, 0, 8ll );
	__builtin_memset( (int64*)((uint8*)THIS$1 + 8ll), 0, 8ll );
	*(int64*)((uint8*)THIS$1 + 8ll) = IN_DURATION$1;
	label$3:;
}

boolean _ZN12ONDELAYTIMER6STATUSEv( struct $12ONDELAYTIMER* THIS$1 )
{
	boolean fb$result$1;
	__builtin_memset( &fb$result$1, 0, 1ll );
	label$4:;
	fb$result$1 = (boolean)((int64)-(_ZN12ONDELAYTIMER6TIME0$E >= (*(int64*)THIS$1 + *(int64*)((uint8*)THIS$1 + 8ll))) != 0ll);
	goto label$5;
	label$5:;
	return fb$result$1;
}

void _ZN12ONDELAYTIMER8NEXTTICKEv( void )
{
	label$6:;
	_ZN12ONDELAYTIMER6TIME0$E = _ZN12ONDELAYTIMER6TIME0$E + 1ll;
	label$7:;
}

void _ZN12ONDELAYTIMER5RESETEv( struct $12ONDELAYTIMER* THIS$1 )
{
	label$8:;
	*(int64*)THIS$1 = _ZN12ONDELAYTIMER6TIME0$E;
	label$9:;
}

void _ZN9COMPONENTC1ER8FBSTRINGu7INTEGERS2_S2_S2_S2_10TIMER_ENUM10STYLE_ENUM( struct $9COMPONENT* THIS$1, FBSTRING* IN_TITLE$1, int64 IN_ROW1$1, int64 IN_COL1$1, int64 IN_ROWS$1, int64 IN_COLS$1, int64 IN_COLOR$1, $10TIMER_ENUM IN_TIMERID$1, $10STYLE_ENUM IN_STYLE$1 )
{
	label$16:;
	__builtin_memset( (FBSTRING*)THIS$1, 0, 24ll );
	__builtin_memset( (int64*)((uint8*)THIS$1 + 24ll), 0, 8ll );
	__builtin_memset( (int64*)((uint8*)THIS$1 + 32ll), 0, 8ll );
	__builtin_memset( (int64*)((uint8*)THIS$1 + 40ll), 0, 8ll );
	__builtin_memset( (int64*)((uint8*)THIS$1 + 48ll), 0, 8ll );
	__builtin_memset( (FBSTRING*)((uint8*)THIS$1 + 56ll), 0, 24ll );
	__builtin_memset( (boolean*)((uint8*)THIS$1 + 80ll), 0, 1ll );
	__builtin_memset( (int64*)((uint8*)THIS$1 + 88ll), 0, 8ll );
	__builtin_memset( ($10TIMER_ENUM*)((uint8*)THIS$1 + 96ll), 0, 8ll );
	__builtin_memset( ($10STYLE_ENUM*)((uint8*)THIS$1 + 104ll), 0, 8ll );
	__builtin_memset( (int64*)((uint8*)THIS$1 + 112ll), 0, 8ll );
	__builtin_memset( (int64*)((uint8*)THIS$1 + 120ll), 0, 8ll );
	FBSTRING* vr$26 = fb_StrAssign( (void*)THIS$1, -1ll, (void*)IN_TITLE$1, -1ll, 0 );
	*(int64*)((uint8*)THIS$1 + 24ll) = IN_ROW1$1;
	*(int64*)((uint8*)THIS$1 + 32ll) = IN_COL1$1;
	*(int64*)((uint8*)THIS$1 + 40ll) = IN_ROWS$1;
	*(int64*)((uint8*)THIS$1 + 48ll) = IN_COLS$1;
	*(int64*)((uint8*)THIS$1 + 120ll) = IN_COLOR$1;
	*($10TIMER_ENUM*)((uint8*)THIS$1 + 96ll) = IN_TIMERID$1;
	*($10STYLE_ENUM*)((uint8*)THIS$1 + 104ll) = IN_STYLE$1;
	label$17:;
}

void _ZN9COMPONENT3ADDERK8FBSTRING( struct $9COMPONENT* THIS$1, FBSTRING* K$1 )
{
	label$18:;
	if( *(boolean*)((uint8*)THIS$1 + 80ll) == (boolean)0ll ) goto label$21;
	{
		FBSTRING TMP$7$2;
		__builtin_memset( &TMP$7$2, 0, 24ll );
		FBSTRING* vr$5 = fb_StrConcat( &TMP$7$2, (void*)((uint8*)THIS$1 + 56ll), -1ll, (void*)K$1, -1ll );
		FBSTRING* vr$8 = fb_StrAssign( (void*)((uint8*)THIS$1 + 56ll), -1ll, (void*)vr$5, -1ll, 0 );
		label$22:;
		int64 vr$11 = fb_StrLen( (void*)((uint8*)THIS$1 + 56ll), -1ll );
		if( vr$11 <= (*(int64*)((uint8*)THIS$1 + 40ll) * *(int64*)((uint8*)THIS$1 + 48ll)) ) goto label$23;
		{
			FBSTRING* vr$19 = fb_StrMid( (FBSTRING*)((uint8*)THIS$1 + 56ll), *(int64*)((uint8*)THIS$1 + 48ll) + 1ll, -1ll );
			FBSTRING* vr$22 = fb_StrAssign( (void*)((uint8*)THIS$1 + 56ll), -1ll, (void*)vr$19, -1ll, 0 );
		}
		goto label$22;
		label$23:;
	}
	goto label$20;
	label$21:;
	{
		FBSTRING TMP$8$2;
		__builtin_memset( &TMP$8$2, 0, 24ll );
		FBSTRING* vr$30 = fb_StrConcat( &TMP$8$2, (void*)((uint8*)THIS$1 + 56ll), -1ll, (void*)K$1, -1ll );
		FBSTRING* vr$31 = fb_LEFT( (FBSTRING*)vr$30, *(int64*)((uint8*)THIS$1 + 40ll) * *(int64*)((uint8*)THIS$1 + 48ll) );
		FBSTRING* vr$34 = fb_StrAssign( (void*)((uint8*)THIS$1 + 56ll), -1ll, (void*)vr$31, -1ll, 0 );
	}
	label$20:;
	label$19:;
}

FBSTRING* _ZN9COMPONENT6REMOVEEu7INTEGERS0_( struct $9COMPONENT* THIS$1, int64 COUNT$1, int64 EOL$1 )
{
	FBSTRING fb$result$1;
	__builtin_memset( &fb$result$1, 0, 24ll );
	label$24:;
	if( COUNT$1 > 0ll ) goto label$27;
	{
		int64 vr$3 = fb_StrLen( (void*)((uint8*)THIS$1 + 56ll), -1ll );
		COUNT$1 = vr$3;
	}
	label$27:;
	label$26:;
	if( EOL$1 <= 0ll ) goto label$29;
	{
		FBSTRING* vr$4 = fb_CHR( 1, EOL$1 );
		int64 vr$7 = fb_StrInstr( 1ll, (FBSTRING*)((uint8*)THIS$1 + 56ll), (FBSTRING*)vr$4 );
		COUNT$1 = vr$7;
	}
	label$29:;
	label$28:;
	FBSTRING* vr$10 = fb_LEFT( (FBSTRING*)((uint8*)THIS$1 + 56ll), COUNT$1 );
	FBSTRING* vr$12 = fb_StrAssign( (void*)&fb$result$1, -1ll, (void*)vr$10, -1ll, 0 );
	FBSTRING* vr$16 = fb_StrMid( (FBSTRING*)((uint8*)THIS$1 + 56ll), COUNT$1 + 1ll, -1ll );
	FBSTRING* vr$19 = fb_StrAssign( (void*)((uint8*)THIS$1 + 56ll), -1ll, (void*)vr$16, -1ll, 0 );
	label$25:;
	FBSTRING* vr$21 = fb_StrAllocTempResult( (FBSTRING*)&fb$result$1 );
	return vr$21;
}

void _ZN9COMPONENT6RENDEREv( struct $9COMPONENT* THIS$1 )
{
	label$30:;
	float X1$1;
	X1$1 = (float)((*(int64*)((uint8*)THIS$1 + 32ll) << (3ll & 63ll)) + -8ll);
	float Y1$1;
	Y1$1 = (float)((*(int64*)((uint8*)THIS$1 + 24ll) << (3ll & 63ll)) + -8ll);
	float X2$1;
	X2$1 = (float)(((*(int64*)((uint8*)THIS$1 + 32ll) + *(int64*)((uint8*)THIS$1 + 48ll)) << (3ll & 63ll)) + -8ll);
	float Y2$1;
	Y2$1 = (float)(((*(int64*)((uint8*)THIS$1 + 24ll) + *(int64*)((uint8*)THIS$1 + 40ll)) << (3ll & 63ll)) + -8ll);
	if( *(int64*)((uint8*)THIS$1 + 104ll) != 1ll ) goto label$33;
	{
		fb_GfxLine( (void*)0ull, X1$1 + 0x1.p+2f, Y1$1 + 0x1.p+2f, X2$1, Y2$1 + -0x1.p+2f, 8u, 0, 61680u, 0 );
		{
			int64 ROW$3;
			ROW$3 = 0ll;
			int64 TMP$9$3;
			TMP$9$3 = *(int64*)((uint8*)THIS$1 + 40ll) + -1ll;
			goto label$34;
			label$37:;
			{
				FBSTRING S$4;
				FBSTRING* vr$32 = fb_StrMid( (FBSTRING*)((uint8*)THIS$1 + 56ll), (ROW$3 * *(int64*)((uint8*)THIS$1 + 48ll)) + 1ll, *(int64*)((uint8*)THIS$1 + 48ll) );
				FBSTRING* vr$34 = fb_StrInit( (void*)&S$4, -1ll, (void*)vr$32, -1ll, 0 );
				int64 vr$41 = fb_StrLen( (void*)&S$4, -1ll );
				fb_GfxDrawString( (void*)0ull, (float)(fb_F2L( (X1$1 + X2$1) + (float)(vr$41 << (3ll & 63ll)) ) / 2ll), Y1$1 + (float)(ROW$3 << (3ll & 63ll)), 4, (FBSTRING*)&S$4, 15u, (void*)0ull, 0, (void*)0ull, (void*)0ull, (void*)0ull );
				fb_StrDelete( (FBSTRING*)&S$4 );
			}
			label$35:;
			ROW$3 = ROW$3 + 1ll;
			label$34:;
			if( ROW$3 <= TMP$9$3 ) goto label$37;
			label$36:;
		}
	}
	goto label$32;
	label$33:;
	{
		FBSTRING S$2;
		FBSTRING* vr$53 = fb_StrInit( (void*)&S$2, -1ll, (void*)THIS$1, -1ll, 0 );
		if( *(int64*)((uint8*)THIS$1 + 112ll) == 0ll ) goto label$39;
		{
			FBSTRING* vr$56 = fb_StrConcatAssign( (void*)&S$2, -1ll, (void*)" (need CR)", 11ll, 0 );
		}
		label$39:;
		label$38:;
		fb_GfxDrawString( (void*)0ull, X1$1 + -0x1.p+2f, Y1$1 + -0x1.p+4f, 4, (FBSTRING*)&S$2, 7u, (void*)0ull, 0, (void*)0ull, (void*)0ull, (void*)0ull );
		int32 vr$62 = fb_StrCompare( (void*)((uint8*)THIS$1 + 56ll), -1ll, (void*)"", 1ll );
		if( (int64)vr$62 <= 0ll ) goto label$41;
		{
			fb_GfxLine( (void*)0ull, X1$1 + -0x1.p+1f, Y1$1 + -0x1.p+1f, X2$1 + 0x1.p+1f, Y2$1 + 0x1.p+1f, 1u, 2, 65535u, 0 );
		}
		label$41:;
		label$40:;
		fb_GfxLine( (void*)0ull, X1$1 + -0x1.8p+1f, Y1$1 + -0x1.8p+1f, X2$1 + 0x1.8p+1f, Y2$1 + 0x1.8p+1f, (uint32)*(int64*)((uint8*)THIS$1 + 120ll), 1, 65535u, 0 );
		{
			int64 ROW$3;
			ROW$3 = 0ll;
			int64 TMP$11$3;
			TMP$11$3 = *(int64*)((uint8*)THIS$1 + 40ll) + -1ll;
			goto label$42;
			label$45:;
			{
				FBSTRING* vr$82 = fb_StrMid( (FBSTRING*)((uint8*)THIS$1 + 56ll), (ROW$3 * *(int64*)((uint8*)THIS$1 + 48ll)) + 1ll, *(int64*)((uint8*)THIS$1 + 48ll) );
				fb_GfxDrawString( (void*)0ull, X1$1, Y1$1 + (float)(ROW$3 << (3ll & 63ll)), 4, (FBSTRING*)vr$82, 15u, (void*)0ull, 0, (void*)0ull, (void*)0ull, (void*)0ull );
			}
			label$43:;
			ROW$3 = ROW$3 + 1ll;
			label$42:;
			if( ROW$3 <= TMP$11$3 ) goto label$45;
			label$44:;
		}
		fb_StrDelete( (FBSTRING*)&S$2 );
	}
	label$32:;
	label$31:;
}

int32 main( int32 __FB_ARGC__$0, char** __FB_ARGV__$0 )
{
	FBSTRING TMP$15$0;
	FBSTRING TMP$18$0;
	FBSTRING TMP$21$0;
	FBSTRING TMP$24$0;
	FBSTRING TMP$27$0;
	FBSTRING TMP$30$0;
	FBSTRING TMP$33$0;
	FBSTRING TMP$35$0;
	FBSTRING TMP$38$0;
	FBSTRING TMP$40$0;
	FBSTRING TMP$43$0;
	FBSTRING TMP$46$0;
	int32 fb$result$0;
	__builtin_memset( &fb$result$0, 0, 4ll );
	fb_Init( __FB_ARGC__$0, (uint8**)__FB_ARGV__$0, 0 );
	label$0:;
	struct $12ONDELAYTIMER TIMERS$0[4];
	struct $8FBARRAY1I12ONDELAYTIMERE tmp$2$0;
	*(struct $12ONDELAYTIMER**)&tmp$2$0 = (struct $12ONDELAYTIMER*)TIMERS$0;
	*(struct $12ONDELAYTIMER**)((uint8*)&tmp$2$0 + 8ll) = (struct $12ONDELAYTIMER*)TIMERS$0;
	*(int64*)((uint8*)&tmp$2$0 + 16ll) = 64ll;
	*(int64*)((uint8*)&tmp$2$0 + 24ll) = 16ll;
	*(int64*)((uint8*)&tmp$2$0 + 32ll) = 1ll;
	*(int64*)((uint8*)&tmp$2$0 + 40ll) = 4ll;
	*(int64*)((uint8*)&tmp$2$0 + 48ll) = 0ll;
	*(int64*)((uint8*)&tmp$2$0 + 56ll) = 3ll;
	_ZN12ONDELAYTIMERC1Eu7INTEGER( (struct $12ONDELAYTIMER*)TIMERS$0, 0ll );
	_ZN12ONDELAYTIMERC1Eu7INTEGER( (struct $12ONDELAYTIMER*)((uint8*)TIMERS$0 + 16ll), 10ll );
	_ZN12ONDELAYTIMERC1Eu7INTEGER( (struct $12ONDELAYTIMER*)((uint8*)TIMERS$0 + 32ll), 30ll );
	_ZN12ONDELAYTIMERC1Eu7INTEGER( (struct $12ONDELAYTIMER*)((uint8*)TIMERS$0 + 48ll), 20ll );
	struct $9COMPONENT COMPONENTS$0[12];
	struct $8FBARRAY1I9COMPONENTE tmp$12$0;
	*(struct $9COMPONENT**)&tmp$12$0 = (struct $9COMPONENT*)COMPONENTS$0;
	*(struct $9COMPONENT**)((uint8*)&tmp$12$0 + 8ll) = (struct $9COMPONENT*)COMPONENTS$0;
	*(int64*)((uint8*)&tmp$12$0 + 16ll) = 1536ll;
	*(int64*)((uint8*)&tmp$12$0 + 24ll) = 128ll;
	*(int64*)((uint8*)&tmp$12$0 + 32ll) = 1ll;
	*(int64*)((uint8*)&tmp$12$0 + 40ll) = 12ll;
	*(int64*)((uint8*)&tmp$12$0 + 48ll) = 0ll;
	*(int64*)((uint8*)&tmp$12$0 + 56ll) = 11ll;
	__builtin_memset( &TMP$15$0, 0, 24ll );
	FBSTRING* vr$11 = fb_StrAssign( (void*)&TMP$15$0, -1ll, (void*)"Display", 8ll, 0 );
	_ZN9COMPONENTC1ER8FBSTRINGu7INTEGERS2_S2_S2_S2_10TIMER_ENUM10STYLE_ENUM( (struct $9COMPONENT*)COMPONENTS$0, &TMP$15$0, 5ll, 5ll, 5ll, 16ll, 15ll, 1ll, 0ll );
	__builtin_memset( &TMP$18$0, 0, 24ll );
	FBSTRING* vr$16 = fb_StrAssign( (void*)&TMP$18$0, -1ll, (void*)"Host In", 8ll, 0 );
	_ZN9COMPONENTC1ER8FBSTRINGu7INTEGERS2_S2_S2_S2_10TIMER_ENUM10STYLE_ENUM( (struct $9COMPONENT*)((uint8*)COMPONENTS$0 + 128ll), &TMP$18$0, 15ll, 5ll, 1ll, 16ll, 14ll, 1ll, 0ll );
	__builtin_memset( &TMP$21$0, 0, 24ll );
	FBSTRING* vr$21 = fb_StrAssign( (void*)&TMP$21$0, -1ll, (void*)"Serial In", 10ll, 0 );
	_ZN9COMPONENTC1ER8FBSTRINGu7INTEGERS2_S2_S2_S2_10TIMER_ENUM10STYLE_ENUM( (struct $9COMPONENT*)((uint8*)COMPONENTS$0 + 256ll), &TMP$21$0, 20ll, 5ll, 1ll, 16ll, 8ll, 2ll, 0ll );
	__builtin_memset( &TMP$24$0, 0, 24ll );
	FBSTRING* vr$26 = fb_StrAssign( (void*)&TMP$24$0, -1ll, (void*)"Wire 1", 7ll, 0 );
	_ZN9COMPONENTC1ER8FBSTRINGu7INTEGERS2_S2_S2_S2_10TIMER_ENUM10STYLE_ENUM( (struct $9COMPONENT*)((uint8*)COMPONENTS$0 + 384ll), &TMP$24$0, 20ll, 21ll, 1ll, 38ll, 8ll, 2ll, 1ll );
	__builtin_memset( &TMP$27$0, 0, 24ll );
	FBSTRING* vr$31 = fb_StrAssign( (void*)&TMP$27$0, -1ll, (void*)"Serial Out", 11ll, 0 );
	_ZN9COMPONENTC1ER8FBSTRINGu7INTEGERS2_S2_S2_S2_10TIMER_ENUM10STYLE_ENUM( (struct $9COMPONENT*)((uint8*)COMPONENTS$0 + 512ll), &TMP$27$0, 20ll, 60ll, 1ll, 16ll, 8ll, 3ll, 0ll );
	__builtin_memset( &TMP$30$0, 0, 24ll );
	FBSTRING* vr$36 = fb_StrAssign( (void*)&TMP$30$0, -1ll, (void*)"Device Out", 11ll, 0 );
	_ZN9COMPONENTC1ER8FBSTRINGu7INTEGERS2_S2_S2_S2_10TIMER_ENUM10STYLE_ENUM( (struct $9COMPONENT*)((uint8*)COMPONENTS$0 + 640ll), &TMP$30$0, 25ll, 60ll, 1ll, 16ll, 14ll, 3ll, 0ll );
	__builtin_memset( &TMP$33$0, 0, 24ll );
	FBSTRING* vr$41 = fb_StrAssign( (void*)&TMP$33$0, -1ll, (void*)"Device In", 10ll, 0 );
	_ZN9COMPONENTC1ER8FBSTRINGu7INTEGERS2_S2_S2_S2_10TIMER_ENUM10STYLE_ENUM( (struct $9COMPONENT*)((uint8*)COMPONENTS$0 + 768ll), &TMP$33$0, 30ll, 60ll, 1ll, 16ll, 14ll, 3ll, 0ll );
	__builtin_memset( &TMP$35$0, 0, 24ll );
	FBSTRING* vr$46 = fb_StrAssign( (void*)&TMP$35$0, -1ll, (void*)"Serial In", 10ll, 0 );
	_ZN9COMPONENTC1ER8FBSTRINGu7INTEGERS2_S2_S2_S2_10TIMER_ENUM10STYLE_ENUM( (struct $9COMPONENT*)((uint8*)COMPONENTS$0 + 896ll), &TMP$35$0, 35ll, 60ll, 1ll, 16ll, 8ll, 2ll, 0ll );
	__builtin_memset( &TMP$38$0, 0, 24ll );
	FBSTRING* vr$51 = fb_StrAssign( (void*)&TMP$38$0, -1ll, (void*)"Wire 2", 7ll, 0 );
	_ZN9COMPONENTC1ER8FBSTRINGu7INTEGERS2_S2_S2_S2_10TIMER_ENUM10STYLE_ENUM( (struct $9COMPONENT*)((uint8*)COMPONENTS$0 + 1024ll), &TMP$38$0, 35ll, 21ll, 1ll, 38ll, 8ll, 2ll, 1ll );
	__builtin_memset( &TMP$40$0, 0, 24ll );
	FBSTRING* vr$56 = fb_StrAssign( (void*)&TMP$40$0, -1ll, (void*)"Serial Out", 11ll, 0 );
	_ZN9COMPONENTC1ER8FBSTRINGu7INTEGERS2_S2_S2_S2_10TIMER_ENUM10STYLE_ENUM( (struct $9COMPONENT*)((uint8*)COMPONENTS$0 + 1152ll), &TMP$40$0, 35ll, 5ll, 1ll, 16ll, 8ll, 1ll, 0ll );
	__builtin_memset( &TMP$43$0, 0, 24ll );
	FBSTRING* vr$61 = fb_StrAssign( (void*)&TMP$43$0, -1ll, (void*)"Host Out", 9ll, 0 );
	_ZN9COMPONENTC1ER8FBSTRINGu7INTEGERS2_S2_S2_S2_10TIMER_ENUM10STYLE_ENUM( (struct $9COMPONENT*)((uint8*)COMPONENTS$0 + 1280ll), &TMP$43$0, 40ll, 5ll, 1ll, 16ll, 14ll, 1ll, 0ll );
	__builtin_memset( &TMP$46$0, 0, 24ll );
	FBSTRING* vr$66 = fb_StrAssign( (void*)&TMP$46$0, -1ll, (void*)"Keyboard", 9ll, 0 );
	_ZN9COMPONENTC1ER8FBSTRINGu7INTEGERS2_S2_S2_S2_10TIMER_ENUM10STYLE_ENUM( (struct $9COMPONENT*)((uint8*)COMPONENTS$0 + 1408ll), &TMP$46$0, 45ll, 5ll, 1ll, 16ll, 15ll, -1ll, 0ll );
	fb_StrDelete( (FBSTRING*)&TMP$46$0 );
	fb_StrDelete( (FBSTRING*)&TMP$43$0 );
	fb_StrDelete( (FBSTRING*)&TMP$40$0 );
	fb_StrDelete( (FBSTRING*)&TMP$38$0 );
	fb_StrDelete( (FBSTRING*)&TMP$35$0 );
	fb_StrDelete( (FBSTRING*)&TMP$33$0 );
	fb_StrDelete( (FBSTRING*)&TMP$30$0 );
	fb_StrDelete( (FBSTRING*)&TMP$27$0 );
	fb_StrDelete( (FBSTRING*)&TMP$24$0 );
	fb_StrDelete( (FBSTRING*)&TMP$21$0 );
	fb_StrDelete( (FBSTRING*)&TMP$18$0 );
	fb_StrDelete( (FBSTRING*)&TMP$15$0 );
	*(boolean*)((uint8*)COMPONENTS$0 + 80ll) = (boolean)1ll;
	*(int64*)((uint8*)COMPONENTS$0 + 1240ll) = 1ll;
	*(int64*)((uint8*)COMPONENTS$0 + 600ll) = 1ll;
	*(int64*)((uint8*)COMPONENTS$0 + 472ll) = 1ll;
	*(int64*)((uint8*)COMPONENTS$0 + 1112ll) = 1ll;
	int64 PAGE$0;
	PAGE$0 = 0ll;
	fb_GfxScreenRes( 640, 480, 8, 2, 0, 0 );
	fb_GfxPageSet( (int32)(1ll - PAGE$0), (int32)PAGE$0 );
	boolean PAUSED$0;
	__builtin_memset( &PAUSED$0, 0, 1ll );
	label$46:;
	{
		if( (boolean)(PAUSED$0 == 0ll) == (boolean)0ll ) goto label$50;
		{
			_ZN12ONDELAYTIMER8NEXTTICKEv(  );
		}
		label$50:;
		label$49:;
		FBSTRING K$1;
		FBSTRING* vr$86 = fb_Inkey(  );
		FBSTRING* vr$88 = fb_StrInit( (void*)&K$1, -1ll, (void*)vr$86, -1ll, 0 );
		{
			int32 vr$90 = fb_StrCompare( (void*)&K$1, -1ll, (void*)"\x1B", 2ll );
			if( (int64)vr$90 != 0ll ) goto label$52;
			label$53:;
			{
				fb_StrDelete( (FBSTRING*)&K$1 );
				goto label$47;
			}
			goto label$51;
			label$52:;
			int32 vr$94 = fb_StrCompare( (void*)&K$1, -1ll, (void*)"\x09", 2ll );
			if( (int64)vr$94 != 0ll ) goto label$54;
			label$55:;
			{
				PAUSED$0 = (boolean)(PAUSED$0 == 0ll);
			}
			goto label$51;
			label$54:;
			int32 vr$98 = fb_StrCompare( (void*)&K$1, -1ll, (void*)"\x0D", 2ll );
			if( (int64)vr$98 != 0ll ) goto label$56;
			label$57:;
			{
				_ZN9COMPONENT3ADDERK8FBSTRING( (struct $9COMPONENT*)((uint8*)COMPONENTS$0 + 1408ll), (FBSTRING*)&K$1 );
			}
			goto label$51;
			label$56:;
			int32 vr$103 = fb_StrCompare( (void*)&K$1, -1ll, (void*)"\xFF;", 3ll );
			if( (int64)vr$103 != 0ll ) goto label$58;
			label$59:;
			{
				*(int64*)((uint8*)TIMERS$0 + 24ll) = *(int64*)((uint8*)TIMERS$0 + 24ll) + 1ll;
			}
			goto label$51;
			label$58:;
			int32 vr$107 = fb_StrCompare( (void*)&K$1, -1ll, (void*)"\xFFT", 3ll );
			if( (int64)vr$107 != 0ll ) goto label$60;
			label$61:;
			{
				*(int64*)((uint8*)TIMERS$0 + 24ll) = *(int64*)((uint8*)TIMERS$0 + 24ll) + -1ll;
			}
			goto label$51;
			label$60:;
			int32 vr$111 = fb_StrCompare( (void*)&K$1, -1ll, (void*)"\xFF<", 3ll );
			if( (int64)vr$111 != 0ll ) goto label$62;
			label$63:;
			{
				*(int64*)((uint8*)TIMERS$0 + 40ll) = *(int64*)((uint8*)TIMERS$0 + 40ll) + 1ll;
			}
			goto label$51;
			label$62:;
			int32 vr$115 = fb_StrCompare( (void*)&K$1, -1ll, (void*)"\xFFU", 3ll );
			if( (int64)vr$115 != 0ll ) goto label$64;
			label$65:;
			{
				*(int64*)((uint8*)TIMERS$0 + 40ll) = *(int64*)((uint8*)TIMERS$0 + 40ll) + -1ll;
			}
			goto label$51;
			label$64:;
			int32 vr$119 = fb_StrCompare( (void*)&K$1, -1ll, (void*)"\xFF=", 3ll );
			if( (int64)vr$119 != 0ll ) goto label$66;
			label$67:;
			{
				*(int64*)((uint8*)TIMERS$0 + 56ll) = *(int64*)((uint8*)TIMERS$0 + 56ll) + 1ll;
			}
			goto label$51;
			label$66:;
			int32 vr$123 = fb_StrCompare( (void*)&K$1, -1ll, (void*)"\xFFV", 3ll );
			if( (int64)vr$123 != 0ll ) goto label$68;
			label$69:;
			{
				*(int64*)((uint8*)TIMERS$0 + 56ll) = *(int64*)((uint8*)TIMERS$0 + 56ll) + -1ll;
			}
			goto label$51;
			label$68:;
			int32 vr$127 = fb_StrCompare( (void*)&K$1, -1ll, (void*)"\xFF>", 3ll );
			if( (int64)vr$127 != 0ll ) goto label$70;
			label$71:;
			{
				FBSTRING* vr$130 = _ZN9COMPONENT6REMOVEEu7INTEGERS0_( (struct $9COMPONENT*)COMPONENTS$0, 0ll, 0ll );
				fb_hStrDelTemp( (FBSTRING*)vr$130 );
			}
			goto label$51;
			label$70:;
			int32 vr$132 = fb_StrCompare( (void*)&K$1, -1ll, (void*)"\xFF?", 3ll );
			if( (int64)vr$132 != 0ll ) goto label$72;
			label$73:;
			{
				*(int64*)((uint8*)COMPONENTS$0 + 1392ll) = *(int64*)((uint8*)COMPONENTS$0 + 1392ll) ^ 13ll;
			}
			goto label$51;
			label$72:;
			int32 vr$136 = fb_StrCompare( (void*)&K$1, -1ll, (void*)"\xFF@", 3ll );
			if( (int64)vr$136 != 0ll ) goto label$74;
			label$75:;
			{
				*(int64*)((uint8*)COMPONENTS$0 + 880ll) = *(int64*)((uint8*)COMPONENTS$0 + 880ll) ^ 13ll;
			}
			goto label$51;
			label$74:;
			int32 vr$140 = fb_StrCompare( (void*)&K$1, -1ll, (void*)"\xFF" "A", 3ll );
			if( (int64)vr$140 != 0ll ) goto label$76;
			label$77:;
			{
				*(int64*)((uint8*)COMPONENTS$0 + 752ll) = *(int64*)((uint8*)COMPONENTS$0 + 752ll) ^ 13ll;
			}
			goto label$51;
			label$76:;
			int32 vr$144 = fb_StrCompare( (void*)&K$1, -1ll, (void*)"\xFF" "B", 3ll );
			if( (int64)vr$144 != 0ll ) goto label$78;
			label$79:;
			{
				*(int64*)((uint8*)COMPONENTS$0 + 240ll) = *(int64*)((uint8*)COMPONENTS$0 + 240ll) ^ 13ll;
			}
			goto label$51;
			label$78:;
			int32 vr$148 = fb_StrCompare( (void*)&K$1, -1ll, (void*)"\xFF" "C", 3ll );
			if( (int64)vr$148 != 0ll ) goto label$80;
			label$81:;
			{
				{
					int64 I$4;
					I$4 = 0ll;
					label$85:;
					{
						fb_StrAssign( (void*)(((uint8*)COMPONENTS$0 + (I$4 << (7ll & 63ll))) + 56ll), -1ll, (void*)"", 1ll, 0 );
						*(int64*)(((uint8*)COMPONENTS$0 + (I$4 << (7ll & 63ll))) + 112ll) = 0ll;
					}
					label$83:;
					I$4 = I$4 + 1ll;
					label$82:;
					if( I$4 <= 11ll ) goto label$85;
					label$84:;
				}
			}
			goto label$51;
			label$80:;
			int32 vr$155 = fb_StrCompare( (void*)&K$1, -1ll, (void*)" ", 2ll );
			if( (int64)vr$155 < 0ll ) goto label$86;
			int32 vr$158 = fb_StrCompare( (void*)&K$1, -1ll, (void*)"~", 2ll );
			if( (int64)vr$158 > 0ll ) goto label$86;
			label$87:;
			{
				_ZN9COMPONENT3ADDERK8FBSTRING( (struct $9COMPONENT*)((uint8*)COMPONENTS$0 + 1408ll), (FBSTRING*)&K$1 );
			}
			label$86:;
			label$51:;
		}
		if( *(int64*)((uint8*)TIMERS$0 + 24ll) >= 0ll ) goto label$89;
		{
			*(int64*)((uint8*)TIMERS$0 + 24ll) = 0ll;
		}
		goto label$88;
		label$89:;
		if( *(int64*)((uint8*)TIMERS$0 + 24ll) <= 100ll ) goto label$90;
		{
			*(int64*)((uint8*)TIMERS$0 + 24ll) = 100ll;
		}
		label$90:;
		label$88:;
		if( *(int64*)((uint8*)TIMERS$0 + 40ll) >= 0ll ) goto label$92;
		{
			*(int64*)((uint8*)TIMERS$0 + 40ll) = 0ll;
		}
		goto label$91;
		label$92:;
		if( *(int64*)((uint8*)TIMERS$0 + 40ll) <= 100ll ) goto label$93;
		{
			*(int64*)((uint8*)TIMERS$0 + 40ll) = 100ll;
		}
		label$93:;
		label$91:;
		if( *(int64*)((uint8*)TIMERS$0 + 56ll) >= 0ll ) goto label$95;
		{
			*(int64*)((uint8*)TIMERS$0 + 56ll) = 0ll;
		}
		goto label$94;
		label$95:;
		if( *(int64*)((uint8*)TIMERS$0 + 56ll) <= 100ll ) goto label$96;
		{
			*(int64*)((uint8*)TIMERS$0 + 56ll) = 100ll;
		}
		label$96:;
		label$94:;
		{
			int64 I$2;
			I$2 = 0ll;
			label$100:;
			{
				boolean vr$165 = _ZN12ONDELAYTIMER6STATUSEv( (struct $12ONDELAYTIMER*)((uint8*)TIMERS$0 + (*(int64*)(((uint8*)COMPONENTS$0 + (I$2 << (7ll & 63ll))) + 96ll) << (4ll & 63ll))) );
				if( vr$165 == (boolean)0ll ) goto label$102;
				{
					FBSTRING TMP$64$4;
					__builtin_memset( &TMP$64$4, 0, 24ll );
					FBSTRING* vr$171 = _ZN9COMPONENT6REMOVEEu7INTEGERS0_( (struct $9COMPONENT*)(((uint8*)COMPONENTS$0 + (I$2 << (7ll & 63ll))) + 128ll), *(int64*)(((uint8*)COMPONENTS$0 + (I$2 << (7ll & 63ll))) + 216ll), *(int64*)(((uint8*)COMPONENTS$0 + (I$2 << (7ll & 63ll))) + 240ll) );
					FBSTRING* vr$173 = fb_StrAssign( (void*)&TMP$64$4, -1ll, (void*)vr$171, -1ll, 0 );
					_ZN9COMPONENT3ADDERK8FBSTRING( (struct $9COMPONENT*)((uint8*)COMPONENTS$0 + (I$2 << (7ll & 63ll))), (FBSTRING*)&TMP$64$4 );
					fb_StrDelete( (FBSTRING*)&TMP$64$4 );
				}
				label$102:;
				label$101:;
			}
			label$98:;
			I$2 = I$2 + 1ll;
			label$97:;
			if( I$2 <= 10ll ) goto label$100;
			label$99:;
		}
		{
			int64 I$2;
			I$2 = 1ll;
			label$106:;
			{
				boolean vr$181 = _ZN12ONDELAYTIMER6STATUSEv( (struct $12ONDELAYTIMER*)((uint8*)TIMERS$0 + (I$2 << (4ll & 63ll))) );
				if( vr$181 == (boolean)0ll ) goto label$108;
				{
					_ZN12ONDELAYTIMER5RESETEv( (struct $12ONDELAYTIMER*)((uint8*)TIMERS$0 + (I$2 << (4ll & 63ll))) );
				}
				label$108:;
				label$107:;
			}
			label$104:;
			I$2 = I$2 + 1ll;
			label$103:;
			if( I$2 <= 3ll ) goto label$106;
			label$105:;
		}
		fb_Cls( -65536 );
		{
			int64 I$2;
			I$2 = 0ll;
			label$112:;
			{
				_ZN9COMPONENT6RENDEREv( (struct $9COMPONENT*)((uint8*)COMPONENTS$0 + (I$2 << (7ll & 63ll))) );
			}
			label$110:;
			I$2 = I$2 + 1ll;
			label$109:;
			if( I$2 <= 11ll ) goto label$112;
			label$111:;
		}
		if( PAUSED$0 == (boolean)0ll ) goto label$114;
		{
			fb_Color( 12, 0, 2 );
			fb_Locate( 27, 20, -1, 0, 0 );
			FBSTRING* vr$188 = fb_StrAllocTempDescZEx( (uint8*)"---<<< P A U S E D >>>---", 25ll );
			fb_PrintString( 0, (FBSTRING*)vr$188, 1 );
		}
		label$114:;
		label$113:;
		fb_Locate( 5, 30, -1, 0, 0 );
		fb_Color( 15, 0, 2 );
		FBSTRING* vr$189 = fb_StrAllocTempDescZEx( (uint8*)"Host Speed  : ###%", 18ll );
		fb_PrintUsingInit( (FBSTRING*)vr$189 );
		fb_PrintUsingLongint( 0, -(*(int64*)((uint8*)TIMERS$0 + 24ll)) + 100ll, 0 );
		fb_PrintUsingEnd( 0 );
		fb_Color( 7, 0, 2 );
		FBSTRING* vr$192 = fb_StrAllocTempDescZEx( (uint8*)"  (F1/Shift+F1 to adjust)", 25ll );
		fb_PrintString( 0, (FBSTRING*)vr$192, 1 );
		fb_Locate( 7, 30, -1, 0, 0 );
		fb_Color( 15, 0, 2 );
		FBSTRING* vr$193 = fb_StrAllocTempDescZEx( (uint8*)"Serial Speed: ###%", 18ll );
		fb_PrintUsingInit( (FBSTRING*)vr$193 );
		fb_PrintUsingLongint( 0, -(*(int64*)((uint8*)TIMERS$0 + 40ll)) + 100ll, 0 );
		fb_PrintUsingEnd( 0 );
		fb_Color( 7, 0, 2 );
		FBSTRING* vr$196 = fb_StrAllocTempDescZEx( (uint8*)"  (F2/Shift+F2 to adjust)", 25ll );
		fb_PrintString( 0, (FBSTRING*)vr$196, 1 );
		fb_Locate( 9, 30, -1, 0, 0 );
		fb_Color( 15, 0, 2 );
		FBSTRING* vr$197 = fb_StrAllocTempDescZEx( (uint8*)"Device Speed: ###%", 18ll );
		fb_PrintUsingInit( (FBSTRING*)vr$197 );
		fb_PrintUsingLongint( 0, -(*(int64*)((uint8*)TIMERS$0 + 56ll)) + 100ll, 0 );
		fb_PrintUsingEnd( 0 );
		fb_Color( 7, 0, 2 );
		FBSTRING* vr$200 = fb_StrAllocTempDescZEx( (uint8*)"  (F3/Shift+F3 to adjust)", 25ll );
		fb_PrintString( 0, (FBSTRING*)vr$200, 1 );
		fb_Color( 10, 0, 2 );
		fb_Locate( 48, 5, -1, 0, 0 );
		FBSTRING* vr$201 = fb_StrAllocTempDescZEx( (uint8*)"Type keys to start", 18ll );
		fb_PrintString( 0, (FBSTRING*)vr$201, 1 );
		fb_Color( 7, 0, 2 );
		fb_Locate( 50, 5, -1, 0, 0 );
		FBSTRING* vr$202 = fb_StrAllocTempDescZEx( (uint8*)"ESC to EXIT", 11ll );
		fb_PrintString( 0, (FBSTRING*)vr$202, 1 );
		fb_Color( 7, 0, 2 );
		fb_Locate( 40, 30, -1, 0, 0 );
		FBSTRING* vr$203 = fb_StrAllocTempDescZEx( (uint8*)"F4 to clear display", 19ll );
		fb_PrintString( 0, (FBSTRING*)vr$203, 1 );
		fb_Color( 14, 0, 2 );
		fb_Locate( 42, 30, -1, 0, 0 );
		FBSTRING* vr$204 = fb_StrAllocTempDescZEx( (uint8*)"F5 to toggle 'Host Out' buffering", 33ll );
		fb_PrintString( 0, (FBSTRING*)vr$204, 1 );
		fb_Locate( 44, 30, -1, 0, 0 );
		FBSTRING* vr$205 = fb_StrAllocTempDescZEx( (uint8*)"F6 to toggle 'Device In' buffering", 34ll );
		fb_PrintString( 0, (FBSTRING*)vr$205, 1 );
		fb_Locate( 46, 30, -1, 0, 0 );
		FBSTRING* vr$206 = fb_StrAllocTempDescZEx( (uint8*)"F7 to toggle 'Device Out' buffering", 35ll );
		fb_PrintString( 0, (FBSTRING*)vr$206, 1 );
		fb_Locate( 48, 30, -1, 0, 0 );
		FBSTRING* vr$207 = fb_StrAllocTempDescZEx( (uint8*)"F8 to toggle 'Host In' buffering", 32ll );
		fb_PrintString( 0, (FBSTRING*)vr$207, 1 );
		fb_Color( 7, 0, 2 );
		fb_Locate( 50, 30, -1, 0, 0 );
		FBSTRING* vr$208 = fb_StrAllocTempDescZEx( (uint8*)"F9 to reset everything", 22ll );
		fb_PrintString( 0, (FBSTRING*)vr$208, 1 );
		PAGE$0 = 1ll - PAGE$0;
		fb_GfxPageSet( (int32)(1ll - PAGE$0), (int32)PAGE$0 );
		fb_SleepEx( 25, 1 );
		fb_StrDelete( (FBSTRING*)&K$1 );
	}
	label$48:;
	goto label$46;
	label$47:;
	fb_ArrayDestructObj( (struct $7FBARRAYIvE*)&tmp$12$0, (void*)&_ZN9COMPONENTD1Ev );
	label$1:;
	fb_End( 0 );
	return fb$result$0;
}

static void _ZN9COMPONENTaSERKS_( struct $9COMPONENT* THIS$1, struct $9COMPONENT* __FB_RHS__$1 )
{
	label$10:;
	FBSTRING* vr$4 = fb_StrAssign( (void*)THIS$1, -1ll, (void*)__FB_RHS__$1, -1ll, 0 );
	*(int64*)((uint8*)THIS$1 + 24ll) = *(int64*)((uint8*)__FB_RHS__$1 + 24ll);
	*(int64*)((uint8*)THIS$1 + 32ll) = *(int64*)((uint8*)__FB_RHS__$1 + 32ll);
	*(int64*)((uint8*)THIS$1 + 40ll) = *(int64*)((uint8*)__FB_RHS__$1 + 40ll);
	*(int64*)((uint8*)THIS$1 + 48ll) = *(int64*)((uint8*)__FB_RHS__$1 + 48ll);
	FBSTRING* vr$17 = fb_StrAssign( (void*)((uint8*)THIS$1 + 56ll), -1ll, (void*)((uint8*)__FB_RHS__$1 + 56ll), -1ll, 0 );
	*(boolean*)((uint8*)THIS$1 + 80ll) = *(boolean*)((uint8*)__FB_RHS__$1 + 80ll);
	*(int64*)((uint8*)THIS$1 + 88ll) = *(int64*)((uint8*)__FB_RHS__$1 + 88ll);
	*($10TIMER_ENUM*)((uint8*)THIS$1 + 96ll) = *($10TIMER_ENUM*)((uint8*)__FB_RHS__$1 + 96ll);
	*($10STYLE_ENUM*)((uint8*)THIS$1 + 104ll) = *($10STYLE_ENUM*)((uint8*)__FB_RHS__$1 + 104ll);
	*(int64*)((uint8*)THIS$1 + 112ll) = *(int64*)((uint8*)__FB_RHS__$1 + 112ll);
	*(int64*)((uint8*)THIS$1 + 120ll) = *(int64*)((uint8*)__FB_RHS__$1 + 120ll);
	label$11:;
}

static void _ZN9COMPONENTD1Ev( struct $9COMPONENT* THIS$1 )
{
	label$14:;
	label$15:;
	fb_StrDelete( (FBSTRING*)((uint8*)THIS$1 + 56ll) );
	fb_StrDelete( (FBSTRING*)THIS$1 );
}
