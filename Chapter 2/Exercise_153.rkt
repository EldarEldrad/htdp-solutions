;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_153) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
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