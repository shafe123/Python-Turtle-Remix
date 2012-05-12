
trtlCnv: lex.yy.c TurtleTurtle.tab.c
	gcc.exe TurtleTurtle.tab.c lex.yy.c -lfl -ly -o trtlCnv 

lex.yy.c: TurtleTurtle.l
	flex.exe  TurtleTurtle.l

TurtleTurtle.tab.c: TurtleTurtle.y
	bison.exe -dv TurtleTurtle.y

clean:
	del -f lex.yy.c 
	del -f TurtleTurtle.output
	del -f TurtleTurtle.tab.h
	del -f TurtleTurtle.tab.c

