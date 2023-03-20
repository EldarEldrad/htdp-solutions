;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise_257) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
; [X Y] [X Y -> Y] Y [List-of X] -> Y
; f*oldl works just like foldl
(check-expect (f*oldl cons '() '(a b c))
              (foldl cons '() '(a b c)))
(check-expect (f*oldl / 1 '(6 3 2))
              (foldl / 1 '(6 3 2)))
(define (f*oldl f e l)
  (foldr f e (reverse l)))

; [X] N [N -> X] -> [List-of X]
; constructs a list by applying f to 0, 1, ..., (sub1 n)
(check-expect (build-l*st 5 identity) (build-list 5 identity))
(check-expect (build-l*st 0 sqr) (build-list 0 sqr))
(check-expect (build-l*st 3 add1) (build-list 3 add1))
(define (build-l*st n f)
  (cond
    [(zero? n) '()]
    [else
     (add-at-end (build-l*st (sub1 n) f)
                 (f (sub1 n)))]))

; [X] [List-of X] X -> [List-of X]
; adds given element at the end of the given list
(check-expect (add-at-end '() 10) '(10))
(check-expect (add-at-end '(5 6) 10) '(5 6 10))
(check-expect (add-at-end '("c") "bh") '("c" "bh"))
(check-expect (add-at-end '(#true #true #false) #true) '(#true #true #false #true))
(check-expect (add-at-end (list (make-posn 10 10) (make-posn 20 10) (make-posn 20 20) (make-posn 10 20))
                          (make-posn 20 30))
              (list (make-posn 10 10) (make-posn 20 10) (make-posn 20 20) (make-posn 10 20) (make-posn 20 30)))
(define (add-at-end pol p)
  (cond
    [(empty? pol) (list p)]
    [else (cons (first pol)
                (add-at-end (rest pol) p))]))