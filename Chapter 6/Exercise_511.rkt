;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_511) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(λ (x) x)
;   |  ^
;   |  |
;   ----

(λ (x) y)
; x is bounding , y is free variable

(λ (y) (λ (x) y))
;   |         ^
;   |         |
;   -----------

((λ (x) x) (λ (x) x))
;    |  ^      |  ^
;    |  |      |  |
;    ----      ----

((λ (x) (x x)) (λ (x) (x x)))
;    |   ^ ^       |   ^ ^
;    |   | |       |   | |
;    -------       -------

(((λ (y) (λ (x) y)) (λ (z) z)) (λ (w) w))
;     |         ^       |  ^       |  ^
;     |         |       |  |       |  |
;     -----------       ----       ----