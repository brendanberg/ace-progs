( BREAKOUT )

: YOUMOVE
  INKEY
  IF
    5 ROLL DUP 21 SWAP 
    AT 2 SPACES MOVE DUP 
    21 SWAP AT ." (GRAPHIC 
    3 GRAPHIC 3)"
    5 ROLL 5 ROLL 5 
    ROLL 5 ROLL 
  ELSE
    50 0 
    DO 
    LOOP 
  THEN 
;

: CHECK
  DUP 9913 >
  IF
    32 SWAP C! 9246 C@ 
    DUP ASCII 0 =
    IF 
      ABORT 
    ELSE
      1- 9246 C! 9505 15403 
      C@ 1 AND +
    THEN 
  THEN
;

: BALLDRAW 
  DUP C@ 160 = 
  IF
    ROT NEGATE ROT ROT 4 
    ROLL 1+ 0 8 AT
    DUP . 4 ROLL 4 
    ROLL 4 ROLL 
  THEN
  79 OVER C! 
;
400 VARIABLE S 

: DRAW
  CLS 0 1 AT ." Score: 0 
          Balls: 5"
  4 0 AT 32 5 * 0 
  DO
  ." (INVERSE SPACE)" 
  LOOP
  1 0 AT ." (GRAPHIC 4)" 
  30 0
  DO
  ." (INVERSE GRAPHIC 3)" 
  LOOP
  ." (INVERSE GRAPHIC 7)" 
  23 2
  DO
  I 0 AT . " (GRAPHIC 5)"