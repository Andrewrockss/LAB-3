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

move.l 48(%sp), %d7    /*Counter MinMax*/
move.l %a2, %a4      	/*Copy array pointer*/
move.l (%a4), %d2     /*Min inital*/
move.l (%a4), %d3     /*Max inital*/

MinMax:        /*Min,Max* calculation*/
cmp.l 4(%a4), %d2    /*compare the next value stored to the current min*/
blt Min               /*if next value is less than current min branch to min*/
move.l 4(%a4), %d2      /*if not min put value in d2*/

Min:
cmp.l 4(%a4), %d3    /*compare the next value stored to the current max*/
bgt Max              /*if next value is greater than current max branch to max*/
move.l 4(%a4), %d3  /*move value to d3*/

Max:
subq.l #1, %d7   /*subtract from counter*/
addq.l #4, %a4    /*increment entery being checked*/
cmp.l #1, %d7   /*go to next number if counter is not zero*/
bgt MinMax    


move.l %d2, (%a3)+			/*result of mix and max gose into a3*/
move.l %d3, (%a3)+			

move.l 48(%sp), %d7			 /*Counter once agian*/
move.l %a2, %a4				/*result of mix and max gose into a4*/
clr %d2						  /*clearing d2*/

Mean:
add.l (%a4)+, %d2  /*adding all the enterys adn stroring reult into d2*/
subq.l #1, %d7 /*minus from the counter */
tst %d7    /*comparing counter with zero*/
bne Mean  /*go to Mean if counter is not zero*/

divu.l 48(%sp), %d2  /*divide d2 but the total number of enteries */
move.w #0, (%a3)+    /*clear world length */
move.w %d2, (%a3)+			/*store answer in a3*/


move.l 48(%sp), %d7			/*Counter once agian*/
move.l %a2, %a4				/*Copy array pointer*/
clr %d2						/*Clearing d2*/

Divisor:
tst %d7   /*Comparison with zero*/
beq End   /*end if counter is zero*/
subq.l #1, %d7   /*decresed the counter*/

move.l (%a4)+, %d2    /*move fist value to d2*/
divu.w 46(%sp), %d2    /*divide it by the divisor*/
swap %d2        /*swap upper and lower halves*/
tst.w %d2     /*Comparison with zero*/
bne Divisor      /*do agian if not equal to zer0*/
move.l -4(%a4), (%a3)+ /*divisable if equal to zero, move answer to a3*/
addq.l #1, %d4   /*add one to indicate how many are divisable*/
bra Divisor     /*check the next value*/

End:  

move.l %d4, 52(%sp)   /*how many divisable enteries*/
movem.l (%sp), %d2-%d7/%a2-%a5   /*restore all the used registers*/ 
add.l #40, %sp      /*clean up the stack*/


rts    /*return from the stack, and pop the value of the return addresss*/ 

/*End of Subroutine **************************************************/ 
.data
/*All Strings placed here **************************************************/



/*End of Strings **************************************************/
