
#ifndef SFEM_EXPORT_H
#define SFEM_EXPORT_H

#ifdef SFEM_STATIC_DEFINE
#  define SFEM_EXPORT
#  define SFEM_NO_EXPORT
#else
#  ifndef SFEM_EXPORT
#    ifdef libsfem_EXPORTS
        /* We are building this library */
#      define SFEM_EXPORT __attribute__((visibility("default")))
#    else
        /* We are using this library */
#      define SFEM_EXPORT __attribute__((visibility("default")))
#    endif
#  endif

#  ifndef SFEM_NO_EXPORT
#    define SFEM_NO_EXPORT __attribute__((visibility("hidden")))
#  endif
#endif

#ifndef SFEM_DEPRECATED
#  define SFEM_DEPRECATED __attribute__ ((__deprecated__))
#endif

#ifndef SFEM_DEPRECATED_EXPORT
#  define SFEM_DEPRECATED_EXPORT SFEM_EXPORT SFEM_DEPRECATED
#endif

#ifndef SFEM_DEPRECATED_NO_EXPORT
#  define SFEM_DEPRECATED_NO_EXPORT SFEM_NO_EXPORT SFEM_DEPRECATED
#endif

#if 0 /* DEFINE_NO_DEPRECATED */
#  ifndef SFEM_NO_DEPRECATED
#    define SFEM_NO_DEPRECATED
#  endif
#endif

#endif /* SFEM_EXPORT_H */
