%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>

  typedef struct
  {
	char TurtName[20];
	char string[9001];
	int ival;
	int angle;
	int dist;
	char color[20];
	int pen;
	int width;
	int lineNo;
  } tstruct;
  #define YYSTYPE  tstruct
  typedef enum { false, true } bool;

  #include "TurtleTurtle.tab.h"
  
  int returnDigit(char *array)
  {
	char num[4]; 
	strncpy(num, strchr(array, ' ')+1, strlen(array));
	return atoi(num);
  }
  
  int lineNo=1;
%}

DIGIT [0-9]
UPPER [A-Z]
LOWER [a-z]
ALPHA [a-zA-Z]
ALPHANUM [a-zA-z]|[0-9]
WHITESPACE [ \t\n]
COLOR black|blue|green|red|white|purple|pink|orange|yellow|magenta|brown
%%

@@[^#]*# /*Do nothing with comments*/

hatch { return START; }
soup { return END; }
; { yylval.lineNo = lineNo; return ENDL; }
turtle { return TURTLE; }

forward { return FORWARD; }
backward { return BACKWARD; }
turn { return TURN; }
left { return LEFT; }
right { return RIGHT; }

reset { return RESET; }
width {yylval.width = atoi(yytext); return WIDTH; }

notrail { return NOTRAIL; }
trail { return TRAIL; }

color { return COLOR; }
{COLOR} { strcpy(yylval.TurtName, yytext); return COLORCHOICE; }

instinct {yylval.lineNo=lineNo; return INSTINCT; }
endinstinct { return ENDINSTINCT; }
shell	{ return SHELL; }
endshell	{return ENDSHELL;}
{ALPHA}({ALPHA}|{DIGIT})* {strcpy(yylval.TurtName, yytext); return ID; }


-?{DIGIT}+ { yylval.ival = atoi(yytext); return NUM; }
\+		{ return PLUS; }
\-		{ return MINUS; }
\*		{ return TIMES; }
\/		{yylval.lineNo=lineNo; return DIVIDE; }
%		{yylval.lineNo=lineNo; return MOD; }
\^		{ return POWER; }
\(		{ return OPEN; }
\)		{ return CLOSE; }

\n 		 {lineNo++;}
.
%%

int main(void)
{
 yyparse();
 return 0;
}

int yywrap(void)
{
 return 0;
}

int yyerror(char *s)
{
	printf("Error: %s\n", s);
	exit(1);
}