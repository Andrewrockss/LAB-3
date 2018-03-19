/* DO NOT MODIFY THIS --------------------------------------------*/
.text
.global WelcomePrompt
.extern iprintf
.extern cr
.extern value
.extern getstring
/*----------------------------------------------------------------*/

/******************************************************************/
/* General Information ********************************************/
/* File Name: Lab3a.s **************************************/
/* Names of Students: _________________ and ____________________ **/
/* Date: _________________                                       **/
/* General Description:                                          **/
/*                                                               **/
/******************************************************************/
WelcomePrompt:
/*Write your program here******************************************/

suba.l #60, %sp                 /*We are using all registers move the stack pointer up 60(4*15)*/
movem.l %a0-%a6/%d0-%d7, (%sp)  /* Preservation of register contents on top of the stack*/
movea.l #0x2300000, %a2        /*values that are analyzed stored starting at 0x2300000*/

/* Print the first message of the program */
pea Welcome_message1
jsr iprintf        /*Prints a string to the monitor*/
adda.l #4, %sp    /* Clean up the stack(message was printed) */
jsr cr            /* A function that generates a carriage return and linefeed */

/*Print the second message of the program asking the user for a number] */
Check: pea Prompt_message
	   jsr iprintf     /*Prints a string to the monitor*/
	   adda.l #4, %sp  /* Clean up the stack (message was printed)*/
	   jsr cr          /*new line after message is printed */
	   jsr getstring   /* getting the sting from the user stored in D0*/
	   move.l %d0, %d6 /*moving the useres number into D6 for comparisons*/
	   jsr cr          /*new line after reading message */
     
     /* Check to the see if the number is in the range [3,15] */
     
	   cmp.l #3, %d6 
	   ble Invalid     /*The signed comparisons, branch on lower than or equal*/
	   cmp.l #15, %d6
	   bge Too_Many    /*The signed comparisons, branch on greater than or equal*/
     
/* Instructions to deal with negative, excessive and valid number */

Valid: move.l %d6, 64(%sp) /*60 reisters, divsor(4), start of entry stored )
	   move.l %d6, %d7 /* Use d7 as a counter******/
     bra divisor
     
     
Invalid: pea Message_for_invalid
		 jsr iprintf
		 adda.l #4, %sp
		 jsr cr
		 bra Check
     
Too_Many: pea Message_for_too_many
		      jsr iprintf
		      adda.l #4, %sp /* Clean up the stack (message was printed)*/
		      jsr cr
		      bra Check

divisor:  pea Message_for_divisor:
          jsr iprintf
		      adda.l #4, %sp /* Clean up the stack (message was printed)*/
          jsr cr
               
  divisor: pea Message_for_divisor
	   jsr iprintf     /*Prints a string to the monitor*/
	   adda.l #4, %sp  /* Clean up the stack (message was printed)*/
	   jsr cr          /*new line after message is printed */
	   jsr getstring   /* getting the sting from the user stored in D0*/
	   move.l %d0, %d5 /*moving the useres number into D6 for comparisons*/
	   jsr cr          /*new line after reading message */
     
     /* Check to the see if the number is in the range [2,5] */
     
	   cmp.l #2, %d5 
	   ble Invalid2     /*The signed comparisons, branch on lower than or equal*/
	   cmp.l #5, %d5
	   bge Too_Big    /*The signed comparisons, branch on greater than or equal*/        

valid_Divisor:
      move.l %d5, 60(%sp) /*60 reisters, start of entry stored )
      bra Get_Numbers
 
 
Invalid2: pea Message_for_invalid_divisor
		 jsr iprintf
		 adda.l #4, %sp
		 jsr cr
		 bra divisor

Too_Big:
      pea Message_for_too_big
		      jsr iprintf
		      adda.l #4, %sp /* Clean up the stack (message was printed)*/
		      jsr cr
		      bra divisor

/*  Print a message/string prompting the user for a number*/
Get_Numbers: pea Message_for_numbers
		         jsr iprintf
	           adda.l #4, %sp
		         jsr cr
  
             
/* Print a message indicating the last entry */
Get_Number: jsr getstring   /*get the number entered*/
            move.l %d0, %d4  /* move number into d4 for comarison*/
            jsr cr
            cmp.l #0, %d4
            blt Negative /*branch if number entered is less than*/       
             
/* Instructions to deal with positive and negative user entries*/
Positive: move.l %d4, (%a2)+ /*storing the numbers to location a2 and incrmenting a2 by a long word*/
		  sub.l #1, %d7 /*counter minus 1*/
		  cmp.l #0, %d7 
      
		  beq Lab_3b /* move on to the next step once we have all of the numbers*/
      
		  cmp.l #1, %d7 /* Check if the counter is at the 2nd last entry */
      bne Get_Numbers
		  bra Last_Number
      
Negative: pea Message_for_negative_number
		      jsr iprintf
	        adda.l #4, %sp
		      jsr cr
		      bra Get_Numbers
      
Last_Number: pea Message_for_last_number
			 jsr iprintf
			 adda.l #4, %sp
			 jsr cr
			 bra Get_Number
       
/* Restore the registers and go back to the main program*/
Lab_3b: movem.l %a0-%a6/%d0-%d7, (%sp)
		adda.l #60, %sp 
		rts
    
/*note:
(a2) = enteries 
move.l (%sp)+, %d2
move.l (%sp)+, %d3
divisor=d2
number of enteries=d3
*/


/*End of Subroutine **************************************************/ 
.data
/*All Strings placed here **************************************************/

/*WelcomeLines:*/
Welcome_message1: .string "Welcome to the Bubble Sort Program  "
Prompt_message: .string "Please enter the number (2min-15max) of entries followed by 'enter'"

Message_for_invalid: .string "Invalid entry. Please enter more than 2 entrys"
Message_for_too_many: .string "Too many entries, Please enter less that or equal to 15"

Message_for_divisor:"Please enter the divisor(2min-5max) followed by ‘enter’"
Message_for_invalid_divisor:"invalid entry. Please enter 2, up to 5"
Message_for_too_big: "invalid entry. Please enter no more than 5 butlarger than 2"

Message_for_numbers: .string "Please enter a number (positive only) followed by 'enter'"
Message_for_negative_number: .string "Negative value entered, only positive ones accepted"

Message_for_last_number: .string "Please enter the last number (positive only) followed by 'enter'"
/*End of Strings **************************************************/

