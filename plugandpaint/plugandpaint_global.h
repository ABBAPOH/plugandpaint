#ifndef PLUGANDPAINT_GLOBAL_H
#define PLUGANDPAINT_GLOBAL_H

#include <qglobal.h>

#ifdef PLUGANDPAINT_STATIC_LIB
#   define PLUGANDPAINT_EXPORT
#else
#   ifdef PLUGANDPAINT_LIBRARY
#       define PLUGANDPAINT_EXPORT Q_DECL_EXPORT
#   else
#       define PLUGANDPAINT_EXPORT Q_DECL_IMPORT
#   endif
#endif

#endif // PLUGANDPAINT_GLOBAL_H
