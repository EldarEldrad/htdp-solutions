;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_413) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct inex [mantissa sign exponent])
; An Inex is a structure: 
;   (make-inex N99 S N99)
; An S is one of:
; – 1
; – -1
; An N99 is an N between 0 and 99 (inclusive).

; N Number N -> Inex
; makes an instance of Inex after checking the arguments
(define (create-inex m s e)
  (cond
    [(and (<= 0 m 99) (<= 0 e 99) (or (= s 1) (= s -1)))
     (make-inex m s e)]
    [else (error "bad values given")]))
 
; Inex -> Number
; converts an inex into its numeric equivalent 
(define (inex->number an-inex)
  (* (inex-mantissa an-inex)
     (expt
       10 (* (inex-sign an-inex) (inex-exponent an-inex)))))

(define ERROR "inex out of range")

; Inex Inex -> Inex
; adds two Inex representations of numbers that have the same exponent
(check-expect (inex* (create-inex 5 1 0) (create-inex 3 1 0)) (create-inex 15 1 0))
(check-expect (inex* (create-inex 5 1 0) (create-inex 6 1 0)) (create-inex 30 1 0))
(check-expect (inex* (create-inex 60 1 0) (create-inex 2 1 0)) (create-inex 12 1 1))
(check-expect (inex* (create-inex 2 1 4) (create-inex 8 1 10)) (create-inex 16 1 14))
(check-expect (inex* (create-inex 20 1 1) (create-inex  5 1 4)) (create-inex 10 1 6))
(check-expect (inex* (create-inex 27 -1 1) (create-inex  7 1 4)) (create-inex 19 1 4))
(check-expect (inex* (create-inex 1 -1 5) (create-inex  1 -1 4)) (create-inex 1 -1 9))
(check-expect (inex* (create-inex 50 -1 5) (create-inex  3 -1 14)) (create-inex 15 -1 18))
(check-expect (inex* (create-inex 50 -1 5) (create-inex  50 -1 14)) (create-inex 25 -1 17))
(check-expect (inex* (create-inex 50 -1 5) (create-inex  50 1 14)) (create-inex 25 1 11))
(check-error (inex* (create-inex 90 1 99) (create-inex  90 1 0)) ERROR)
(check-error (inex* (create-inex 90 1 69) (create-inex 10 1 59)) ERROR)
(define (inex* in1 in2)
  (local ((define new-mantissa (* (inex-mantissa in1) (inex-mantissa in2)))
          (define new-exponent (+ (* (inex-sign in1) (inex-exponent in1))
                                  (* (inex-sign in2) (inex-exponent in2)))))
    (cond
      [(> new-exponent 99) (error ERROR)]
      [(<= new-mantissa 99)
       (create-inex new-mantissa
                    (if (>= new-exponent 0) 1 -1)
                    (abs new-exponent))]
      [(and (<= new-mantissa 999) (< new-exponent 99))
       (create-inex (round (/ new-mantissa 10))
                    (if (>= new-exponent -1) 1 -1)
                    (abs (+ 1 new-exponent)))]
      [(and (<= new-mantissa 9999) (< new-exponent 98))
       (create-inex (round (/ new-mantissa 100))
                    (if (>= new-exponent -2) 1 -1)
                    (abs (+ 2 new-exponent)))]
      [else (error ERROR)])))