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
move.l %d7, -(%sp)

jsr cr
jsr cr

pea NumEntries
jsr iprintf
move.l 24(%sp), (%sp)
jsr value
addq.l #4, %sp
jsr cr

move.l 24(%sp), %d7		/*Counter*/

InputList:
pea NumEntList
jsr iprintf
addq.l #4, %sp
jsr cr

move.l (%a2)+, -(%sp)
jsr value
addq.l #4, %sp

subq.l #1, %d7
tst.l %d7
bne InputList


pea MinNum
jsr iprintf
move.l (%a3)+, (%sp)
jsr value
addq.l #4, %sp
jsr cr

pea MaxNum
jsr iprintf
move.l (%a3)+, (%sp)
jsr value
addq.l #4, %sp
jsr cr

pea MeanNum
jsr iprintf
move.l (%a3)+, (%sp)
jsr value
addq.l #4, %sp
jsr cr

pea NumDiv1
jsr iprintf
move.l 28(%sp), (%sp)
jsr value
pea NumDiv2
jsr iprintf
move.l 24(%sp), (%sp)
jsr value
addq.l #4, %sp
jsr cr







rts 

rts 

/*End of Subroutine **************************************************/ 
.data

NumEntries:
.string "The number of entries was "
MinNum:
.string "Min Number =: "
MaxNum:
.string "Max Number =: "
MeanNum:
.string "Mean Number =: "
NumDiv1:
.string "There are "
NumDiv2:
.string " number(s) divisible by "
NumEntList:
.string "Divisible numbers are:"
NumDivList:
.string "Inputted numbers are:"
Ended:
.string "Program ended"
/*All Strings placed here **************************************************/




/*End of Strings **************************************************/
