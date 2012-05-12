
struct turtle			//each turtle will be placed in a turtle structure
{
	char name[20];		//the turtle's name
	float x;				//the turtle's position on the x axis
	float y;				//the turtle's position on the y axis
	int angle;			//the angle the turtle is facing (with right being 0 degrees)
	int pen;
	char color[20];
	int width;
};

typedef struct turtle TurtleStruct;

TurtleStruct TurtleList[100];	//We can have a maximum of 100 turtles in play
int numTurtles=1;		//This counts the actual number of turtles we have
int currentTurtle=1;	//The turtle that is currently meandering about in the wild
int tempTurtle=-1;			//Will hold the value of current Turtle when we are wroking with holdturtle
int checkPen = 0;		// Used to see if the pen has changed in 
int checkColor = 0;		// Used to check if color has changed

//we are using TurtleList[0] as a temporary turtle to hold values for shells 

void setHold()
{
	TurtleList[0].x = 0;
	TurtleList[0].y = 0;
	TurtleList[0].angle = 0;
	TurtleList[0].pen = 1;
	strcpy(TurtleList[0].color, "green");
	TurtleList[0].width = -1;
}

void addTurtle( char *s )	//a method used to add a turtle to the turtlelist
{
	strcpy( TurtleList[numTurtles].name, s);
	TurtleList[numTurtles].x = 0;
	TurtleList[numTurtles].y = 0;
	TurtleList[numTurtles].angle = 0;
	TurtleList[numTurtles].pen = 1;
	strcpy(TurtleList[numTurtles].color, "green");
	TurtleList[numTurtles].width = 5;
	numTurtles++;
}

void showTurtles()			//prints all the turtles and locations in the list (error testing purposes)
{
	printf("Showing Turtles\n");
	int i;
	for( i=1; i < numTurtles; i++ )
	{
		printf("%s (%f,%f) %d degrees\n", TurtleList[i].name, TurtleList[i].x, TurtleList[i].y, TurtleList[i].angle);
	}
}

int findTurtle( char * s)	//searches through the list of turtles to find the turtle that matches the name
{
	int i;
	for( i=1; i < numTurtles; i++ )
	{
		if( strcmp(TurtleList[i].name, s) == 0 )	//if the turtle is in the list return its location
			return i;
	}
	return -1;
}

void resetTurtles()
{
	int i;
	for (i=0; i < numTurtles; i++)
	{
		TurtleList[i].angle=0;
		TurtleList[i].x=0;
		TurtleList[i].y=0;
		TurtleList[i].pen = 1;
		strcpy(TurtleList[i].color, "green");
		TurtleList[i].width = 5;
	}
}

void penUp()
{
	TurtleList[currentTurtle].pen = 0;
}

void penDown()
{
	TurtleList[currentTurtle].pen = 1;
}

void changeWidth( int width)
{
	TurtleList[currentTurtle].width = width;
}

void changeColor( char * s)
{
	strcpy(TurtleList[currentTurtle].color, s);
	return;
}

void checkTurtle( char * s )
{
	int check;
	string[0]='\0';
	check = findTurtle( s );
	//printf("%d | %d\n", currentTurtle, check);
	if( currentTurtle == check )
		return;
	//printf("It didn't stop?\n");
	char hold[10];
	strcpy(string, "\ninvisible()\n ");
	strcat(string, "\n\npen_up()\n");
	
	int changeX = TurtleList[currentTurtle].x - TurtleList[check].x;
	/*if(  (TurtleList[currentTurtle].x > 0 && TurtleList[check].x < 0) || (TurtleList[currentTurtle].x < 0 && TurtleList[check].x > 0) )
		{
			if( changeX > 0 )
				changeX++;
			if( changeX < 0 )
				changeX--;
		}*/
	int changeY = TurtleList[currentTurtle].y - TurtleList[check].y;
	/*if(  (TurtleList[currentTurtle].y > 0 && TurtleList[check].y < 0) || (TurtleList[currentTurtle].y < 0 && TurtleList[check].y > 0) )
		{
			if( changeY > 0 )
				changeY++;
			if( changeY < 0 )
				changeY--;
		}*/
	int angle = TurtleList[currentTurtle].angle;
	//printf("dif x is %d\n", changeX);
	//printf("dif y is %d\n", changeY);
	//printf("angle is %d\n", angle);
	
	strcat(string, "turn("); //face back to the start position
	sprintf(hold, "%d", angle); 
	strcat(string, hold);
	strcat(string, ")\n");  
	
	strcat(string, "go(");   //move to the proper X position
	sprintf(hold, "%d", -1*changeX);
	strcat(string, hold);
	strcat(string, ")\n");
	
	strcat(string, "turn(-90)\n"); // face the Y direction (be sure to fix the minus sign for when ethan forgets)
	
	strcat(string, "go(");		//move to the proper Y position
	sprintf(hold, "%d", -1*changeY);
	strcat(string, hold);
	strcat(string, ")\n");
	
	strcat(string, "turn(90)\n"); //face back to start position
	
	strcat(string, "turn(");	//face the way the new turtle is
	sprintf(hold, "%d", -1*TurtleList[check].angle);
	strcat(string, hold);
	strcat(string, ")\n");
	
	strcat(string, "width(");	//set the new width
	sprintf(hold, "%d", TurtleList[check].width);
	strcat(string, hold);
	strcat(string, ")\n");
	
	if (TurtleList[check].pen)
		strcat(string, "pen_down()");
	strcat(string, "\ncolor(\"");
	strcat(string, TurtleList[check].color);
	strcat(string, "\")\n");
	strcat(string, "visible()\n\n");
	
	currentTurtle = check;	//change the currentTurtle
	
	return;
	
}

void recordPosition( int go )
{
	double angle = TurtleList[currentTurtle].angle;
	if( angle == 0 )
		TurtleList[currentTurtle].x = TurtleList[currentTurtle].x + go;
	else if( angle == 90 )
		TurtleList[currentTurtle].y = TurtleList[currentTurtle].y + go;
	else if( angle == 180 )
		TurtleList[currentTurtle].x = TurtleList[currentTurtle].x - go;
	else if( angle == 270 )
		TurtleList[currentTurtle].y = TurtleList[currentTurtle].y - go;
	else if( angle < 90 )
	{
		angle = angle*3.141592654/180;
		TurtleList[currentTurtle].x = TurtleList[currentTurtle].x + go * cos( angle );
		TurtleList[currentTurtle].y = TurtleList[currentTurtle].y + go * sin( angle );
	}
	else if( 90 < angle && angle < 180 )
	{
		angle = (180-angle)*3.141592654/180;
		TurtleList[currentTurtle].x = TurtleList[currentTurtle].x + go * cos( angle );
		TurtleList[currentTurtle].y = TurtleList[currentTurtle].y + go * sin( angle );
	}
	else if( 180 < angle && angle < 270 )
	{
		angle = (angle-180)*3.141592654/180;
		TurtleList[currentTurtle].x = TurtleList[currentTurtle].x + go * cos( angle );
		TurtleList[currentTurtle].y = TurtleList[currentTurtle].y + go * sin( angle );
	}
	else if( 270 < angle )
	{
		angle = (360-angle)*3.141592654/180;
		TurtleList[currentTurtle].x = TurtleList[currentTurtle].x + go * cos( angle );
		TurtleList[currentTurtle].y = TurtleList[currentTurtle].y + go * sin( angle );
	}
}

void changeAngle( int theta )
{
	TurtleList[currentTurtle].angle = TurtleList[currentTurtle].angle + theta;
	while (TurtleList[currentTurtle].angle>360)		//change these to while loops so we can handle turn(10000)
		TurtleList[currentTurtle].angle -= 360;
	while (TurtleList[currentTurtle].angle<0)
		TurtleList[currentTurtle].angle += 360;
}

void updateTurtle()
{
	//add the additional distance to the current turtle
	TurtleList[currentTurtle].x = TurtleList[currentTurtle].x + TurtleList[0].x;
	TurtleList[currentTurtle].y = TurtleList[currentTurtle].y + TurtleList[0].y;
	
	//compensate for the x=0 and y=0 lines (fixes the off by 1 bit error)
	if( (TurtleList[currentTurtle].x > 0 && TurtleList[0].x < 0) || (TurtleList[currentTurtle].x < 0 && TurtleList[0].x > 0) )
		{
			if( TurtleList[currentTurtle].x > 0 )
				TurtleList[currentTurtle].x++;
			if( TurtleList[currentTurtle].x < 0 )
				TurtleList[currentTurtle].x++;
		}
	if( (TurtleList[currentTurtle].y > 0 && TurtleList[0].y < 0) || (TurtleList[currentTurtle].y < 0 && TurtleList[0].y > 0) )
		{
			if( TurtleList[currentTurtle].y > 0 )
				TurtleList[currentTurtle].y++;
			if( TurtleList[currentTurtle].y < 0 )
				TurtleList[currentTurtle].y++;
		}
	changeAngle( TurtleList[0].angle );
	TurtleList[currentTurtle].pen = TurtleList[0].pen;
	
	//check if the width was changed
	if( TurtleList[0].width != -1 )
		TurtleList[currentTurtle].width = TurtleList[0].width;
	strcpy(TurtleList[currentTurtle].color,TurtleList[0].color);
		
	setHold();
}













