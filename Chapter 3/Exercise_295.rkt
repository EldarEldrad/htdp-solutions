;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_295) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; distances in terms of pixels 
(define WIDTH 300)
(define HEIGHT 300)

; N -> [List-of Posn]
; generates n random Posns in [0,WIDTH) by [0,HEIGHT)
(check-satisfied (random-posns 3)
                 (n-inside-playground? 3))
(define (random-posns n)
  (build-list
    n
    (lambda (i)
      (make-posn (random WIDTH) (random HEIGHT)))))

; N -> [List-of Posn]
; badly generates n random Posns in [0,WIDTH) by [0,HEIGHT)
(check-satisfied (random-posns/bad 3)
                 (n-inside-playground? 3))
(define (random-posns/bad n)
  (build-list n
              (lambda (x) (make-posn x x))))

; N -> [[List-of Posn] -> Boolean]
; generates a predicate that ensures that the length of the given list is some given count
; and that all Posns in this list are within a WIDTH by HEIGHT rectangle
(define (n-inside-playground? n)
  (lambda (l)
    (local ((define (within-range? p)
              (and (>= (posn-x p) 0) (>= (posn-y p) 0)
                   (> WIDTH (posn-x p)) (> HEIGHT (posn-y p)))))
      (and (equal? (length l) n)
           (andmap within-range? l)))))