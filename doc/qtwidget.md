<a name="qtwidget.dok"></a>
# QtWidget Package Reference Manual #

Package `qtwidget` provides convenient way
to make drawings and capture user events.
In particular, class [QtLuaPainter](#qtluapainter) gives 
the ability to draw simple graphics using well known 
postscript-like operators. Graphic output can be sent to an 
arbitrary widget, to a PS or PDF file, or to a printer.
Class [QtLuaListener](#qtlualistener) gives the 
ability to listen to events on arbitrary widgets

For instance, the convenient 
function [qtwidget.newwindow](#qtwidgetnewwindow)
creates a main window and returns its descriptor.

```lua
require 'qtwidget'
w=qtwidget.newwindow(400,300,"Some QWidget")
```

Drawing is easily achieved using Postscript-like operators.

```lua
w:moveto(0,0); w:curveto(0,300,400,0,400,300); w:closepath()
w:setcolor("red"); w:fill(false)
w:setcolor("blue"); w:setlinewidth(5); w:stroke()
```

Text output is of course supported 
using [show](#paintershow).

```lua
w:moveto(90,40)
w:setcolor("black")
w:setfont(qt.QFont{serif=true,italic=true,size=20})
w:show("The Quick Brown Fox...")
```

Alpha-transparency works as well.

```lua
w:rectangle(50,50,300,200)
w:setcolor(1,1,0,.5)
w:fill()
```

Finally you can capture Qt events using the 
[qt.connect](qt.md#qt.connect) function
on the predefined [qt.QtLuaListener](#qtlualistener) object,

```lua
qt.connect(w.listener,
    'sigMousePress(int,int,QByteArray,QByteArray,QByteArray)',
    function(...) print("MousePress",...) end );
```


and you can erase everything with

```lua
w:showpage()
```

<a name="highlevel"></a>
## High Level Interface ##

The following convenience functions 
provide simple ways to perform graphic display 
whose output is directed to a window on the screen,
to an image in memory, to a PostScript file, to a PDF file, or to a printer.
Each of these functions return a Lua table
that defines a number of useful fields and methods.
In particular, all the 
[painting functions](#qtluapainterfunctions) 
defined by class [qt.QtLuaPainter](#qtluapainter)
can be called directly using the 
[Lua method syntax](..:LuaManual#FunctionCalls) 
on these tables.



<a name="qtwidgetnewwindow"></a>
### qtwidget.newwindow(w,h,[title]) ###
<a name="qtwidget.newwindow"></a>

Expression `qtwidget.newwindow(w,h,title)` creates a
toplevel widget of class [qt.QWidget](qtgui.md#qwidget)
and a [qt.QtLuaPainter](#qtluapainter) object 
operating on that widget.  
Numerical arguments `w` and `h` specify the size of the widget.
String argument `title` specifies a window title.
The expression returns a Lua table that 
serves as a drawing port descriptor.

<a name="qtwidgetnewimage"></a>
### qtwidget.newimage(...) ###
<a name="qtwidget.newimage"></a>

Function `qtwidget.newimage` creates an image in memory
that can be the target of drawing operations.
This function returns a Lua table that 
serves as a drawing port descriptor.

There are several ways to specify its arguments:

__`qtwidget.newimage(w,h,[monoflag])`__

Creates an image of width `w` and height `h`.
When the optional argument `monoflag` is `true`, 
a bitonal image is created.
Otherwise the image can contain arbitrary RGBA colors.

__`qtwidget.newimage(filename,[format])`__

Creates an image by loading the contents of file `filename`.
The file format is defined by the optional string argument `format` 
or derived from the file name extension.

__`qtwidget.newimage(torchtensor)`__

Creates an image by extracting the contents of the specified
[torch.Tensor](..:torch:index#Tensor).
The valid tensor formats are described in the documentation for function 
[qt.QImage.fromTensor](qt.md#qimagefromtensor).
This only works when both packages [torch](..:torch:index)
and [qttorch](qt.md) have been loaded.


<a name="qtwidgetnewps"></a>
### qtwidget.newps(w,h,filename) ###
<a name="qtwidget.newps"></a>

Expression `qtwidget.newps(w,h,filename)` returns a Lua table that 
serves as a drawing port descriptor.
Drawing operations will be output 
into the PostScript file `filename`.
Arguments `w` and `h` represent the 
initial size of the coordinate system.

The output file contains incomplete data until
you delete the painter object or call 
method [close](#qtwidgetclose).

<a name="qtwidgetnewpdf"></a>
### qtwidget.newpdf(w,h,filename) ###
<a name="qtwidget.newpdf"></a>

Expression `qtwidget.newpdf(w,h,filename)` returns a Lua table that 
serves as a drawing port descriptor.
Drawing operations will be output 
into the PDF file `filename`.
Arguments `w` and `h` represent the 
initial size of the coordinate system.

The output file contains invalid data until
you delete the painter object or call 
method [close](#qtwidgetclose).


<a name="qtwidgetnewsvg"></a>
### qtwidget.newsvg(w,h,[filename]) ###
<a name="qtwidget.newsvg"></a>

Expression `qtwidget.newsvg(w,h,filename)` returns a Lua table that 
serves as a drawing port descriptor.
The optional argument `filename` contains the 
name of the destination file for the SVG data.
Arguments `w` and `h` represent the 
initial size of the coordinate system.

The output contains invalid data until
you delete the painter object or call 
method [close](#qtwidgetclose).
When argument `filename` is not specified, 
the SVG data is written into an internal memory buffer 
accessible using expression 
[desc.svg:data()](qtsvg.md#qtluasvggeneratordata).


<a name="qtwidgetnewprint"></a>
### qtwidget.newprint(w,h,[printername]) ###
<a name="qtwidget.newprint"></a>

Expression `qtwidget.newprint(w,h,printername)` 
returns a Lua table that 
serves as a drawing port descriptor.
Drawing operations will be output to printer `printername`.
When argument `printername` is omitted,
this function pops a print dialog that allows the user
to choose a printer and specify its settings.
Arguments `w` and `h` represent the 
initial size of the coordinate system.



<a name="qtpaintingfunctions"></a>
### Painting Functions. ###

All the [painting functions](#qtluapainterfunctions) 
defined by class [qt.QtLuaPainter](#qtluapainter)
can be called directly using the 
[Lua method syntax](..:LuaManual#FunctionCalls) 
on the table returned by the functions 
[qtwidget.newwindow](#qtwidgetnewwindow),
[qtwidget.newimage](#qtwidgetnewimage),
[qtwidget.newps](#qtwidgetnewps),
[qtwidget.newpdf](#qtwidgetnewpdf),
[qtwidget.newsvg](#qtwidgetnewsvg), and
[qtwidget.newprint](#qtwidgetnewprint).

These calls are simply forwarded to the underlying
[qt.QtLuaPainter](#qtluapainter) object.

  * [Link to the painting functions](#qtluapainterfunctions).


<a name="qtwidgetotherfunctions"></a>
### Other Functions and Fields. ###

The following fields and functions are defined
on the descriptor tables returned by the functions 
[qtwidget.newwindow](#qtwidgetnewwindow),
[qtwidget.newimage](#qtwidgetnewimage),
[qtwidget.newps](#qtwidgetnewps),
[qtwidget.newpdf](#qtwidgetnewpdf), and
[qtwidget.newprint](#qtwidgetnewprint).


<a name="descport"></a>
#### desc.port ####
<a name="qtwidget.desc.port"></a>

Field `desc.port` contains the
[qt.QtLuaPainter](#qtluapainter) object
that is used to perform the drawings.


<a name="qtwidget.desc.widget"></a>
#### desc.widget ####

Field `desc.widget` contains the
[qt.QWidget](qtgui.md#qwidget) object
that underlies drawing port descriptors created with 
[qtwidget.newwindow](#qtwidgetnewwindow).


<a name="qtwidget.desc.listener"></a>
#### desc.listener ####

Field `desc.widget` contains a
[qt.QtLuaListener](#qtlualistener) object.
that can be used to capture events on the widget created by
[qtwidget.newwindow](#qtwidgetnewwindow).

<a name="qtwidget.desc.printer"></a>
#### desc.printer ####

Field `desc.printer` contains the
[qt.QtLuaPrinter](#qtluaprinter) object
that underlies drawing port descriptors created with 
[qtwidget.newps](#qtwidgetnewps),
[qtwidget.newpdf](#qtwidgetnewpdf), or
[qtwidget.newprint](#qtwidgetnewprint).

<a name="qtwidget.desc.svg"></a>
#### desc.svg ####

Field `desc.svg` contains the
[qt.QtLuaSvgGenerator](qtsvg.md#qtluasvggenerator) object
associated with drawing ports created with
[qtwidget.newsvg](#qtwidgetnewsvg).


<a name="qtwidget.desc.width"></a>
#### desc.width ####

Field `desc.width` contains the width of the drawing surface.

<a name="qtwidget.desc.height"></a>
#### desc.height ####

Field `desc.height` contains the height of the drawing surface.


<a name="qtwidgetclose"></a>
#### desc:close() ####
<a name="qtwidget.desc.close"></a>

Function `desc:close()` closes the [qt.QtLuaPainter](#qtluapainter).
In the case of a drawing port descriptor returned by function
[qtwidget.newwindow](#qtwidgetnewwindow), 
this function also closes the [qt.QWidget](qtgui.md#qwidget) 
and the windows disappears from the screen.

<a name="qtwidget.desc.resize"></a>
#### desc:resize(w,h) ####

Function `desc:resize(w,h)` is only available for
drawing port descriptor returned by function
[qtwidget.newwindow](#qtwidgetnewwindow).
It resizes the underlying widget.


<a name="qtwidget.desc.onResize"></a>
#### desc:onResize(f) ####

Function `desc:onResize(f)` is only available for
drawing port descriptor returned by function
[qtwidget.newwindow](#qtwidgetnewwindow).
It ensures that 
function `f(w,h)` gets called whenever the widget size changes. 
The function argument indicate the new widget size.
Each call of `desc:onResize` replaces the previous callback function by `f`.
Calling it with argument `nil` removes the current callback.


<a name="qtwidget.desc.valid"></a>
#### desc:valid() ####

Expression `desc:valid()` returns `false` if the 
underlying drawing target is no longer valid,
for instance because the window has been closed.
Otherwise it returns `true`.


<a name="qtwidget.classes"></a>
## Classes ##

<a name="qtlualistener"></a>
### qt.QtLuaListener ###

Class `QtLuaListener` emits signals when its parent receives event messages.
This is convenient because the Lua program can define event handling functions
using the signal connection function [qt.connect](qt.md#qt.connect).

<a name="qtlualistener"></a>
#### qt.QtLuaListener(qwidget) ####

Expression `qt.QtLuaListener(qwidget)` returns a new `QtLuaListener` object
that relays the event messages received by widget `qwidget`.
This object is a child of `qwidget`.

<a name="qtlualistener.sigClose"></a>
#### [QtLuaListener signal] sigClose() ####

Signal `sigClose` is emitted when the underlying widget receives a 
[QCloseEvent](http://doc.trolltech.com/4.4/qcloseevent.html).

<a name="qtlualistener.sigResize"></a>
#### [QtLuaListener signal] sigResize(int,int) ####

Signal `sigResize` is emitted whenever the underlying widget receives a
[QResizeEvent](http://doc.trolltech.com/4.4/qresizeevent.html)
because it has changed size.  The two arguments are the new widget size.


<a name="qtlualistener.sigKeyPress"></a>
#### [QtLuaListener signal] sigKeyPress(QString,QByteArray,QByteArray) ####

Signal `sigKeyPress` is emitted whenever the underlying widget receives a
[QKeyEvent](http://doc.trolltech.com/4.4/qkeyevent.html)
of type `QEvent::KeyPress` because a key was pressed on the keyboard.
The first argument is a string representing the text associated with the key.
The second argument is the 
[key name](http://doc.trolltech.com/4.4/qt.html#Key-enum).
The third argument is a string containing the 
[keyboard modifier names](http://doc.trolltech.com/4.4/qt.html#KeyboardModifier-enum)
separated by a vertical bar.  


<a name="qtlualistener.sigKeyRelease"></a>
#### [QtLuaListener signal] sigKeyRelease(QString,QByteArray,QByteArray) ####

Signal `sigKeyRelease` is emitted whenever the underlying widget receives a
[QKeyEvent](http://doc.trolltech.com/4.4/qkeyevent.html)
of type `QEvent::KeyRelease` because a key was released on the keyboard.
The first argument is a string representing the text associated with the key.
The second argument is the 
[key name](http://doc.trolltech.com/4.4/qt.html#Key-enum).
The third argument is a string containing the 
[keyboard modifier names](http://doc.trolltech.com/4.4/qt.html#KeyboardModifier-enum)
separated by a vertical bar.  



<a name="qtlualistener.sigMousePress"></a>
#### [QtLuaListener signal] sigMousePress(int,int,QByteArray,QByteArray,QByteArray) ####

Signal `sigMousePress` is emitted whenever the underlying widget receives a
[QMouseEvent](http://doc.trolltech.com/4.4/qmouseevent.html)
of type `QEvent::MouseButtonPress` because a mouse button was pressed.
The first two arguments are the 
pixel coordinates of the mouse pointer when the button was clicked
The third argument is a string containing the 
[button name](http://doc.trolltech.com/4.4/qt.html#MouseButton-enum).
The fourth argument is a string containing the 
[keyboard modifier names](http://doc.trolltech.com/4.4/qt.html#KeyboardModifier-enum)
separated by a vertical bar.  
The fifth argument is a string containing the names of all depressed buttons
separated by a vertical bar.  



<a name="qtlualistener.sigMouseRelease"></a>
#### [QtLuaListener signal] sigMouseRelease(int,int,QByteArray,QByteArray,QByteArray) ####

Signal `sigMouseRelease` is emitted whenever the underlying widget receives a
[QMouseEvent](http://doc.trolltech.com/4.4/qmouseevent.html)
of type `QEvent::MouseButtonRelease` because a mouse button was released.
The first two arguments are the 
pixel coordinates of the mouse pointer when the button was released
The third argument is a string containing the 
[button name](http://doc.trolltech.com/4.4/qt.html#MouseButton-enum).
The fourth argument is a string containing the 
[keyboard modifier names](http://doc.trolltech.com/4.4/qt.html#KeyboardModifier-enum)
separated by a vertical bar.  
The fifth argument is a string containing the names of all depressed buttons
separated by a vertical bar.  

<a name="qtlualistener.sigMouseDoubleClick"></a>
#### [QtLuaListener signal] sigMouseDoubleClick(int,int,QByteArray,QByteArray,QByteArray) ####

Signal `sigMouseRelease` is emitted whenever the underlying widget receives a
[QMouseEvent](http://doc.trolltech.com/4.4/qmouseevent.html)
of type `QEvent::MouseButtonDblClick` because a mouse button was double-clicked.
The first two arguments are the 
pixel coordinates of the mouse pointer when the button was clicked
The third argument is a string containing the 
[button name](http://doc.trolltech.com/4.4/qt.html#MouseButton-enum).
The fourth argument is a string containing the 
[keyboard modifier names](http://doc.trolltech.com/4.4/qt.html#KeyboardModifier-enum)
separated by a vertical bar.  
The fifth argument is a string containing the names of all depressed buttons
separated by a vertical bar.  

<a name="qtlualistener.sigMouseMove"></a>
#### [QtLuaListener signal] sigMouseMove(int,int,QByteArray,QByteArray) ####

Signal `sigMouseRelease` is emitted whenever the underlying widget receives a
[QMouseEvent](http://doc.trolltech.com/4.4/qmouseevent.html)
of type `QEvent::MouseMove` because the mouse was moved.
Such events occur only when a mouse button is pressed down, 
unless the widget property `mouseTracking` has been set to `true`.
The first two arguments are the 
pixel coordinates of the mouse pointer when the button was released
The third argument is a string containing the 
[keyboard modifier names](http://doc.trolltech.com/4.4/qt.html#KeyboardModifier-enum)
separated by a vertical bar.  
The fourth argument is a string containing the names of all depressed buttons
separated by a vertical bar.  



<a name="qtlualistener.sigEnter"></a>
#### [QtLuaListener signal] sigEnter(bool) ####

Signal `sigEnter` is emitted whenever the underlying widget receives an
event of type 
[QEvent::Enter](http://doc.trolltech.com/4.4/qevent.html)
or 
[QEvent::Leave](http://doc.trolltech.com/4.4/qevent.html).
The boolean argument indicates whether the mouse pointer has just
entered or left the widget area.

<a name="qtlualistener.sigFocus"></a>
#### [QtLuaListener signal] sigFocus(bool) ####

Signal `sigEnter` is emitted whenever the underlying widget receives 
a [QFocusEvent](http://doc.trolltech.com/4.4/qfocusevent.html).
The boolean argument indicates whether the widget has just gained
or just lost the keyboard focus.

<a name="qtlualistener.sigShow"></a>
#### [QtLuaListener signal] sigShow(bool) ####

Signal `sigEnter` is emitted whenever the underlying widget receives 
a [QShowEvent](http://doc.trolltech.com/4.4/qshowevent.html) or a
a [QHideEvent](http://doc.trolltech.com/4.4/qhideevent.html).
The boolean argument indicates whether the widget has just been
shown or just been hidden.


<a name="qtlualistener.sigPaint"></a>
#### [QtLuaListener signal] sigPaint() ####

Signal `sigEnter` is emitted whenever the underlying widget receives 
a [QPaintEvent](http://doc.trolltech.com/4.4/qpaintevent.html).

<a name="qtluapainter"></a>
### qt.QtLuaPainter ###

Painting in Qt is usually achieved using class
[QPainter](http://doc.trolltech.com/4.4/qpainter.html).
Since this class is neither a subclass of
[QObject](http://doc.trolltech.com/4.4/qobject.html)
nor a value class suitable for storing into a Qt variant,
the QtLua class `QtLuaPainter` defines a Qt object that
exposes the painting capabilities of Qt in a more flexible way.

Instances of class `QtLuaPainter` can target:

  * Any image stored in memory represented as a [qt.QImage](qtgui.md#qimage) or a [qt.QPixmap](qtgui.md#qpixmap).
  * Any widget represented as a [qt.QWidget](qtgui.md#qwidget).
  * Any `QPaintDevice` encapsulated in a Qt object class such as class [qt.QtLuaPrinter](#qtluaprinter).

Class `QtLuaPainter` provides an automatic buffering 
capability when it targets a widget. Drawing functions 
paint onto an offline image. The class logic ensures
that the widget is automatically refreshed or updated
when appropriate.

Despite these differences, the Qt documentation for the 
[Qt paint system](http://doc.trolltech.com/4.4/paintsystem.html)
contains lots of useful information. In particular, the documentation for 
class [QPainter](http://doc.trolltech.com/4.4/qpainter.html)
accurately describes how the painter settings affects drawing operations.


<a name="qtluapainter"></a>
#### qt.QtLuaPainter(...) ####

Function `qt.QtLuaPainter` constructs a new `QtLuaPainter` instance.

<a name="qtluapainter"></a>
#### qt.QtLuaPainter(qimage) ####

Constructs a painter instance that targets an offscreen image.
The image is initialized with a copy of the 
[qt.QImage](qtgui.md#qimage) 
passed as argument. Painting operations do not modify the image 
passed as argument. Instead a copy of the current image can be 
accessed using expression [painter:image()](#paintergrab).

<a name="qtluapainter"></a>
#### qt.QtLuaPainter(filename, [format]) ####

Constructs a painter instance that targets an offscreen image
initialized by reading the image file `filename`.  
The file format is determined by the optional string 
`format` or by the file name extension.
Use expression [painter.image()](#paintergrab) to 
obtain a copy of the offscreen image.

<a name="qtluapainter"></a>
#### qt.QtLuaPainter(w,h,[monoflag]) ####

Constructs a painter instance that targets an offscreen image
of width `w` and height `h`. The image is bitonal when 
the optional boolean flag `monoflag` is `true`. Otherwise
the image is a 32 bits RGBA image.
Use expression [painter.image()](#paintergrab) to 
obtain a copy of the offscreen image.

<a name="qtluapainter"></a>
#### qt.QtLuaPainter(qpixmap) ####

Constructs a painter instance that targets a 
device-dependent pixmap in memory.
The pixmap is initialized with a copy of 
the [qt.QPixmap](qtgui.md#qpixmap) passed as argument.
Use expression [painter:pixmap()](#painterpixmap).
to obtain a copy of the target pixmap.
Since Qt only supports painting a device-dependent `QPixmap` from 
the main thread, one must use [qt.pcall](qt.md#qt.qcall)
to ensure that painting operations are performed from the main thread.
Otherwise Qt prints a lot of warnings and behaves erratically.

<a name="qtluapainter"></a>
#### qt.QtLuaPainter(qwidget,[buffered]) ####

Constructs a painter instance that targets the 
specified [qt.QWidget](qtgui.md#qwidget).
The resulting painter is a child of `qwidget`.
The optional boolean argument `buffered` indicates
whether drawing should be performed in a offscreen buffer
or directly on the widget surface.  The default is to
create a buffered painter.

A buffered painter always draws onto an offscreen image
and ensures that the widget surface is automatically refreshed or 
updated when needed.  Since the painting functions target
a [qt.QImage](qtgui.md#qimage), 
they can be called from any thread at any time.  
This is the recommended mode of operation.

An unbuffered painter directly draws onto the widget surface. 
Unfortunately Qt4 only supports painting a widget from the paint event handler
[QObject::paintEvent](http://doc.trolltech.com/4.4/qwidget.html#paintEvent). 
While this is happening in the main thread, 
the Lua interpreter might be unavailable for painting because
the Lua thread is busy running another program.
Unbuffered widget painters are therefore difficult to use for painting;
they are mostly useful for grabbing the on-screen representation 
of a widget using function [painter.image()](#paintergrab).

<a name="qtluapainter"></a>
#### qt.QtLuaPainter(object) ####

Constructs a painter instance that target the output
device represented by the instance `object` of a suitable Qt object class.
The class must implement an invokable method `device()` that returns
a pointer of type =QPaintDevice*=.  
The class can also define an invokable method `printer()` 
that returns a pointer of type `QPrinter*= and a signal =closing(QObject*)`
that indicates that the object is being destroyed. 
Class [qt.QtLuaPrinter](#qtluaprinter) does all this.


<a name="qtluapainter.properties"></a>
#### QtLuaPainter Properties ####

<a name="qtluapainterangleunit"></a>
##### painter.angleUnit #####
<a name="qtluapainter.angleUnit"></a>

This property contains a string defining how arguments 
representing angles are interpreted in painter functions
such as [painter:rotate(angle)](#painterrotate).
The acceptable values are the strings `"Degrees"` and `"Radians"`.
The default unit is the degree.


<a name="qtluapainterbackground"></a>
##### painter.background #####
<a name="qtluapainter.background"></a>

This property contains the [qt.QBrush](qtgui.md#qbrush)
used to draw the spaces in stippled lines, the text background, 
and the zero color of bitonal images.
The default background brush is an empty brush
meaning that these pixels are not painted at all.

<a name="qtluapainterbrush"></a>
##### painter.brush #####
<a name="qtluapainter.painter"></a>

Property `painter.brush` contains a Qt variant of class
[qt.QBrush](qtgui.md#qbrush) representing the painter settings
that determine how function [painter:fill](#painterfill)
fills shapes and how function [painter:show](#painterfill) 
draws text.

<a name="qtluapainterclippath"></a>
##### painter.clippath #####
<a name="qtluapainter.clippath"></a>

Property `painter.clippath` contient a Qt variant of class
[qt.QPainterPath](qtgui.md#qpainterpath) 
representing the boundary
of the current clipping region. Drawing operations
only modify pixels located within the clip region.
An empty path means that no clipping is performed.

<a name="qtluapaintercompositionmode"></a>
##### painter.compositionMode #####
<a name="qtluapainter.compositionMode"></a>

The 
[composition mode](http://doc.trolltech.com/4.4/qpainter.html#CompositionMode-enum)
defines how new drawings are merged with previous drawings in the image.
Composition modes are representing as a string containing the
name of the composition mode without the prefix `QPainter::`.
The default composition mode is `"SourceOver"`.

Not all devices support complex alpha-blending composition modes.
In particular printers often support only the default composition mode.
When a composition mode is not supported, the Qt library prints a warning.


<a name="qtluapainterdepth"></a>
##### painter.depth #####
<a name="qtluapainter.depth"></a>

Expression `painter.depth` returns the color depth
of the target surface for drawings.
A depth of `1` indicates a bitonal surface.  
A depth of `24` or `32` indicates a true color surface.

<a name="qtluapainterfont"></a>
##### painter.font #####
<a name="qtluapainter.font"></a>

Property `painter.font` contient a Qt variant of class
[qt.QFont](qtgui.md#qfont) representing the font settings
used for drawing text.

<a name="qtluapainterheight"></a>
##### painter.height #####
<a name="qtluapainter.height"></a>

Expression `painter.height` returns the height of 
the drawing surface expressed in pixels.
The returned value
is not affected by the current transformation matrix. 
It corresponds to the default coordinate system
set by [painter:initmatrix](#painterinitmatrix).

<a name="qtluapaintermatrix"></a>
##### painter.matrix #####
<a name="qtluapainter.matrix"></a>

Property `painter.font` contient a Qt variant of class
[qt.QTransform](qtgui.md#qtransform) representing
how coordinates passed to the path construction functions
are transformed into device depending coordinates.

<a name="qtluapainterpath"></a>
##### painter.path #####
<a name="qtluapainter.path"></a>

Property `painter.path` contient a Qt variant of class
[qt.QPainterPath](qtgui.md#qpainterpath) 
representing the current path. 
A path is a mathematical boundary delimiting regions in the plane.
The current path is used implicitely by functions
[painter:fill](#painterfill) 
and [painter:stroke](#painterstroke).
The current path is modified by a rich collection
of path defining functions.

<a name="qtluapainterpen"></a>
##### painter.pen #####
<a name="qtluapainter.pen"></a>

Property `painter.pen` contains a Qt variant of class
[qt.QPen](qtgui.md#qpen) representing the painter settings
that determine how function [painter:stroke](#painterfill)
draws shapes.

<a name="qtluapainterpoint"></a>
##### painter.point #####
<a name="qtluapainter.point"></a>

Property `painter.point` contient a Qt variant of class
[qt.QPointF](qtcore.md#qpoint) representing the
coordinates of the current point.  These coordinates
are used and updated implicitely by the majority
of the path construction functions.


<a name="qtluapainterrenderhints"></a>
##### painter.renderHints #####
<a name="qtluapainter.renderHints"></a>

[Rendering hints](http://doc.trolltech.com/4.4/qpainter.html#RenderHint-enum)
are flags controlling the quality of the drawing operations.
They are represented by a string containing the concatenation of
the names of the active rendering flags (without the prefix `QPainter::`)
separated with a vertical bar "`|`" symbolizing a boolean `or` operator.


<a name="qtluapainterstylesheet"></a>
##### painter.styleSheet #####
<a name="qtluapainter.styleSheet"></a>

This property contains a string containing a CSS style sheet
that is used when drawing rich text with 
function [show](#paintershow).


<a name="qtluapainterwidth"></a>
##### painter.width #####
<a name="qtluapainter.width"></a>

Expression `painter.width` returns the width of 
the drawing surface expressed in pixels.
The returned value
is not affected by the current transformation matrix. 
It corresponds to the default coordinate system
set by [painter:initmatrix](#painterinitmatrix).


<a name="qtluapainterfunctions"></a>
#### QtLuaPainter Functions ####

Class `QtLuaPainter` provides a broad array of 
painting functions that closely resemble
the well-known PostScript operators.
Additional functions provide capabilities
that are unique to the Qt platform.


<a name="qtluapainter.arc"></a>
##### painter:arc(x,y,r,angle1,angle2) #####

Expression `painter:arc(x,y,r,angle1,angle2)`
appends an arc of a circle to the current path.
The arc is centered at coordinates `(x,y)` 
with radius `r` and extends from angle `angle1` 
to angle `angle2` in the trigonometric direction.

If there is a current point, a line segment joins 
the current point to the first endpoint of the arc.
The second endpoint becomes the new current point.

Angles can be expressed in degrees or radians
according to the [current angle unit](#qtluapainterangleunit).
The default angle unit is the degree.


See also: PostScript operator `arc`.

<a name="qtluapainter.arcn"></a>
##### painter:arcn(x,y,r,angle1,angle2) #####

Expression `painter:arcn(x,y,r,angle1,angle2)`
appends an arc of a circle to the current path.
The arc is centered at coordinates `(x,y)` 
with radius `r` and extends from angle `angle1` 
to angle `angle2` in the inverse trigonometric direction.

If there is a current point, a line segment joins 
the current point to the first endpoint of the arc.
The second endpoint becomes the new current point.

Angles can be expressed in degrees or radians
according to the [current angle unit](#qtluapainterangleunit).
The default angle unit is the degree.

See also: PostScript operator `arcn`. 

<a name="qtluapainter.arcto"></a>
##### painter:arcto(x1,y1,x2,y2,r) #####

Expression `painter:arcto(x1,y1,x2,y2,r)`
appends an arc of a circle to the current path
defined by the radius `r` and two tangent lines 
extending from the current point `(x0,y0)` to `(x1,y1)` 
and from `(x1,y1)` to `(x2,y2)`. 

When the current point is set, a line segment joins 
the current point to the first endpoint of the arc. 
The second endpoint becomes the new current point.

See also: PostScript operators `arct` and `arcto`.


<a name="qtluapainter.charpath"></a>
##### painter:charpath(string) #####

Expression `painter:charpath(string)` 
computes the path for the glyph outlines that would 
result if string `string` was displayed 
using [painter:show(string)](#paintershow).
This path is appended to the current path
and is therefore suitable for functions 
[painter:stroke](#painterstroke)
or [painter:fill](#painterfill).

After calling this function, the current point is left unset.

See also: PostScript operators `charpath`.

<a name="painterclip"></a>
##### painter:clip(optnewpath) #####
<a name="qtluapainter.clip"></a>

Function `painter:clip` intersects the 
[current clip region](#qtluapainterclippath)
with the region described by the current path,
that is the region that would be painted by
[qtpainter.fill](#painterfill).
This intersection becomes the new clip region.

The optional boolean `optnewpath` specifies
whether this function resets the current path 
using [painter:newpath()](#painternewpath).
The default is to leave the current path unchanged.
The interior of the current path is determined using the 
[winding rule](http://doc.trolltech.com/4.4/qpainterpath.html#setFillRule).
See function [painter:eoclip](#paintereoclip) for an alternative.

This function cannot enlarge the clipping path.
The recommended approach is to call 
[painter:gsave()](#paintergsave)
before reducing the clip region and 
[painter:grestore()](#paintergrestore)
to restore the initial clip region.

See also: PostScript operator `clip`.


<a name="painterclose"></a>
##### painter:close() #####
<a name="qtluapainter.close"></a>

Expression `painter:close()` detaches 
the `QtLuaPainter` object from the underlying widget.
After doing this, you cannot draw anything.
Painters operating on a widget or a printer should
be closed before the underlying widget
or printer is destroyed.


<a name="qtluapainter.closepath"></a>
##### painter:closepath() #####

Expression `painter:closepath()` 
closes the current subpath by appending a 
straight line segment connecting the
current point to the subpath to its starting point.
This function does nothing if the current subpath
is already closed.

Using function `painter:closepath` is better than specifying
the line segment using `painter:lineto` because it will
ensure that the line segments are joined using the 
current pen `capStyle` and `joinStyle` attributes.

After calling this function, 
the current point is left unset.

See also: PostScript operator `closepath`.

<a name="qtluapainter.concat"></a>
##### painter:concat(qtransform) #####

Expression `painter:concat(qtransform)` 
replaces the [current transformation matrix](#qtluapaintermatrix)
by the product of the current matrix
by the `QTransform` object `qtransform`.

It is much easier to use functions
[painter:translate](#paintertranslate), 
[painter:scale](#painterscale), or 
[painter:rotate](#painterrotate).

See also: PostScript operator `concat`.

<a name="qtluapainter.currentangleunit"></a>
##### painter:currentangleunit() #####

Expression `painter:currentangleunit()` returns the 
[current angle unit](#qtluapainterangleunit) 
for angles in functions such as [painter:rotate](#painterrotate).
Possible values are strings `"Degrees"` and `"Radians"`. 
The default angle unit are degrees.


<a name="qtluapainter.currentbackground"></a>
##### painter:currentbackground() #####

Expression `painter:currentbackground()`
returns a [qt.QBrush](qtgui.md#qbrush) 
representing the [current background brush](#qtluapainterbackground)
used for displaying the backgrounds when painting
dashed line, text, or bitonal images.
The default is an empty brush.


<a name="qtluapainter.currentbrush"></a>
##### painter:currentbrush() #####

Expression `painter:currentbrush()`
returns a [qt.QBrush](qtgui.md#qbrush) 
representing the [current brush](#qtluapainterbrush)
used for filling path with [painter:fill()](#painterfill).
The default is an empty brush.


<a name="qtluapainter.currentclip"></a>
##### painter:currentclip() #####

Expression `painter:currentclip()`
returns a [QPainterPath](qtgui.md#qpainterpath)
representing the [current clip region](#qtluapainterclippath).

<a name="qtluapainter.currentcolor"></a>
##### painter:currentcolor() #####

Expression `painter:currentcolor()` 
returns four numbers representing the 
red, green, blue, and alpha components 
of the color of the [current brush](qtgui.md#qbrush).
This numbers range from zero to one.


<a name="qtluapainter.currentdash"></a>
##### painter:currentdash() #####

Expression `painter:currentdash()`
returns the dash pattern and the dash offset
of the [current pen](#qtluapainterpen).


<a name="qtluapainter.currentfont"></a>
##### painter:currentfont() #####

Expression `painter:currentfont()`
returns a [QFont](qtgui.md#qfont)
describing the [current font](#qtluapainterfont)
for drawing text.

<a name="qtluapainter.currentfontsize"></a>
##### painter:currentfontsize() #####

Expression `painter:currentfontsize()`
returns the size in points of the 
[current font](#qtluapainterfont).


<a name="qtluapainter.currenthints"></a>
##### painter:currenthints() #####

Expression `painter:currenthints()` returns the 
[current rendering hints](#qtluapainterrenderhints)
controlling the quality of the drawings.


<a name="qtluapainter.currentlinewidth"></a>
##### painter:currentlinewidth() #####

Expression `painter:currentlinewidth()` returns
the line width associated with the 
[current pen](#qtluapainterpen).

<a name="qtluapainter.currentmatrix"></a>
##### painter:currentmatrix() #####

Expression `painter:currentmatrix()` returns a Qt variant of class
[qt.QTransform](qtgui.md#qtransform) representing the
[current transformation matrix](#qtluapaintermatrix).

<a name="qtluapainter.currentmode"></a>
##### painter:currentmode() #####

Expression `painter:currentmode()` returns a string representing the 
[current composition mode](#qtluapaintercompositionmode).


<a name="qtluapainter.currentpath"></a>
##### painter:currentpath() #####

Expression `painter:currentpath()` returns a Qt variant of class
[qt.QPainterPath](qtgui.md#qpainterpath) representing the
[current path](#qtluapainterpath).


<a name="qtluapainter.currentpen"></a>
##### painter:currentpen() #####

Expression `painter:currentpath()` returns a Qt variant of class
[qt.QPen](qtgui.md#qpen) representing the
[current pen](#qtluapainterpen).


<a name="qtluapainter.currentpoint"></a>
##### painter:currentpoint() #####

Expression `painter:currentpoint()` returns two numbers
representing the coordinates of the
[current point](#qtluapainterpoint).


<a name="paintercurrentsize"></a>
##### painter:currentsize() #####
<a name="qtluapainter.currentsize"></a>

Expression `painter:currentsize()` returns two numbers
representing the width and height of the drawing are
expressed in pixels. The returned values 
are not affected by the current transformation matrix. 
They correspond to the default coordinate system
sets by [painter:initmatrix](#painterinitmatrix).


<a name="paintercurrentstylesheet"></a>
##### painter:currentstylesheet() #####
<a name="qtluapainter.currentstylesheet"></a>

Expression `painter:currentstylesheet()` returns the 
the [current style sheet](#qtluapainterstylesheet)
used by function [show](#paintershow) for
displaying rich text.


<a name="paintercurveto"></a>
##### painter:curveto(x1,y1,x2,y2,x3,y3) #####
<a name="qtluapainter.curveto"></a>

Expression `painter:curveto(x1,y1,x2,y2,x3,y3)`
appends a section of a cubic Bezier curve to the current path.
The curve starts on the current point and ends in point `(x3,y3)`
using `(x1,y1)` and `(x2,y2)` as the Bezier control points. 
The endpoint `(x3,y3)` then becomes the new current point.

The behavior of this function is undefined 
when the current point is not set

See also: PostScript operator `curveto`.


<a name="painterdevice"></a>
##### painter:device() #####
<a name="qtluapainter.device"></a>

Expression `painter:device()` returns a pointer to the Qt 
paint device underlying the painter.
Since the Qt class
[QPaintDevice](http://doc.trolltech.com/4.4/qpaintdevice.html)
is neither a Qt variant not a Qt object, this pointer
is represented by a Qt variant of type =QPaintDevice*=.
This is not very useful in Lua.


<a name="paintereoclip"></a>
##### painter:eoclip(optnewpath) #####
<a name="qtluapainter.eoclip"></a>

Function `painter:eoclip` is similar to function 
[painter:clip](#painterclip). However the interior of the
current path is interpreted using the 
[odd-even rule](http://doc.trolltech.com/4.4/qpainterpath.html#setFillRule)
instead of the winding rule.



<a name="paintereofill"></a>
##### painter:eofill(optnewpath) #####
<a name="qtluapainter.eofill"></a>

Function `painter:eofill` is similar to function 
[painter:fill](#painterfill). However the interior of the
current path is determined using the 
[odd-even rule](http://doc.trolltech.com/4.4/qpainterpath.html#setFillRule)
instead of the winding rule.

See also: PostScript operator `eofill`.

<a name="painterfill"></a>
##### painter:fill(optnewpath) #####
<a name="qtluapainter.fill"></a>

Function `painter:fill` fills the interior of the 
[current path](#qtluapainterpath) using
the [current brush](#qtluapainterbrush).

The optional boolean `optnewpath` specifies
whether this function resets the current path
using [painter:newpath()](#painternewpath).
The default is to reset the current path.
The interior of the current path is determined using the 
[winding rule](http://doc.trolltech.com/4.4/qpainterpath.html#setFillRule).
See function [painter:eofill](#paintereofill) for an alternative.

See also: PostScript operator `fill`.


<a name="paintergbegin"></a>
##### painter:gbegin() #####
<a name="qtluapainter.gbegin"></a>

Functions [painter:gbegin](#paintergbegin) and 
[painter:gend](#paintergend) can be used
to bracket code segments that perform drawings that
are meaningful as a whole.  The actual display is
usually postponed until the last call to `painter:gend`.
This is useful for implementing smooth transitions
between successive drawings.

<a name="paintergend"></a>
##### painter:gend([invalidate]) #####
<a name="qtluapainter.gend"></a>

Functions [painter:gbegin](#paintergbegin) and 
[painter:gend](#paintergend) can be used
to bracket code segments that perform drawings that
are meaningful as a whole.  The actual display is
usually postponed until the last call to `painter:gend`.
This is useful for implementing smooth transitions
between successive drawings.

When the target device is a buffered widget,
setting flag `invalidate` to true
ensures that the whole widget will be refreshed.
This is useful after drawing directly into
the underlying `QPainter` object without
using the `QtLuaPainter` functions.


<a name="paintergrestore"></a>
##### painter:grestore() #####
<a name="qtluapainter.grestore"></a>

Expression `painter:grestore()` restores the painter settings
previously saved by a matching expression [painter:gsave()](#paintergsave).

Functions [painter:gsave](#paintergsave) and 
[painter:restore](#paintergrestore) should be used
to bracket code segments that perform some rendering
in order to ensure that the painter settings 
remain unchanged.



<a name="paintergsave"></a>
##### painter:gsave() #####
<a name="qtluapainter.gsave"></a>

Expression `painter:gsave()` records the painter settings
and pushes this information on top of a stack of painter settings.
Subsequent calls to [painter:grestore()](#paintergrestore)
can be used to restore the saved settings.

Functions [painter:gsave](#paintergsave) and 
[painter:restore](#paintergrestore) should be used
to bracket code segments that perform some rendering
in order to ensure that the painter settings 
remain unchanged.

<a name="paintergrab"></a>
##### painter:image() #####
<a name="qtluapainter.image"></a>

Expression `painter:image()` returns a Qt variant of class
[qt.QImage](qtgui.md#qimage) 
representing the drawing surface.

When the underlying surface is a widget without backing store,
this function grabs the widget image from the display.
When the painter operates on a device that cannot be represented
as an image, for instance a printer, 
this function returns an empty image for which method
[tobool](qt.md#qt.tobool) returns `false`.

Note that this function must be invoked without arguments.
Otherwise see the documentation for [painter:image(...)](#painterblit).


<a name="painterblit"></a>
##### painter:image(x,y,[w,h],image,[sx,sy,[sw,sh]]) #####
<a name="qtluapainter.image"></a>

Function `painter:image` paints a segment of image `image`
at position `(x,y)` in the current coordinate systems
with with `w` and height `h`.  The source segment
is defined by the rectangle of size `(sw,sh)`
starting on point `(sx,sy)`.

The default source width `sw` and height `sh` are the width and height of the
source image. The default source origin `(sx,sy)` is the origin `(0,0)`.
The default target width `w` and height `h` are 
the source width `sw` and height `sh`.

Argument `image` can be a Qt variant of 
class [qt.QImage](qtgui.md#qimage)
or [qt.QPixmap](qtgui.md#qpixmap) 
or a Qt object of class [qt.QtLuaPainter](#qtluapainter).
In the latter case, the function 
[painter:image()](#paintergrab) without arguments
is used to obtain the source surface.

  * To blit an image `img` constructed with [qtwidget.newimage](#qtwidgetnewimage), you must specify the associated painter [img.port](#descport).
  * To blit a [torch.Tensor](..:torch:index#Tensor), first create a [qt.QImage](qtgui.md#qimage) using the function [qt.QImage.fromTensor](qt.md#qimagefromtensor) from by package [qttorch](qt.md).

Blit is of course affected by 
the [current composition mode](#qtluapaintercompositionmode).

Note that this function must be invoked with arguments.
Otherwise see the documentation for [painter:image()](#paintergrab).

See also: PostScript operator `image`.


<a name="painterinitclip"></a>
##### painter:initclip() #####
<a name="qtluapainter.initclip"></a>

Expression `painter:initclip()` resets the
[current clip region](#qtluapainterclippath)
to the empty path. This effectively means
that clipping is disabled and therefore
that all surface pixels can be affected
by a subsequent drawing operation.


See also: PostScript operator `initclip`.


<a name="painterinitgraphics"></a>
##### painter:initgraphics() #####
<a name="qtluapainter.initgraphics"></a>

Expression `painter:initgraphics()` resets
all painter settings to their default values.
After calling this function:

  * The [current clip region](#qtluapainterclippath) is set as with [painter:initclip()](#painterinitclip).
  * The [current transformation matrix](#qtluapaintermatrix) is set as with [painter:initmatrix()](#painterinitmatrix).
  * The [current brush](#qtluapainterbrush) is a solid black brush with brush origin (0,0).
  * The [current pen](#qtluapainterpen) is a solid black pen with line width `1`, flat caps, and miter joins.
  * The [current background](#qtluapainterbackground) is an empty brush meaning that background pixels are not painted at all.
  * The [current font](#qtluapainterfont) is a 10 points sans serif font.
  * The [current path](#qtluapainterpath) is empty and the [current point](#qtluapainterpoint) is unset.
  * The [current rendering hints](#qtluapainterrenderhints) are `"Antialiasing|TextAntialiasing"`.
  * The [current composition mode](#qtluapaintercompositionmode) is `"SourceOver"`.
  * The [current angle unit](#qtluapainterangleunit) is `"Degrees"`.

See also: PostScript operator `initgraphics`.


<a name="painterinitmatrix"></a>
##### painter:initmatrix() #####
<a name="qtluapainter.initmatrix"></a>

Expression `painter:initmatrix()` resets the
[current transformation matrix](#qtluapaintermatrix)
to its default value.
The coordinate system has then its origin
in the upper left corner of the surface
with X coordinates ordered from left to right
and Y coordinates ordered from top to bottom.
Coordinates are expressed in device pixels
on most devices.

See also: PostScript operator `initmatrix`.

<a name="qtluapainter.lineto"></a>
##### painter:lineto(x,y) #####

Expression `painter:lineto(x,y)` appends 
a line segment to the current path,
starting from the [current point](#qtluapainterpoint) 
and ending at coordinates `(x,y)`.
The segment end point then becomes 
the new current point.

The behavior of this function is undefined 
when the current point is not set

See also: PostScript operator `lineto`.


<a name="qtluapainter.moveto"></a>
##### painter:moveto(x,y) #####

Expression `painter:moveto(x,y)` terminates the 
last subpath of the current path and moves
the current point to coordinates `(x,y)`.

See also: PostScript operator `moveto`.


##### painter:newpath() #####
![](anchor:painternewpath)
<a name="qtluapainter.newpath"></a>

Expression `painter:newpath()` terminates the last subpath.
After calling this function, the current point is left unset.

See also: PostScript operator `newpath`.

<a name="painterobject"></a>
##### painter:object() #####
<a name="qtluapainter.object"></a>

Expression `painter:object()` returns the Qt object
that represents the paint device if such an object exists.
Typical return values are instance of class 
[qt.QWidget](qtgui.md#qwidget) or class 
[qt.QtLuaPrinter](#qtluaprinter).


<a name="painterpainter"></a>
##### painter:painter() #####
<a name="qtluapainter.painter"></a>

Expression `painter:painter()` returns a pointer 
to the underlying Qt painter.
Since the Qt class
[QPainter](http://doc.trolltech.com/4.4/qpainter.html)
is neither a Qt variant not a Qt object, this pointer
is represented by a Qt variant of type =QPainter*=.


<a name="painterpixmap"></a>
##### painter:pixmap() #####
<a name="qtluapainter.pixmap"></a>

Expression `painter:pixmap()` returns a Qt variant of class
[qt.QPixmap](qtgui.md#qpixmap) representing the drawing surface.

When the underlying surface is a widget without backing store,
this function grabs the widget representation from the display.
When the painter operates on a device that cannot be represented
as a pixmap, for instance a printer, 
this function returns an empty pixmap for which method 
[tobool](qt.md#qt.tobool) returns `false`.

<a name="qtluapainter.printer"></a>
##### painter:printer() #####

Expression `painter:printer()` returns a pointer
to the underlying Qt printer.
Since the Qt class
[QPrinter](http://doc.trolltech.com/4.4/qpainter.html)
is neither a Qt variant not a Qt object, this pointer
is represented by a Qt variant of type =QPrinter*=.



<a name="qtluapainter.rcurveto"></a>
##### painter:rcurveto(x1,y1,x2,y2,x3,y3) #####

This is similar to calling function 
[painter:curveto](#paintercurveto)
with the following arguments

```lua
painter:curveto(x0+x1,y0+y1,x0+x2,y0+y2,x0+x3,y0+y3)
```

where `(x0,y0)` are the coordinates of the previous
current point.

The behavior of this function is undefined 
when the current point is not set.

See also: PostScript operator `rcurveto`.

<a name="qtluapainter.rect"></a>
##### painter:rect() #####

Expression `painter:rect()` returns a Qt variant 
of class [=qt.QRect](qtcore.md#qrect)
representing the pixel coordinates of the drawing surface.
This does not depend on the transformation matrix
but corresponds to the default coordinate system
set by [painter:initmatrix()](#painterinitmatrix).

The same information can be obtained more conveniently
using function [painter:currentsize()](#paintercurrentsize)
or properties [painter.width](#qtluapainterwidth)
and [painter.height](#qtluapainterheight).


<a name="qtluapainter.rectangle"></a>
##### painter:rectangle(x,y,w,h) #####

Expression `painter:rectangle(x,y,w,h)`
appends a rectangle to the current path.
The rectangle starts is defined by its origin `(x,y)`, 
its width `w` and its height `h`.

After calling this function, 
the current point is left unset.



<a name="qtluapainter.refresh"></a>
##### painter:refresh() #####

Expression `painter:refresh()` immediately 
repaints the displayed image, 
regardless of the nesting count of functions
[painter:gbegin()](#paintergbegin) and
[painter:gend()](#paintergend).



<a name="qtluapainter.rlineto"></a>
##### painter:rlineto(rx,ry) #####

Expression `painter:lineto(x,y)` appends a line segment 
to the current path, starting from the current point `(x0,y0)`
and ending at coordinates `(x0+x,y0+y)`.
The segment end point then becomes 
the new current point.

The behavior of this function is undefined 
when the current point is not set

See also: PostScript operator `rlineto`.

<a name="qtluapainter.rmoveto"></a>
##### painter:rmoveto(rx,ry) #####

Expression `painter:moveto(x,y)` terminates the 
last subpath of the current path and moves
the current point to coordinates `(x0+x,y0+y)`
where `(x0,y0)` are the coordinates of the previous
current point.

The behavior of this function is undefined 
when the current point is not set

See also: PostScript operator `rmoveto`.

<a name="painterrotate"></a>
##### painter:rotate(angle) #####
<a name="qtluapainter.rotate"></a>

Expression `painter:rotate(angle)` 
rotates the axes of the coordinate system by `angle` angle units
in the trigonometric direction around the coordinate origin.
The position of the coordinate origin and the size of the coordinate units
are unaffected.

Argument `angle` can be expressed in degrees or radians
according to the [current angle unit](#qtluapainterangleunit).
The default angle unit is the degree.

See also: PostScript operator `rotate`.

<a name="painterscale"></a>
##### painter:scale(sx,sy) #####
<a name="qtluapainter.scale"></a>

Expression `scale(sx,sy)` scales the units of the 
coordinate space by a factor of `sx` horizontally and
`sy` vertically. The position of the coordinate origin and 
the orientation of the axes are unaffected.

See also: PostScript operator `scale`.


<a name="paintersetangleunit"></a>
##### painter:setangleunit(unit) #####
<a name="qtluapainter.setangleunit"></a>

Expression `painter:setangleunit(unit)` sets the 
[angle unit](#qtluapainterangleunit)
for functions such as [painter:rotate](#painterrotate)
that require an angle as argument.

Argument `unit` must be string `"Degrees"` 
for expressing angles in degrees,
or `"Radians"` for expressing angles in radians.
The default angle unit is the degree.


<a name="qtluapainter.setbackground"></a>
##### painter:setbackground(brush) #####

Expression `painter:setbackground(brush)` sets the
[current background brush](#qtluapainterbackground).
Argument `brush` must be a Qt variant of type
[qt.QBrush](qtgui.md#qbrush).

<a name="qtluapainter.setbrush"></a>
##### painter:setbrush(brush) #####

Expression `painter:setbrush(brush)` sets the
[current brush](#qtluapainterbrush).
Argument `brush` must be a Qt variant of type
[qt.QBrush](qtgui.md#qbrush).

<a name="qtluapainter.setclip"></a>
##### painter:setclip(qpainterpath) #####

Expression `painter:setclip(qpainterpath)` sets the
[current clipping region](#qtluapainterclippath)
to be the interior of the specified path.
Argument `brush` must be a Qt variant of type
[qt.QPainterPath](qtgui.md#qpainterpath).


<a name="qtluapainter.setcolor"></a>
##### painter:setcolor(...) #####

Function `painter:setcolor` sets the color of both the 
[current brush](#qtluapainterbrush)
and [current pen](#qtluapainterpen).

There are several ways to specify a color:

__`painter:setcolor(qcolor)`__

Argument `qcolor` is a Qt variant of 
class [qt.QColor](qtgui.md#qcolor).

__`painter:setcolor(string)`__

Argument `string` is a string representing a color name.
All [SVG color names](http://www.w3.org/TR/SVG/types.html#ColorKeywords)
are recognized.Color names can have also the format `"#RGB"`, 
`"#RRGGBB"`, `"#RRRGGGBBB"`, or ="#RRRRGGGGBBBB"
where letters `R`, `G`, or `B` represent hexadecimal 
digits for each of the color component.

__`painter:setcolor(r,g,b,[a])`__

Arguments `r`, `g`, `b`, and `a` are numbers in range `[0,1]`
representing the intensities of the red, green, blue, and alpha channels.
The default value for argument `a` is `1` for a fully opaque color.


<a name="qtluapainter.setdash"></a>
##### painter:setdash([sizes,[offset]]) #####

Function `painter:setdash` changes the 
style of the [current pen](#qtluapainterpen).

When this function is called without argument,
or when argument `sizes` is `nil`,
this function sets the current pen style 
to `"SolidLine"`.

Otherwise argument `sizes` can be a single number or 
a table containing a list of numbers.
The number or the list of numbers represent the length of successive 
[dashes and blanks](http://doc.trolltech.com/4.4/qpen.html#setDashPattern) 
along the drawn curve, expressed in units of the line width.  
When the size of the sequence is odd, the last blank
is assumed to have the same size as the last dash.
The optional argument `offset` is a length 
representing the starting position of the dash sequence.


<a name="qtluapainter.setfont"></a>
##### painter:setfont(qfont) #####

Expression `painter:setfont(qfont)` sets the
[current font](#qtluapainterfont).
Argument `font` must be a Qt variant of type
[qt.QFont](qtgui.md#qfont).

<a name="qtluapainter.setfontsize"></a>
##### painter:setfontsize(size) #####

Expression `painter:setfontsize(size)` changes the size
of the [current font](#qtluapainterfont).
Argument `size` must be a positive number.


<a name="qtluapainter.sethints"></a>
##### painter:sethints(hints) #####

Expression `painter:sethints(hints)` sets the
[current rendering hints](#qtluapainterrenderhints).
Argument `hints` must be a string containing 
a concatenation of the names of the active 
[rendering flags](http://doc.trolltech.com/4.4/qpainter.html#RenderHint-enum) 
separated with a vertical bar "`|`".


<a name="qtluapainter.setlinewidth"></a>
##### painter:setlinewidth(lw) #####

Expression `painter:setlinewidth(lw)` changes the line width
of the [current pen](#qtluapainterpen).
Argument `lw` must be a positive number.

<a name="qtluapainter.setmatrix"></a>
##### painter:setmatrix(qtransform) #####

Expression `painter:setmatrix(qtransform)` sets the
[current transformation matrix](#qtluapaintermatrix).
Argument `qtransform` must be a Qt variant of type
[qt.QTransform](qtgui.md#qtransform).


<a name="qtluapainter.setmode"></a>
##### painter:setmode(compositionmode) #####

Expression `painter:setmode(compositionmode)` sets the 
[current composition mode](#qtluapaintercompositionmode) 
for subsequent drawing operations.
Argument `compositionmode` must be a string containing the name of a 
[composition mode](http://doc.trolltech.com/4.4/qpainter.html#CompositionMode-enum).


<a name="qtluapainter.setpath"></a>
##### painter:setpath(qpainterpath) #####

Expression `painter:setpath(qpainterpath)` sets the
[current path](#qtluapainterpath).
Argument `qpainterpath` must be a Qt variant of type
[qt.QPainterPath](qtgui.md#qpainterpath).


<a name="qtluapainter.setpattern"></a>
##### painter:setpattern(pattern,[x,y]) #####

Expression `painter:setpattern(pattern,[x,y])` 
creates a textured pattern brush.
This brush is used to set both the [current brush](#qtluapainterbrush) 
and the brush of the [current pen](#qtluapainterpen).

Argument `p` can be either a Qt variant 
of type [qt.QImage](qtgui.md#qimage) or an object
equipped with a method `image` returning a suitable image.
Such objects include instances of [qt.QtLuaPainter](#qtluapainter)
as well as the return values of functions 
[qtwidget.newwindow](#qtwidgetnewwindow)
or [qtwidget.newimage](#qtwidgetnewimage)

The optional arguments `x` and `y` specify 
the origin of the pattern in the source image.


<a name="qtluapainter.setpen"></a>
##### painter:setpen(qpen) #####

Expression `painter:setpen(qpen)` sets the
[current pen](#qtluapainterpen).
Argument `qpen` must be a Qt variant of type
[qt.QPen](qtgui.md#qpen).


<a name="qtluapainter.setpoint"></a>
##### painter:setpoint(x,y) #####

Expression `painter:setpoint(x,y)` sets the
[current point](#qtluapainterpen) coordinates to `(x,y)`.
Arguments `x` and `y` must be valid numbers.


<a name="qtluapainter.setstylesheet"></a>
##### painter:setstylesheet(s) #####

Expression `painter:setstylesheet(s)` sets the 
the [current style sheet](#qtluapainterstylesheet)
used by function [show](#paintershow) for
displaying rich text.



<a name="paintershow"></a>
##### painter:show(string,[x,y,w,h,textflags]) #####
<a name="qtluapainter.show"></a>

Function `painter:show` draws string `string` using 
the [current font](#qtluapainterfont).

When called with a single string argument `string`,
this function draws the specified text
starting from the [current point](#qtluapainterpoint).
After displaying each glyph, the current point is adjusted
with a displacement computed from the font's glyph-spacing information.
The behavior of this function is undefined 
when the current point is not set.

When called with more arguments, this function draws
the text `string` within the rectangle specified by
the origin `(x,y)`, the width `w`, and the heigth `h`.
Argument `textflags` is then a string composed by concatenating
a subset of the following keywords separated 
by a vertical bar "`|`" symbolizing a `or` operator:
[AlignLeft](http://doc.trolltech.com/4.4/qt.html#AlignmentFlag-enum),
[AlignRight](http://doc.trolltech.com/4.4/qt.html#AlignmentFlag-enum), 
[AlignTop](http://doc.trolltech.com/4.4/qt.html#AlignmentFlag-enum), 
[AlignBottom](http://doc.trolltech.com/4.4/qt.html#AlignmentFlag-enum), 
[AlignHCenter](http://doc.trolltech.com/4.4/qt.html#AlignmentFlag-enum), 
[AlignVCenter](http://doc.trolltech.com/4.4/qt.html#AlignmentFlag-enum), 
[AlignCenter](http://doc.trolltech.com/4.4/qt.html#AlignmentFlag-enum), 
[AlignJustify](http://doc.trolltech.com/4.4/qt.html#AlignmentFlag-enum).
[TextSingleLine](http://doc.trolltech.com/4.4/qt.html#TextFlag-enum), 
[TextExpandTabs](http://doc.trolltech.com/4.4/qt.html#TextFlag-enum), 
[TextShowMnemonic](http://doc.trolltech.com/4.4/qt.html#TextFlag-enum), 
[TextWordWrap](http://doc.trolltech.com/4.4/qt.html#TextFlag-enum),
[RichText](http://doc.trolltech.com/4.4/richtext-html-subset.html).

The flag `RichText` is directly implemented by the `QtLuaPainter` class.
It indicates that the text contains rich text data using the 
[subset of HTML](http://doc.trolltech.com/4.4/richtext-html-subset.html)
supported by Qt and can be used in conjunction with alignment flags only.
Display is affected by 
the [current font](#qtluapainterfont), 
the [current brush color](#qtluapainterbrush), and 
the [current style sheet](#qtluapainterstylesheet).
You can use the css `style` attribute in HTML tags 
to specify more complicated formats.

See also: PostScript operator `show`.


<a name="qtluapainter.showpage"></a>
##### painter:showpage() #####

Expression `painter:showpage()` 
clears the current drawing
and paints the background all white.  

Things are a bit different when the painting device is a printer.
Function `painter:showpage` ensures that the next drawing operation
will first print the current page and initialize a new page.
Successive calls of `painter:showpage()` do not print multiple pages
unless some drawing operation is performed on each page.

See also: PostScript operator `showpage`.


<a name="qtluapainter.size"></a>
##### painter:size() #####

Expression `painter:size()` returns a Qt variant 
of class [qt.QSize](qtcore.md#qsize)
representing the size in pixels of the drawing surface.
This does not depend on the transformation matrix
but corresponds to the default coordinate system
set by [painter:initmatrix()](#painterinitmatrix).

The same information can be obtained more conveniently
using function [painter:currentsize()](#paintercurrentsize)
or properties [painter.width](#qtluapainterwidth)
and [painter.height](#qtluapainterheight).

<a name="qtluapainter.stringrect"></a>
##### painter:stringrect(string,[x,y,w,h,textflags]) #####

Function `painter:stringrect` returns a Qt variant of type
[qt.QRectF](qtcore.md#qrect) representing
the bounding box of the text that would be displayed
by calling function [painter:show](#paintershow)
with the same arguments.


<a name="qtluapainter.stringwidth"></a>
##### painter:stringwidth(string) #####

Fonction `painter:stringwidth` returns 
two numbers representing the total displacement `(dx,dy)` 
that would be applied to the [current point](#qtluapainterpoint)
by expression [show(string)](#paintershow).

See also: PostScript operator `stringwidth`.


<a name="painterstroke"></a>
##### painter:stroke(optnewpath) #####
<a name="qtluapainter.stroke"></a>

Function `painter:stroke` draws the boundary of the 
[current path](#qtluapainterpath) using
the [current pen](#qtluapainterpen).

The optional boolean `optnewpath` specifies
whether this function resets the current path
using [painter:newpath()](#painternewpath).
The default is to reset the current path.

See also: PostScript operator `stroke`.

<a name="paintertranslate"></a>
##### painter:translate(dx,dy) #####
<a name="qtluapainter.translate"></a>

Expression `translate(dx,dy)` translates the coordinate
origin by `dx` units along the X axis and `dy` units
along the Y axis. The  the size of the coordinate units and 
the orientation of the axes are unaffected.

See also: PostScript operator `translate`.

<a name="qtluapainter.widget"></a>
##### painter:widget() #####

Expression `painter:widget()` returns the Qt object of class
[qt.QWidget](qtgui.md#qwidget) underlying the painter.
When the painter is not associated with a widget,
this expression returns `nil`.


<a name="qtluapainter.write"></a>
##### painter:write(f,[format]) #####

Expression `painter:write(f)` saves the image 
associated with the painter into the file named `f`.  
Argument `f` can be a file name or a Lua file descriptor.

The image data is obtained using 
function [painter:image()](#paintergrab).
The image format is determined by the
optional string argument `format` or
deduced from the file name extension.



<a name="qtluaprinter"></a>
### qt.QtLuaPrinter ###

Printing in Qt is usually achieved using class
[QPrinter](http://doc.trolltech.com/4.4/qprinter.html).
Since this class is neither a subclass of
[QObject](http://doc.trolltech.com/4.4/qobject.html)
nor a value class suitable for storing into a Qt variant,
the QtLua class `QtLuaPrinter` defines a Qt object that
acts as a thin wrapper for class `QPrinter`.

Most usual 
[printer settings](http://doc.trolltech.com/4.4/qprinter.html) 
are exposed by class `qt.QtLuaPrinter` as properties. 
Property [printer.paperSize](#printerpapersize) 
can be used to specify the size of the drawing in pixels.
Printers can be selected using [printer.printerName](#printerprintername)
and PostScript and PDF files can be produced with 
properties [printer.outputFileName](#printeroutputfilename)
and [printer.outputFormat](#printeroutputformat).
Alternatively, function `printer:setup()` pops a print dialog
that lets the user adjust these properties interactively.


<a name="qtluaprinternew"></a>
#### qt.QtLuaPrinter([mode]) ####
<a name="qtluaprinter"></a>

Expression `qt.QtLuaPrinter(mode)` returns a 
new instance of class `qt.QtLuaPrinter`.

The optional argument `mode` is a string specifying 
the resolution of the initial coordinate system. 
The default value `ScreenResolution` replicates the screen resolution.
Value `HighResolution` initializes the coordinate 
system with the resolution of the printer.

Most printer properties should be set before
creating the [qt.QtLuaPainter](#qtluapainter)
that will peform the drawings.


<a name="qtluaprinter.abort"></a>
#### printer:abort() ####

Expression `printer:abort()` aborts the current print run. 
Returns `true` if the print run was successfully aborted.
Property [printer.printerState](#printerprinterstate) 
will then be `"Aborted"`.
It is not always possible to abort a print job.

<a name="qtluaprinter.collateCopies"></a>
#### printer.collateCopies ####

Boolean property `printer.collateCopies` specifies 
if collation is turned on when multiple copies is selected. 

<a name="qtluaprinter.colorMode"></a>
#### printer.colorMode ####

Boolean property `printer.colorMode` is `true`
when one prints in color (the default) and `false`
when one prints in gray scale.

<a name="qtluaprinter.creator"></a>
#### printer.creator ####

Property `printer.creator` is a string containing
the name of the application producing the printout.
This information is passed to the print spooling system.

<a name="qtluaprinter.docName"></a>
#### printer.docName ####

Property `printer.creator` is a string containing
the name of the document being printed.
This information is passed to the print spooling system

<a name="qtluaprinter.doubleSidedPrinting"></a>
#### printer.doubleSidedPrinting ####

Boolean property `printer.doubleSidedPrinting` 
indicates whether double sided printing is requested.

<a name="qtluaprinter.fontEmbeddingEnabled"></a>
#### printer.fontEmbeddingEnabled ####

Boolean property `printer.fontEmbeddingEnabled` indicates
whether the output data should embed a font description.
This is `true` by default.


<a name="qtluaprinter.fromPage"></a>
#### printer.fromPage ####

Readonly numerical property `printer.fromPage`
contains the index of the first page to print.
Use function [printer:setFromTo](#printersetfromto) to change it.

<a name="qtluaprinter.fullPage"></a>
#### printer.fullPage ####

Setting boolean property `printer.fullPage` to `true`
enables support for painting over the entire page.
Otherwise painting is restricted to the printable area 
reported by the device.

<a name="qtluaprinter.landscape"></a>
#### printer.landscape ####

Setting boolean property `printer.landscape` to `true`
sets the printout in landscape mode.
Otherwise printing happens in portrait mode.


<a name="qtluaprinter.newPage"></a>
#### printer:newPage() ####

Expression `printer:newPage()`
tells the printer to eject the current page and 
to continue printing on a new page. 
Returns `true` if this was successful.

<a name="qtluaprinter.numCopies"></a>
#### printer.numCopies ####

Property `printer.numCopies` contains the number of copies to be printed. 
The default value is 1.

Qt handles the number of copies in a rather strange way:
the value you obtain by reading property `printer.numCopies` is not 
the value you have set but reports the number of times you should 
draw the document in order to achieve the desired effect.
On Windows, Mac OS X and X11 systems that support CUPS, 
reading property `printer.numCopies` always return 1 because these systems
internally handle the number of copies.

<a name="printeroutputfilename"></a>
#### printer.outputFileName ####
<a name="qtluaprinter.outputFileName"></a>

Setting property `printer.outputFileName` to a nonempty
string indicates that printing should be redirected
to the specified file.  


<a name="printeroutputformat"></a>
#### printer.outputFormat ####
<a name="qtluaprinter.outputFormat"></a>

Property `printer.outputFormat` contains a string describing
the output format for this file or printer. 
Recognized values are `"PdfFormat"`, `"PostScriptFormat"`, 
and `"NativeFormat"`.


<a name="printerpagerect"></a>
#### printer.pageRect ####
<a name="qtluaprinter.pageRect"></a>

Read-only property `painter.pageRect` contains 
a [qt.QRect](qtcore.md#qrect)
describing the coordinates of the printable 
area of a page.

This rectangle is expressed in coordinates
starting from the top-left corner of the page
and with units specified according to 
[=printer.resolution](#printerresolution).
This coordinate system is not related the
the drawing coordinate system.


<a name="printerpagesize"></a>
#### printer.pageSize ####
<a name="qtluaprinter.pageSize"></a>

String property `printer.pageSize` contains the name of the paper format. 
The recognized names are
`"A4"`, `"B5"`, `"Letter"`, `"Legal"`, `"Executive"`,
`"A0"`, `"A1"`, `"A2"`, `"A3"`, `"A5"`, `"A6"`, 
`"A7"`, `"A8"`, `"A9"`, `"B0"`, `"B1"`,
`"B10"`, `"B2"`, `"B3"`, `"B4"`, `"B6"`, 
`"B7"`, `"B8"`, `"B9"`, `"C5E"`, `"Comm10E"`,
`"DLE"`, `"Folio"`, `"Ledger"`, and `"Tabloid"`.

When using Qt-4.4 or greater,
this property can also contain the value `"Custom"`
to indicate that the produced output must
describe an image whose size matches 
exactly the specified paper size.  
When using an earlier version of Qt,
setting this property to `"Custom"` does nothing.


<a name="printerpaperrect"></a>
#### printer.paperRect ####
<a name="qtluaprinter.paperRect"></a>

Read-only property `painter.paperRect` contains 
a [qt.QRect](qtcore.md#qrect)
describing the full size of the paper.

This rectangle is expressed in coordinates
starting from the top-left corner of the page
and with units specified according to 
[printer.resolution](#printerresolution).
This coordinate system is not related the
the drawing coordinate system.

<a name="printerpapersize"></a>
#### printer.paperSize ####
<a name="qtluaprinter.paperSize"></a>

Property `printer.paperSize` contains a 
[qt.QSizeF](qtcore.md#qsize)
describing the desired size of the drawable area.

When this property contains a valid size,
that is a size with positive width and height,
the painter initial coordinate system 
is adjusted to display the specified drawable area
within the desired page size.

Furthermore, with Qt-4.4. or greater, 
when property [printer.pageSize](#printerpagesize) 
is equal to `"Custom"`, property `printer.paperSize`
also specifies the size of the image described
by the output file.

<a name="printerprinter"></a>
#### printer:printer() ####
<a name="qtluaprinter.printer"></a>

Returns a pointer to the real `QPrinter` object
which is a subclass of `QPaintDevice`.


<a name="qtluaprinter.printProgram"></a>
#### printer.printProgram ####

Setting string property `printer.printProgram` overrides
the name of the program used to submit the printout
to the spooling system.


<a name="printerprintername"></a>
#### printer.printerName ####
<a name="qtluaprinter.printerName"></a>

String property `printer.printerName` 
contains the name of the target printer. 
This value is initially set to the name of the 
default printer for your system.


<a name="printerprinterstate"></a>
#### printer.printerState ####
<a name="qtluaprinter.printerState"></a>

Readonly string property `printer.printerState` 
returs a string describing the state of the printer.
Possible values are `Idle`, `Active`, `Aborted` and `Error`.
That does not work on all systems.


<a name="printerresolution"></a>
#### printer.resolution ####
<a name="qtluaprinter.resolution"></a>

Numerical property `printer.resolution` 
contains the resolution of the printer. 
This is initially set by the `mode` argument
of the constructor [qt.QtLuaPrinter(mode)](#qtluaprinternew).
The resolution affects the coordinate systems
for properties [printer.paperRect](#printerpaperrect)
and [printer.pageRect](#printerpagerect).
It only affects the drawing coordinate systems
when property [printer.papersize](#printerpapersize)
does not contain a valid size.


<a name="printersetfromto"></a>
#### printer:setFromTo(frompage,topage) ####
<a name="qtluaprinter.setFromTo"></a>

Function `printer:setFromTo` 
specifies the indices of the page range to print.
If both `frompage` and `topage` are zero (the default),
the whole document is printed.

<a name="qtluaprinter.setup"></a>
#### printer:setup([parentwidget]) ####

Expression `printer:setup()` displays a dialog
allowing the user to choose a printer
and select various print settings. 
It returns `true` if the user presses the button "Print"
and `false` if the user cancels.

<a name="qtluaprinter.toPage"></a>
#### printer.toPage ####

Readonly numerical property `printer.toPage`
contains the index of the last page to print.
Use function [printer:setFromTo](#printersetfromto) to change it.

