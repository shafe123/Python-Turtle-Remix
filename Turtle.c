
  
struct elem
{
	char name[25];
	char actions[5000];
	float x;				//the turtle's position on the x axis
	float y;				//the turtle's position on the y axis
	int angle;				//the angle the turtle is facing (with right being 0 degrees)
	int pen;
	char color[20];
	int width;
};

typedef struct elem Instincts;


Instincts instincts[100];
int numInstincts = 0;
int currentInstinct = 0;


void addInstinct(char *name)
{
	strcpy(instincts[numInstincts].name, name);
	numInstincts++;
}

int findInstinct(char *name)
{
	int i;
	for( i=0; i<numInstincts; i++ )
	{
		if( strcmp(instincts[i].name, name) == 0 )
			return i;
	}
	return -1;
}

void setInstinct(char *name)
{
	int i;
	for( i=0; i<numInstincts; i++ )
	{
		if( strcmp(instincts[i].name, name) == 0 )
			{
				currentInstinct = i;
				return;
			}
	}
}

void setInstinctString( char* s )
{
	strcpy( instincts[currentInstinct].actions, s );
	return;
}

void updateInstinct()
{
	instincts[currentInstinct].x = TurtleList[0].x;
	instincts[currentInstinct].y = TurtleList[0].y;
	instincts[currentInstinct].angle = TurtleList[0].angle;
	instincts[currentInstinct].width = TurtleList[0].width;
	if( checkPen == 1 )
	{
		instincts[currentInstinct].pen = TurtleList[0].pen;
		checkPen = 0;
	}
	else
	{
		instincts[currentInstinct].pen = -1;
	}
	
	
	if( checkColor == 1 )
	{
		strcpy( instincts[currentInstinct].color, TurtleList[0].color );
		checkColor = 0;
	}
}

void fixTurtle()
{
	//add the additional distance to the current turtle
	TurtleList[currentTurtle].x = TurtleList[currentTurtle].x + instincts[currentInstinct].x;
	TurtleList[currentTurtle].y = TurtleList[currentTurtle].y + instincts[currentInstinct].y;
	
	//compensate for the x=0 and y=0 lines (fixes the off by 1 bit error)
	if( (TurtleList[currentTurtle].x > 0 && instincts[currentInstinct].x < 0) || (TurtleList[currentTurtle].x < 0 && instincts[currentInstinct].x > 0) )
		{
			if( TurtleList[currentTurtle].x > 0 )
				TurtleList[currentTurtle].x++;
			if( TurtleList[currentTurtle].x < 0 )
				TurtleList[currentTurtle].x++;
		}
	if( (TurtleList[currentTurtle].y > 0 && instincts[currentInstinct].y < 0) || (TurtleList[currentTurtle].y < 0 && instincts[currentInstinct].y > 0) )
		{
			if( TurtleList[currentTurtle].y > 0 )
				TurtleList[currentTurtle].y++;
			if( TurtleList[currentTurtle].y < 0 )
				TurtleList[currentTurtle].y++;
		}
	changeAngle( instincts[currentInstinct].angle );
	TurtleList[currentTurtle].pen = instincts[currentInstinct].pen;
	
	//check if the width was changed
	if( instincts[currentInstinct].width != -1 )
		TurtleList[currentTurtle].width = instincts[currentInstinct].width;
	strcpy(TurtleList[currentTurtle].color,instincts[currentInstinct].color);
}

int isInstinct(char * name)
{
	int i;
	for (i=0; i<numInstincts; i++)
		//strcmp returns 0 if strings are equal, C standard has !=0 as true
		if (!strcmp(instincts[i].name, name)) 
			return 1;
}