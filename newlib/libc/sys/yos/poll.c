/*
 * poll.c
 *
 *  Created on: 11.04.2011
 *      Author: Yosic
 */

#include <sys/poll.h>
#include <stdarg.h>
#include <reent.h>
#include <errno.h>

extern int _poll(struct pollfd *fds, nfds_t nfds, int timeout);
int _poll_r(struct _reent *ptr, struct pollfd *fds, nfds_t nfds, int timeout);

int poll(struct pollfd *fds, nfds_t nfds, int timeout)
{
    return _poll_r (_REENT, fds, nfds, timeout);
}

int _poll_r(struct _reent *ptr, struct pollfd *fds, nfds_t nfds, int timeout)
{
  errno = 0;
  int ret;
  if ((ret = _poll(fds, nfds, timeout)) == -1 && errno != 0)
    ptr->_errno = errno;
  return ret;
}

