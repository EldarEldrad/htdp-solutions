;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise_252) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
; [List-of Number] -> Number
(check-expect (product '()) 1)
(check-expect (product '(1)) 1)
(check-expect (product '(1 2)) 2)
(check-expect (product '(-5 6 -2 1)) 60)
(check-expect (product '(1 2 3 4 5 6)) 720)
(check-expect (product '(542 -56 0 124 -56)) 0)
(define (product l)
  (fold2 * 1 l))

; [List-of Posn] -> Image
(check-expect (image* '()) emt)
(check-expect (image* (list (make-posn 4 5))) (place-image dot 4 5 emt))
(check-expect (image* (list (make-posn 4 5) (make-posn 35 42)))
              (place-image dot 4 5 (place-image dot 35 42 emt)))
(define (image* l)
  (fold2 place-dot emt l))
 
; Posn Image -> Image 
(define (place-dot p img)
  (place-image
     dot
     (posn-x p) (posn-y p)
     img))
 
; graphical constants:    
(define emt
  (empty-scene 100 100))
(define dot
  (circle 3 "solid" "red"))


; [X Y -> Y] Y [List-of X] -> Y
; folds given list into single value using folding function and initial value
(define (fold2 f n l)
  (cond
    [(empty? l) n]
    [else (f (first l)
             (fold2 f n (rest l)))]))