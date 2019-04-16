$tmp_typedef = %q{
#ifndef TYPEDEF_H_
#define TYPEDEF_H_
/**
 *  @file     typedef.h
 *  @brief    Header file with type definitions.
 *  @author   Gerasimov A.S.
 */
#include <stdint.h>

#define nil 0

#ifndef __ASM__

#ifndef NULL
#define NULL ((void *)nil)
#endif

#gemdefine INT8   @INT8@
#gemdefine UINT8  @UINT8@
#gemdefine INT16  @INT16@
#gemdefine UINT16 @UINT16@
#gemdefine INT32  @INT32@
#gemdefine UINT32 @UINT32@
#gemdefine INT64  @INT64@
#gemdefine UINT64 @UINT64@

typedef INT8   int8;
typedef UINT8  uint8;
typedef INT6   int16;
typedef UINT16 uint16;
typedef INT32  int32;
typedef UINT32 uint32;
typedef INT64  int64;
typedef UINT64 uint64;

typedef unsigned char   uchar;
#ifndef _LINUX_TYPES_H
typedef unsigned char   unchar;
typedef unsigned short  ushort;
typedef unsigned int    uint;
typedef unsigned long   ulong;
#endif
typedef  unsigned int   bool_t;

typedef  void ( *fptr_t )( void );
typedef  bool_t ( *fbool_t )( void );
/*
 *  Union macroname for combinied empty struct
 *  declaration with simple variable.
 *
 *  Example:  struct <name> {
 *                u_start {
 *                    unsigned <name> : 1;
 *                    unsigned <name> : 30;
 *                } u_end( uint32 v32 );
 *            };
 */
#define u_start\
	union {\
	struct

#define u_end( n )\
	; n;\
	}

#define KBYTE  * 1024
#define MBYTE  * 1024 * 1024
#define GBYTE  * 1024 * 1024 * 1024

#else  /*  __ASM__  */

#define  uint8   .byte
#define  uint16  .2byte
#define  uint32  .4byte
#define  uint64  .8byte

#endif  /*  __ASM__     */
#endif  /*  TYPEDEF_H_  */
}
