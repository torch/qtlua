// -*- C++ -*-

#ifndef QTWIDGET_H
#define QTWIDGET_H

extern "C" {
#include "lua.h"
#include "lauxlib.h"
}
#include "qtluaengine.h"
#include "qtluautils.h"


#ifdef _WIN32
# ifdef libqtwidget_EXPORTS
#  define QTWIDGET_API __declspec(dllexport)
# else
#  define QTWIDGET_API __declspec(dllimport)
# endif
#else
# define QTWIDGET_API /**/
#endif

#define LUA_EXTERNC extern "C"

LUA_EXTERNC QTWIDGET_API int luaopen_libqtwidget(lua_State *L);


#endif


/* -------------------------------------------------------------
   Local Variables:
   c++-font-lock-extra-types: ("\\sw+_t" "\\(lua_\\)?[A-Z]\\sw*[a-z]\\sw*")
   End:
   ------------------------------------------------------------- */


