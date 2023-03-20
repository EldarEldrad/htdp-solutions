;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_159) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; N Image -> Image
; produces a column of n copies of given image
(check-expect (col 0 (square 5 "solid" "red")) (empty-scene 0 0))
(check-expect (col 1 (square 5 "solid" "red")) (square 5 "solid" "red"))
(check-expect (col 1 (circle 3 "solid" "green")) (circle 3 "solid" "green"))
(check-expect (col 2 (circle 3 "solid" "green"))
              (above (circle 3 "solid" "green") (circle 3 "solid" "green")))
(check-expect (col 3 (square 5 "solid" "red"))
              (above (square 5 "solid" "red") (above (square 5 "solid" "red") (square 5 "solid" "red"))))
(define (col n i)
  (cond
    [(= n 0) (empty-scene 0 0)]
    [(= n 1) i]
    [else (above i (col (sub1 n) i))]))

; N Image -> Image
; produces a row of n copies of given image
(check-expect (row 0 (square 5 "solid" "red")) (empty-scene 0 0))
(check-expect (row 1 (square 5 "solid" "red")) (square 5 "solid" "red"))
(check-expect (row 1 (circle 3 "solid" "green")) (circle 3 "solid" "green"))
(check-expect (row 2 (circle 3 "solid" "green"))
              (beside (circle 3 "solid" "green") (circle 3 "solid" "green")))
(check-expect (row 3 (square 5 "solid" "red"))
              (beside (square 5 "solid" "red") (beside (square 5 "solid" "red") (square 5 "solid" "red"))))
(define (row n i)
  (cond
    [(= n 0) (empty-scene 0 0)]
    [(= n 1) i]
    [else (beside i (row (sub1 n) i))]))

(define SIZE 10)
(define COLUMNS 10)
(define ROWS 20)

(define CLASSROOM (overlay (col ROWS (row COLUMNS (square SIZE "outline" "black")))
                               (empty-scene (* SIZE COLUMNS) (* SIZE ROWS))))
(define DOT (circle (/ SIZE 4) "solid" "red"))

(define-struct pair [balloon# lob])
; A Pair is a structure (make-pair N List-of-posns)
; A List-of-posns is one of: 
; – '()
; – (cons Posn List-of-posns)
; interpretation (make-pair n lob) means n balloons 
; must yet be thrown and added to lob

; Pair -> Image
; produces an image according to given pair
(check-expect (to-image (make-pair 5 '())) CLASSROOM)
(check-expect (to-image (make-pair 0 '())) CLASSROOM)
(check-expect (to-image (make-pair 4 (cons (make-posn 1 2) '()))) (place-image DOT SIZE (* 2 SIZE) CLASSROOM))
(check-expect (to-image (make-pair 1 (cons (make-posn 1 2) (cons (make-posn 6 3) '()))))
              (place-image DOT SIZE (* 2 SIZE) (place-image DOT (* 6 SIZE) (* 3 SIZE) CLASSROOM)))
(check-expect (to-image (make-pair 0
                                   (cons (make-posn 0 5) (cons (make-posn 1 2) (cons (make-posn 6 3) '())))))
              (place-image DOT 0 (* 5 SIZE)
                           (place-image DOT SIZE (* 2 SIZE) (place-image DOT (* 6 SIZE) (* 3 SIZE) CLASSROOM))))
(define (to-image p)
  (add-balloons (pair-lob p)))

; List-of-posns -> Image
; produces an image of the lecture hall with red dots added as specified by the Posns
(check-expect (add-balloons '()) CLASSROOM)
(check-expect (add-balloons (cons (make-posn 1 2) '())) (place-image DOT SIZE (* 2 SIZE) CLASSROOM))
(check-expect (add-balloons (cons (make-posn 1 2) (cons (make-posn 6 3) '())))
              (place-image DOT SIZE (* 2 SIZE) (place-image DOT (* 6 SIZE) (* 3 SIZE) CLASSROOM)))
(check-expect (add-balloons (cons (make-posn 0 5) (cons (make-posn 1 2) (cons (make-posn 6 3) '()))))
              (place-image DOT 0 (* 5 SIZE)
                           (place-image DOT SIZE (* 2 SIZE) (place-image DOT (* 6 SIZE) (* 3 SIZE) CLASSROOM))))
(define (add-balloons lop)
  (cond
    [(empty? lop) CLASSROOM]
    [else (place-image DOT
                       (* SIZE (posn-x (first lop)))
                       (* SIZE (posn-y (first lop)))
                       (add-balloons (rest lop)))]))

; Pair -> Pair
; adds new Posn to balloon hit list in given pair
(check-random (tock (make-pair 1 '())) (make-pair 0 (cons (make-posn (random COLUMNS) (random ROWS)) '())))
(check-random (tock (make-pair 5 '())) (make-pair 4 (cons (make-posn (random COLUMNS) (random ROWS)) '())))
(check-random (tock (make-pair 1 (cons (make-posn 5 6) '())))
              (make-pair 0 (cons (make-posn (random COLUMNS) (random ROWS)) (cons (make-posn 5 6) '()))))
(check-random (tock (make-pair 9 (cons (make-posn 5 6) '())))
              (make-pair 8 (cons (make-posn (random COLUMNS) (random ROWS)) (cons (make-posn 5 6) '()))))
(define (tock p)
  (make-pair (sub1 (pair-balloon# p))
             (cons (make-posn (random COLUMNS) (random ROWS))
                   (pair-lob p))))

; Pair -> Boolean
; returns #true if no more balloons should hit anything
(check-expect (no-more-balloons? (make-pair 0 '())) #true)
(check-expect (no-more-balloons? (make-pair 3 '())) #false)
(check-random (no-more-balloons? (make-pair 0 (cons (make-posn 5 6) '()))) #true)
(check-random (no-more-balloons? (make-pair 9 (cons (make-posn 5 6) '()))) #false)
(define (no-more-balloons? p)
  (zero? (pair-balloon# p)))

; Number -> List-of-posns
; consumes how many balloons the students want to throw, shows visualization
; and returns the list of Posns where the balloons hit
(define (riot n)
  (pair-lob
   (big-bang (make-pair n '())
     [on-tick tock 1]
     [to-draw to-image]
     [stop-when no-more-balloons? to-image])))

(riot 5)