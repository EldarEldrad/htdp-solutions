;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_160) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; A Son.L is one of: 
; – empty 
; – (cons Number Son.L)
		
; A Son.R is one of: 
; – empty 
; – (cons Number Son.R)

; Constraint If s is a Son.R, 
; no number occurs twice in s

; Son is used when it 
; applies to Son.L and Son.R

; Number Son.L -> Son.L
; adds a numbe to given set
(check-expect (set+.L 5 '()) (cons 5 '()))
(check-expect (set+.L 3 '()) (cons 3 '()))
(check-expect (set+.L 5 (cons 3 '())) (cons 5 (cons 3 '())))
(check-expect (set+.L 5 (cons 5 '())) (cons 5 (cons 5 '())))
(check-expect (set+.L -1 (cons 5 (cons 3 '()))) (cons -1 (cons 5 (cons 3 '()))))
(check-expect (set+.L 5 (cons 5 (cons 3 '()))) (cons 5 (cons 5 (cons 3 '()))))
(check-expect (set+.L 3 (cons 5 (cons 3 '()))) (cons 3 (cons 5 (cons 3 '()))))
(define (set+.L x s)
  (cons x s))

; Number Son.R -> Son.R
; adds a numbe to given set
(check-expect (set+.R 5 '()) (cons 5 '()))
(check-expect (set+.R 3 '()) (cons 3 '()))
(check-expect (set+.R 5 (cons 3 '())) (cons 5 (cons 3 '())))
(check-expect (set+.R 5 (cons 5 '())) (cons 5 '()))
(check-expect (set+.R -1 (cons 5 (cons 3 '()))) (cons -1 (cons 5 (cons 3 '()))))
(check-expect (set+.R 5 (cons 5 (cons 3 '()))) (cons 5 (cons 3 '())))
(check-expect (set+.R 3 (cons 5 (cons 3 '()))) (cons 5 (cons 3 '())))
(define (set+.R x s)
  (if (member? x s) s
      (cons x s)))