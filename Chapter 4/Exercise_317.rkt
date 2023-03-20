;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_317) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
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

; S-expr Symbol -> N 
; counts all occurrences of sy in sexp
(check-expect (count 'world 'hello) 0)
(check-expect (count '(world hello) 'hello) 1)
(check-expect (count '(((world) hello) hello) 'hello) 2)
(check-expect (count '(((5 world) hello) "abc" hello) 'hello) 2)
(define (count sexp sy)
  (local (; SL -> N
          ; counts all occurrences of sy in sl
          (define (count-sl sl)
            (cond
              [(empty? sl) 0]
              [else
               (+ (count (first sl) sy) (count-sl (rest sl)))]))
          ; Atom -> N
          ; counts all occurrences of sy in at
          (define (count-atom at)
            (cond
              [(number? at) 0]
              [(string? at) 0]
              [(symbol? at) (if (symbol=? at sy) 1 0)])))
    (cond
      [(atom? sexp)
       (count-atom sexp)]
      [else
       (count-sl sexp)])))

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