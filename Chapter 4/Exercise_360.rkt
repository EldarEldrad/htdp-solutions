;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_360) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
(define-struct func [name param body])
; A BSL-fun-def is a structure:
;   (make-func Symbol Symbol BSL-fun-expr)

; An Association is a list of two items:
;   (cons Symbol (cons Number '())).

; BSL-da-all is one of:
; - '()
; - (cons Association BSL-da-all)
; - (cons BSL-fun-def BSL-da-all)

(define-struct add [left right])
(define-struct mul [left right])

(define da-ex `((close-to-pi 3.14)
                ,(make-func 'area-of-circle 'r (make-mul 'close-to-pi (make-mul 'r 'r)))
                ,(make-func 'volume-of-10-cylinder 'r (make-mul 10 '(area-of-circle r)))))

(define ERROR-CON "No such constant definition exists")
(define ERROR-FUN "No such function exists")

; A BSL-fun-expr is one of: 
; – Number
; – Symbol 
; – (make-add BSL-fun-expr BSL-fun-expr)
; – (make-mul BSL-fun-expr BSL-fun-expr)
; - (Symbol BSL-fun-expr)

; BSL-da-all Symbol -> Association
; produces the representation of a constant definition whose name is x, if such a piece of data exists in da
; otherwise the function signals an error saying that no such constant definition can be found.
(check-expect (lookup-con-def da-ex 'close-to-pi) '(close-to-pi 3.14))
(check-error (lookup-con-def da-ex 'x) ERROR-CON)
(check-error (lookup-con-def da-ex 'area-of-circle) ERROR-CON)
(check-error (lookup-con-def '() 'close-to-pi) ERROR-CON)
(check-error (lookup-con-def '((k 0) (x 4) (y 7) (z 10)) 'close-to-pi) ERROR-CON)
(check-expect (lookup-con-def '((k 0) (x 4) (y 7) (z 10)) 'y) '(y 7))
(check-expect (lookup-con-def '((k 0) (x 4) (y 7) (z 10)) 'z) '(z 10))
(check-expect (lookup-con-def '((k 0) (x 4) (y 7) (z 10)) 'k) '(k 0))
(define (lookup-con-def da x)
  (cond
    [(empty? da) (error ERROR-CON)]
    [(func? (first da)) (lookup-con-def (rest da) x)]
    [(list? (first da))
     (if (equal? x (first (first da)))
         (first da)
         (lookup-con-def (rest da) x))]))

; BSL-da-all Symbol -> BSL-fun-def
; produces the representation of a function definition whose name is f, if such a piece of data exists in da
; otherwise the function signals an error saying that no such function definition can be found
(check-error (lookup-fun-def da-ex 'close-to-pi) ERROR-FUN)
(check-error (lookup-fun-def da-ex 'x) ERROR-FUN)
(check-expect (lookup-fun-def da-ex 'area-of-circle)
              (make-func 'area-of-circle 'r (make-mul 'close-to-pi (make-mul 'r 'r))))
(check-expect (lookup-fun-def da-ex 'volume-of-10-cylinder)
              (make-func 'volume-of-10-cylinder 'r (make-mul 10 '(area-of-circle r))))
(check-error (lookup-fun-def '() 'close-to-pi) ERROR-FUN)
(define (lookup-fun-def da f)
  (cond
    [(empty? da) (error ERROR-FUN)]
    [(list? (first da)) (lookup-fun-def (rest da) f)]
    [(func? (first da))
     (if (equal? f (func-name (first da)))
         (first da)
         (lookup-fun-def (rest da) f))]))