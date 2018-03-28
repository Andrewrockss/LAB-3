/* DO NOT MODIFY THIS --------------------------------------------*/
.text
.global Display
.extern iprintf
.extern cr
.extern value
.extern getstring
/*----------------------------------------------------------------*/

/******************************************************************/
/* General Information ********************************************/
/* File Name: Lab3c.s **************************************/
/* Names of Students: _________________ and ____________________ **/
/* Date: _________________                                       **/
/* General Description:                                          **/
/*                                                               **/
/******************************************************************/
Display:
/*Write your program here******************************************/
lea      -40(%a7),%a7
movem.l %d2-%d7/%a2-%a5,(%a7)
move.l 60(%a7),%d6  /*number that are divisible by divider*/
move.l 52(%a7),%d3 /*number of divisor*/
move.l 56(%a7),%d2 /*number of entry*/
move.l 44(%a7),%a3  /*results*/
move.l 48(%a7),%a2 /*The entries*/

/*clearing registers*/
clr.l %d4
clr.l %d5
clr.l %d7
move.l %d2, %d4 	/*moving num of enteries into d4*/
move.l %d6, %d7   /*moving div nums into d7*/

pea entry_number     /*push number enterys message to stack*/
jsr cr		/*new line*/
jsr iprintf    /*print message to matty */
addq.l #4,%a7  /*clean up stack*/
move.l %d4, -(%a7)   /*print message to matty */
jsr cr    	/*new line*/
jsr value    /*print value to matty */
addq.l #4,%a7  /*clean up stack*/
jsr cr    	/*new line*/


pea Howmanynum  /**/
jsr iprintf   /*print message to matty */
addq.l #4,%a7  /*clean up stack*/
jsr cr     	/*new line*/

next:
move.l (%a2)+, %d5
move.l %d5, -(%a7)
jsr value   /*print value to matty */
jsr cr    	/*new line*/
move.l (%a7)+, %d5
sub.l #1, %d4
cmp.l #0,%d4
bne nextvalue
jsr cr     	/*new line*/

clr.l %d5
pea End2   /**/
jsr iprintf
addq.l #4,%a7
move.l (%a3)+, %d5
move.l %d5, -(%a7)
jsr value    /*print value to matty */
addq.l #4,%a7  /*clean up stack*/
jsr cr      	/*new line*/

clr.l %d5
pea End3   /**/
jsr iprintf
addq.l #4,%a7 /*clean up stack*/
move.l (%a3)+, %d5
move.l %d5, -(%a7)
jsr value    /*print value to matty */
addq.l #4,%a7  /*clean up stack*/
jsr cr    	/*new line*/

clr.l %d5
pea End4   /**/
jsr iprintf
addq.l #4,%a7  /*clean up stack*/
move.l (%a3)+, %d5
move.l %d5, -(%a7)
jsr value    /*print value to matty */
addq.l #4,%a7  /*clean up stack*/
jsr cr     	/*new line*/

pea End5   /**/
jsr iprintf    /*print message to matty */
addq.l #4,%a7  /*clean up stack*/
move.l %d6, -(%a7)
jsr value     /*print value to matty */
addq.l #4,%a7  /*clean up stack*/

pea End6   /**/
jsr iprintf   /*print message to matty */
addq.l #4,%a7   /*clean up stack*/
move.l %d3, -(%a7)
jsr value    /*print value to matty */
addq.l #4,%a7  /*clean up stack*/
jsr cr    	/*new line*/

clr.l %d5
pea End7   /**/
jsr iprintf   /*print message to matty */
addq.l #4,%a7   /*clean up stack*/

nextdiv:
move.l (%a3)+, %d5
move.l %d5, -(%a7)
jsr value     /*print value to matty */
move.l (%a7)+, %d5

pea End8   /**/
jsr iprintf   /*print message to matty */
addq.l #4,%a7   /*clean up stack*/

sub.l #1, %d7
cmp.l #0,%d7
bne nextdiv
jsr cr    	/*new line*/

pea End9   
jsr iprintf   /*print message to matty */
addq.l #4,%a7   /*clean up stack*/

/*cleaning up the stack components*/
movem.l (%a7),%d2-%d7/%a2-%a5
lea      40(%a7),%a7
rts     

/*End of Subroutine **************************************************/ 
.data
/*All Strings placed here **************************************************/
entry_number:
.string "The number of values entered were "
Howmanynum:
.string "The numbers are "
End2:
.string "Min number = "
End3:
.string "Max number = "
End4:
.string "Mean number = "
End5:
.string "There are "
End6:
.string " number(s) divisible by "
End7:
.string "They are: "
End8:
.string " "
End9:
.string "Program ended"


/*End of Strings **************************************************/
