;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_318) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
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

; S-expr -> N 
; consumes an S-expression and determines its depth.
; An Atom has a depth of 1.
; The depth of a list of S-expressions is the maximum depth of its items plus 1
(check-expect (depth 'world) 1)
(check-expect (depth '(world hello)) 2)
(check-expect (depth '((world hello) hello)) 3)
(check-expect (depth '(((world) hello) hello)) 4)
(check-expect (depth '(((5 world) hello) "abc" hello)) 4)
(define (depth sexp)
  (local (; SL -> N
          ; counts depth of given SL
          (define (depth-sl sl)
            (cond
              [(empty? sl) 1]
              [else
               (max (depth (first sl)) (depth-sl (rest sl)))])))
    (cond
      [(atom? sexp) 1]
      [else (add1 (depth-sl sexp))])))

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