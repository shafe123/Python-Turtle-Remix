%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include <math.h>


  
  typedef enum { false, true } bool;
  
  typedef struct
  {
    char TurtName[20];
	char string[9001];
    int ival;			//used to catch errors in syntax
	int angle;
	int dist;
	char color[20];
	int pen;
	int width;
	int lineNo;
  } tstruct;
  #define YYSTYPE tstruct
  
  typedef struct
  {
	int lineNo;
	char message[75];
  } error;
  
  error errors[20];
  int curError=0;
  char string[1000];
  char junk[1000];
  
  
  #include "TurtleOps.c"
  #include "Turtle.c"
  
void printErrors()
{
	int i=0;
	for (i=0; i<curError; i++)
	{
		printf("Line %d:\n\tMessage: %s\n", errors[i].lineNo, errors[i].message);
	}
	exit(1);
}
%}

%token START
%token END
%token TURTLE

%token FORWARD
%token BACKWARD

%token LEFT
%token RIGHT
%token TURN

%token RESET
%token WIDTH

%token NUM
%token ENDL

%token NOTRAIL
%token TRAIL

%token COLOR
%token COLORCHOICE

%token INSTINCT
%token ENDINSTINCT
%token SHELL
%token ENDSHELL
%token ID

%token PLUS
%token MINUS
%token TIMES
%token DIVIDE
%token MOD
%token POWER
%token OPEN
%token CLOSE

%%
program: 
		START commandList END 	
			{ 
			  if( $2.ival != 0 )
				printf("ERROR: statements must contain a turtle designation\n");
			  else if (curError > 0)
				printErrors();
			  printf("turn(90)\ncolor(\"green\")\nwidth(5)\n%s\n", $2.string);
			  exit(0); 
			}
	|	START END { exit(0); }
	;
	
commandList:
		command commandList		
			{ if( $1.ival != $2.ival )		//if we have conflicting statements
				$$.ival = 2;				//we obviously have an error here
			  else
				$$.ival = $1.ival; 			//pass on the current state
			  strcpy($$.string, $1.string);
			  strcat($$.string, $2.string);
			}
	|	command					
			{ $$.ival = $1.ival; strcpy($$.string, $1.string);}
	;
	
command: 
		INSTINCT ID commandList ENDINSTINCT 	//It is not necessary for instincts to be declared at the top
			{ if($3.ival != 1)					//catch the error
				{printf("ERROR: instincts do not require turtle designations\n");
				 exit(1);
				} 
			  if( isInstinct( $2.TurtName ) )
			  {
				//have ethan through in some of his error checking statement shiz...
			  }
			  $$.ival = 0;						//set the ival to show no errors
			  
			  currentTurtle = tempTurtle;
			  tempTurtle = -1;
			 
			  addInstinct( $2.TurtName );
			  setInstinct( $2.TurtName );
			  setInstinctString( $3.string );
			  updateInstinct();
			  
			}								
	|	SHELL ID commandList ENDSHELL			
			{ 
			  if($3.ival != 1)					//catch the error
				{printf("ERROR: shells do not require turtle designations\n");
				 exit(1);
				}
			  else if (findTurtle($2.TurtName)!=-1) //check if turtle is declared
				{
				  //set the ival to show no errors
				  $$.ival = 0;
				  
				  currentTurtle = tempTurtle;
				  checkTurtle($2.TurtName);
				  
				  strcpy($$.string, string);
				  strcat($$.string, $3.string);
				  updateTurtle();

				  tempTurtle = -1;	//we have used this hold turtle, so mark it for reset
				  
				}
			}
	|	statement								
			{ $$.ival = $1.ival; strcpy($$.string, $1.string);}
	;
	
statement:
		RESET ENDL	{ $$.ival = 0;
					  strcpy( $$.string, "reset()\n");
					  resetTurtles();
					  strcat($$.string, "invisible()\nturn(90)\ncolor(\"green\")\nwidth(5)\nvisible()\n");
					}
	|	ID line ENDL	{
						if (findTurtle($1.TurtName)!=-1)
						{
							$$.ival = 0; //error checking statement
							checkTurtle( $1.TurtName ); //change the turtles
							strcpy($$.string, string); 	//place the change turtle string before the execution string
							strcat($$.string, $2.string); //concatinate on the current command
							if( $2.angle != 0 )			//record the new position depending on the command
								changeAngle(-1*$2.angle);
							else if( $2.dist != 0 )
								recordPosition($2.dist);
							else if(strcmp($2.color, "")!=0)
								changeColor($2.color);
							else if($2.pen==55)
							{
								penDown();
							}
							else if($2.pen==66)
							{
								penUp();
							}
							else if($2.width!=0)
								changeWidth($2.width);
						}
						else
						{
							errors[curError].lineNo = $3.lineNo;
							strcpy(errors[curError].message, "Turtle not defined");
							curError++;
						}
						}
	|	line ENDL		{
							//Error Checking
							$$.ival = 1;
							
							//Pass Up the command string
							strcpy( $$.string, $1.string );
							
							//We will need to store all the changes made in a shell or and instinct in a temporary turtle
							//this allows us to keep track of the changes in the shell and add them to the turtle it is modifying
							
							//check to see if we are not yet working in a hold turtle
							if( tempTurtle == -1 )
							{
								setHold();	//resets our hold turtle for new input
								tempTurtle = currentTurtle; //hold the value of our current turtle
								currentTurtle = 0; // 0 is the location of the temp turtle, this allows us to use our functions in TurtleOps.c on our temp
							}
							
							if( $1.angle != 0 )			//record the new position depending on the command
								changeAngle(-1*$1.angle);
							else if( $1.dist != 0 )
								recordPosition($1.dist);
							else if(strcmp($1.color, "")!=0)
								changeColor($1.color);
							else if($1.pen==55)
							{
								penDown();
							}
							else if($1.pen==66)
							{
								penUp();
							}
							else if($1.width!=0)
								changeWidth($1.width);
						}
	|	TURTLE ID ENDL  {
						 $$.ival = 0; //error checking statement
						if (findTurtle($2.TurtName)==-1)
							addTurtle($2.TurtName);
						else
						{
							errors[curError].lineNo = $3.lineNo;
							strcpy(errors[curError].message, "Turtle already declared");
							curError++;
						}
						}
	|	ID 	ID	ENDL	{
						if (findTurtle($1.TurtName)!= -1)
						{
							if (isInstinct($2.TurtName))
							{
								$$.ival = 0;
								setInstinct($2.TurtName);
								checkTurtle($1.TurtName);
								strcpy( $$.string, string );
								strcat( $$.string, instincts[currentInstinct].actions );
								fixTurtle();
							}
							else 
							{
								errors[curError].lineNo = $1.lineNo;
								strcpy(errors[curError].message, "Instinct not defined");
								curError++;
							}
						}
						else
						{
							errors[curError].lineNo = $1.lineNo;
							strcpy(errors[curError].message, "Turtle not defined");
							curError++;
						}
					  }
	
	;
	
line:
		TURN addition	{ strcpy( $$.string, "turn(" );
					  sprintf( junk, "%d", -1*$2.ival );
					  strcat( $$.string, junk );
					  strcat( $$.string, ")\n" );
					  $$.angle = -1*$2.ival;
					  $$.dist = 0; }
	|	RIGHT		{ strcpy( $$.string, "turn(90)\n");
							$$.angle = 90; $$.dist=0;}
	|	LEFT		{ strcpy( $$.string, "turn(-90)\n");
							$$.angle = -90; $$.dist = 0;}
	|	FORWARD addition {strcpy( $$.string, "go(" );
					  sprintf( junk, "%d", $2.ival );
					  strcat( $$.string, junk );
					  strcat( $$.string, ")\n" );
					  $$.dist = $2.ival; $$.angle = 0;
					  }
	|   BACKWARD addition {
					  strcpy( $$.string, "go(" );
					  sprintf( junk, "%d", $2.ival*-1 );
					  strcat( $$.string, junk );
					  strcat( $$.string, ")\n" );
					  $$.dist = -1*$2.ival; $$.angle=0;}
    | 	TRAIL	 	{strcpy( $$.string, "pen_down()\n"); $$.dist=0;$$.angle=0;$$.pen=55; }
	|	NOTRAIL  	{strcpy( $$.string, "pen_up()\n"); $$.dist=0;$$.angle=0;$$.pen=66;}
	|	COLOR COLORCHOICE {strcpy( $$.string, "color(\"");
									   strcat( $$.string, $2.TurtName);
									   strcat( $$.string, "\")\n");
									   $$.dist=0;$$.angle=0;
									   strcpy($$.color, $2.TurtName);
						  }	
	|	WIDTH addition	{$$.width = $2.ival;
						 strcat($$.string, "width(");
						 sprintf( junk, "%d", $2.ival);
						 strcat($$.string, junk);
						 strcat($$.string, ")\n");
						}
	;
	
addition
    : addition PLUS multiplication  { $$.ival = $1.ival + $3.ival;  }
    | addition MINUS multiplication  { $$.ival = $1.ival - $3.ival; }
    | multiplication		   { $$.ival = $1.ival; }
    ;

multiplication
    : multiplication TIMES exponent  { $$.ival = $1.ival * $3.ival; }
    | multiplication DIVIDE exponent  { if( $3.ival == 0 )
						{
						errors[curError].lineNo = $2.lineNo;
						strcpy(errors[curError].message, "Divide by 0");
						curError++;
						}
				     else
				       $$.ival = $1.ival/$3.ival; }
    | multiplication MOD exponent  { if( $3.ival == 0 )
						{
						errors[curError].lineNo = $2.lineNo;
						strcpy(errors[curError].message, "Mod by 0");
						curError++;	
						}
				     else
				       $$.ival = $1.ival%$3.ival; }
    | exponent			   { $$.ival = $1.ival; }
    ;

exponent
    : exponent POWER par	 { $$.ival = $1.ival; int i;
			   for( i=1; i<$3.ival; i++ )
			     $$.ival = $$.ival * $1.ival; }
    | par		 { $$.ival = $1.ival; }
    ;

par
    : OPEN addition CLOSE     { $$.ival = $2.ival; }
    | NUM		 { $$.ival = $1.ival;}
    ;