<a name="qtsvg.dok"></a>
# QtSvg Bindings #

The package `qtsvg` 
contains bindings for classes defined by the Qt module
[QtSvg](http://doc.trolltech.com/4.4/qtsvg.html).

Besides the capabilites reported below,
all qt variants inherit a set 
of [default methods](qt.md#QVariants),
and all qt object classes inherit the capabilities from their 
superclasses and automatically expose 
[properties, slots and signals](qt.md#QObjects).

You can also use the function 
[qtwidget.newpdf](qtwidget.md#qtwidgetnewpdf),
defined in module `qtwidget`,
to easily generate SVG files. 


<a name="qtsvg_loadsvg"></a>
### qtsvg.loadsvg(filename) ###
<a name="qtsvg.loadsvg"></a>

Returns a Qt object of 
class [qt.QSvgRenderer](#qsvgrenderer)
representing the SVG file `filename`.

<a name="qtsvg_paintsvg"></a>
### qtsvg.paintsvg(port,svg,...) ###
<a name="qtsvg.paintsvg"></a>

Draws a SVG image.

Argument `port` must be a 
[qt.QtLuaPainter](qtwidget.md#qtluapainter) or a 
[qtwidget'' high level port descriptor](qtwidget.md#highlevel).
Argument `svg` can be the SVG filename or
an instance of class [qt.QSvgRenderer](#qsvgrenderer)
such as those returned by function [qtsvg.loadsvg](#qtsvg_loadsvg).
The remaining arguments are the same
as those for the C++ function `QSvgRenderer::render`.


<a name="qsvgwidget"></a>
### qt.QSvgWidget ###

Class 
[QSvgWidget](http://doc.trolltech.com/4.4/qsvgwidget.html)
provides a widget that is used to display the contents 
of Scalable Vector Graphics (SVG) files.

<a name="qsvgwidget"></a>
#### qt.QSvgWidget([filename],[parent]) ####

Expression `qt.QSvgWidget(parent)` returns a 
new widget for rendering SVG data.

The optional argument `filename` specifies the name
of a file containing the SVG data.  Without this argument,
you must use slot `qsvgwidget:load()` to load SVG data.

The optional argument `parent` specifies the widget parent.
New widgets are always created from the main thread using
the [thread hopping](qt.md#qtqcall) mechanism.
When argument `parent` is `nil` or not specified,
the new widget is owned by the Lua interpreter 
and is automatically destroyed when the garbage collector
determines that it is no longer referenced.

<a name="qsvgwidget.renderer"></a>
#### qsvgwidget:renderer() ####

Returns the [qt.QSvgRenderer](#qsvgrenderer) object 
associated with this widget.


<a name="qsvgrenderer"></a>
### qt.QSvgRenderer ###

Class 
[QSvgRenderer](http://doc.trolltech.com/4.4/qsvgrenderer.html)
is used to draw the contents of SVG files onto paint devices.
You should use instead function 
[qtsvg.paintsvg](#qtsvg_paintsvg)
to easily display SVG data.

<a name="qsvgrenderer"></a>
#### qt.QSvgRenderer([filename],[parent]) ####

Creates a new instance of class `QSvgRenderer`.

The optional argument `filename` specifies the name
of a file containing the SVG data.  Without this argument,
you must use slot `qsvgwidget:load()` to load SVG data.

The optional argument `parent` specifies the widget parent.
When argument `parent` is `nil` or not specified,
the new widget is owned by the Lua interpreter 
and is automatically destroyed when the garbage collector
determines that it is no longer referenced.


<a name="qtluasvggenerator"></a>
### qt.QtLuaSvgGenerator ###

This is a thin wrapper around the Qt class
[QSvgGenerator](http://doc.trolltech.com/4.4/qsvggenerator.html).

You should use instead function 
[qtwidget.newpdf](qtwidget.md#qtwidgetnewpdf)
to easily generate SVG files.

<a name="qtluasvggenerator"></a>
#### qt.QtLuaSvgGenerator([filename],[parent]) ####

Creates a new instance of class `QtLuaSvgGenerator`.

When argument `filename` is present, the SVG data is written
into the specified file. Otherwise it is written into a memory
buffer accessible using the method 
[qsvggenerator:data()](#qtluasvggeneratordata).

The optional argument `parent` specifies the widget parent.
When argument `parent` is `nil` or not specified,
the new widget is owned by the Lua interpreter 
and is automatically destroyed when the garbage collector
determines that it is no longer referenced.

<a name="qtluasvggeneratordata"></a>
#### qtluasvggenerator:data() ####
<a name="qtluasvggenerator.data"></a>

Assuming the `qtluasvggenerator` was created without the `filename` argument,
this function returns a [qt.QByteArray](qtcore.md#qbytearray)
containing the generated SVG data.  This data may be incomplete
until [painter:close()](qtwidget.md#painterclose) has
been closed on all painters operating on `qtluasvggenerator`.

<a name="qtluasvggenerator.description"></a>
#### qtluasvggenerator.description ####

Starting with Qt-4.5, this string property defines 
the contents of the `<desc>` tag of the SVG file.

<a name="qtluasvggenerator.title"></a>
#### qtluasvggenerator.title ####

Starting with Qt-4.5, this string property defines 
the contents of the `<title>` tag of the SVG file.

<a name="qtluasvggenerator.size"></a>
#### qtluasvggenerator.size ####

This property contains a [qt.QSize](qtcore.md#qsize) 
variant containing the size of the drawable area.
This information is shown in the `viewBox` attribute of the `<svg>` tag.

<a name="qtluasvggenerator.resolution"></a>
#### qtluasvggenerator.resolution ####

This integer property defines the resolution, in dots per inch, 
of the coordinate system.
Together with `qtluasvggenerator.size`, this property determines
the contents of the `width` and `height` attributes of the `<svg>` tag.

