
require 'qt'
qt.require 'libqtsvg'

local qt = qt
local type = type

qtsvg = qtsvg or {}

function qtsvg.loadsvg(filename)
   return qt.QSvgRenderer(filename)
end

function qtsvg.paintsvg(port,svg,...)
   if type(port) == "table" then
      port = port.port
   end
   if not qt.isa(port, "QtLuaPainter") then
      error("arg 1 is not a valid painting device", 2)
   end
   if type(svg) == "string" then
      svg = loadsvg(svg)
   end
   if not qt.isa(svg, "QSvgRenderer") then
      error("arg 2 is not a string or a svg renderer", 2)
   end
   port:gbegin()
   svg:render(port:painter(), ...)
   port:gend(true)
end

return qtsvg
