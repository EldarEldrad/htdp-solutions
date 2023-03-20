;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_152) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
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