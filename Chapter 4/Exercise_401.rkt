;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_401) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; An S-expr (S-expression) is one of: 
; – Atom
; – [List-of S-expr]
; 
; An Atom is one of: 
; – Number
; – String
; – Symbol

; S-expr S-expr -> Boolean
; determines whether two S-expressions are equal
(check-expect (sexpr=? 2 2) #true)
(check-expect (sexpr=? 2 5) #false)
(check-expect (sexpr=? "ab" "ba") #false)
(check-expect (sexpr=? 'a 'b) #false)
(check-expect (sexpr=? '((a 4) (b ("hello" 5))) '(("hi" 'hi) (54 7))) #false)
(check-expect (sexpr=? '((a 4) (b ("hello" 5))) '((a 4) (b ("hello" 5)) 3)) #false)
(check-expect (sexpr=? '((a 4) (b ("hello" 5))) '((a 4) (b ("hello" 5)))) #true)
(define (sexpr=? s1 s2)
  (local ((define (atom? x)
            (or (number? x) (string? x) (symbol? x))))
    (cond
      [(and (atom? s1) (atom? s2)) (equal? s1 s2)]
      [(and (list? s1) (list? s2) (equal? (length s1) (length s2)))
       (andmap sexpr=? s1 s2)]
      [else #false])))