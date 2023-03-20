;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_445) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define EPSILON 0.001)

; [Number -> Number] Number Number -> Number
; determines R such that f has a root in [R,(+ R ε)]
; assume f is continuous 
; (2) (or (<= (f left) 0 (f right)) (<= (f right) 0 (f left)))
; generative divides interval in half, the root is in 
; one of the two halves, picks according to (2)
(check-satisfied (poly (find-root poly 3 6)) (lambda (result) (< (abs result) EPSILON)))
(define (find-root f left right)
  (cond
    [(<= (- right left) EPSILON) left]
    [else
      (local ((define mid (/ (+ left right) 2))
              (define f@mid (f mid)))
        (cond
          [(or (<= (f left) 0 f@mid) (<= f@mid 0 (f left)))
           (find-root f left mid)]
          [(or (<= f@mid 0 (f right)) (<= (f right) 0 f@mid))
           (find-root f mid right)]))]))

; Number -> Number
(define (poly x)
  (* (- x 2) (- x 4)))

step     left     f left     right     f right     mid     f mid

n=1      3        -1         6.00      8.00        4.50    1.25
n=2      3        -1         4.50      1.25        3.75    -0.4375
n=3      3.75     -0.4375    4.50      1.25        4.125   0.265625
n=4      3.75     -0.4375    4.125     0.265625    3.9375  -0.12109375
n=5      3.9375   -0.1210938 4.125     0.265625    4.03125 0.0634765625
n=6      3.9375   -0.1210938 4.03125   0.063476563 3.98438 -0.0309960156
n=7      3.98438  -0.0309960 4.03125   0.063476563 4.00782 0.0157011524
n=8      3.98438  -0.0309960 4.00782   0.015701152 3.9961  -0.00778479
n=9      3.9961   -0.0077848 4.00782   0.015701152 4.00196 0.0039238416
n=10     3.9961   -0.0077848 4.00196   0.003923842 3.99903 -0.0019390591
n=11     3.99903  -0.0019391 4.00196   0.003923842 4.0005  0.000990245025
n=12     3.99903  -0.0019391 4.0005    0.000990245 3.99977 -0.000469944775
n=13     3.99977  -0.00047   4.0005    0.000990245 -----------------------