#include "predef.h"
#include <stdio.h>
#include <ctype.h>
#include <startnet.h>
#include <autoupdate.h>
#include <NetworkDebug.h>


extern "C" {
void UserMain(void * pd);
}

extern "C" {
	void AssemblyProgram();  /*Subroutine for student coding*/
	void cr(); /*Subroutine for carriage return and line feed*/
	int getstring(); /*Subroutine to get numerical value from keyboard*/
	void value(int P1); /*Subroutine to print decimal value to monitor*/
	int getchr(); /*function to get value of keyboard character*/
	void putchr(int B);
	void value1(int P1);
	
}
 
/*****************************************************
A Subroutine that prints a decimal number to the monitor
Input = decimal number on stack
Output = nothing
 
*****************************************************/ 
void value(int P1)
{
		iprintf( "\%d", P1);
}

/*****************************************************
A Subroutine that generates a carriage return and linefeed
Input = nothing
Output = nothing

*****************************************************/ 

void cr()
{
		iprintf( "\r\n");
}

/*****************************************************
A Subroutine that gets a numerical value from the keyboard
Input = nothing
Output = numberical value in register D0
This subroutine includes buffer check by clearing the buffer
if a wrong input is given and prompts the user to re-enter
a valid number
*****************************************************/ 
int number;
int getstring()
{			
			int r;
repeat:			r = scanf("%d", &number );
/*******************************************
 * clears the buffer if a wrong input is given
*********************************************/

		if (r==0)
		{	getchar();			
			iprintf("\n");
			iprintf("Not a number entered, please enter valid number \n");	
			goto repeat;	
		}
		
				
			return number;		
}


/*****************************************************
A function to get character from the keyboard
Input = nothing
Output = places the Ascii character input into data
register D0
*****************************************************/ 

int getchr()
{			
			return getchar();
			
} 

/**************************************************************/

void putchr(int B) 
{			
			putchar(B);
			
}

void value1(int P1)
{
		iprintf( "0x\%X\n", P1);
}


const char * AppName="bubblesortB";

void UserMain(void * pd) {
    InitializeStack();
    OSChangePrio(MAIN_PRIO);
    EnableAutoUpdate();

    #ifdef _DEBUG
    InitializeNetworkGDB_and_Wait();	
    #endif
	OSTimeDly(100); /*Time delay for debugging purposes */
    iprintf("Application started\n");
    while (1) {
    	AssemblyProgram(); /*the main program for students to code*/
        OSTimeDly(20); /*delay program*/
    }
}
