<a name="qtide.dok"/>
# QtIde Package Reference Manual #

A package implementing 
the QLua Integrated Development Environment (IDE),
including the text editor, the object inspector,
the help browser, and the lua graphical console.

This package is not complete because
it is under heavy development. 


<a name="qtide.functions."/>
## Functions ##
<a name="qtidefunctions"/>

<a name="qtide.editor"/>
### qtide.editor([filename]) ###

Called without argument, this function returns a 
text editor object of class [QLuaEditor](#qluaeditor).
Otherwise it returns an editor for the file `filename`,
possibly creating a new editor window.
It pops a message box and returns `nil` if the 
file `filename` does not exist or cannot be loaded.

Open editors have object names of the form `editor`_n_ 
and are accessible by name in the `qt` package.


<a name="qtide.doeditor"/>
### qtide.doeditor(qluaeditor) ###

This function executes the chunk of Lua code
corresponding to the text present in the editor `qluaeditor`.
This is the function called by the IDE when one selects 
the menu entry "_Load Lua File_" from an editor
whose contents is not associated with a file
or has been modified (otherwise one can use the standard
Lua function `dofile`.)


<a name="qtide.browser"/>
### qtide.browser([url]) ###

This function opens a web browser for URL `url`.
The web browser is a widget of class [QLuaBrowser](#qluabrowser).
This is the function called by the IDE when one
requests the help index.


<a name="qtide.inspector"/>
### qtide.inspector(...) ###

Not yet implemented


<a name="qtide.preferences"/>
### qtide.preferences() ###

Not yet implemented


<a name="qtide.start"/>
### qtide.start([style]) ###
<a name="qtidestart"/>

Starts the QLua Integrated Development Environment (IDE)
and ensure that the main window is visible.
This function is called implicitely when program `qlua`
is executed with option `-ide`.

The optional argument `style` is a string 
specifying the default IDE style.  
When this argument is not specified
the last used style is assumed.
The recognized IDE styles are:

  * `"sdi"` for an IDE with multiple main windows,
  * `"mdi"` for an IDE with subwindows in the style of Windows,
  * `"tab"` groups all editors into a single tabbed window.
  * `"tab2"` groups all editors and the console into a single tabbed window.


<a name="qtide.setup"/>
### qtide.setup([style]) ###
<a name="qtidesetup"/>

This function is called by [qtide.start()](#qtidestart)
to setup the IDE style. You can call it directly if you
want to organize QLua editors and windows without creating
a graphic console.


<a name="qtclasses"/>
## Qt Classes ##

<a name="qluaide"/>
### qt.QLuaIde ###

Object `qt.qLuaIde` represetns the global state of the IDE.
This is the unique instance of class `qt.QLuaIde`
which inherits [qt.QObject](..:qt:index#qobject).
Most of its capabilities are conveniently
accessible using the functions defined
by the [package ''qtide](#qtidefunctions).

<a name="qluaide.editOnError"/>
#### qt.qLuaIde.editOnError ####

When a Lua error occurs, this boolean property 
specifies whether editors are automatically opened
on the location of the error.
This property is `false` by default
Function [qtide.start](#qtidestart) sets it to `true`.

<a name="qluaide.windows"/>
#### qt.qLuaIde:windows() ####

Returns a variant of type `qt.QObjectList` containing
all the main windows managed by the IDE.

<a name="qluaide.windowNames"/>
#### qt.qLuaIde:windowNames() ####

Returns a variant of type `qt.QStringList` containing
the names of all the main windows managed by the IDE.

<a name="qluaide.activeWindow"/>
#### qt.qLuaIde:activeWindow() ####

<a name="qluaide.editor"/>
#### qt.qLuaIde:editor([fname]) ####

<a name="qluaide.browser"/>
#### qt.qLuaIde:browser([url]) ####

<a name="qluaide.inspector"/>
#### qt.qLuaIde:inspector() ####

<a name="qluaide.recentFiles"/>
#### qt.qLuaIde:recentFiles() ####

Returns a variant of type `qt.QStringList` containing
the file names appearing in the "Open Recent Files" menu.

<a name="qluaide.addRecentFile"/>
#### qt.qLuaIde:addRecentFile(fname) ####

<a name="qluaide.clearRecentFiles"/>
#### qt.qLuaIde:clearRecentFiles() ####

<a name="qluaide.activateWidget"/>
#### qt.qLuaIde:activateWidget(qwidget) ####

<a name="qluaide.activateConsole"/>
#### qt.qLuaIde:activateConsole() ####

<a name="qluaide.messageBox"/>
#### qt.qLuaIde:messageBox(title,message,buttons,[defbutton,[icon]]) ####

<a name="qluaide.hasAction"/>
#### qt.qLuaIde:hasAction(name) ####

<a name="qluaide.stdAction"/>
#### qt.qLuaIde:stdAction(name) ####

<a name="qluaide.prefsRequested"/>
#### [qt.QLuaIde signal] prefsRequested(qwidget) ####

This signal is emitted when the "Preferences" menu is selected.

<a name="qluaide.helpRequested"/>
#### [qt.QLuaIde signal] helpRequested(qwidget) ####

This signal is emitted when the "Help Index" menu is selected.



<a name="qluamainwindow"/>
### qt.QLuaMainWindow ###

This subclass of `QMainWindow` implements common 
functionalities shared by all main windows defined
by the `qtide` package.

<a name="qluamainwindow.clearStatusMessage"/>
#### qluamainwindow:clearStatusMessage() ####

<a name="qluamainwindow.showStatusMessage"/>
#### qluamainwindow:showStatusMessage(string,[timeout]) ####

<a name="qluamainwindow.hasAction"/>
#### qluamainwindow:hasAction(name) ####

<a name="qluamainwindow.stdAction"/>
#### qluamainwindow:stdAction(name) ####

<a name="qluamainwindow.doXXXX"/>
#### qluamainwindow:doXXXX() ####

Methods whose name start with `do` implement
the functions accessible from the menus and toolbar icons
in various subclasses of `qt.QLuaMainWindow`.


<a name="qluaeditor"/>
### qt.QLuaEditor ###

This subclass of [qt.QLuaMainWindow](#qluamainwindow)
implements the QLua editor windows using 
an instance of [qt.QLuaTextEdit](#qluatextedit)
as its main widget.

<a name="qluaeditor.widget"/>
#### qluaeditor:widget() ####

Expression `qluaeditor:widget()` returns the
[qt.QLuaTextEdit](#qluatextedit)
object that underlies the editor window.

<a name="qluaeditor.fileName"/>
#### qluaeditor.fileName ####

This property contains the name of the file being edited.

<a name="qluaeditor.readFile"/>
#### qluaeditor:readFile(string) ####

<a name="qluaeditor.writeFile"/>
#### qluaeditor:writeFile(string) ####


<a name="qluabrowser"/>
### qt.QLuaBrowser ###

This subclass of [qt.QLuaMainWindow](#qluamainwindow)
implements the QLua web browser windows using the Qt WebKit interface.


<a name="qluabrowser.url"/>
#### qluabrowser.url ####

This property contains a qt variant 
of type [qt.QUrl](..:qt:index#qurl) 
representing the URL displayed by the browser.

<a name="qluabrowser.html"/>
#### qluabrowser.html ####

This property contains a qt variant of type `QString`
representing the HTML text displayed by the browser.




<a name="qluasdimain"/>
### qt.QLuaSdiMain ###

This subclass of [qt.QLuaMainWindow](#qluamainwindow)
implements the QLua console window.
Expression `qt.qLuaSdiMain` returns the single console
window when such a window exists.

<a name="qluasdimain.consoleWidget"/>
#### qt.qLuaSdiMain:consoleWidget() ####

Returns the object of class 
[qt.QLuaTextEdit](#qluaconsolewidget)
implementing the part of the main console
where the user can edit and submit lua strings.

<a name="qluasdimain.editorWidget"/>
#### qt.qLuaSdiMain:editorWidget() ####

Returns the object of class 
[qt.QLuaTextEdit](#qluatextedit)
implementing the part of the main console
where the Lua output is shown.


<a name="qluamdimain"/>
### qt.QLuaMdiMain ###

This subclass of [qt.QLuaMainWindow](#qluamainwindow)
aggregates selected windows into a single main window
to implement the IDE styles. Expression `qt.qLuaMdiMain` 
returns the single main window when such a window exists.

<a name="qluamdimain.tabMode"/>
#### qt.qLuaMdiMain.tabMode ####

The boolean property `qt.qLuaMdiMain.tabMode`
indicates whether the aggregated
windows are displayed using tabs or using a multiple document interface.

<a name="qluamdimain.clientClass"/>
#### qt.qLuaMdiMain.clientClass ####

The string property `qt.qLuaMdiMain.clientClass` 
contains the name of a class.
All new main windows inheriting this class are then 
managed by the single main window.

<a name="qluamdimain.adoptAll"/>
#### qt.qLuaMdiMain:adoptAll() ####

Collects all main windows that are 
subclasses of `qt.qLuaMdiMain.clientClass` 
and aggregates them into the mdi main window.

<a name="qluamdimain.adopt"/>
#### qt.qLuaMdiMain:adopt(qwidget) ####

<a name="qluamdimain.activate"/>
#### qt.qLuaMdiMain:activate(qwidget) ####

<a name="qluatextedit"/>
### qt.QLuaTextEdit ###

Class `QLuaTextEdit` is a text editor widget derived 
from `QPlainTextEdit` with support for line numbers, 
find dialog, replace dialog, and printing.

<a name="qluatextedit.showLineNumbers"/>
#### qluatextedit.showLineNumbers ####

<a name="qluatextedit.autoComplete"/>
#### qluatextedit.autoComplete ####

<a name="qluatextedit.autoIndent"/>
#### qluatextedit.autoIndent ####

<a name="qluatextedit.autoHighlight"/>
#### qluatextedit.autoHighlight ####

<a name="qluatextedit.autoMatch"/>
#### qluatextedit.autoMatch ####

<a name="qluatextedit.tabExpand"/>
#### qluatextedit.tabExpand ####

<a name="qluatextedit.tabSize"/>
#### qluatextedit.tabSize ####

<a name="qluatextedit.setEditorMode"/>
#### qluatextedit:setEditorMode(suffix) ####

<a name="qluatextedit.readFile"/>
#### qluatextedit:readFile(fname) ####

<a name="qluatextedit.writeFile"/>
#### qluatextedit:writeFile(fname) ####

<a name="qluatextedit.showLine"/>
#### qluatextedit:showLine(lineno) ####

<a name="qluaconsolewidget"/>
### qt.QLuaConsoleWidget ###

Class `QLuaConsoleWidget` is a subclass of 
[qt.QLuaTextEdit](#qluatextedit)
that captures and display the lua output.

<a name="qluaconsolewidget.printTimings"/>
#### qluaconsolewidget.printTimings ####

Boolean property that indicates whether the console
displays the running time of each command.

<a name="qluaconsolewidget.addOutput"/>
#### qluaconsolewidget:addOutput(text,[format]) ####

Adds `text` to the console window.
Argument `format` is a string specifying the text format.
Possible values are `"default"`, `"quote"`, and `"comment"`.

<a name="qluaconsolewidget.moveToEnd"/>
#### qluaconsolewidget:moveToEnd() ####

Shows the bottom of the text displayed in the console window.



<a name="qtobjects"/>
## Qt Objects ##

<a name="qtqluaide"/>
### qt.qLuaIde ###

Expression `qt.qLuaIde` refers to the unique instance
of class [qt.QLuaIde](#qluaide).
This instance is created when package `qtide` is loaded.


<a name="qtqluasdimain"/>
### qt.qLuaSdiMain ###

Expression `qt.qLuaSdiMain` refers to the unique instance of 
class [qt.QLuaSdiMain](#qluasdimain),
created by function [qtide.start()](#qtidestart).


<a name="qtqluamdimain"/>
### qt.qLuaMdiMain ###

Expression `qt.qLuaMdiMain` refers to the unique instance of 
class [qt.QLuaMdiMain](#qluamdimain) created 
by function [qtide.setup()](#qtidesetup).
There is no such object when the IDE runs in SDI mode.

