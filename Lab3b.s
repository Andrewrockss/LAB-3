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
suba.l #60, %sp
movem.l %a0-%a6/%d0-%d7, (%sp)

movea.l %a2, %a3 /* Copy the contents of %a2 to %a3 */

/* current min will be stored in a3*/
min:
  cmp.l %a2, %a3
  bge greater
  ble lesser

greater: add.l #4, %a2
         sub #1 %d7
         cmp.l #0, %d7
         bge min
         ble store
         

lesser: move %a2, %a3
        add.l #4, %a2
        sub #1 %d7
        cmp.l #0, %d7
        bge min


store: add.l #4, %a3
        sub.l 4*d7, %a2
/* current max will be stored in a3*/
max:
  cmp.l %a2, %a3
  bge greater
  ble lesser

greater: add.l #4, %a2
         sub #1 %d7
         cmp.l #0, %d7
         bge min
         ble store
         

lesser: move %a2, %a3
        add.l #4, %a2
        sub #1 %d7
        cmp.l #0, %d7
        bge min




Next_Round: move.l %a3, %a2
		    sub.l #1, %d7 /* "Round" counter */
            beq Lab_3c
            move.l %d7, %d6 /* "Pass" counter */

            move.l (%a2)+, %d3
            move.l (%a2), %d4

/* Compare two successive numbers in the array */
Compare: cmp.l %d3, %d4
         bge Do_Not_Switch
       /*bra Switch_With_Next_Position*/

/* Sort the numbers in the array in ascending order */
Switch_With_Next_Position: move.l %d4, -4(%a2)
                           move.l %d3, (%a2)+
                           move.l (%a2), %d4
                           sub.l #1, %d6
                           cmp.l #0, %d6
                           beq Next_Round
                           bra Compare
Do_Not_Switch: move.l (%a2)+, %d3
               move.l (%a2), %d4
               sub.l #1, %d6
               cmp.l #0, %d6
               beq Next_Round
               bra Compare


rts 

/*End of Subroutine **************************************************/ 
.data
/*All Strings placed here **************************************************/



/*End of Strings **************************************************/
