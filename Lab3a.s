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

jsr cr
jsr cr
pea Welcome
jsr iprintf
addq.l #4,%sp

jsr cr
pea Entries
jsr iprintf
addq.l #4, %sp

jsr cr
jsr getstring
move.l %d0, %d2
jsr cr


EntryCheck:			
cmp.l #3, %d2
blt InvalidESma
cmp.l #15, %d2
bgt InvalidEBig
bra ContinueEnt


InvalidEBig:
pea InvalidBigS
jsr iprintf			
move.l %d2, (%sp)
jsr value
addq.l #4, %sp 		

jsr cr
jsr getstring
move.l %d0, %d2
jsr cr
bra EntryCheck

InvalidESma:
pea InvalidSmaS
jsr iprintf			
move.l %d2, (%sp)
jsr value
addq.l #4, %sp 		

jsr cr
jsr getstring
move.l %d0, %d2
jsr cr
bra EntryCheck

ContinueEnt:

move.l %d2, 48(%sp)



jsr cr				/********Divisor*******/
pea Divisor
jsr iprintf
addq.l #4, %sp

jsr cr
jsr getstring
move.l %d0, %d2
jsr cr


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
addq.l #4, %sp 		

jsr cr
jsr getstring
move.l %d0, %d2
jsr cr
bra DivisorCheck


InvalidDBig:
pea InvalidBigS
jsr iprintf			
move.l %d2, (%sp)
jsr value
addq.l #4, %sp 		

jsr cr
jsr getstring
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
jsr iprintf
addq.l #4, %sp

jsr getstring
move.l %d0, %d2
tst.l %d2
bge Continue
jsr cr
pea InvalidLT0
jsr iprintf
addq.l #4, %sp
bra ValueLoop

Continue:

move.l %d2, (%a2)+
subq.l #1, %d7
cmp.l #1, %d7
jgt ValueLoop

jsr cr			
pea FinalNum
jsr iprintf
addq.l #4, %sp

jsr getstring
move.l %d0, (%a2)+

movem.l (%sp), %d2-%d7/%a2-%a5
add.l #40, %sp

rts

/*End of Subroutine **************************************************/ 
.data

Welcome:
.string "Welcome to Wing's statistics program"
Entries:
.string "Please enter the number(3min-15max) of entries followed by 'enter'"
InvalidBigS:
.string "Invalid entry. Please enter a number less than "
InvalidSmaS:
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
