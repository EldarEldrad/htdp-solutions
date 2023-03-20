;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_433) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define BUNDLE-ERROR "Chunks should have positive length")

; [List-of 1String] N -> [List-of String]
; bundles chunks of s into strings of length n
(check-expect (bundle '("a" "b" "c" "d" "e" "f" "g" "h") 2) '("ab" "cd" "ef" "gh"))
(check-expect (bundle '("a" "b" "c" "d" "e" "f" "g" "h") 3) '("abc" "def" "gh"))
(check-expect (bundle '("a" "b") 3) (list "ab"))
(check-expect (bundle '() 3) '())
(check-error (bundle '("") 3))
(check-error (bundle '("a" "b" "c") 0) BUNDLE-ERROR)
(check-error (bundle '("a" "b" "c") -4) BUNDLE-ERROR)
(define (bundle s n)
  (cond
    [(<= n 0) (error BUNDLE-ERROR)]
    [(empty? s) '()]
    [else
     (cons (implode (take s n)) (bundle (drop s n) n))]))
 
; [List-of X] N -> [List-of X]
; keeps the first n items from l if possible or everything
(define (take l n)
  (cond
    [(zero? n) '()]
    [(empty? l) '()]
    [else (cons (first l) (take (rest l) (sub1 n)))]))
 
; [List-of X] N -> [List-of X]
; removes the first n items from l if possible or everything
(define (drop l n)
  (cond
    [(zero? n) l]
    [(empty? l) l]
    [else (drop (rest l) (sub1 n))]))