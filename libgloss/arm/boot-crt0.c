/*
 * yos-crt0.c
 *
 *  Created on: 12.10.2011
 *      Author: Yosic
 */

#include "newlib.h"
#include <sys/types.h>

void start(void);
void _start(void) __attribute__ ((alias ("start")));
void _mainCRTStartup(void) __attribute__ ((alias ("start")));

register void * stack_ptr asm ("sp");

extern char __bss_start__;
extern char __bss_end__;
extern char __data_load__;
extern char __data_start__;
extern char __data_end__;
extern char __stack__;

#ifdef __USES_INITFINI__
extern void __libc_init_array();
extern void __libc_fini_array();
#endif
extern int boot_main();
extern void *memset(void * ptr, int value, size_t num);
extern void *memcpy(void * dest, const void * src, size_t num);

void start(void)
{
    if(&__stack__!=0)
        stack_ptr=&__stack__;
    size_t size=&__data_end__ - &__data_start__;
    if(size)
        memcpy(&__data_start__, &__data_load__, size);
    size=&__bss_end__ - &__bss_start__;
    if(size)
        memset(&__bss_start__, 0 , size);
#ifdef __USES_INITFINI__
    __libc_init_array();
#endif
    boot_main();
#ifdef __USES_INITFINI__
    __libc_fini_array;
#endif
}
