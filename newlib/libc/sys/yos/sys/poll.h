/*
 * poll.h
 *
 *  Created on: 07.04.2011
 *      Author: Yosic
 */

#ifndef POLL_H_
#define POLL_H_

#include <stddef.h>

struct pollfd {
    int   fd;         /* file descriptor */
    short events;     /* requested events */
    short revents;    /* returned events */
};
typedef int nfds_t;


#define POLLRDNORM _BV(0)
#define POLLRDBAND _BV(1)
#define POLLPRI _BV(2)
#define POLLIN (POLLRDNORM | POLLRDBAND)
#define POLLHUP _BV(3)
#define POLLERR _BV(4)
#define POLLWRNORM _BV(5)
#define POLLWRBAND _BV(6)
#define POLLOUT POLLWRNORM
#define POLLNVAL _BV(7)

int poll(struct pollfd *fds, nfds_t nfds, int timeout);

#endif /* IOCTL_H_ */
