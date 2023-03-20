;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_290) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; [X] [List-of X] [List-of X] -> [List-of X]
; appends two lists using foldr
(check-expect (append-from-fold '() '()) '())
(check-expect (append-from-fold '(2) '()) '(2))
(check-expect (append-from-fold '() '(5)) '(5))
(check-expect (append-from-fold '(2) '(5)) '(2 5))
(check-expect (append-from-fold '("a" "b") '("c")) '("a" "b" "c"))
(check-expect (append-from-fold '(#false '() 25) '("red" (make-posn 3 4)))
              '(#false '() 25 "red" (make-posn 3 4)))
(define (append-from-fold list1 list2)
  (foldr cons list2 list1))

; [List-of Number] -> Number
; compute the sum of a list of numbers
(check-expect (sum '()) 0)
(check-expect (sum '(1)) 1)
(check-expect (sum '(2 5 7)) 14)
(check-expect (sum '(-3 0 3)) 0)
(define (sum lon)
  (foldr + 0 lon))

; [List-of Number] -> Number
; compute the product of a list of numbers
(check-expect (product '()) 1)
(check-expect (product '(0)) 0)
(check-expect (product '(5)) 5)
(check-expect (product '(8 0.125)) 1)
(check-expect (product '(-3 5 8)) -120)
(define (product lon)
  (foldr * 1 lon))

; [List-of Image] -> Image
; horizontally composes a list of Images
(check-expect (compose-hor '()) empty-image)
(check-expect (compose-hor (list (square 50 "solid" "red"))) (square 50 "solid" "red"))
(check-expect (compose-hor (list (square 50 "solid" "red") (square 50 "solid" "yellow")))
              (beside (square 50 "solid" "red") (square 50 "solid" "yellow")))
(check-expect (compose-hor (list (square 50 "solid" "red")
                                 (square 50 "solid" "yellow")
                                 (square 50 "solid" "green")))
              (beside (square 50 "solid" "red") (beside (square 50 "solid" "yellow")
                                                        (square 50 "solid" "green"))))
(define (compose-hor loi)
  (foldr beside empty-image loi))

; [List-of Image] -> Image
; vertically composes a list of Images
(check-expect (compose-ver '()) empty-image)
(check-expect (compose-ver (list (square 50 "solid" "red"))) (square 50 "solid" "red"))
(check-expect (compose-ver (list (square 50 "solid" "red") (square 50 "solid" "yellow")))
              (above (square 50 "solid" "red") (square 50 "solid" "yellow")))
(check-expect (compose-ver (list (square 50 "solid" "red")
                                 (square 50 "solid" "yellow")
                                 (square 50 "solid" "green")))
              (above (square 50 "solid" "red") (above (square 50 "solid" "yellow")
                                                      (square 50 "solid" "green"))))
(define (compose-ver loi)
  (foldr above empty-image loi))