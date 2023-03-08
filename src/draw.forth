( DRAW )
( by Simon Cross )
( https://www.jupiter-ace.co.uk/listing_YC_feb_83_121.html )

( Comments must be omitted when typing in the program           )
( on an unexpanded Ace.                                         )

( DRAWING PICTURES on the television screen may not be new, but )
( this program is written in Forth to run on the Jupiter Ace so )
( it has a different structure to Basic drawing programs. The   )
( program enables straight and diagonal lines to be drawn and   )
( rubbed out on the screen.                                     )

( Load the program from the cassette by entering "load drawer"  )
( The program may then run by entering "drawer"                 )

( The keys around the G key control flashing cursor as shown    )
( in the diagram below:                                         )
(       R   T   Y                                               )
(       F   G   H                                               )
(       V   B   N                                               )

( If T, H, B, and F are North, East, South and West             )
( respectively, then R, Y, N and V are NW, NE,SE, and SW. The   )
( cursor may be switched between drawing and rubbing out modes  )
( by pressing O.                                                )

( This program uses the plot function on the Ace. This function )
( requires three numbers on the stack, the X co-ordinate, the Y )
( co-ordinate and the Plotting mode. The other words in the     )
( program test to see if any of the keys specified have been    )
( pressed and alter the values of X,Y, and the Colour           )
( appropriately. One interesting aspect is the method of        )
( testing to see if a key has been pressed and then leaving the )
( result as a flag on the stack. The position of the cursor is  )
( then tested to see if movement in the desired direction will  )
( take it off the edge of the screen; this result is also saved )
( on the stack. The flags on the stack are then tested using    )
( the And function, if true, then the X and Y co-ordinates are  )
( changed accordingly.)

0 variable x
0 variable y
0 variable colour

: x+ x @ 1+ x ! ;
: x- x @ 1- x ! ;
: y+ y @ 1+ y ! ;
: y- y @ 1- y ! ;

: up inkey 116 = y @ 45 < and if y+ then ;
: down inkey 98 = y @ 0> and if y- then ;
: right inkey 104 = x @ 63 < and if x+ then ;
: left inkey 102 = x @ 0> and if x- then ;

: diag1 inkey 114 = x @ 0> y @ 45 < and and if x- y+ then ;
: diag2 inkey 118 = x @ 0> y @ 0> and and if x- y- then ;
: diag3 inkey 121 = x @ 63 < y @ 45 < and and if x+ y+ then ;
: diag4 inkey 110 = x @ 63 < y @ 0> and and if x+ y- then ;

: change colour @ if 0 colour ! else 1 colour ! then ;
: colour? inkey = 48 if change 50 200 beep then ;
: input? colour? up down right left diag1 diag2 diag3 diag4 ;
: zero cls 21 y ! 31 x ! 0 colour ! ;
: draw x @ y @ colour @ plot ;
: flash change 250 0 do loop ;

: drawer zero begin input? draw flash draw flash 0 until ;