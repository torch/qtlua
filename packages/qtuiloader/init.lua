
require 'qtcore'

if qt and qt.qApp and qt.qApp:runsWithoutGraphics() then
   print("qlua: not loading module qtuiloader (running with -nographics)")
   return
end

qt.require 'libqtuiloader'

local qt = qt

qtuiloader = qtuiloader or {}
local M = qtuiloader

local theloader = nil

function M.loader()
   if (not theloader or not theloader:tobool()) then
      theloader = qt.QUiLoader()
   end
   return theloader;
end

local loaderFunctions = {
   "load", "availableWidgets", "createWidget",
   "createLayout", "createAction", "createActionGroup" }

for i = 1,#loaderFunctions do
   local f = loaderFunctions[i]
   M[f] = function(...)
              local uiloader = M.loader()
              return uiloader[f](uiloader,...)
           end
end

return M
