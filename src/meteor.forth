( METEOR )

: GR 8 * 11263 + DUP 8 + DO I C! -1 + LOOP ;
: SHIP 40 124 84 124 254 186 146 0 1 GR ;
: METEOR 28 62 127 255 255 254 124 56 2 GR ;

( Once the preceding lines have been entered, free up some memory )

FORGET GR

( Then initialize some variables before entering the main program )

15 VARIABLE X
 3 VARIABLE L
 0 VARIABLE S	

( And now the main program )

: POINT AT 152388 @ C@ ;
: MOVE INKEY DUP 53 = IF x @ 1- x ! THEN 56 = IF x @ 1+ x THEN ;
: END 10 10 AT ." SCORE:"S @ . BEGIN 100 AND 20 + 50 BEEP 0 UNTIL ;
: SHIP 0 x @ POINT 2 = IF L @ 1- DUP L ! 0= IF END THEN 300 300
  BEEP 200 150 BEEP 250 150 BEEP 300 300 BEEP 400 700 BEEP CLS
  THEN I EMIT ;
: UFO 22 32 RND AT 2 EMIT CR CR ;
: SET 3 L ! 0 S ! 15 x ! CLS ;
: GAME SET BEGIN MOVE SHIP 1000 20 BEEP S @ 1+ S ! UFO 0 UNTIL ;
