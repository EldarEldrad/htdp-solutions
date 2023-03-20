;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_416) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; Number -> Number
; computes n that is
; (expt #i10.0 n) return inexact number
; (expt #i10. (- n 1)) is approximated with 0
(check-expect (compute-n 0) -323)
(check-expect (compute-n -60) -323)
(check-expect (compute-n -323) -323)
(check-error (compute-n -324) "Number is too small")
(define (compute-n n)
  (cond
    [(equal? (expt #i10.0 n) #i0.0) (error "Number is too small")]
    [(and (inexact? (expt #i10.0 n))
          (equal? (expt #i10.0 (- n 1)) #i0.0)) n]
    [else (compute-n (- n 1))]))