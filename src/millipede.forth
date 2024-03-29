( This program requires a RAM expansion )

0 variable seed
0 variable a
0 variable b
0 variable g
0 variable h
0 variable m
0 variable p
0 variable s 

: setup 7 a ! 23 b ! 0 g ! 0 m ! 15 p ! 0 s ! ;
: long-delay 20000 0 do loop ;
: short-delay 200 0 do loop ;
: 2dup over over ;
: print at ." MILLIPEDE" ; 

: right 23 0 do i dup print loop ;
: centre 23 0 do i 11 print loop ;
: left 23 0 do i dup 22 swap - print loop ;

: title 10 0 do cls right short-delay cls centre short-delay
  cls left short-delay loop cls centre ;
  
: hi-sound 30 100 beep ; 
: low-sound 60 100 beep ; 
: pause begin inkey until hi-sound low-sound ;
: hardness cls cr cr ." Enter the hardness level (2-10)" cr
  query line dup dup 11 < swap 1 > and if h ! 1000 0 do loop
  else drop hardness then ;	 
  
: instructions cls ." Hit any key to continue" cr cr
  ." Guzzle down the bugs" cr cr
  ." Without hitting the walls" cr cr
  ." Left 'Z'" 8 spaces ." Right 'M'" cr pause ; 
  
: mil 60 189 102 165 102 165 126 60 1 ;	
: bug 24 60 153 126 60 255 60 219 2 ; 
: graph 8 * 11263 + dup 8 + do i c! -1 +loop ; 
: def-graph mil graph bug graph ; 
: wall-print 20 dup a @ at 46 emit b @ at 46 emit ;
: randomise seed @ 75 u* 75 0 d+ 2dup u< - - 1- dup seed ! ; 
: rnd randomise u* swap drop ;

: bug-print 10 rnd 1+ 9 > if 20 a @ dup b @ swap
  - 2 / + at 2 emit then ;
  
: screen-peek at 15388 @ c@ ;
: millipede ; 

: once-more cls ." DO YOU WANT TO PLAY AGAIN" cr
  begin inkey ?dup until dup 121 = if drop millipede else 110 =
  if cls cr cr ." Bye for now" cr long-delay abort
  else once-more then then ;
  
: endit cls 9 0 do ." YOU SNUBBED YOUR NOSE ON THE" cr
  ." TUNNEL WALL" cr loop long-delay cls 6 0 at
  ." You scored " s @ 10 / dup . ." points." cr cr
  ." You ate " g @ dup . ." grubs" cr cr
  ." That's " + . ." in total" long-delay once-more ;
  
: check-out screen-peek 46 = if endit then ; 
: nose-snub 15 p @ check-out 16 p @ check-out ;	
: g+ g @ 1+ g ! ; 
: eat-bug 16 p @ screen-peek 32 = 0= if g+ low-sound hi-sound then ;
: mil-print 15 p @ at 1 emit ; 
: scroll 22 31 at 32 emit cr ; 
: supdate s @ 1+ s ! ; 
: mupdate h @ dup rnd swap 2 / - ?dup if 3 rnd + m ! else mupdate then ; 
: aupdate a @ dup -1 > if m @ + then a ! ;
: bupdate b @ dup 31 < if m @ + then b ! ;
: a2update a @ dup 1 < if m @ abs + a ! b @ m @ abs + b ! else drop then ;
: b2update b @ dup 28 > if m @ abs - b ! a @ m @ abs - a ! else drop then ;
: update supdate mupdate aupdate bupdate a2update b2update ;
: mil-clear 15 p @ at 32 emit ;

: getkey inkey dup 122 = if drop p @ 1- p !
  else 109 = if p @ 1+ p ! then then ;
  
: millipede setup title hardness instructions def-graph begin
  wall-print bug-print nose-snub eat-bug mil-print scroll
  update mil-clear getkey 0 until ;
  
redefine millipede
