=============================================
=============================================
			Python Turtle Remix
								
	  A Language Processing Adventure
			   Dr. Halverson
			   Dustin Stage
			   Ethan Shafer
									
				04/30/2012
=============================================
=============================================

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
Table of Contents
	(1. . )	Getting Started
		(1.a. )	Installing Python Turtle
			(1.a.1)	... on Windows
			(1.a.b)	... on Linux
		(1.b. )	Using trtlCnv
			(1.b.1)	... on Windows
			(1.b.b)	... on Linux
	
	(2. . )	List of Commands
		(2.a. )	Movement
			(2.a.1)	forward
			(2.a.2)	backward
			(2.a.3) left
			(2.a.4) right
			(2.a.5)	turn
		(2.b. )	Pen Control
			(2.b.1)	width
			(2.b.2) color
			(2.b.3) trail
			(2.b.4) notrail
		(2.c. )	Control Structures
			(2.c.1)	hatch
			(2.c.2)	soup
			(2.c.3)	turtle
			(2.c.4) comments
			(2.c.5)	instinct
			(2.c.6)	endinstinct
			(2.c.7)	shell
			(2.c.8)	endshell
		(2.d. )	Math Operations
	
	(3. . )	Other Notes
		(3.a. )	Screen Flickering
		(3.b. )	Multiple Turtles
		(3.c. ) Miscellaneous
		
	(4. . ) List of Examples
	
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=


=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
(1. . )	Getting Started
	Hello, and welcome to using Python Turtle Remix!  If you have any questions throughout this documentation, do not be afraid to contact us @shafe123 on Twitter or through email at ethanshafer@hotmail.com.  (Note:  my spam filter is quite strict, so the preferred method is through Twitter)
	
	\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
		(1.a. )	Installing Python Turtle
	\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
(1.a.1)	... on Windows
	1. Go to http://pythonturtle.org
	2. Click the download PythonTurtle 0.1 (Windows Installer)
	3. Run the executable when prompted.
	4. Follow the set-up prompts.
	5. Congratulations, you can now run PythonTurtle on Windows!

(1.a.b)	... on Linux
	1. Make sure you have git and curl installed
		$ sudo apt-get install git-core
		$ sudo apt-get install curl
	2. Grab the PythonTurtle repository
		$ git clone git://github.com/cool-RR/PythonTurtle.git
	3. Install the wxPython tools.
		Go to System -> Software Sources -> Other Software
		Add "deb http://apt.wxwidgets.org/ <distro> main"
		and "deb-src http://apt.wxwidgets.org/ <distro> main
			i.e. for Ubuntu Lucid
				deb http://apt.wxwidgets.org/ lucid main
				deb-src http://apt.wxwidgets.org/ lucid main
		
		$ sudo apt-get install python-wxgtk2.8 python-wxtools wx2.8-i18n
	4. Run PythonTurtle
		$ python PythonTurtle/src/pythonturtle.py

	\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
		(1.b. )	Using trtlCnv
	\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
(1.b.1)	... on Windows
	1. Download the zip file from http://ethanshafer.com/Projects.aspx -> Windows Source
	2. For easiest use, unzip the files in a location near your code.
	3. Open up the Command Prompt
	4. Enter the command trtlCnv.exe < <infile> > <outfile>
				   (i.e.)trtlCnv.exe < exmp.txt > outp.txt
	5. From PythonTurtle, run execfile("<path>")
						(i.e.)execfile("c:/<path>/outp.txt")

(1.b.b)	... on Linux
	1. Download trtlCnv from http://ethanshafer.com/Projects.aspx -> Linux Source
	2. For easiest use, place trtlCnv in a location near your code.
	3. From the terminal, enter trtlCnv < <infile> > <outfile>
						  (i.e.)trtlCnv < exmp.txt > outp.txt
	4. From PythonTurtle, run execfile("<path>")
						(i.e.)execfile("c:/<path>/outp.txt")

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
		(2. . )	List of Commands
\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\

	\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
		(2.a. )	Movement
	\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
(2.a.1)	forward
	usage: moves turtle in the direction it is facing
	
	prototype: forward <int>;
	
	example: bob forward 20;
		moves bob forward 20 pixels
		
(2.a.2)	backward
	usage: moves turtle in the opposite	direction that it is facing
	
	prototype: backward <int>;
	
	example: bob backward 20;
		moves bob backward 20 pixels
		
(2.a.3) left
	usage: turns turtle left 90 degrees
	
	prototype: left;
	
	example: sally left;
		turns sally to her left
		
(2.a.4) right
	usage: turns turtle right 90 degrees
	
	prototype: right;
	
	example: sally right;
		turns sally to her right
		
(2.a.5)	turn
	usage: turns turtle counter-clockwise
	
	prototype: turn <int>;
	
	example: sally turn 20;
		turns sally 20 degrees to her left
		
		sally turn -20;
		turns sally 20 degrees to her right
		
	\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
			(2.b. )	Pen Control
	\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
	
(2.b.1)	width
	usage: sets the absolute width of the pen, if the value is negative, width = 1
	
	prototype: width <int>;
	
	example: bob width 5;
		the width of bob's pen will be 5 pixels
		
(2.b.2) color
	usage: sets the color of the pen
	
	prototype: color	{black|blue|green|red|white|purple|pink|orange|yellow|magenta|brown};
	
	example: bob color black;
	
(2.b.3) trail
	usage: leaves a trail when the turtle moves
	
	prototype: trail;
	
	example: sally trail;
		sally's movements will now leave a trail on the background
		
(2.b.4) notrail
	usage: does not leave a trail when the turtle moves
	
	prototype: notrail;
	
	example: sally notrail;
		sally's movements will no longer leave a trail on the background
		
	/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
		(2.c. )	Control Structures
	/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
	
(2.c.1)	hatch
	usage: beginning of the program, similar to int main() in C
	
	prototype: hatch <program code> soup
	
	example: hatch
			 turtle fred;
			 soup
	
(2.c.2)	soup
	usage: signifies the end of the program
	
	prototype: hatch <program code> soup
	
	example: hatch
			 turtle fred;
			 soup
	
(2.c.3)	turtle
	usage: declares a new turtle
	
	prototype: turtle <identifier>;
	
	example: turtle fred;
		creates a new turtle named fred
	
(2.c.4) comments
	usage: used to create comments within your code
	
	prototype: @@ <comment body> #
	
	example: @@ here is my comment #
			 @@ it can also be
				multi-line #
	
(2.c.5)	instinct
	usage: used to create an instinct for reuse, similar to a function
		   also used to call an instinct
	
	prototype: 
		Declaration:instinct <name>
						<instinct code> 
					endinstinct
					
			Calling:<turtle> <instinct>
	
	example: instinct woo
				turn 20;
				go 20;
				turn 20;
			 endinstinct
			 
			 fred woo;
	
(2.c.6)	endinstinct
	usage: signifies the end of an instinct, only used in declarations
	
	prototype:  instinct <name>
					<instinct code>
				endinstinct
	
	example: (see (2.c.6))
	
(2.c.7)	shell
	usage: creates a block of code to be executed for one turtle.
	
	prototype: shell <turtle>
					<shell code>
			   endshell
	
	example: shell fred
				turn 20;
				go 20;
				width 50;
				go 20;
			 endshell
		only fred will execute those commands
	
(2.c.8)	endshell
	usage: ends a shell declaration
	
	prototype: shell <turtle>
					<shell code>
			   endshell
	
	example: (see (2.c.7))
	
	\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
		(2.d. )	Math Operations
	\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
	
Math operations have standard order of precedence.  Any divisions or mod by 0 will result in an error upon compile time.

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
		(3. . )	Other Notes
\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
(3.a. )	Screen Flickering
	During execution of your program, it is common for the screen to flicker. This is not from the conversion of your code, but merely how PythonTurtle executes.  This is something we cannot fix for now.

(3.b. )	Multiple Turtles
	PythonTurtle does not natively implement multiple turtles.  Instead, we chose to implement multiple turtles behind the scenes.  The converter keeps track of all of the turtles and their various properties, and then redraws the turtles as necessary.  As such, the turtle will go invisible at times when the program is switching turtles.

(3.c. ) Miscellaneous
	When a turtle is created it has several default properties.
		The width is set to 5 pixels.
		The direction is to face screen right.
		The color of the pen is green.
		The pen is down.
		The turtle starts at the origin.

	Python Turtle Remix does not provide any way to declare variables for storing values.  This was left out intentionally because of a lack of documentation in the language specification.
	
	Nesting instincts is not implemented.
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
		(4. . ) List of Examples
\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
Some of the examples are available to execute immediately from Python, others are an exercise in compiling.

There are 4 examples available, showcasing various aspects of Python Turtle Remix.

	CompileExample1.txt and CompileExample2.txt, when compiled, reflect the code that is in PreCompiledExample1.txt and PreCompiledExample2.txt.  You can use these to verify that you are indeed compiling your code properly.

	Example3.txt and Example4.txt provide samples of more advanced features such as shells and instincts.  Please use these as a reference to help build your own programs.
=============================================
=============================================