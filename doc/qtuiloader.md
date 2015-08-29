<a name="qtuiloader.dok"></a>
# QtUiLoader Package Reference Manual #

Package `qtuiloader` provides 
functions for dynamically creating widgets
from the user interface files created by program
[Qt Designer](http://doc.trolltech.com/4.4/designer-manual.html).
This is achieved by providing bindings for the Qt class
[QUiLoader](http://doc.trolltech.com/4.4/quiloader.html).



Directory `${`_TorchInstallDir=}/share/lua/5.1/qtuiloader=
contains a small demonstration of this package.
Use program
[Qt Designer](http://doc.trolltech.com/4.4/designer-manual.html)
to examine file `test.ui`.  
Then load file `test.lua` into the
[qlua](qt.md#qlua) program.

```
$ cd /usr/local/share/lua/5.1/qtuiloader
$ /usr/local/bin/qlua
Lua 5.1  Copyright (C) 1994-2008 Lua.org, PUC-Rio
> dofile('test.lua')
```


<a name="qtuiloader.functions"></a>
## Functions ##

Package `qtuiloader` provides a few convenience functions. 
Function [qtuiloader.loader](#qtuiloaderloader) returns a 
preallocated instance of class [qt.QUiLoader](#quiloader). 
Function [qtuiloader.load](#qtuiloaderload) uses 
this preallocated loader to construct a widget using a
[Qt Designer](http://doc.trolltech.com/4.4/designer-manual.html)
user interface description.


<a name="qtuiloaderavailablewidgets"></a>
### qtuiloader.availableWidgets() ###
<a name="qtuiloader.availablewidgets"></a>

Expression `qtuiloader.availableWidgets()` returns a 
[qt.QStringList](qtcore.md#qstringlist)
containing the names of the supported widget classes.


<a name="qtuiloader.createWidget"></a>
### qtuiloader.createWidget(classname,[parent,[objectname]]) ###

Creates a [widget](qtgui.md#qwidget) of class `classname`.
Argument `classname` can be any of the strings returned
by [`qtuiloader.availableWidgets()`](#qtuiloaderavailablewidgets).
The optional argument `parent` specifies the parent widget
and the optional argument `name` specifies the 
[object name](qtcore.md#qobjectobjectname).

When argument `parent` is `nil` or not specified,
the new widget is owned by the Lua interpreter 
and is automatically destroyed when the garbage collector
determines that it is no longer referenced.

<a name="qtuiloaderload"></a>
### qtuiloader.load(filename,[parent]) ###
<a name="qtuiloader.load"></a>

Expression `qtuiloader.load(filename,parent)` dynamically
constructs and returns the widget described by the 
[Qt Designer](http://doc.trolltech.com/4.4/designer-manual.html)
file `filename`.

When argument `parent` is `nil` or not specified,
the new widget is owned by the Lua interpreter 
and is automatically destroyed when the garbage collector
determines that it is no longer referenced.

<a name="qtuiloaderloader"></a>
### qtuiloader.loader() ###
<a name="qtuiloader.loader"></a>

Expression `qtuiloader.loader()`
returns a preallocated instance
of class [qt.QUiLoader](#quiloader).


<a name="qtuiloader.classes"></a>
## Classes ##

<a name="quiloader"></a>
### qt.QUiLoader ###

Class `qt.QUiLoader` provides bindings 
for all the functions of the Qt class 
[QUiLoader](http://doc.trolltech.com/4.4/quiloader.html).

To be documented further...


