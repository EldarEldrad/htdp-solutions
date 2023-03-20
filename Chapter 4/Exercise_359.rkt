;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_359) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
(define-struct func [name param body])
; A BSL-fun-def is a structure:
;   (make-func Symbol Symbol BSL-fun-expr)

; A BSL-fun-def* is [List-of BSL-fun-def]

(define-struct add [left right])
(define-struct mul [left right])

(define ERROR "Can't evaluate given expression")
(define ERROR-FUNC "No such function defined")

; A BSL-fun-expr is one of: 
; – Number
; – Symbol 
; – (make-add BSL-fun-expr BSL-fun-expr)
; – (make-mul BSL-fun-expr BSL-fun-expr)
; - (Symbol BSL-fun-expr)

; (define (f x) (+ 3 x))
(define f (make-func 'f 'x (make-add 3 'x)))

; (define (g y) (f (* 2 y)))
(define g (make-func 'g 'y `(f ,(make-mul 2 'y))))

; (define (h v) (+ (f v) (g v)))
(define h (make-func 'h 'v (make-add '(f v) '(g v))))

(define da-fgh (list f g h))

; BSL-fun-def* Symbol -> BSL-fun-def
; retrieves the definition of f in da
; signals an error if there is none
(check-expect (lookup-def da-fgh 'f) f)
(check-expect (lookup-def da-fgh 'g) g)
(check-expect (lookup-def da-fgh 'h) h)
(check-error (lookup-def da-fgh 'i) ERROR-FUNC)
(check-error (lookup-def '() 'f) ERROR-FUNC)
(define (lookup-def da f)
  (cond
    [(empty? da) (error ERROR-FUNC)]
    [(equal? f (func-name (first da))) (first da)]
    [else (lookup-def (rest da) f)]))

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

; BSL-fun-expr BSL-fun-def* -> Number
; determines value of ex regarding given definition area da
(check-expect (eval-function* 3 da-fgh) 3)
(check-expect (eval-function* (make-add 1 1) da-fgh) 2)
(check-expect (eval-function* (make-mul 3 10) da-fgh) 30)
(check-expect (eval-function* (make-add (make-mul 1 1) 10) da-fgh) 11)
(check-error (eval-function* 'x da-fgh) ERROR)
(check-error (eval-function* (make-posn 3 4) da-fgh) ERROR)
(check-error (eval-function* (make-add 'x 3) da-fgh) ERROR)
(check-error (eval-function* (make-add (make-mul 'x 'x) (make-mul 'y 'y)) da-fgh) ERROR)
(check-error (eval-function* (make-add (make-mul 'z 'z) (make-mul 'k 'k)) da-fgh) ERROR)
(check-expect (eval-function* '(f 4) da-fgh) 7)
(check-expect (eval-function* '(g 3) da-fgh) 9)
(check-expect (eval-function* '(h 2) da-fgh) 12)
(check-error (eval-function* '(i 2) da-fgh) ERROR-FUNC)
(check-error (eval-function* '(f 2) '()) ERROR-FUNC)
(define (eval-function* ex da)
  (cond
    [(number? ex) ex]
    [(symbol? ex) (error ERROR)]
    [(add? ex) (+ (eval-function* (add-left ex) da)
                  (eval-function* (add-right ex) da))]
    [(mul? ex) (* (eval-function* (mul-left ex) da)
                  (eval-function* (mul-right ex) da))]
    [(list? ex)
     (local ((define f-def (lookup-def da (first ex)))
             (define value (eval-function* (second ex) da))
             (define plugd (subst (func-body f-def) (func-param f-def) value)))
       (eval-function* plugd da))]
    [else (error ERROR)]))