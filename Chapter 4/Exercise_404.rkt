;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_404) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; [X Y -> Boolean] [List-of X] [List-of Y] -> Boolean
; applies f to pairs of corresponding values from the two lists,
; and if f always produces #true, andmap2 produces #true, too.
; Otherwise, andmap2 produces #false
(check-expect (andmap2 equal? '() '()) #true)
(check-expect (andmap2 equal? '(1 2 3 #true f) '(1 2 3 #true f)) #true)
(check-expect (andmap2 >= '(1 2 3) '(1 2 3)) #true)
(check-expect (andmap2 > '(1 2 3) '(1 2 3)) #false)
(define (andmap2 f lox loy)
  (cond
    [(empty? lox) #true]
    [else (and (f (first lox) (first loy)) (andmap2 f (rest lox) (rest loy)))]))