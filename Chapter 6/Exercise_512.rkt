;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_512) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; A Lam is one of: 
; – a Symbol
; – (list 'λ (list Symbol) Lam)
; – (list Lam Lam)

(define ex-var1 'x)
(define ex-var2 'y)
(define ex1 '(λ (x) x))
(define ex2 '(λ (x) y))
(define ex3 '(λ (y) (λ (x) y)))
(define ex4 '((λ (x) (x x)) (λ (x) (x x))))
(define ex5 '((λ (x) x) (λ (x) x)))
(define ex6 '(((λ (y) (λ (x) y)) (λ (z) z)) (λ (w) w)))

(define ERROR-λ "Given LAM is not a λ expression")
(define ERROR-APP "Given LAM is not an application")

; Lam -> Boolean
; returns #true if given Lam is variable
(check-expect (is-var? ex-var1) #true)
(check-expect (is-var? ex-var2) #true)
(check-expect (is-var? ex1) #false)
(check-expect (is-var? ex2) #false)
(check-expect (is-var? ex3) #false)
(check-expect (is-var? ex4) #false)
(check-expect (is-var? ex5) #false)
(check-expect (is-var? ex6) #false)
(define (is-var? l)
  (symbol? l))

; Lam -> Boolean
; returns #true if given Lam is λ expression
(check-expect (is-λ? ex-var1) #false)
(check-expect (is-λ? ex-var2) #false)
(check-expect (is-λ? ex1) #true)
(check-expect (is-λ? ex2) #true)
(check-expect (is-λ? ex3) #true)
(check-expect (is-λ? ex4) #false)
(check-expect (is-λ? ex5) #false)
(check-expect (is-λ? ex6) #false)
(define (is-λ? l)
  (and (list? l)
       (equal? (first l) 'λ)))

; Lam -> Boolean
; returns #true if given Lam is application
(check-expect (is-app? ex-var1) #false)
(check-expect (is-app? ex-var2) #false)
(check-expect (is-app? ex1) #false)
(check-expect (is-app? ex2) #false)
(check-expect (is-app? ex3) #false)
(check-expect (is-app? ex4) #true)
(check-expect (is-app? ex5) #true)
(check-expect (is-app? ex6) #true)
(define (is-app? l)
  (and (list? l)
       (not (equal? (first l) 'λ))))

; Lam -> Symbol
; extracts the parameter from a λ expression
(check-expect (λ-para ex1) ex-var1)
(check-expect (λ-para ex2) ex-var1)
(check-expect (λ-para ex3) ex-var2)
(check-error (λ-para ex4) ERROR-λ)
(define (λ-para l)
  (cond
    [(is-λ? l) (first (second l))]
    [else (error ERROR-λ)]))

; Lam -> Lam
; extracts the body from a λ expression
(check-expect (λ-body ex1) ex-var1)
(check-expect (λ-body ex2) ex-var2)
(check-expect (λ-body ex3) '(λ (x) y))
(check-error (λ-body ex4) ERROR-λ)
(define (λ-body l)
  (cond
    [(is-λ? l) (third l)]
    [else (error ERROR-λ)]))

; Lam -> Lam
; extracts the function from the application
(check-expect (app-fun ex4) '(λ (x) (x x)))
(check-expect (app-fun ex5) '(λ (x) x))
(check-expect (app-fun ex6) '((λ (y) (λ (x) y)) (λ (z) z)))
(check-expect (app-fun '(x y)) 'x)
(check-error (app-fun ex3) ERROR-APP)
(define (app-fun l)
  (cond
    [(is-app? l) (first l)]
    [else (error ERROR-APP)]))

; Lam -> Lam
; extracts the argument from the application
(check-expect (app-arg ex4) '(λ (x) (x x)))
(check-expect (app-arg ex5) '(λ (x) x))
(check-expect (app-arg ex6) '(λ (w) w))
(check-expect (app-arg '(x y)) 'y)
(check-error (app-arg ex3) ERROR-APP)
(define (app-arg l)
  (cond
    [(is-app? l) (second l)]
    [else (error ERROR-APP)]))

; Lam -> [List-of Symbols]
; produces the list of all symbols used as λ parameters in a λ term
(check-expect (declareds ex1) '(x))
(check-expect (declareds ex2) '(x))
(check-expect (declareds ex3) '(y x))
(check-expect (declareds ex4) '(x x))
(check-expect (declareds ex5) '(x x))
(check-expect (declareds ex6) '(y x z w))
(check-expect (declareds ex-var1) '())
(define (declareds l)
  (cond
    [(is-var? l) '()]
    [(is-app? l) (append (declareds (app-fun l))
                         (declareds (app-arg l)))]
    [(is-λ? l) (cons (λ-para l)
                     (declareds (λ-body l)))]))