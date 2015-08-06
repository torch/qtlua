// -*- C -*-

#ifndef QTLUACONF_H
#define QTLUACONF_H

#ifdef WIN32
# ifdef libqtlua_EXPORTS
#  define QTLUAAPI __declspec(dllexport)
# else
#  define QTLUAAPI __declspec(dllimport)
# endif
#else
# define QTLUAAPI
#endif

#ifdef __cplusplus
# define QTLUA_EXTERNC extern "C"
#else
# define QTLUA_EXTERNC extern
#endif

#if !defined LUA_VERSION_NUM || LUA_VERSION_NUM==501
# define lua_pushglobaltable(L) lua_pushvalue(L, LUA_GLOBALSINDEX)
# define lua_setuservalue lua_setfenv
# define lua_getuservalue lua_getfenv
# define luaQ_typerror luaL_typerror
static void luaL_setfuncs (lua_State *L, const luaL_Reg *l, int nup) {
  luaL_checkstack(L, nup+1, "too many upvalues");
  for (; l->name != NULL; l++) {  /* fill the table with given functions */
    int i;
    lua_pushstring(L, l->name);
    for (i = 0; i < nup; i++)  /* copy upvalues to the top */
      lua_pushvalue(L, -(nup+1));
    lua_pushcclosure(L, l->func, nup);  /* closure with those upvalues */
    lua_settable(L, -(nup + 3));
  }
  lua_pop(L, nup);  /* remove upvalues */
}
#else
# define lua_objlen lua_rawlen
# define LUA_PATHSEP     ";"
static int luaQ_typerror(lua_State *L, int narg, const char *tname)
{
  return luaL_error(L, "%s expected, got %s", tname, luaL_typename(L, narg));
}
#endif

#endif


/* -------------------------------------------------------------
   Local Variables:
   c++-font-lock-extra-types: ( "\\sw+_t" "lua_[A-Z]\\sw*[a-z]\\sw*" )
   c-font-lock-extra-types: ( "\\sw+_t" "lua_[A-Z]\\sw*[a-z]\\sw*" )
   End:
   ------------------------------------------------------------- */
