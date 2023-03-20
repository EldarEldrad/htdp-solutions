;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_422) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; [List-of 1String] N -> [List-of String]
; bundles chunks of s into strings of length n
(check-expect (bundle '("a" "b" "c" "d" "e" "f" "g" "h") 2) '("ab" "cd" "ef" "gh"))
(check-expect (bundle '("a" "b" "c" "d" "e" "f" "g" "h") 3) '("abc" "def" "gh"))
(check-expect (bundle '("a" "b") 3) (list "ab"))
(check-expect (bundle '() 3) '())
(check-error (bundle '("") 3))
(define (bundle s n)
  (map implode (list->chunks s n)))
 
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

; [List-of Any] N -> [List-of [List-of Any]]
; consumes a list l of arbitrary data and a natural number n.
; The function’s result is a list of list chunks of size n.
; Each chunk represents a sub-sequence of items in l.
(check-expect (list->chunks '("a" "b" "c" "d" "e" "f" "g" "h") 2) '(("a" "b") ("c" "d") ("e" "f") ("g" "h")))
(check-expect (list->chunks '("a" "b" "c" "d" "e" "f" "g" "h") 3) '(("a" "b" "c") ("d" "e" "f") ("g" "h")))
(check-expect (list->chunks '("a" "b") 3) '(("a" "b")))
(check-expect (list->chunks '() 3) '())
(check-expect (list->chunks '("") 3) '(("")))
(define (list->chunks l n)
  (cond
    [(empty? l) '()]
    [else
     (cons (take l n) (list->chunks (drop l n) n))]))
