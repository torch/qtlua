<a name="qtcore.dok"/>
# QtCore Bindings #

The package `qtcore` 
contains bindings for classes defined by the Qt module
[QtCore](http://doc.trolltech.com/4.4/qtcore.html).

Besides the capabilites reported below,
all qt variants inherit a set 
of [default methods](..:qt:index#qt.QVariants),
and all qt object classes inherit the capabilities from their 
superclasses and automatically expose 
[properties, slots and signals](..:qt:index#qt.QObjects).


<a name="qbytearray"/>
## qt.QByteArray ##

Class `qt.QByteArray` represents Qt values of type 
[QByteArray](http://doc.trolltech.com/4.4/qbytearray.html).
These values are special because lua strings
are automatically converted to QByteArray objects 
when such objects are needed.

<a name="qbytearray"/>
### qt.QByteArray(arg) ###

Expression `qt.QByteArray(arg)` returns a new byte array object.
Argument `arg` may be a lua string or a table containing 
the integer values of the successive bytes.

<a name="qbytearray.totable"/>
### qbytearray:totable() ###

Expression `qbytearray:totable()` returns a table
containing the integer values of the bytes represented
by the bytearray.

<a name="qcoreapplication"/>
## qt.QCoreApplication ##

The Qt class 
[QCoreApplication](http://doc.trolltech.com/4.4/qcoreapplication.html)
provides an event loop for console Qt applications and serves
as a base class for class [QApplication](..:qtgui:index#qapplication).

<a name="qcoreapplication"/>
### qt.QCoreApplication() ###

Returns the unique instance of class `QCoreApplication`.make i


<a name="qline"/>
## qt.QLine, qt.QLineF ##

Classes `qt.QLine` and `qt.QLineF` represent common Qt classes.
Please refer to the Qt documentation for classes
[QLine](http://doc.trolltech.com/4.4/qline.html) 
and [QLineF](http://doc.trolltech.com/4.4/qlinef.html)
for details.

<a name="qline"/>
### qt.QLine(table),  qt.QLineF(table) ###
<a name="qlineF"/>

Expression `qt.QLine(table)` or `qt.QLineF(table)` 
constructs a new `qt.QLine` or `qt.QLineF` object
representing a segment whose endpoints coordinates
are given by fields `x1`, `y1`, `x2`, and `y2`
of table `table`.

<a name="qline.totable"/>
### qline:totable() ###

Expression `qline:totable()` returns a table whose fields
`x1`, `y1`, `x2`, and `y2` contain the coordinates of the
endpoints of the `qt.QLine` or `qt.QLineF` object `qline`.


<a name="qobject"/>
## qt.QObject ##

Qt class 
[QObject](http://doc.trolltech.com/4.4/qobject.html).
is the base class of all [Qt objects](..:qt:index#qt.QObjects).
All Qt object classes have separate metatables following the 
same inheritance pattern as the corresponding Qt classes. 
The metatable [qt.QObject](#qobject) sits at the top
of this hierarchy.

<a name="qobject.children"/>
### qobject:children() ###

Expression `qobject:children()` 
returns a Qt value of class [qt.QVariantList](#qvariantlist)
containing all the children of object `qobject`.


<a name="qobjectdeletelater"/>
### qobject:deleteLater() ###

Calling `qobject:deleteLater()` is the recommended way to delete 
the Qt object `qobject`. The object is not deleted immediately.
The deletion occurs when the object thread is processing
interactive events.


<a name="qobjectdumobjectinfo"/>
### qobject:dumpObjectInfo() ###

Function `qobject:dumpObjectInfo` prints a human readable
description of the object `qobject`.
This function only works when Qt and QtLua are 
compiled in debug mode.


<a name="qobjectdumobjecttree"/>
### qobject:dumpObjectTree() ###

Function `qobject:dumpObjectTree` prints a human readable
description of the object hierarchy containing `qobject`.
This function only works when Qt and QtLua are 
compiled in debug mode.


<a name="qobjectobjectname"/>
### qobject.objectName ###

Property `qobject.objectName` contains a string 
representing the name of a Qt object `qobject`.
Named children of a Qt object can be accessed
by indexing the parent object.

Consider for instance a variable `a` referring 
to a Qt object that contains a child object named `"b"`.
The child object can be accessed using the Lua syntax `a.b`.
In case of name conflicts, property and methods have precedence
over named children.

<a name="qobjectparent"/>
### qobject:parent() ###

Expression `qobject:parent()` returns the parent of object `qobject`
if such a parent exists. Otherwise it returns `nil`.

<a name="qpoint"/>
## qt.QPoint, qt.QPointF ##
<a name="qpointf"/>

Classes `qt.QPoint` and `qt.QPointF` represent common Qt classes.
Please refer to the Qt documentation for classes
[QPoint](http://doc.trolltech.com/4.4/qpoint.html) 
and [QPointF](http://doc.trolltech.com/4.4/qpointf.html)
for details.

<a name="qpoint"/>
### qt.QPoint(table),  qt.QPointF(table) ###
<a name="qpointf"/>

Expression `qt.QPoint(table)` or `qt.QPointF(table)`
returns a new `qt.QPoint` or `qt.QPointF` object
initialized with the contents of fields `x` and `y`
from table `table`.

<a name="qpoint.totable"/>
### qpoint:totable() ###

Expression `qpoint:totable()` returns a table whose fields `x` and `y`
contain the coordinates of the `qt.QPoint` or `qt.QPointF` object `qpoint`.


<a name="qrect"/>
## qt.QRect, qt.QRectF ##
<a name="qrectf"/>

Classes `qt.QRect` and `qt.QRectF` represent common Qt classes.
Please refer to the Qt documentation for classes
[QRect](http://doc.trolltech.com/4.4/qrect.html) 
and [QRectF](http://doc.trolltech.com/4.4/qrectf.html)
for details.

<a name="qrect"/>
### qt.QRect(table),  qt.QRectF(table) ###
<a name="qrectf"/>

Expression `qt.QRect(table)` or `qt.QRectF(table)`
returns a new `qt.QRect` or `qt.QRectF` object
representing a rectangle whose origin is
specified by table fields `x` and `y`
and whose width and height are specified
by the table fields `width` and `height`.

<a name="qrect.totable"/>
### qrect:totable() ###

Expression `qrect:totable()` returns a table
whose fields `x` and `y` contain the origin of the rectangle `qrect`
and whose fields `width` and `height` contain the width and
height of the rectangle.


<a name="qsize"/>
## qt.QSize, qt.QSizeF ##
<a name="qsizef"/>

Classes `qt.QSize` and `qt.QSizeF` represent common Qt classes.
Please refer to the Qt documentation for classes
[QSize](http://doc.trolltech.com/4.4/qsize.html) 
and [QSizeF](http://doc.trolltech.com/4.4/qsizef.html)
for details.

Example:
```lua
  require 'qtwidget'
  widget = qt.QWidget()
  widget.size = qt.QSize{width=320,height=200}
  widget:show()
```

<a name="qsize"/>
### qt.QSize(table),  qt.QSizeF(table) ###
<a name="qsizef"/>

Expression `qt.QSize(table)` or `qt.QSizeF(table)`
returns a new `qt.QSize` or `qt.QSizeF` object
initialized with the contents of fields `width` and `height`
from table `table`.

<a name="qsize.totable"/>
### qsize:totable() ###

Expression `qsize:totable()` returns a table whose
fields `width` and `height` are initialized with
the width and height of the size `qsize`.


<a name="qstring"/>
## qt.QString ##

Class `qt.QString` represents Qt values of type 
[QString](http://doc.trolltech.com/4.4/qstring.html).
These values are special because lua strings
are automatically converted to string objects 
when such objects are needed.

<a name="qstring"/>
### qt.QString(arg) ###

Expression `qt.QString(arg)` returns a new string object.
Argument `arg` may be a lua string representing the string
in locale encoding or a table containing the unicode values
for the string characters.

<a name="qstring.totable"/>
### qstring:totable() ###

Expression `qurl:totable()` returns a table
containing the integer values of the successive 
unicode characters represented by the string.

<a name="qstringlist"/>
## qt.QStringList ##

Class `qt.QStringList` represents Qt values of type 
[QStringList](http://doc.trolltech.com/4.4/qstringlist.html) 
containing a list of Qt strings.

<a name="qstringlist"/>
### qt.QStringList(table) ###

Expression `qt.QStringList(table)` creates a new `QStringList`
initialized with the strings contained in 
table `table` at positions `1` to `#table`.  
When the argument `table` is omitted, 
an empty string list is returned.

Example
```lua
 require 'qt'
 a = qt.QStringList{"a","b","c"}
```

<a name="qstringlist.totable"/>
### qstringlist:totable() ###

Expression `qstringlist:totable()` returns a Lua table
containing the elements of `qstringlist` starting at position `1`.

Example
```lua
 require 'qt'
 a = qt.QStringList{"a","b","c"}
 return a:totable()[2]
```


<a name="qtimer"/>
## qt.QTimer ##

Class `qt.QTimer` is a subclass of [qt.QObject](#qobject)
associated with Qt objects of class `QTimer`.
Please see the Qt documentation for class
[QTimer](http://doc.trolltech.com/4.4/qtimer.html) 
for an explanation of the available
slots, signals and properties.

Example:
```lua
require 'qt'
timer = qt.QTimer()
timer.singleShot = true
qt.connect(timer,'timeout()', function() print("timeout") end)
timer:start(2000) -- wait for 2 seconds...
```


<a name="qtimer"/>
### qt.QTimer(parent) ###

Expression `qt.QTimer(parent)` returns a 
new `QTimer` object created from the current thread.
Argument `parent` optionally specifies its parent.
Note that the parent object must belong to the current thread as well.
When argument `parent` is not specified, 
the new timer is owned by the Lua interpreter
and will be deleted by the Lua garbage collector
when it is no longer referenced.


<a name="qurl"/>
## qt.QUrl ##

Class `qt.QStringList` represents Qt values of type 
[QUrl](http://doc.trolltech.com/4.4/qurl.html) 
containing an URL.

<a name="qurl"/>
### qt.QUrl(string) ###

Expression `qt.QUrl(string)` returns a 
QUrl object from string `string`.

<a name="qurl.tostring"/>
### qurl:tostring() ###

Expression `qurl:tostring()` returns a string 
describing the QUrl object `qurl`.

### qurl.fromlocalfile(s) ###

Returns a file url associated with the file named s.

<a name="qurl.tolocalfile"/>
### qurl:tolocalfile() ###

If the url describes a local file, 
expression `qurl:tolocalfile()` returns a string 
describing the local filename associated with the url.
Otherwise it returns nil.


<a name="qvariantlist"/>
## qt.QVariantList ##

Class `qt.QVariantList` represents Qt values of type 
[QVariantList](http://doc.trolltech.com/4.4/qvariant.html#QVariantList-typedef) 
containing a list of values represented by class 
[QVariant](http://doc.trolltech.com/4.4/qvariant.html).

<a name="qvariantlist"/>
### qt.QVariantList(table) ###

Expression `qt.QVariantList(table)` creates a new `QVariantList`
initialized with the strings contained in 
table `table` at positions `1` to `#table`.  
When the argument `table` is omitted, 
an empty string list is returned.

Example
```lua
 require 'qt'
 a = qt.QVariantList{"a",32}
```

<a name="qvariantlist.totable"/>
### qvariantlist:totable() ###

Expression `qvariantlist:totable()` returns a Lua table
containing the elements of `qstringlist` starting at position `1`.

Example
```lua
 require 'qt'
 a = qt.QVariantList{"a",2,3,4}
 return a:totable()[2]
```


<a name="qvariantmap"/>
## qt.QVariantMap ##

Class `qt.QVariantList` represents Qt values of type 
[QVariantMap](http://doc.trolltech.com/4.4/qvariant.html#QVariantMap-typedef) 
containing a dictionary of named values represented by class 
[QVariant](http://doc.trolltech.com/4.4/qvariant.html).


<a name="qvariantmap"/>
### qt.QVariantMap(table) ###

Expression `qt.QVariantMap(table)` creates a new `QVariantMap`
initialized with the contents of the table `table`.
When the argument `table` is omitted, 
an empty map is returned.

Example
```lua
 require 'qt'
 a = qt.QVariantMap{a=23,b=45,c="foo"}
```

<a name="qvariantmap.totable"/>
### qvariantmap:totable() ###

Expression `qvariantmap:totable()` returns a Lua table
containing the contents of the dictonary `qvariantmap`.

Example
```lua
 require 'qt'
 a = qt.QVariantMap{a=23,b=45,c="foo"}
 t = a:totable()
 return t.c
```


