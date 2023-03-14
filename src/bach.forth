200 variable beat

definer note , does> @ beat @ beep ;

478 note c4
451 note c#4
426 note d4
402 note d#4
379 note e4
358 note f4
338 note f#4
319 note g4
301 note g#4
284 note a4
268 note a#4
253 note b4
239 note c5
225 note c#5
213 note d5
201 note d#5
190 note e5
179 note f5
169 note f#5
159 note g5
150 note g#5
142 note a5
134 note a#5
127 note b5
119 note c6

: cmaj
  c4 d4 e4 f4 g4 a4 b4 c5
;

:chrom
  C4 C#4 d4 d#4 e4 f4 f#4 g4 g#4 a4 a#4 b4 c5
;

: blues
  c4 d#4 f4 f#4 g4 a#4 c5
;

: part1
  f4 g4 a4 c5 a#4 a#4 d5 c5 c5 f5 e5 f5 c5 a4 f4 g4 a4
;

: part2
  part1 a#4 c5 d5 c5 a#4 a4 g4 a4 f4 e4 f4 g4 c4 e4 g4 a#4 a4 g4
;

: part3
  part2 a4
  part1 d4 c5 a#4 a4 g4 f4 c4 f4 e4 f4 a4 c5 f5 c5 a4 f4 a4 c5
;

: bach
  part3 179 beat @ 3 * beep
;
