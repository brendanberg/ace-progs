( ACE AVOIDER )
( by John Sinyard )
( https://www.jupiter-ace.co.uk/listing_AceAvoider.html )

( Comments must be omitted when typing in the program               )
( on an unexpanded Ace.                                             )

DECIMAL                     ( all numbers are in decimal            )

CREATE MC                   ( - )
                            ( machine code routines for scrolling   )
                            ( the screen excluding the top line     )
 17 C, 9951 ,               ( LD DE 9951 )   ( scroll right routine )
 33 C. 9950 ,               ( LD HL 9950 )
  1 C, 672  ,               ( LD BC 672  )
237 C, 184 C,               ( LDDR       )
253 C, 233 C,               ( JP[IY]     )
 17 C, 9951 ,               ( LD DE 9951 )   ( scroll down routine  )
 33 C, 9919 ,               ( LD HL 9919 )
  1 C, 672 ,                ( LD BC 672  )
237 C, 184 C,               ( LDDR       )
253 C, 233 C,               ( JP[IY]     )
 17 C, 9280 ,               ( LD DS 9280 )   ( scroll left routine  )
 33 C, 9281 ,               ( LD HL 9281 )
  1 C; 672 ,                ( LD BC 672  )
237 C, 176 C,               ( LDIR       )
253 C, 233 C,               ( JP[IY]     )
 17 C, 9280 ,               ( LD DE 9280 )   ( scroll up routine    )
 33 C, 9312 ,               ( LD HL 9312 )
  1 C,  672 ,               ( LD BC 672  )
237 C, 176 C,               ( LDIR       )
253 C, 233 C,               ( JP[IY]     )


0 VARIABLE S                ( score                                 )
0 VARIABLE W                ( wave                                  )
0 VARIABLE SD               ( used for generating random numbers    )
0 VARIABLE P                ( crafts position in screen memory      )

: RP                        ( charactor - )
                            ( pokes a jewelite/prang randomly       )
                            ( on to the screen                      )
  BEGIN
    474                     ( number of available positions         )
    SD @ 75 U* 75 0 D+      (                                       )
    OVER OVER U< - - 1-     (  RND as in the manual                 )
    DUP SD ! U* SWAP DROP   (                                       )
    9280 + DUP C@ 32 >      ( forms random address and checks       )
  WHILE                     ( that it is not poking onto already    )
    DROP                    ( exsisting jewelite/prang/craft        )
  REPEAT
  C!
;


: D?                        ( direction - )
                            ( advances craft in direction           )
                            ( only if within the borders of         )
                            ( the screen                            )
  DUP P @ + DUP P !         ( forms new address and stores it       )
  DUP 9312 < OVER           ( in P, then checks if it is within     )
  9919 > OR OVER 32 MOD     ( the borders of the screen             )
  DUP 0= SWAP 31 = OR OR
  IF  
    - ABS P !               ( if on borders then restore            )
  ELSE                      ( original value to P                   )
    DROP DROP               ( else retain new value of P            )
  THEN
;
    

: S?                        ( charactor - )
                            ( if craft has encountered a            )
                            ( jewelite [ 42 = ASCII of * ,          )
                            ( the jewelite ] then increment score   )
                            ( and clear that place on screen        )
  42 =
  IF    
    S @ 1+ S ! 32 P @ C! 
  THEN
;

: K?                        ( - )
                            ( checks if a direction key has         )
                            ( been pressed, and if so then          )
                            ( sends direction vector to D? for      )
                            ( validation checks                     )
  INKEY ?DUP
  IF
    DUP 53 =
    IF
      -1 D?                 ( Left    )
    THEN
    DUP 54 =
    IF
      -32 D?                ( Up      )
    THEN
    DUP 55 =
    IF
      32 D?                 ( Down    )
    THEN
    56 =
    IF
      1 D?                  ( Right   )
    THEN
    ELSE
      20 10 BEEP            ( balances the time delay of key        )
  THEN                      ( checks if no key has been pressed     )
; 

: MV                        ( - )
                            ( initiates the screen : then           )
                            ( prints the status, controls the       )
                            ( scrolling of the screen, checks       )
                            ( for collisions with craft : until     )
                            ( all jewelites are taken or            )
                            ( collision with a prang                )
  BEGIN
    CLS S @ -1              ( stacks initial score and starts       )
                            ( a counter                             )
    79 9584 DUP P ! C!      ( resets craft into centre of the       )
                            ( screen                                )
    W @ 1+ DUP W !          ( wave number [* 2 ] determines         )
    2 * 0                   ( the density of the clouds             )
    DO
      88 RP 42 RP           ( 88 = ASCII of X , the prangs          )
    LOOP                    ( 42 = ASCII of * , the jewelites       )
    100 2000 BEEP           ( GET READY ! )
    BEGIN
      9216 15388 !          ( this is faster than 0 0 AT            )
      ." SCORE= " S @ .
      ."   LIVES= " I' .    ( I' fetches the loop counter of        )
      ."   WAVE= " W @ .    ( the 'lives' DO-LOOP within RUN        )
                            ( from the return stack underneath      )
                            ( the return address for RUN            )
      32 P @ C!             ( enables movement of craft/screen      )
      K?
      P @ C@ DUP 88 =       ( collision of craft with a prang       )
      IF                    ( causes return to RUN so               )
        EXIT                ( decrementing the 'lives' loop         )
      THEN                  ( counter, second C@ used by S? ,       )
      S?                    ( else dropped on return to RUN         )
      1+                    ( increment the counter                 )
      DUP 24 MOD 6 /        ( equation for deriving from the        )
      13 * MC + CALL        ( counter the order in which the        )
                            ( machine code screen scrolling         )
                            ( routines are called, producing        )
                            ( a 6x6 square of rotation              )
      P @ C@ DUP 88 =
      IF
        EXIT                ( same as before )
      THEN
      S?
      79 P @ C! 20 5 BEEP   ( pokes the craft onto the screen,      )
                            ( 79 = ASCII of 0 , the craft, the      )
                            ( beep provides a delay before it       )
                            ( is cleared                            )
      OVER DUP              ( initial score to top of stack         )
      S @ = 0=              ( 1 flag if initial and new scores      )
                            ( are different                         )
      SWAP S @ - W @        ( 1 flag if waves2 modulus of           )
      2 * MOD 0=            ( jewelites eaten this wave =0          )
      AND                   ( all jewelites must be eaten to        )
    UNTIL                   ( procede                               )
    DROP DROP               ( drops initial score and counter       )
    50 1000 BEEP 0          ( WELL DONE ! )
  UNTIL
;

: RUN                       ( - )
                            ( the word to run the complete game     )
  0 S 0 ! 0 W !
  0 5
  DO                        ( the 'lives' DO—LOOP )
    MV    
    DROP DROP DROP          ( drop the C@, counter and initial      )
    207 P @ C!              ( score stacked within MV               )
    500 2000 BEEP 1         ( OOPS ! )
  +LOOP  
  700 2000 BEEP             ( OH DEAR ! )
;
