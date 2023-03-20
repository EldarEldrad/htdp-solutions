;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_357) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
(define-struct add [left right])
(define-struct mul [left right])

(define ERROR "Can't evaluate given expression")

; A BSL-fun-expr is one of: 
; – Number
; – Symbol 
; – (make-add BSL-fun-expr BSL-fun-expr)
; – (make-mul BSL-fun-expr BSL-fun-expr)
; - (Symbol BSL-fun-expr)

; BSL-fun-expr Symbol Symbol BSL-fun-expr -> Number
; determines the value of ex
(check-expect (eval-definition1 3 'f 'x (make-add 'x 1)) 3)
(check-expect (eval-definition1 (make-add 1 1) 'f 'x (make-add 'x 1)) 2)
(check-expect (eval-definition1 (make-mul 3 10) 'f 'x (make-add 'x 1)) 30)
(check-expect (eval-definition1 (make-add (make-mul 1 1) 10) 'f 'x (make-add 'x 1)) 11)
(check-error (eval-definition1 'x 'f 'x (make-add 'x 1)) ERROR)
(check-error (eval-definition1 (make-add 'x 3) 'f 'x (make-add 'x 1)) ERROR)
(check-error (eval-definition1 (make-add (make-mul 'x 'x) (make-mul 'y 'y)) 'f 'x (make-add 'x 1)) ERROR)
(check-error (eval-definition1 (make-add (make-mul 'z 'z) (make-mul 'k 'k)) 'f 'x (make-add 'x 1)) ERROR)
(check-expect (eval-definition1 '(f 4) 'f 'x 'x) 4)
(check-expect (eval-definition1 '(f 3) 'f 'x (make-add 'x 1)) 4)
(check-expect (eval-definition1 '(f 2) 'f 'x (make-add (make-mul 2 'x) 1)) 5)
(check-error (eval-definition1 '(g 2) 'f 'x (make-add (make-mul 2 'x) 1)) ERROR)
(check-error (eval-definition1 '(f 2) 'f 'x (make-add (make-mul 2 'y) 1)) ERROR)
; (check-expect (eval-definition1 '(f 1) 'f 'x '(f x)) 1) - infinite loop
(define (eval-definition1 ex f x b)
  (cond
    [(number? ex) ex]
    [(symbol? ex) (error ERROR)]
    [(add? ex) (+ (eval-definition1 (add-left ex) f x b)
                  (eval-definition1 (add-right ex) f x b))]
    [(mul? ex) (* (eval-definition1 (mul-left ex) f x b)
                  (eval-definition1 (mul-right ex) f x b))]
    [(and (list? ex)
          (symbol=? f (first ex)))
     (local ((define value (eval-definition1 (second ex) f x b))
             (define plugd (subst b x value)))
       (eval-definition1 plugd f x b))]
    [else (error ERROR)]))

; BSL-fun-expr Symbol Number -> BSL-fun-expr
; produces a BSL-fun-expr like ex with all occurrences of x replaced by v
(check-expect (subst 2 'x 5) 2)
(check-expect (subst 'x 'x 5) 5)
(check-expect (subst 'x 'y 5) 'x)
(check-expect (subst (make-add 'x 3) 'x 5) (make-add 5 3))
(check-expect (subst (make-add (make-mul 'x 'x) (make-mul 'y 'y)) 'y 4)
              (make-add (make-mul 'x 'x) (make-mul 4 4)))
(check-expect (subst '(f x) 'x 5) '(f 5))
(check-expect (subst `(f ,(make-add 'x 3)) 'x 5) `(f ,(make-add 5 3)))
(define (subst ex x v)
  (cond
    [(number? ex) ex]
    [(symbol? ex) (if (symbol=? ex x) v ex)]
    [(add? ex) (make-add (subst (add-left ex) x v)
                         (subst (add-right ex) x v))]
    [(mul? ex) (make-mul (subst (mul-left ex) x v)
                         (subst (mul-right ex) x v))]
    [(list? ex)
     (list (first ex) (subst (second ex) x v))]))