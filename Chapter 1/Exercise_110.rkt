;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_110) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; Any -> Number
; computes the area of a disk with radius v, 
; if v is a number
(check-error (checked-area-of-disk 0) "area-of-disk: positive number expected")
(check-error (checked-area-of-disk -5) "area-of-disk: positive number expected")
(check-error (checked-area-of-disk "my-disk") "area-of-disk: positive number expected")
(check-expect (checked-area-of-disk 1) 3.14)
(define (checked-area-of-disk v)
  (cond
    [(and (number? v) (positive? v)) (area-of-disk v)]
    [else (error "area-of-disk: positive number expected")]))

; Number -> Number
; computes the area of a disk with radius r
(check-expect (area-of-disk 1) 3.14)
(check-expect (area-of-disk 0) 0)
(check-expect (area-of-disk -5) (area-of-disk 5))
(define (area-of-disk r)
  (* 3.14 (* r r)))