;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_151) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; N Number -> Number
; multiplies given number and given natural number
(check-expect (multiply 3 2) 6)
(check-expect (multiply 2 0) 0)
(check-expect (multiply 5 5) 25)
(check-expect (multiply 6 -4) -24)
(define (multiply n x)
  (cond
    [(= n 0) 0]
    [else (+ x (multiply (sub1 n) x))]))

(multiply 3 5)
; -> (cond
;      [(= 3 0) 0]
;      [else (+ 5 (multiply (sub1 3) 5))])
; -> (cond
;      [#false 0]
;      [else (+ 5 (multiply (sub1 3) 5))])
; -> (cond
;      [else (+ 5 (multiply (sub1 3) 5))])
; -> (+ 5 (multiply (sub1 3) 5))
; -> (+ 5 (multiply 2 5))
; -> (+ 5
;       (cond
;         [(= 2 0) 0]
;         [else (+ 5 (multiply (sub1 2) 5))]))
; -> (+ 5
;       (cond
;         [#false 0]
;         [else (+ 5 (multiply (sub1 2) 5))]))
; -> (+ 5
;       (cond
;         [else (+ 5 (multiply (sub1 2) 5))]))
; -> (+ 5
;       (+ 5 (multiply (sub1 2) 5)))
; -> (+ 5
;       (+ 5 (multiply 1 5)))
; -> (+ 5
;       (+ 5
;          (cond
;            [(= 1 0) 0]
;            [else (+ 5 (multiply (sub1 1) 5))])))
; -> (+ 5
;       (+ 5
;          (cond
;            [#false 0]
;            [else (+ 5 (multiply (sub1 1) 5))])))
; -> (+ 5
;       (+ 5
;          (cond
;            [else (+ 5 (multiply (sub1 1) 5))])))
; -> (+ 5
;       (+ 5
;          (+ 5 (multiply (sub1 1) 5))))
; -> (+ 5
;       (+ 5
;          (+ 5 (multiply 0 5))))
; -> (+ 5
;       (+ 5
;          (+ 5
;             (cond
;               [(= 0 0) 0]
;               [else (+ 5 (multiply (sub1 0) 5))]))))
; -> (+ 5
;       (+ 5
;          (+ 5
;             (cond
;               [#true 0]
;               [else (+ 5 (multiply (sub1 0) 5))]))))
; -> (+ 5
;       (+ 5
;          (+ 5
;             0)))
; -> (+ 5
;       (+ 5
;          5))
; -> (+ 5
;       10)
; -> 15