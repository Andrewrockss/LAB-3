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

sub.l #40, %sp
movem.l %d2-%d7/%a2-%a5, (%sp)
clr.l %d2 			/*%d2 = storage*/

jsr cr      	/*new line*/
jsr cr        	/*new line*/


pea WelcomePrompt       	/*Push welcome messadge onto the stack*/
jsr iprintf         	/*print the messadge to Matty*/
addq.l #4,%sp         	/*clean up the stack*/

jsr cr      	/*new line*/
pea Entries      /*Push Entry messadge onto the stack*/
jsr iprintf     *print the messadge to Matty*/
addq.l #4, %sp     /*clean up the stack*/

jsr cr      	/*new line*/
jsr getstring   /*get the number the user typed */
move.l %d0, %d2 /*move the number the useer entered to d2 */
jsr cr  	/*new line*/


CheckEntry: 	/*testing the user's entry*/
cmp.l #3, %d2  /*compareing with 3*/
blt InvalidESma   /*branch to Invalid_tosmall if less than 3*/
cmp.l #15, %d2    /*compareing with 15*/
bgt Invalid_tobig    /*branch to Invalid_tobig if greater than 3*/
bra ContinueEnt /*branch to ContinueEnt if the value is greater than */

Invalid_tobig: 
pea Invalid_tobig    /*push the error messadge to stack an ask for new one */
jsr iprintf			    /*print the messadge to Matty*/
move.l %d2, (%sp)    /*move d2 into stack pointer*/
jsr value              /*print the value on the stack to Matty*/
addq.l #4, %sp 		 /*clean up the stack*/

jsr cr    /*new line*/
jsr getstring     /*get the number the user typed */
move.l %d0, %d2    /*print the value on the stack to Matty*/
jsr cr        	/*new line*/
bra CheckEntry   /*testing the user's entry*/

Invalid_tosmall:
pea InvalidSmaS   /*push the error messadge to stack an ask for new one */
jsr iprintf			/*print the messadge to Matty*/
move.l %d2, (%sp)  /*move d2 into stack pointer*/
jsr value         /*print the value on the stack to Matty*/
addq.l #4, %sp 		/*clean up the stack*/

jsr cr          /*new line*/
jsr getstring    /*get the number the user typed */
move.l %d0, %d2     /*move the value the user entered to d2*/
jsr cr           	/*new line*/
bra EntryCheck   /*testing the user's entry in d2*/
   
ContinueEnt:     /*branch to ContinueEnt if the value is in range */
move.l %d2, 48(%sp) /*move d2 to a number of entereies located on the stack*/
jsr cr     	/*new line*/
pea Divisor    /*push onto stack the messadge to get Divisor */
jsr iprintf       /*print the messadge to Matty*/
addq.l #4, %sp    /*clean up the stack*/

jsr cr       	/*new line*/
jsr getstring     /*get the number the user typed */
move.l %d0, %d2  
jsr cr    	/*new line*/


DivisorCheck:			
cmp.l #2, %d2
blt InvalidDSma
cmp.l #5, %d2
bgt InvalidDBig
bra ContinueDiv


InvalidDSma:
pea InvalidSmaS
jsr iprintf			
move.l %d2, (%sp)
jsr value
addq.l #4, %sp     /*clean up the stack*/
jsr cr
jsr getstring      /*get the number the user typed */
move.l %d0, %d2
jsr cr
bra DivisorCheck


InvalidDBig:
pea InvalidBigS
jsr iprintf			/*print the messadge to Matty*/
move.l %d2, (%sp)
jsr value
addq.l #4, %sp 	 /*clean up the stack*/	

jsr cr
jsr getstring     /*get the number the user typed */
move.l %d0, %d2
jsr cr
bra DivisorCheck

ContinueDiv:
move.l %d2, 44(%sp)



move.l 48(%sp), %d7 /*%d7 is a counter*/
move.l #0x2300000, %a2

/****/
ValueLoop:
jsr cr
pea EnterNum
jsr iprintf   /*print the messadge to Matty*/
addq.l #4, %sp /*clean up the stack*/

jsr getstring     /*get the number the user typed */
move.l %d0, %d2
cmp.l #0, %d2
bge Continue
jsr cr
pea InvalidLT0
jsr iprintf   /*print the messadge to Matty*/
addq.l #4, %sp
bra ValueLoop

Continue:
move.l %d2, (%a2)+
subq.l #1, %d7
cmp.l #1, %d7
bgt ValueLoop
Next:
jsr cr			
pea FinalNum
jsr iprintf   /*print the messadge to Matty*/
addq.l #4, %sp

jsr getstring     /*get the number the user typed */
cmp.l #0, %d0
ble Next
move.l %d0, (%a2)+

movem.l (%sp), %d2-%d7/%a2-%a5  
add.l #40, %sp      /*clean up the stack*/

rts

/*End of Subroutine **************************************************/ 
.data

WelcomePrompt:
.string "Welcome to Wing's statistics program"
Entries:
.string "Please enter the number(3min-15max) of entries followed by 'enter'"
Invalid_tobig:
.string "Invalid entry. Please enter a number less than "
Invalid_tosmall:
.string "Invalid entry. Please enter a number more than "
Divisor:
.string "Please enter the divisor(2min-5max) followed by 'enter'"
EnterNum:
.string "Please enter a number(Positive Only): "
InvalidLT0:
.string "The number must be positive"
FinalNum:
.string "Please enter the last number(Positive Only): "
/*All Strings placed here **************************************************/

/*End of Strings **************************************************/
