;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_149) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; N String -> List-of-strings 
; creates a list of n copies of s
(check-expect (copier 0 "hello") '())
(check-expect (copier 2 "hello")
              (cons "hello" (cons "hello" '())))
(check-expect (copier 3 #false)
              (cons #false (cons #false (cons #false '()))))
(check-expect (copier 1 (circle 6 "solid" "green"))
              (cons (circle 6 "solid" "green") '()))
(define (copier n s)
  (cond
    [(zero? n) '()]
    [(positive? n) (cons s (copier (sub1 n) s))]))

; N String -> List-of-strings 
; creates a list of n copies of s
(check-expect (copier.v2 0 "hello") '())
(check-expect (copier.v2 2 "hello")
              (cons "hello" (cons "hello" '())))
(check-expect (copier.v2 3 #false)
              (cons #false (cons #false (cons #false '()))))
(check-expect (copier.v2 1 (circle 6 "solid" "green"))
              (cons (circle 6 "solid" "green") '()))
(define (copier.v2 n s)
  (cond
    [(zero? n) '()]
    [else (cons s (copier.v2 (sub1 n) s))]))

; for 0.1 and "x" as arguments:
; copier produces error (no approriate clause for cond exists)
; copier.v2 goes infinite loop