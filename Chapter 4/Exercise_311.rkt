;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_311) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
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
; consumes a family tree and counts the child structures in the tree
(check-expect (count-persons Carl) 1)
(check-expect (count-persons Bettina) 1)
(check-expect (count-persons Adam) 3)
(check-expect (count-persons Dave) 3)
(check-expect (count-persons Eva) 3)
(check-expect (count-persons Fred) 1)
(check-expect (count-persons Gustav) 5)
(define (count-persons an-ftree)
  (cond
    [(no-parent? an-ftree) 0]
    [else (+ 1
             (count-persons
                 (child-father an-ftree))
             (count-persons
                 (child-mother an-ftree)))]))

; FT Number -> Number
; consumes a family tree and the current year.
; It produces the total age of all child structures in the family tree
(check-expect (count-total-age Carl 2000) 74)
(check-expect (count-total-age Bettina 2000) 74)
(check-expect (count-total-age Adam 2000) 198)
(check-expect (count-total-age Dave 2000) 193)
(check-expect (count-total-age Eva 2000) 183)
(check-expect (count-total-age Fred 2000) 34)
(check-expect (count-total-age Gustav 2000) 229)
(define (count-total-age an-ftree year)
  (cond
    [(no-parent? an-ftree) 0]
    [else (+ (- year (child-date an-ftree))
             (count-total-age
                 (child-father an-ftree) year)
             (count-total-age
                 (child-mother an-ftree) year))]))

; FT Number -> Number
; consumes a family tree and the current year.
; It produces the average age of all child structures in the family tree
(check-expect (average-age Carl 2000) 74)
(check-expect (average-age Bettina 2000) 74)
(check-expect (average-age Adam 2000) 66)
(check-expect (average-age Dave 2000) 193/3)
(check-expect (average-age Eva 2000) 61)
(check-expect (average-age Fred 2000) 34)
(check-expect (average-age Gustav 2000) 229/5)
(define (average-age an-ftree year)
  (cond
    [(no-parent? an-ftree) 0]
    [else (/ (count-total-age an-ftree year)
             (count-persons an-ftree))]))