/*
 * getreent.c
 *
 *  Created on: 13.10.2011
 *      Author: Yosic
 */

#include <reent.h>
#define weak_alias(name, aliasname) \
  extern __typeof (name) aliasname __attribute__ ((weak, alias (#name)));

extern struct _reent *__libc_getreent (void);

struct _reent *
__imp_getreent (void)
{
  return __libc_getreent();
}
weak_alias(__imp_getreent,__getreent)
