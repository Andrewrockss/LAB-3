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


CheckDivisor:			/*testing the user's divisor entry*/
cmp.l #2, %d2       /*compareing with 3*/
blt Invalid_dtoosmall   /*branch to Invalid_dtoosmall if less than 3*/
cmp.l #5, %d2     /*compareing with 5*/
bgt Invalid_dtoobig      /*branch to Invalid_dtoosmall if greater than 3*/
bra ContinueDiv        /*else go to ContinueDiv*/


Invalid_dtoosmall :        /*divisor number is too small*/
pea InvalidSmaS                 /*push invalid messadge to stack*/
jsr iprintf			            /*print the messadge to Matty*/
move.l %d2, (%sp)   /*move useres value into stack pointer*/
jsr value                /*print the useres invalid entery*/
addq.l #4, %sp     /*clean up the stack*/
jsr cr           /*new line*/
jsr getstring      /*get the number the user typed */
move.l %d0, %d2
jsr cr    /*new line*/
bra CheckDivisor  


InvalidDBig:   /*divisor number is too big*/
pea Invalid_tobig       /*push invalid messadge to stack and promt for new number*/
jsr iprintf			/*print the messadge to Matty*/
move.l %d2, (%sp)   /*move useres value into stack pointer*/
jsr value    /*print the useres invalid entery*/
addq.l #4, %sp 	 /*clean up the stack*/	

jsr cr     /*new line*/
jsr getstring     /*get the number the user typed */
move.l %d0, %d2    /*get the new number the user entered and check it agian*/
jsr cr        /*new line*/
bra DivisorCheck   /*check users number agian*/

ContinueDiv:   /*if the user entered a number in the range*/
move.l %d2, 44(%sp)  /*store the divisor number*/

move.l 48(%sp), %d7         /*%d7 is a counter = num of enteries*/
move.l #0x2300000, %a2  /*havge a2 point to this address*/

/*Once all the correct values are stored enter the remaning positive values*/

ValueLoop:
jsr cr     /*new line*/
pea EnterNum      /*push EnterNum messadge to stack*/
jsr iprintf   /*print the messadge to Matty*/
addq.l #4, %sp /*clean up the stack*/

jsr getstring     /*get the number the user typed */
move.l %d0, %d2     /*store number the user typed in d2*/
cmp.l #0, %d2       /*compareing with 0*/
bge Continue     /*valid if greater than 0*/
jsr cr    /*new line*/

pea Invalid_toolarge
jsr iprintf   /*print the messadge to Matty*/
addq.l #4, %sp   /*clean up the stack*/
bra ValueLoop   /*getting a new number go back*/

Continue:     /*gose here if the number is valid*/
move.l %d2, (%a2)+   /*store the number and incremnt a2*/
subq.l #1, %d7   /*subtract one fron the counter*/
cmp.l #1, %d7     /*compareing with 1*/
bgt ValueLoop    /* if the counter is greater than one get the next value*/

Next:             /*getting the last entery*/
jsr cr			  /*new line*/
pea FinalNum      /*pushFinalNum messadge to stack*/ 
jsr iprintf   /*print the messadge to Matty*/
addq.l #4, %sp     /*clean up the stack*/

jsr getstring     /*get the number the user typed */
cmp.l #0, %d0   /*compareing with 0*/
ble Next      /*if less than zero contiune to next*/
move.l %d0, (%a2)+   /*store in a2 then increment a2*/

movem.l (%sp), %d2-%d7/%a2-%a5   /*restore all the used registers*/ 
add.l #40, %sp      /*clean up the stack*/

rts    /*return from the stack, and pop the value of the return addresss*/

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
Invalid_toolarge:
.string "The number must be positive"
FinalNum:
.string "Please enter the last number(Positive Only): "
/*All Strings placed here **************************************************/

/*End of Strings **************************************************/
