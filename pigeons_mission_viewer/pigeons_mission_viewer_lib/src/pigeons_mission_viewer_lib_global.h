#ifndef PIGEONS_MISSION_VIEWER_LIB_GLOBAL_H
#define PIGEONS_MISSION_VIEWER_LIB_GLOBAL_H

#include <QtCore/qglobal.h>

#if defined(PIGEONS_MISSION_VIEWER_LIB_LIBRARY)
#  define PIGEONS_MISSION_VIEWER_LIBSHARED_EXPORT Q_DECL_EXPORT
#else
#  define PIGEONS_MISSION_VIEWER_LIBSHARED_EXPORT Q_DECL_IMPORT
#endif

#endif // PIGEONS_MISSION_VIEWER_LIB_GLOBAL_H
