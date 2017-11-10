# -*- cmake -*-

INCLUDE_DIRECTORIES("${CMAKE_CURRENT_SOURCE_DIR}" "${CMAKE_CURRENT_BINARY_DIR}" "${Qt5Gui_INCLUDE_DIRS}" "${Qt5PrintSupport_INCLUDE_DIRS}")
#INCLUDE(${QT_USE_FILE})		     

SET(qtwidget_SRC 
  qtluapainter.h qtluapainter.cpp
  qtluaprinter.h qtluaprinter.cpp
  qtlualistener.h qtlualistener.cpp
  qtwidget.h qtwidget.cpp )

MACRO_INSTALL_QTLUA_FILES(qtwidget init.lua)

MACRO_QT5_AUTOGEN(qtwidget_GEN ${qtwidget_SRC})
MACRO_ADD_QTLUA_MODULE(libqtwidget ${qtwidget_SRC} ${qtwidget_GEN})
TARGET_LINK_LIBRARIES(libqtwidget ${Qt5PrintSupport_LIBRARIES})

#ADD_TORCH_DOK(dok qtwidget "QT Interface" "Widgets and events" 6.)

