;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_490) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; [List-of Number] -> [List-of Number]
; converts a list of relative to absolute distances
; the first number represents the distance to the origin
(check-expect (relative->absolute '(50 40 70 30 30))
              '(50 90 160 190 220))
(define (relative->absolute l)
  (cond
    [(empty? l) '()]
    [else (local ((define rest-of-l
                    (relative->absolute (rest l)))
                  (define adjusted
                    (add-to-each (first l) rest-of-l)))
            (cons (first l) adjusted))]))
 
; Number [List-of Number] -> [List-of Number]
; adds n to each number on l
(check-expect (cons 50 (add-to-each 50 '(40 110 140 170)))
              '(50 90 160 190 220))
(define (add-to-each n l)
  (map (lambda (elem) (+ elem n)) l))

(relative->absolute (build-list 1 add1))
; -> (relative->absolute (list 1))
; -> (relative->absolute '())
; -> (add-to-each 1 '())

(relative->absolute (build-list 2 add1))
; -> (relative->absolute (list 1 2))
; -> (relative->absolute (list 2))
; -> (relative->absolute '())
; -> (add-to-each 1 '())
; -> (add-to-each 1 (list 2))


(relative->absolute (build-list 3 add1))
; -> (relative->absolute (list 1 2 3))
; -> (relative->absolute (list 2 3))
; -> (relative->absolute (list 3))
; -> (relative->absolute '())
; -> (add-to-each 3 '())
; -> (add-to-each 2 (list 3))
; -> (add-to-each 1 (list 2 5))

; thus, we need N add-to-each, each of it  is O(n). Therefore, running time is O(n^2)