#ifndef __SYS_LOCK_H__
#define __SYS_LOCK_H__


typedef void *_LOCK_T;
typedef void *_LOCK_RECURSIVE_T;
 
#include <_ansi.h>

#define STATIC_LOCK_INITIALIZER (void *)(-1)
#define STATIC_RECURSIVE_LOCK_INITIALIZER (void *)(-2)

void __libc_lock_init(_LOCK_T *lock);
void __libc_lock_init_recursive(_LOCK_RECURSIVE_T *lock);
void __libc_lock_close(_LOCK_T *lock);
void __libc_lock_close_recursive(_LOCK_RECURSIVE_T *lock);
void __libc_lock_acquire(_LOCK_T *lock);
void __libc_lock_acquire_recursive(_LOCK_RECURSIVE_T *lock);
void __libc_lock_try_acquire(_LOCK_T *lock);
void __libc_lock_try_acquire_recursive(_LOCK_RECURSIVE_T *lock);
void __libc_lock_release(_LOCK_T *lock);
void __libc_lock_release_recursive(_LOCK_RECURSIVE_T *lock);

#define __LOCK_INIT(class,lock) class _LOCK_T lock = STATIC_LOCK_INITIALIZER;
#define __LOCK_INIT_RECURSIVE(class,lock) class _LOCK_RECURSIVE_T lock = STATIC_RECURSIVE_LOCK_INITIALIZER;
#define __lock_init(lock) __libc_lock_init(&(lock))
#define __lock_init_recursive(lock) __libc_lock_init_recursive(&(lock))
#define __lock_close(lock) __libc_lock_close(&(lock))
#define __lock_close_recursive(lock) __libc_lock_close_recursive(&(lock))
#define __lock_acquire(lock) __libc_lock_acquire(&(lock))
#define __lock_acquire_recursive(lock) __libc_lock_acquire_recursive(&(lock))
#define __lock_try_acquire(lock) __libc_lock_try_acquire(&(lock))
#define __lock_try_acquire_recursive(lock) __libc_lock_try_acquire_recursive(&(lock))
#define __lock_release(lock) __libc_lock_release(&(lock))
#define __lock_release_recursive(lock) __libc_lock_release_recursive(&(lock))

#endif /* __SYS_LOCK_H__ */
