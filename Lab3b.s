/* DO NOT MODIFY THIS --------------------------------------------*/
.text
.global Stats
.extern iprintf
.extern cr
.extern value
.extern getstring
/*----------------------------------------------------------------*/

/******************************************************************/
/* General Information ********************************************/
/* File Name: Lab3b.s **************************************/
/* Names of Students: _________________ and ____________________ **/
/* Date: _________________                                       **/
/* General Description:                                          **/
/*                                                               **/
/******************************************************************/
Stats:
/*Write your program here******************************************/
move.l 4(%sp), %d5 /* Divisor is implied by %d5*/
move.l 8(%sp), %d7 /* Number of entries is implied by %d7 will be the counter */

/* Preservation of register contents on top of the stack and */
/* pointer assignment for the memory location 0x2300000 */
sub.l #40, %sp
movem.l %d2-%d7/%a2-%a5, (%sp)
clr %d4	

move.l 48(%sp), %d7/*Counter MinMax*/
move.l %a2, %a4	/*Copy array pointer*/
move.l (%a4), %d2 /*Min*/
move.l (%a4), %d3/*Max*/

MinMax:
cmp.l 4(%a4), %d2
blt Min
move.l 4(%a4), %d2
Min:
cmp.l 4(%a4), %d3
bgt Max
move.l 4(%a4), %d3
Max:
subq.l #1, %d7
addq.l #4, %a4
cmp.l #1, %d7
bgt MinMax

move.l %d2, (%a3)+			
move.l %d3, (%a3)+			

move.l 48(%sp), %d7			
move.l %a2, %a4				
clr %d2						

Mean:
add.l (%a4)+, %d2
subq.l #1, %d7
tst %d7
bne Mean
divu.l 48(%sp), %d2
move.w #0, (%a3)+
move.w %d2, (%a3)+			


move.l 48(%sp), %d7			
move.l %a2, %a4				
clr %d2						

Divisor:
tst %d7
beq End
subq.l #1, %d7

move.l (%a4)+, %d2
divu.w 46(%sp), %d2
swap %d2
tst.w %d2
bne Divisor
move.l -4(%a4), (%a3)+
addq.l #1, %d4
bra Divisor

End:

move.l %d4, 52(%sp)
movem.l (%sp), %d2-%d7/%a2-%a5
add.l #40, %sp

rts 

/*End of Subroutine **************************************************/ 
.data
/*All Strings placed here **************************************************/



/*End of Strings **************************************************/
