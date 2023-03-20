;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_319) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
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

; S-expr Symbol Symbol-> S-expr
; consumes an S-expression s and two symbols, old and new.
; The result is like s with all occurrences of old replaced by new
(check-expect (substitute 'world 'hello 'hi) 'world)
(check-expect (substitute '(world hello) 'hello 'hi) '(world hi))
(check-expect (substitute '(((world) hello) hello) 'hello 'hi) '(((world) hi) hi))
(check-expect (substitute '(((5 world) hello) "abc" hello) 'hello 'hi)
              '(((5 world) hi) "abc" hi))
(define (substitute sexp old new)
  (local (; SL -> SL
          ; substitute all occurencies of old with new in given SL
          (define (substitute-sl sl)
            (cond
              [(empty? sl) '()]
              [else
               (cons (substitute (first sl) old new) (substitute-sl (rest sl)))]))
          ; Atom -> Atom
          ; substitute old with new if applicable
          (define (substitute-atom at)
            (cond
              [(and (symbol? at) (symbol=? at old)) new]
              [else at])))
    (cond
      [(atom? sexp)
       (substitute-atom sexp)]
      [else
       (substitute-sl sexp)])))

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