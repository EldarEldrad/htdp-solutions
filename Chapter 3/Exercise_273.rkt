;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_273) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; [X] [X -> Y] [List-of X] -> [List-of Y]
; map defined via fold
(check-expect (map-fold sqr (build-list 6 add1)) (map sqr (build-list 6 add1)))
(check-expect (map-fold identity '("a" "b" "c")) (map identity '("a" "b" "c")))
(check-expect (map-fold explode '("Hello" "world")) (map explode '("Hello" "world")))
(check-expect (map-fold sub1 '()) (map sub1 '()))
(define (map-fold f l)
  (local (; [X Y] X [List-of Y] -> [List-of Y]
          (define (map-elem n list)
            (cons (f n) list)))
    (foldr map-elem '() l)))