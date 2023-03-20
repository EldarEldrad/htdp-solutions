;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_354) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
(define-struct add [left right])
(define-struct mul [left right])

; A BSL-var-expr is one of: 
; – Number
; – Symbol 
; – (make-add BSL-var-expr BSL-var-expr)
; – (make-mul BSL-var-expr BSL-var-expr)

(define ERROR "Can't evaluate given expression")

; BSL-expr -> Number
; consumes a representation of a BSL expression and computes its value
(check-expect (eval-variable 3) 3)
(check-expect (eval-variable (make-add 1 1)) 2)
(check-expect (eval-variable (make-mul 3 10)) 30)
(check-expect (eval-variable (make-add (make-mul 1 1) 10)) 11)
(check-error (eval-variable 'x) ERROR)
(check-error (eval-variable (make-add 'x 3)) ERROR)
(check-error (eval-variable (make-add (make-mul 'x 'x) (make-mul 'y 'y))) ERROR)
(define (eval-variable expr)
  (cond
    [(number? expr) expr]
    [(symbol? expr) (error ERROR)]
    [(add? expr) (+ (eval-variable (add-left expr))
                    (eval-variable (add-right expr)))]
    [(mul? expr) (* (eval-variable (mul-left expr))
                    (eval-variable (mul-right expr)))]))

; An AL (short for association list) is [List-of Association].
; An Association is a list of two items:
;   (cons Symbol (cons Number '())).

(define lal '((k 0) (x 4) (y 7) (z 10)))

; BSL-expr -> Number
; consumes a representation of a BSL expression and computes its value
(check-expect (eval-variable* 3 lal) 3)
(check-expect (eval-variable* (make-add 1 1) lal) 2)
(check-expect (eval-variable* (make-mul 3 10) lal) 30)
(check-expect (eval-variable* (make-add (make-mul 1 1) 10) lal) 11)
(check-expect (eval-variable* 'x lal) 4)
(check-expect (eval-variable* (make-add 'x 3) lal) 7)
(check-expect (eval-variable* (make-add (make-mul 'x 'x) (make-mul 'y 'y)) lal) 65)
(check-expect (eval-variable* (make-add (make-mul 'x 'x) (make-mul 'y 'y))
                              '((x 2) (y 3))) 13)
(check-expect (eval-variable* (make-add (make-mul 'z 'z) (make-mul 'k 'k)) lal) 100)
(check-error (eval-variable* (make-add (make-mul 'z 'z) (make-mul 'k 'k)) '((x 2) (y 3))) ERROR)
(define (eval-variable* expr da)
  (eval-variable
   (foldr (lambda (x rst) (subst rst (first x) (second x)))
          expr da)))

; BSL-var-expr Symbol Number -> BSL-var-expr
; produces a BSL-var-expr like ex with all occurrences of x replaced by v
(check-expect (subst 2 'x 5) 2)
(check-expect (subst 'x 'x 5) 5)
(check-expect (subst 'x 'y 5) 'x)
(check-expect (subst (make-add 'x 3) 'x 5) (make-add 5 3))
(check-expect (subst (make-add (make-mul 'x 'x) (make-mul 'y 'y)) 'y 4)
              (make-add (make-mul 'x 'x) (make-mul 4 4)))
(define (subst ex x v)
  (cond
    [(number? ex) ex]
    [(symbol? ex) (if (symbol=? ex x) v ex)]
    [(add? ex) (make-add (subst (add-left ex) x v)
                         (subst (add-right ex) x v))]
    [(mul? ex) (make-mul (subst (mul-left ex) x v)
                         (subst (mul-right ex) x v))]))