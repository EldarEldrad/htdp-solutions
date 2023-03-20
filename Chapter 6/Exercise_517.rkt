;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_517) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
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

; Lam -> Lam 
; replaces all occurrences of variables with a natural number
; that represents how far away the declaring λ is
(check-expect (static-distance ex1) '(λ (x) 0))
(check-expect (static-distance ex2) ex2)
(check-expect (static-distance ex3) '(λ (y) (λ (x) 1)))
(check-expect (static-distance ex4) '((λ (x) (0 0)) (λ (x) (0 0))))
(check-expect (static-distance ex5) '((λ (x) 0) (λ (x) 0)))
(check-expect (static-distance ex6) '(((λ (y) (λ (x) 1)) (λ (z) 0)) (λ (w) 0)))
(check-expect (static-distance '((λ (x) x) x)) '((λ (x) 0) x))
(check-expect (static-distance '(λ (*undeclared) ((λ (x) (x *undeclared)) y)))
              '(λ (*undeclared) ((λ (x) (0 1)) y)))
(define (static-distance le0)
  (local (; Symbol [List-of Symbol] -> Number
          ; returns index of item in list
          (define (index-of i l)
            (cond
              [(equal? i (first l)) 0]
              [else (+ 1 (index-of i (rest l)))]))
          ; Lam [List-of Symbol] -> Lam
          ; accumulator declareds is a list of all λ 
          ; parameters on the path from le0 to le
          (define (static-distance/a le declareds)
            (cond
              [(is-var? le)
               (if (member? le declareds)
                   (index-of le declareds)
                   le)]
              [(is-λ? le)
               (local ((define para (λ-para le))
                       (define body (λ-body le))
                       (define newd (cons para declareds)))
                 (list 'λ (list para)
                   (static-distance/a body newd)))]
              [(is-app? le)
               (local ((define fun (app-fun le))
                       (define arg (app-arg le)))
               (list (static-distance/a fun declareds)
                     (static-distance/a arg declareds)))])))
    (static-distance/a le0 '())))