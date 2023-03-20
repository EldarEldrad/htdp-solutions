;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_270) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; Number -> [List-of Number]
; creates the list (list 0 ... (- n 1)) for any natural number n
(check-expect (builder-1 1) '(0))
(check-expect (builder-1 2) '(0 1))
(check-expect (builder-1 3) '(0 1 2))
(check-expect (builder-1 4) '(0 1 2 3))
(check-expect (builder-1 5) '(0 1 2 3 4))
(define (builder-1 n) (build-list n identity))

; Number -> [List-of Number]
; creates the list (list 1 ... n) for any natural number n
(check-expect (builder-2 1) '(1))
(check-expect (builder-2 2) '(1 2))
(check-expect (builder-2 3) '(1 2 3))
(check-expect (builder-2 4) '(1 2 3 4))
(check-expect (builder-2 5) '(1 2 3 4 5))
(define (builder-2 n) (build-list n add1))

; Number -> [List-of Number]
; creates the list (list 1 1/2 ... 1/n) for any natural number n;
(check-expect (builder-3 1) '(1))
(check-expect (builder-3 2) `(1 ,(/ 1 2)))
(check-expect (builder-3 3) (list 1 (/ 1 2) (/ 1 3)))
(check-expect (builder-3 4) (list 1 (/ 1 2) (/ 1 3) (/ 1 4)))
(check-expect (builder-3 5) (list 1 (/ 1 2) (/ 1 3) (/ 1 4) (/ 1 5)))
(define (builder-3 n)
  (local ((define (create-progression k)
            (/ 1 (add1 k))))
    (build-list n create-progression)))

; Number -> [List-of Number]
; creates the list of the first n even numbers;
(check-expect (builder-4 1) '(1))
(check-expect (builder-4 2) '(1 3))
(check-expect (builder-4 3) '(1 3 5))
(check-expect (builder-4 4) '(1 3 5 7))
(check-expect (builder-4 5) '(1 3 5 7 9))
(define (builder-4 n)
  (local ((define (create-even k)
            (+ (* 2 k) 1)))
    (build-list n create-even)))

; Number -> [List-of [List-of Number]]
; creates a diagonal square of 0s and 1s;
(check-expect (builder-5 1) '((1)))
(check-expect (builder-5 2) '((1 0) (0 1)))
(check-expect (builder-5 3) '((1 0 0) (0 1 0) (0 0 1)))
(check-expect (builder-5 4) '((1 0 0 0) (0 1 0 0) (0 0 1 0) (0 0 0 1)))
(check-expect (builder-5 5) '((1 0 0 0 0) (0 1 0 0 0) (0 0 1 0 0) (0 0 0 1 0) (0 0 0 0 1)))
(define (builder-5 n)
  (local (; Number -> [List-of Number]
          ; creates row
          (define (create-row cur)
            (local ((define (is-1? k) (if (= k cur) 1 0)))
              (build-list n is-1?))))
    (build-list n create-row)))

; [Number -> Number] Number -> [List-of Number]
; tabilates given function f between n and 0 (incl.) in a list
(check-expect (tabulate sqr 0) '(0))
(check-expect (tabulate sqr 1) '(0 1))
(check-expect (tabulate sqr 2) '(0 1 4))
(check-expect (tabulate sqr 3) '(0 1 4 9))
(check-expect (tabulate sqr 4) '(0 1 4 9 16))
(check-expect (tabulate sqr 5) '(0 1 4 9 16 25))
(define (tabulate f n)
  (build-list (add1 n) f))