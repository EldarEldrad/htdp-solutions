;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_358) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
(define-struct func [name param body])
; A BSL-fun-def is a structure:
;   (make-func Symbol Symbol BSL-fun-expr)

; A BSL-fun-def* is [List-of BSL-fun-def]

(define-struct add [left right])
(define-struct mul [left right])

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