// -*- C++ -*-

#ifndef QTSVG_H
#define QTSVG_H

extern "C" {
#include "lua.h"
#include "lauxlib.h"
}
#include "qtluaengine.h"
#include "qtluautils.h"


#ifdef _WIN32
# ifdef libqtsvg_EXPORTS
#  define QTSVG_API __declspec(dllexport)
# else
#  define QTSVG_API __declspec(dllimport)
# endif
#else
# define QTSVG_API /**/
#endif

#define LUA_EXTERNC extern "C"

LUA_EXTERNC QTSVG_API int luaopen_libqtsvg(lua_State *L);


#endif


/* -------------------------------------------------------------
   Local Variables:
   c++-font-lock-extra-types: ("\\sw+_t" "\\(lua_\\)?[A-Z]\\sw*[a-z]\\sw*")
   End:
   ------------------------------------------------------------- */


