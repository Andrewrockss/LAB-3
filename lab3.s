/* DO NOT MODIFY THIS --------------------------------------------*/
.text
.global AssemblyProgram

AssemblyProgram:

lea      -40(%a7),%a7 
movem.l %d2-%d7/%a2-%a5,(%a7)
/*----------------------------------------------------------------*/
/******************************************************************/
/* General Information ********************************************/
/* File Name: Lab3.s *********************************************/
/* Wing Hoy ******************************************************/
/* Date: April 1, 2009 *******                                     **/
/* General Description:                                          **/
/* This file is not to be modified by the students. **************/
/* The three subroutines written by the students are called by this*/
/* File **********************************************************/
/******************************************************************/

/* Do Not Modify and of this *****************************.ualberta.ca
********/

/*Applies to the first Subroutine */
move.l #0xEEEEEEEE, -(%sp) /*replace this memory with the number of entries*/
move.l #0xDDDDDDDD, -(%sp) /*replace this memory with the divisibility number*/
jsr WelcomePrompt
move.l (%sp)+, %d2
move.l (%sp)+, %d3
/*End first subroutine*/


/*Applies to the second Subroutine */
move.l #0xFFFFFFFF, -(%sp) /*replace this memory with the number of divisible times*/
move.l %d3, -(%a7)
move.l %d2, -(%a7)
move.l #0x2300000,%a2
move.l #0x2310000,%a3
jsr Stats
move.l (%sp)+, %d2
move.l (%sp)+, %d3
move.l (%sp)+, %d4

/*End second subroutine*/


/*Applies to the third Subroutine */
move.l %d4, -(%a7)
move.l %d3, -(%a7)
move.l %d2, -(%a7)
move.l #0x2300000, -(%sp)
move.l #0x2310000, -(%sp)
jsr Display
move.l (%sp)+, %d2
move.l (%sp)+, %d3
move.l (%sp)+, %d4



/*End third subroutine*/
	 


/*End of program **************************************************/

/* DO NOT MODIFY THIS --------------------------------------------*/
movem.l (%a7),%d2-%d7/%a2-%a5 
lea      40(%a7),%a7 
rts
/*----------------------------------------------------------------*/

