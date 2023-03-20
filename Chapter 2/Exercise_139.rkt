;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_139) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; A List-of-numbers is one of: 
; – '()
; – (cons Number List-of-numbers)

; A List-of-amounts is one of: 
; – '()
; – (cons PositiveNumber List-of-amounts)

(define loa1 '())
(define loa2 (cons 5 '()))
(define loa3 (cons 12 (cons 5 '())))

; List-of-amounts -> Number
; computes the sum of the amounts
; for List-of-numbers, this computes sum of all numbers (both positive and negative)
(check-expect (sum loa1) 0)
(check-expect (sum loa2) 5)
(check-expect (sum loa3) 17)
(define (sum loa)
  (cond
    [(empty? loa) 0]
    [(cons? loa) (+ (first loa)
                    (sum (rest loa)))]))

; List-of-numbers -> Boolean
; determines whether all numbers are positive numbers
(check-expect (pos? '()) #true)
(check-expect (pos? (cons 5 '())) #true)
(check-expect (pos? (cons -1 '())) #false)
(check-expect (pos? (cons 5 (cons -1 '()))) #false)
(define (pos? lon)
  (cond
    [(empty? lon) #true]
    [(cons? lon) (and (positive? (first lon))
                      (pos? (rest lon)))]))

; List-of-numbers -> Number
; produces sun only if the input belongs to List-of-amounts
(check-expect (checked-sum loa1) 0)
(check-expect (checked-sum loa2) 5)
(check-expect (checked-sum loa3) 17)
(check-error (checked-sum (cons -1 '())))
(check-error (checked-sum (cons 5 (cons -1 '()))))
(define (checked-sum lon)
   (cond
    [(empty? lon) 0]
    [(cons? lon) (if (positive? (first lon))
                     (+ (first lon)
                        (checked-sum (rest lon)))
                     (error "checked-sum: lon does not belong to List-of-amounts"))]))

; List-of-numbers -> Number
; produces sun only if the input belongs to List-of-amounts
(check-expect (checked-sum.v2 loa1) 0)
(check-expect (checked-sum.v2 loa2) 5)
(check-expect (checked-sum.v2 loa3) 17)
(check-error (checked-sum.v2 (cons -1 '())))
(check-error (checked-sum.v2 (cons 5 (cons -1 '()))))
(define (checked-sum.v2 lon)
   (if (pos? lon)
       (sum lon)
       (error "checked-sum: lon does not belong to List-of-amounts")))

(pos? (cons 5 '()))
; -> (cond
;      [(empty? (cons 5 '())) #true]
;      [(cons? (cons 5 '())) (and (positive? (first (cons 5 '())))
;                            (pos? (rest (cons 5 '()))))])
; -> (cond
;      [#false #true]
;      [(cons? (cons 5 '())) (and (positive? (first (cons 5 '())))
;                            (pos? (rest (cons 5 '()))))])
; -> (cond
;      [(cons? (cons 5 '())) (and (positive? (first (cons 5 '())))
;                            (pos? (rest (cons 5 '()))))])
; -> (cond
;      [#true (and (positive? (first (cons 5 '())))
;                  (pos? (rest (cons 5 '()))))])
; -> (and (positive? (first (cons 5 '())))
;         (pos? (rest (cons 5 '()))))
; -> (and (positive? 5)
;         (pos? (rest (cons 5 '()))))
; -> (and #true
;         (pos? (rest (cons 5 '()))))
; -> (and #true
;         (pos? '()))
; -> (and #true
;         (cond
;           [(empty? '()) #true]
;           [(cons? '()) (and (positive? (first '()))
;                             (pos? (rest '())))]))
; -> (and #true
;         (cond
;           [#true #true]
;           [(cons? '()) (and (positive? (first '()))
;                             (pos? (rest '())))]))
; -> (and #true
;         #true)
; -> #true

(pos? (cons -1 '()))
; -> (cond
;      [(empty? (cons -1 '())) #true]
;      [(cons? (cons -1 '())) (and (positive? (first (cons -1 '())))
;                            (pos? (rest (cons -1 '()))))])
; -> (cond
;      [#false #true]
;      [(cons? (cons -1 '())) (and (positive? (first (cons -1 '())))
;                            (pos? (rest (cons -1 '()))))])
; -> (cond
;      [(cons? (cons -1 '())) (and (positive? (first (cons -1 '())))
;                            (pos? (rest (cons -1 '()))))])
; -> (cond
;      [#true (and (positive? (first (cons -1 '())))
;                  (pos? (rest (cons -1 '()))))])
; -> (and (positive? (first (cons -1 '())))
;         (pos? (rest (cons -1 '()))))
; -> (and (positive? -1)
;         (pos? (rest (cons -1 '()))))
; -> (and #false
;         (pos? (rest (cons -1 '()))))
; -> #false