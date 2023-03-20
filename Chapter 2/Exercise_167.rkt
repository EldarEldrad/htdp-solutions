;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_167) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; List-of-posns -> Number
; consumes a list of Posns and produces the sum of all of its x-coordinates
(check-expect (sum '()) 0)
(check-expect (sum (cons (make-posn 1 2) '())) 1)
(check-expect (sum (cons (make-posn -3 0) (cons (make-posn 3 5) '()))) 0)
(check-expect (sum (cons (make-posn 2 6) (cons (make-posn -3 -1) '()))) -1)
(define (sum lop)
  (cond
    [(empty? lop) 0]
    [else
     (+ (posn-x (first lop))
        (sum (rest lop)))]))