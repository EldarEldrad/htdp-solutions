;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_442) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; List-of-numbers -> List-of-numbers
; produces a sorted version of l
(check-expect (sort< '(11 9 2 18 12 14 4 1)) '(1 2 4 9 11 12 14 18))
(check-expect (sort< '(11)) '(11))
(define (sort< l)
  (cond
    [(empty? l) '()]
    [(cons? l) (insert (first l) (sort< (rest l)))]))
 
; Number List-of-numbers -> List-of-numbers
; inserts n into the sorted list of numbers l 
(define (insert n l)
  (cond
    [(empty? l) (cons n '())]
    [else (if (<= n (first l))
              (cons n l)
              (cons (first l) (insert n (rest l))))]))

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

; Number -> [List-of Number]
(define (create-tests n)
  (build-list n (lambda (x) (random n))))

(define THRESHOLD 20)

; [List-of Number] -> [List-of Number]
; produces a sorted version of alon
; assume the numbers are all distinct
(check-expect (clever-sort< '(11 9 2 18 12 14 4 1)) '(1 2 4 9 11 12 14 18))
(check-expect (clever-sort< '(11)) '(11))
(define (clever-sort< alon)
  (cond
    [(empty? alon) '()]
    [(empty? (rest alon)) alon]
    [(<= (length alon) THRESHOLD) (sort< alon)]
    [else (local ((define pivot (first alon)))
            (append (clever-sort< (smallers (rest alon) pivot))
                    (list pivot)
                    (clever-sort< (largers (rest alon) pivot))))]))

(define test-case (create-tests 10000))
(time (sort< test-case))
(time (quick-sort< test-case))
(time (clever-sort< test-case))