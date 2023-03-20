;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_294) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; [X] X [List-of X] -> [Maybe N]
; determine the index of the first occurrence
; of x in l, #false otherwise
(check-satisfied (index 5 '(1 2 3 4)) (is-index? 5 '(1 2 3 4)))
(check-satisfied (index 5 '(1 2 3 4 5 6)) (is-index? 5 '(1 2 3 4 5 6)))
(check-satisfied (index "a" '("a" "b" "c")) (is-index? "a" '("a" "b" "c")))
(check-satisfied (index "a" '()) (is-index? "a" '()))
(define (index x l)
  (cond
    [(empty? l) #false]
    [else (if (equal? (first l) x)
              0
              (local ((define i (index x (rest l))))
                (if (boolean? i) i (+ i 1))))]))

; [X] X [List-of X] -> [[Maybe N] -> Boolean]
; checks if s is sublist of l starting with e
(define (is-index? e l)
  (lambda (n)
    (cond
      [(false? n) (not (member? e l))]
      [else (equal? e (list-ref l n))])))