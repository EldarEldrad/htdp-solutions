;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_426) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; [List-of Number] -> [List-of Number]
; produces a sorted version of alon
; assume the numbers are all distinct
(check-expect (quick-sort< '(11 9 2 18 12 14 4 1)) '(1 2 4 9 11 12 14 18))
(check-expect (quick-sort< '(11)) '(11))
(define (quick-sort< alon)
  (cond
    [(empty? alon) '()]
    [(empty? (rest alon)) alon]
    [else (local ((define pivot (first alon)))
            (append (quick-sort< (smallers (rest alon) pivot))
                    (list pivot)
                    (quick-sort< (largers (rest alon) pivot))))]))

; [List-of Number] Number -> [List-of Number]
; returns list that contains element that are larger than given number only
(define (largers alon n)
  (filter (lambda (x) (> x n)) alon))

; [List-of Number] Number -> [List-of Number]
; returns list that contains element that are smaller than given number only
(define (smallers alon n)
  (filter (lambda (x) (< x n)) alon))


(quick-sort< (list 11 8 14 7))
; ==
; (append (quick-sort< (list 8 7))
;         (list 11)
;         (quick-sort< (list 14)))
; ==
; (append (append (quick-sort< (list 7))
;                  (list 8)
;                 (quick-sort< '()))
;         (list 11)
;         (quick-sort< (list 14)))
; ==
; (append (append (append (quick-sort< '())
;                         (list 7)
;                         (quick-sort< '()))
;                 (list 8)
;                 (quick-sort< '()))
;         (list 11)
;         (quick-sort< (list 14)))
; ==
; (append (append (append '()
;                          (list 7)
;                         '())
;                 (list 8)
;                 '())
;         (list 11)
;         (quick-sort< (list 14)))
; ==
; (append (append (list 7)
;                 (list 8)
;                 '())
;         (list 11)
;         (quick-sort< (list 14)))
; ==
; (append (list 7 8)
;         (list 11)
;         (quick-sort< (list 14)))
; ==
; (append (list 7 8)
;         (list 11)
;         (append (quick-sort< '())
;                 (list 14)
;                 (quick-sort< '())))
; ==
; (append (list 7 8)
;         (list 11)
;         (append '()
;                 (list 14)
;                 (quick-sort< '())))
; ==
; (append (list 7 8)
;         (list 11)
;         (append '()
;                 (list 14)
;                 '()))
; ==
; (append (list 7 8)
;         (list 11)
;         (list 14))
; ==
; (list 7 8 11 14)