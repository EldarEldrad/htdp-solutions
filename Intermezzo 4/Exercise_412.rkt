;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_412) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
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
(check-expect (inex+/equal (create-inex 5 1 0) (create-inex 3 1 0)) (create-inex 8 1 0))
(check-expect (inex+/equal (create-inex 5 1 0) (create-inex 6 1 0)) (create-inex 11 1 0))
(check-expect (inex+/equal (create-inex 58 1 0) (create-inex 43 1 0)) (create-inex 10 1 1))
(check-expect (inex+/equal (create-inex 58 -1 1) (create-inex 43 -1 1)) (create-inex 10 1 0))
(check-expect (inex+/equal (create-inex 99 1 60) (create-inex 99 1 60)) (create-inex 19 1 61))
(check-error (inex+/equal (create-inex 90 1 99) (create-inex 10 1 99)) ERROR)
(define (inex+/equal in1 in2)
  (local ((define new-mantissa (+ (inex-mantissa in1) (inex-mantissa in2))))
    (cond
      [(<= new-mantissa 99)
       (create-inex new-mantissa (inex-sign in2) (inex-exponent in2))]
      [(<= new-mantissa 999)
       (local ((define new-exponent ((if (equal? (inex-sign in2) 1) + -) (inex-exponent in2) 1)))
         (cond
           [(> new-exponent 99) (error ERROR)]
           [else (create-inex (quotient new-mantissa 10)
                              (if (and (equal? (inex-sign in2) -1)
                                       (equal? (inex-exponent in2) 1))
                                  1
                                  (inex-sign in1))
                              new-exponent)]))]
       [else
        (local ((define new-exponent ((if (equal? (inex-sign in2) 1) + -) (inex-exponent in2) 2)))
         (cond
           [(> new-exponent 99) (error ERROR)]
           [else (create-inex (quotient new-mantissa 100)
                              (if (and (equal? (inex-sign in2) -1)
                                       (equal? (inex-exponent in2) 1))
                                  1
                                  (inex-sign in1))
                              new-exponent)]))])))

; Inex Inex -> Inex
; adds two Inex representations of numbers that have the same exponent or exponent differs by one
(check-expect (inex+ (create-inex 5 1 0) (create-inex 3 1 0)) (create-inex 8 1 0))
(check-expect (inex+ (create-inex 5 1 0) (create-inex 6 1 0)) (create-inex 11 1 0))
(check-expect (inex+ (create-inex 58 1 0) (create-inex 43 1 0)) (create-inex 10 1 1))
(check-expect (inex+ (create-inex 58 -1 1) (create-inex 43 -1 1)) (create-inex 10 1 0))
(check-expect (inex+ (create-inex 99 1 60) (create-inex 99 1 60)) (create-inex 19 1 61))
(check-error (inex+ (create-inex 90 1 99) (create-inex 10 1 99)) ERROR)
(check-expect
  (inex+ (create-inex 1 1 0) (create-inex 1 -1 1))
  (create-inex 11 -1 1))
(check-expect
  (inex+ (create-inex 99 1 0) (create-inex 99 1 1))
  (create-inex 10 1 2))
(check-expect
  (inex+ (create-inex 15 -1 30) (create-inex 97 -1 29))
  (create-inex 24 -1 28))
(check-error (inex+ (create-inex 5 -1 1) (create-inex 15 1 1)) ERROR)
(define (inex+ in1 in2)
  (local
    ((define (first-exponent-lesser-by-one? inx1 inx2)
       (or (and (equal? (inex-sign inx1) (inex-sign inx2))
                (equal? (+ 1 (inex-exponent inx1)) (inex-exponent inx2)))
           (and (equal? -1 (inex-sign inx1))
                (equal? 1 (inex-sign inx2))
                (equal? 1 (inex-exponent inx1))
                (equal? 0 (inex-exponent inx2))))))
    (cond
      [(and (equal? (inex-sign in1) (inex-sign in2))
            (equal? (inex-exponent in1) (inex-exponent in2)))
       (inex+/equal in1 in2)]
      [(first-exponent-lesser-by-one? in1 in2)
       (inex+/equal (make-inex (* (inex-mantissa in2) 10) (inex-sign in2) (inex-exponent in2)) in1)]
      [(first-exponent-lesser-by-one? in2 in1)
       (inex+/equal (make-inex (* (inex-mantissa in1) 10) (inex-sign in1) (inex-exponent in1)) in2)]
      [else (error ERROR)])))