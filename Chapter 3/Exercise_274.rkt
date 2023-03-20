;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_274) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; Lo1S -> List-of-Lo1S
; consumes a list of 1Strings and produces the list of all prefixes
(check-expect (prefixes '()) '())
(check-expect (prefixes (list "a")) (list (list "a")))
(check-expect (prefixes (list "a" "b")) (list (list "a") (list "a" "b")))
(check-expect (prefixes (list "a" "b" "c")) (list (list "a") (list "a" "b") (list "a" "b" "c")))
(define (prefixes lst)
  (local ((define (add1s s l)
            (local ((define (cons-s elem)
                      (cons s elem)))
              (cons (list s) (map cons-s l)))))
  (foldr add1s '() lst)))

; Lo1S -> List-of-Lo1S
; consumes a list of 1Strings and produces the list of all suffixes
(check-expect (suffixes '()) '())
(check-expect (suffixes (list "a")) (list (list "a")))
(check-expect (suffixes (list "a" "b")) (list (list "a" "b") (list "b")))
(check-expect (suffixes (list "a" "b" "c")) (list (list "a" "b" "c") (list "b" "c") (list "c")))
(define (suffixes lst)
  (local ((define (add1s s l)
            (local ((define (cons-s elem)
                      (append elem (list s))))
              (cons (list s) (map cons-s l)))))
  (reverse (foldl add1s '() lst))))