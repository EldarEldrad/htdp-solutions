;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_432) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define MAX 3)

; Posn -> Posn 
; produces a randomly chosen Posn that is guaranteed to be distinct from the given one.
(check-satisfied (food-create (make-posn 1 1)) not=-1-1?)
(define (food-create p)
  (local ((define candidate (make-posn (random MAX) (random MAX))))
    (if (or (equal? p candidate)
            (= 0 (posn-x candidate))
            (= 0 (posn-y candidate)))
        (food-create p) candidate)))

; Posn -> Boolean
; use for testing only 
(define (not=-1-1? p)
  (not (and (= (posn-x p) 1) (= (posn-y p) 1))))