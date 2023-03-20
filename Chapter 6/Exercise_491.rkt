;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_491) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; reverse is O(n^2) by itself or uses accumulator

; [List-of Any] -> [List-of Any]
; reverses given list
(check-expect (reverse.v1 '()) '())
(check-expect (reverse.v1 '(1)) '(1))
(check-expect (reverse.v1 '(a b c fe)) '(fe c b a))
(define (reverse.v1 loa)
  (cond
    [(empty? loa) '()]
    [else (append (reverse.v1 (rest loa)) (list (first loa)))]))

; [List-of Any] -> [List-of Any]
; reverses given list
(check-expect (reverse.v2 '()) '())
(check-expect (reverse.v2 '(1)) '(1))
(check-expect (reverse.v2 '(a b c fe)) '(fe c b a))
(define (reverse.v2 loa)
  (local ((define (last lst)
            (cond
              [(empty? lst) '()]
              [(empty? (rest lst)) (first lst)]
              [else (last (rest lst))]))
          (define (remove-last lst)
            (cond
              [(empty? lst) '()]
              [(empty? (rest lst)) '()]
              [else (cons (first lst)
                          (remove-last (rest lst)))])))
    (cond
      [(empty? loa) '()]
      [else (cons (last loa)
                  (reverse.v2 (remove-last loa)))])))

; [List-of Any] -> [List-of Any]
; reverses given list
(check-expect (reverse.v3 '()) '())
(check-expect (reverse.v3 '(1)) '(1))
(check-expect (reverse.v3 '(a b c fe)) '(fe c b a))
(define (reverse.v3 loa)
  (local ((define (reverse/a res curr)
            (cond
              [(empty? curr) res]
              [else (reverse/a (cons (first curr) res)
                               (rest curr))])))
    (reverse/a '() loa)))