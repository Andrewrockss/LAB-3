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
clr.l %d4
clr.l %d5
clr.l %d7
move.l %d2, %d4
move.l %d6, %d7

pea numberentry
jsr cr		/**/
jsr iprintf
addq.l #4,%a7
move.l %d4, -(%a7)
jsr cr
jsr value
addq.l #4,%a7
jsr cr


pea End1   /**/
jsr iprintf
addq.l #4,%a7
jsr cr

nextvalue:
move.l (%a2)+, %d5
move.l %d5, -(%a7)
jsr value
jsr cr
move.l (%a7)+, %d5
sub.l #1, %d4
cmp.l #0,%d4
bne nextvalue
jsr cr

clr.l %d5
pea End2   /**/
jsr iprintf
addq.l #4,%a7
move.l (%a3)+, %d5
move.l %d5, -(%a7)
jsr value
addq.l #4,%a7
jsr cr

clr.l %d5
pea End3   /**/
jsr iprintf
addq.l #4,%a7
move.l (%a3)+, %d5
move.l %d5, -(%a7)
jsr value
addq.l #4,%a7
jsr cr

clr.l %d5
pea End4   /**/
jsr iprintf
addq.l #4,%a7
move.l (%a3)+, %d5
move.l %d5, -(%a7)
jsr value
addq.l #4,%a7
jsr cr

pea End5   /**/
jsr iprintf
addq.l #4,%a7
move.l %d6, -(%a7)
jsr value
addq.l #4,%a7

pea End6   /**/
jsr iprintf
addq.l #4,%a7
move.l %d3, -(%a7)
jsr value
addq.l #4,%a7
jsr cr

clr.l %d5
pea End7   /**/
jsr iprintf
addq.l #4,%a7
nextdiv:
move.l (%a3)+, %d5
move.l %d5, -(%a7)
jsr value
move.l (%a7)+, %d5

pea End8   /**/
jsr iprintf
addq.l #4,%a7

sub.l #1, %d7
cmp.l #0,%d7
bne nextdiv
jsr cr

pea End9   /**/
jsr iprintf
addq.l #4,%a7

movem.l (%a7),%d2-%d7/%a2-%a5
lea      40(%a7),%a7
rts

/*End of Subroutine **************************************************/ 
.data
/*All Strings placed here **************************************************/
numberentry:
.string "The number of values entered were "
End1:
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
