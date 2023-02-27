/*
 * ioctl.c
 *
 *  Created on: 07.04.2011
 *      Author: Yosic
 */

#include <sys/ioctl.h>
#include <stdarg.h>
#include <reent.h>
#include <errno.h>

extern int _ioctl(int file, int code, ...);

int _ioctl_r(struct _reent *ptr, int fd, int code, ...);

int ioctl(int fd, int code, ...)
{
    va_list ap;
    int ret;

    va_start (ap, code);
    ret = _ioctl_r (_REENT, fd, code, va_arg (ap, void*));
    va_end (ap);
    return ret;
}

int _ioctl_r(struct _reent *ptr, int fd, int code, ...)
{
  va_list ap;
  int ret;

  errno = 0;
  va_start (ap, code);
  if ((ret = _ioctl(fd, code, va_arg (ap, void*))) == -1 && errno != 0)
    ptr->_errno = errno;
  va_end (ap);
  return ret;
}

