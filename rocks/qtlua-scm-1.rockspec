package = "qtlua"
version = "scm-1"

source = {
   url = "git://github.com/torch/qtlua.git",
}

description = {
   summary = "Powerful QT interface to Lua",
   detailed = [[
   ]],
   homepage = "https://github.com/torch/qtlua",
   license = "BSD"
}

dependencies = {
   "lua >= 5.1",
}

build = {
   type = "command",
   build_command = [[
cmake -E make_directory build && cd build && cmake .. -DCMAKE_BUILD_TYPE=Release -DLUA=$(LUA) -DLUALIB=$(LUALIB) -DLUA_BINDIR="$(LUA_BINDIR)" -DLUA_INCDIR="$(LUA_INCDIR)" -DLUA_LIBDIR="$(LUA_LIBDIR)" -DLUADIR="$(LUADIR)" -DLIBDIR="$(LIBDIR)" -DCONFDIR="$(CONFDIR)" && $(MAKE)
]],
   install_command = "cd build && $(MAKE) install"
}
