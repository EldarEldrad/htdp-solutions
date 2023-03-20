;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_348) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
(define-struct tr*e [])
(define-struct f*lse [])
(define-struct *nd [left right])
(define-struct *r [left right])
(define-struct n*t [expr])
; An BSL-str is a structure:
;   (make-BSL-str BSL-expr ...)

; An BSL-boolean is a structure:
;   (make-BSL-boolean)

; An BSL-expr is one of:
; - BSL-boolean
; - BSL-str

; BSL-expr -> Boolean
; consumes a representation of a BSL expression and computes its Boolean value
(check-expect (eval-bool-expression (make-tr*e)) #true)
(check-expect (eval-bool-expression (make-f*lse)) #false)
(check-expect (eval-bool-expression (make-*nd (make-tr*e) (make-f*lse))) #false)
(check-expect (eval-bool-expression (make-*r (make-f*lse) (make-tr*e))) #true)
(check-expect (eval-bool-expression (make-*r (make-tr*e)
                                             (make-*nd (make-*r (make-f*lse) (make-tr*e))
                                                       (make-tr*e)))) #true)
(check-expect (eval-bool-expression (make-n*t (make-f*lse))) #true)
(define (eval-bool-expression expr)
  (cond
    [(tr*e? expr) #true]
    [(f*lse? expr) #false]
    [(n*t? expr) (not (eval-bool-expression (n*t-expr expr)))]
    [(*nd? expr) (and (eval-bool-expression (*nd-left expr))
                      (eval-bool-expression (*nd-right expr)))]
    [(*r? expr) (or (eval-bool-expression (*r-left expr))
                    (eval-bool-expression (*r-right expr)))]))