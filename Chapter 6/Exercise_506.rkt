;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_506) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; [List-of X] [X -> Y] -> [List-of Y]
; accumulator-style version of map
(check-expect (map/a '() add1) '())
(check-expect (map/a '(1 2 3) add1) '(2 3 4))
(check-expect (map/a '(25 81 0 1) sqrt) '(5 9 0 1))
(check-expect (map/a '(#false #true #true #false) not) '(#true #false #false #true))
(check-expect (map/a '(5 "hi" #false y)
                     (lambda (elem)
                       (cond
                         [(number? elem) (- elem)]
                         [(string? elem) (explode elem)]
                         [else elem])))
              '(-5 ("h" "i") #false y))
(define (map/a lox f)
  (local ((define (map/a-inner lst res)
            (cond
              [(empty? lst) (reverse res)]
              [else (map/a-inner (rest lst) (cons (f (first lst))
                                                  res))])))
    (map/a-inner lox '())))