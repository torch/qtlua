# -*- cmake -*-

project(QtLua)

IF(APPLE)
  CMAKE_MINIMUM_REQUIRED(VERSION 2.8.12 FATAL_ERROR)
  CMAKE_POLICY(VERSION 2.8.12)
  SET(CMAKE_MACOSX_RPATH TRUE) # @rpath in libs
ELSE()
  CMAKE_MINIMUM_REQUIRED(VERSION 2.8 FATAL_ERROR)
  CMAKE_POLICY(VERSION 2.8)
ENDIF()

# --- avoid warnings
IF(POLICY CMP0026)
 CMAKE_POLICY(SET CMP0026 OLD)
ENDIF()

SET(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

INCLUDE(QtLuaPaths)

# --- General

SET(WITH_QTLUA_IDE ON
  CACHE BOOL "Compile qlua ide (require Qt>=4.4)")

# --- Macros

INCLUDE(MacroQt4AutoGen)
INCLUDE(MacroAddQtLuaModule)
INCLUDE(CheckCXXSourceCompiles)
INCLUDE(CheckCXXSourceRuns)

# --- Qt4

SET(QT_MIN_VERSION "4.3.0")
FIND_PACKAGE(Qt4 REQUIRED)

# --- Lua

# Include Lua Files
FIND_PACKAGE(Lua REQUIRED)
INCLUDE_DIRECTORIES(${LUA_INCDIR})
LINK_DIRECTORIES(${LUA_LIBDIR})

## Hard to check because of issues with RPATH
## The compiled program looks for the lua library
## relative to its own location (arg!)
# # was lua compiled with c++?
# SET(CMAKE_REQUIRED_DEFINITIONS ${LUA_DEFINITIONS})
# SET(CMAKE_REQUIRED_INCLUDES ${LUA_INCLUDE_DIR})
# SET(CMAKE_REQUIRED_LIBRARIES ${LUA_LIBRARIES})
# CHECK_CXX_SOURCE_RUNS("
# #include <stdlib.h>
# #include \"lua.h\"
# #include \"lauxlib.h\"
# int result = 1;
# int foo(lua_State *L) { 
#   try { luaL_error(L,\"error\"); } catch(...) { result=0; throw; } 
#   return 0; }
# int main() { lua_State *L = luaL_newstate();
#   lua_pushcfunction(L, foo);
#   lua_pcall(L, 0, 0, 0); exit(result); }" 
#   LUA_COMPILED_WITH_CXX)
# SET(CMAKE_REQUIRED_DEFINITIONS)
# SET(CMAKE_REQUIRED_INCLUDES)
# SET(CMAKE_REQUIRED_LIBRARIES)
# MESSAGE("HEYYY <${LUA_COMPILED_WITH_CXX}>")
# IF (NOT "${LUA_COMPILED_WITH_CXX}" EQUAL "0")
#   MESSAGE(FATAL_ERROR "Lua not compiled with C++ exceptions support")
# ENDIF (NOT "${LUA_COMPILED_WITH_CXX}" EQUAL "0")


# --- compile libqtlua

# ADD_SUBDIRECTORY(qtutil)
ADD_SUBDIRECTORY(qtlua)
FIND_PACKAGE(QtLua REQUIRED)
ADD_SUBDIRECTORY(qlua)
ADD_SUBDIRECTORY(packages)

# --- install qt libraries

IF (WIN32 AND NOT CYGWIN)
  SET(QT_INSTALL_LIBRARIES "OFF"
    CACHE BOOL "Copy the required Qt DLLs into the Torch install dirs")
ENDIF (WIN32 AND NOT CYGWIN)

IF (QT_INSTALL_LIBRARIES)
  # -- turn on all the qt modules we use
  SET(QT_USE_QTUITOOLS 1)
  SET(QT_USE_QTWEBKIT 1)
  SET(QT_USE_QTOPENGL 1)
  SET(QT_USE_QTXML 1)
  SET(QT_USE_QTSVG 1)
  # -- this takes care of the install
  INCLUDE("InstallRequiredQtLibraries")
ENDIF (QT_INSTALL_LIBRARIES)
