;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_312) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
(define-struct no-parent [])
(define-struct child [father mother name date eyes])
(define NP (make-no-parent))
; An FT is one of: 
; – NP
; – (make-child FT FT String N String)

; Oldest Generation:
(define Carl (make-child NP NP "Carl" 1926 "green"))
(define Bettina (make-child NP NP "Bettina" 1926 "green"))
 
; Middle Generation:
(define Adam (make-child Carl Bettina "Adam" 1950 "hazel"))
(define Dave (make-child Carl Bettina "Dave" 1955 "black"))
(define Eva (make-child Carl Bettina "Eva" 1965 "blue"))
(define Fred (make-child NP NP "Fred" 1966 "pink"))
 
; Youngest Generation: 
(define Gustav (make-child Fred Eva "Gustav" 1988 "brown"))

; FT -> Number
; consumes a family tree and produces a list of all eye colors in the tree
(check-expect (eye-colors Carl) '("green"))
(check-expect (eye-colors Bettina) '("green"))
(check-expect (eye-colors Adam) '("green" "green" "hazel"))
(check-expect (eye-colors Dave) '("green" "green" "black"))
(check-expect (eye-colors Eva) '("green" "green" "blue"))
(check-expect (eye-colors Fred) '("pink"))
(check-expect (eye-colors Gustav) '("pink" "green" "green" "blue" "brown"))
(define (eye-colors an-ftree)
  (cond
    [(no-parent? an-ftree) '()]
    [else (append
             (eye-colors
                 (child-father an-ftree))
             (eye-colors
                 (child-mother an-ftree))
             (list (child-eyes an-ftree)))]))