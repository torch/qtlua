# -*- cmake -*-

SET(QT_USE_QTXML 1)
SET(QT_USE_QTSVG 1)
#INCLUDE(${QT_USE_FILE})		     
INCLUDE_DIRECTORIES("${CMAKE_CURRENT_SOURCE_DIR}" "${CMAKE_CURRENT_BINARY_DIR}" "${Qt5Svg_INCLUDE_DIRS}" "${Qt5Widgets_INCLUDE_DIRS}")

SET(qtsvg_SRC 
  qtsvg.h qtsvg.cpp
  qtluasvggenerator.h qtluasvggenerator.cpp )
   
MACRO_QT5_AUTOGEN(qtsvg_GEN ${qtsvg_SRC})
MACRO_ADD_QTLUA_MODULE(libqtsvg ${qtsvg_SRC} ${qtsvg_GEN})
TARGET_LINK_LIBRARIES(libqtsvg ${Qt5Svg_LIBRARIES})

MACRO_INSTALL_QTLUA_FILES(qtsvg init.lua)

#ADD_TORCH_DOK(dok qtsvg "QT Interface" "SVG" 6.)
