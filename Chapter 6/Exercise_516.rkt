;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_516) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; A Lam is one of: 
; – a Symbol
; – a Lambda
; – an App

(define-struct lmbda [para body])
; A Lambda is a structure:
;  (make-lmbda Symbol Lam)
; interpretation represents a λ expression

(define-struct app [fun arg])
; An App is a structure:
;   (make-app Lam Lam)
; interpretation represents an application of function to argument

(define ex-var1 'x)
(define ex-var2 'y)
(define ex1 (make-lmbda 'x 'x))
(define ex2 (make-lmbda 'x 'y))
(define ex3 (make-lmbda 'y (make-lmbda 'x 'y)))
(define ex4 (make-app (make-lmbda 'x (make-app 'x 'x)) (make-lmbda 'x (make-app 'x 'x))))
(define ex5 (make-app (make-lmbda 'x 'x) (make-lmbda 'x 'x)))
(define ex6 (make-app (make-app (make-lmbda 'y (make-lmbda 'x 'y)) (make-lmbda 'z 'z)) (make-lmbda 'w 'w)))

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
  (lmbda? l))

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
  (app? l))

; Lam -> Symbol
; extracts the parameter from a λ expression
(check-expect (λ-para ex1) ex-var1)
(check-expect (λ-para ex2) ex-var1)
(check-expect (λ-para ex3) ex-var2)
(check-error (λ-para ex4) ERROR-λ)
(define (λ-para l)
  (cond
    [(is-λ? l) (lmbda-para l)]
    [else (error ERROR-λ)]))

; Lam -> Lam
; extracts the body from a λ expression
(check-expect (λ-body ex1) ex-var1)
(check-expect (λ-body ex2) ex-var2)
(check-expect (λ-body ex3) (make-lmbda 'x 'y))
(check-error (λ-body ex4) ERROR-λ)
(define (λ-body l)
  (cond
    [(is-λ? l) (lmbda-body l)]
    [else (error ERROR-λ)]))

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

; Lam -> Lam 
; replaces all symbols s in le with '*undeclared
; if they do not occur within the body of a λ 
; expression whose parameter is s
(check-expect (undeclareds ex1) ex1)
(check-expect (undeclareds ex2) (make-lmbda 'x '*undeclared))
(check-expect (undeclareds ex3) ex3)
(check-expect (undeclareds ex4) ex4)
(check-expect (undeclareds (make-app (make-lmbda 'x 'x) 'x)) (make-app (make-lmbda 'x 'x) '*undeclared))
(check-expect (undeclareds (make-lmbda '*undeclared (make-app (make-lmbda 'x (make-app 'x '*undeclared)) 'y)))
              (make-lmbda '*undeclared (make-app (make-lmbda 'x (make-app 'x '*undeclared)) '*undeclared)))
(define (undeclareds le0)
  (local (; Lam [List-of Symbol] -> Lam
          ; accumulator declareds is a list of all λ 
          ; parameters on the path from le0 to le
          (define (undeclareds/a le declareds)
            (cond
              [(is-var? le)
               (if (member? le declareds) le '*undeclared)]
              [(is-λ? le)
               (local ((define para (λ-para le))
                       (define body (λ-body le))
                       (define newd (cons para declareds)))
                 (make-lmbda para
                             (undeclareds/a body newd)))]
              [(is-app? le)
               (local ((define fun (app-fun le))
                       (define arg (app-arg le)))
               (make-app (undeclareds/a fun declareds)
                         (undeclareds/a arg declareds)))])))
    (undeclareds/a le0 '())))