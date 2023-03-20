;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_351) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
; An S-expr is one of: 
; – Atom
; – SL
 
; An SL is one of: 
; – '()
; – (cons S-expr SL)
		
; An Atom is one of: 
; – Number
; – String
; – Symbol

; Any -> Boolean
; returns #true if given argument is Atom
(check-expect (atom? #true) #false)
(check-expect (atom? '()) #false)
(check-expect (atom? 5) #true)
(check-expect (atom? "ab") #true)
(check-expect (atom? 'r) #true)
(check-expect (atom? (make-posn 4 5)) #false)
(check-expect (atom? (cons 3 '())) #false)
(define (atom? x)
  (or (number? x)
      (string? x)
      (symbol? x)))

(define-struct add [left right])
(define-struct mul [left right])
; An BSL-str is a structure:
;   (make-BSL-str BSL-expr BSL-expr)

; An BSL-expr is one of:
; - Number
; - BSL-str

(define WRONG "Can't parse given expression")

; S-expr -> BSL-expr
(check-expect (parse 3) 3)
(check-error (parse "Hello") WRONG)
(check-error (parse 'x) WRONG)
(check-error (parse '(1 2 3 4)) WRONG)
(check-error (parse '(f 4 5)) WRONG)
(check-expect (parse '(+ 3 4)) (make-add 3 4))
(check-expect (parse '(* 5 (+ 2 -4))) (make-mul 5 (make-add 2 -4)))
(define (parse s)
  (cond
    [(atom? s) (parse-atom s)]
    [else (parse-sl s)]))
 
; SL -> BSL-expr 
(define (parse-sl s)
  (cond
    [(and (consists-of-3 s) (symbol? (first s)))
     (cond
       [(symbol=? (first s) '+)
        (make-add (parse (second s)) (parse (third s)))]
       [(symbol=? (first s) '*)
        (make-mul (parse (second s)) (parse (third s)))]
       [else (error WRONG)])]
    [else (error WRONG)]))
 
; Atom -> BSL-expr 
(define (parse-atom s)
  (cond
    [(number? s) s]
    [(string? s) (error WRONG)]
    [(symbol? s) (error WRONG)]))
 
; SL -> Boolean
(define (consists-of-3 s)
  (and (cons? s) (cons? (rest s)) (cons? (rest (rest s)))
       (empty? (rest (rest (rest s))))))

; BSL-expr -> Number
; consumes a representation of a BSL expression and computes its value
(check-expect (eval-expression 3) 3)
(check-expect (eval-expression (make-add 1 1)) 2)
(check-expect (eval-expression (make-mul 3 10)) 30)
(check-expect (eval-expression (make-add (make-mul 1 1) 10)) 11)
(define (eval-expression expr)
  (cond
    [(number? expr) expr]
    [(add? expr) (+ (eval-expression (add-left expr))
                    (eval-expression (add-right expr)))]
    [(mul? expr) (* (eval-expression (mul-left expr))
                    (eval-expression (mul-right expr)))]))

; S-expr -> Number
; The function accepts S-expressions.
; If parse recognizes them as BSL-expr, it produces their value.
; Otherwise, it signals the same error as parse
(check-expect (interpreter-expr 3) 3)
(check-error (interpreter-expr "Hello") WRONG)
(check-error (interpreter-expr 'x) WRONG)
(check-error (interpreter-expr '(1 2 3 4)) WRONG)
(check-error (interpreter-expr '(f 4 5)) WRONG)
(check-expect (interpreter-expr '(+ 3 4)) 7)
(check-expect (interpreter-expr '(* 5 (+ 2 -4))) -10)
(define (interpreter-expr s)
  (eval-expression (parse s)))