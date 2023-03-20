;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_355) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
(define-struct add [left right])
(define-struct mul [left right])

; A BSL-var-expr is one of: 
; – Number
; – Symbol 
; – (make-add BSL-var-expr BSL-var-expr)
; – (make-mul BSL-var-expr BSL-var-expr)

(define ERROR "Can't evaluate given expression")

; An AL (short for association list) is [List-of Association].
; An Association is a list of two items:
;   (cons Symbol (cons Number '())).

(define lal '((k 0) (x 4) (y 7) (z 10)))

; BSL-expr -> Number
; consumes a representation of a BSL expression and computes its value
(check-expect (eval-var-lookup 3 lal) 3)
(check-expect (eval-var-lookup (make-add 1 1) lal) 2)
(check-expect (eval-var-lookup (make-mul 3 10) lal) 30)
(check-expect (eval-var-lookup (make-add (make-mul 1 1) 10) lal) 11)
(check-expect (eval-var-lookup 'x lal) 4)
(check-expect (eval-var-lookup (make-add 'x 3) lal) 7)
(check-expect (eval-var-lookup (make-add (make-mul 'x 'x) (make-mul 'y 'y)) lal) 65)
(check-expect (eval-var-lookup (make-add (make-mul 'x 'x) (make-mul 'y 'y))
                              '((x 2) (y 3))) 13)
(check-expect (eval-var-lookup (make-add (make-mul 'z 'z) (make-mul 'k 'k)) lal) 100)
(check-error (eval-var-lookup (make-add (make-mul 'z 'z) (make-mul 'k 'k)) '((x 2) (y 3))) ERROR)
(define (eval-var-lookup expr da)
  (cond
    [(number? expr) expr]
    [(symbol? expr) (local ((define assoc (assq expr da)))
                      (if (list? assoc)
                          (second assoc)
                          (error ERROR)))]
    [(add? expr) (+ (eval-var-lookup (add-left expr) da)
                    (eval-var-lookup (add-right expr) da))]
    [(mul? expr) (* (eval-var-lookup (mul-left expr) da)
                    (eval-var-lookup (mul-right expr) da))]))