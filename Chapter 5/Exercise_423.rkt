;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_423) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; String Number -> [List-of String]
; produces a list of string chunks of size n
(check-expect (partition "abcdefgh" 2) '("ab" "cd" "ef" "gh"))
(check-expect (partition "abcdefgh" 3) '("abc" "def" "gh"))
(check-expect (partition "ab" 3) '("ab"))
(check-expect (partition "" 3) '())
(define (partition s n)
  (cond
    [(equal? s "") '()]
    [(<= (string-length s) n) (list s)]
    [else
     (cons (substring s 0 n)
           (partition (substring s n) n))]))