;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise_187) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define-struct gp [name score])
; A GamePlayer is a structure: 
;    (make-gp String Number)
; interpretation (make-gp p s) represents player p who 
; scored a maximum of s points 

; List-of-GP -> List-of-GP
; produces a sorted version of given list of game player by score
(check-expect (sort> '()) '())
(check-expect (sort> (list (make-gp "Harry" 3))) (list (make-gp "Harry" 3)))
(check-expect (sort> (list (make-gp "Harry" 3) (make-gp "Sally" 2)))
              (list (make-gp "Harry" 3) (make-gp "Sally" 2)))
(check-expect (sort> (list (make-gp "Sally" 2) (make-gp "Harry" 3)))
              (list (make-gp "Harry" 3) (make-gp "Sally" 2)))
(check-expect (sort> (list (make-gp "Sally" 2) (make-gp "Harry" 3) (make-gp "Gary" 4)))
              (list (make-gp "Gary" 4) (make-gp "Harry" 3) (make-gp "Sally" 2)))
(check-expect (sort> (list  (make-gp "Harry" 3) (make-gp "Gary" 4) (make-gp "Sally" 2)))
              (list (make-gp "Gary" 4) (make-gp "Harry" 3) (make-gp "Sally" 2)))
(define (sort> alog)
  (cond
    [(empty? alog) '()]
    [else
     (insert (first alog) (sort> (rest alog)))]))

; GP List-of-GP -> List-of-GP
; inserts gp into the sorted list of game players
(check-expect (insert (make-gp "Harry" 3) '()) (list (make-gp "Harry" 3)))
(check-expect (insert (make-gp "Harry" 3) (list (make-gp "Sally" 2)))
              (list (make-gp "Harry" 3) (make-gp "Sally" 2)))
(check-expect (insert (make-gp "Sally" 2) (list (make-gp "Harry" 3)))
              (list (make-gp "Harry" 3) (make-gp "Sally" 2)))
(check-expect (insert (make-gp "Harry" 3) (list (make-gp "Gary" 4) (make-gp "Sally" 2)))
              (list (make-gp "Gary" 4) (make-gp "Harry" 3) (make-gp "Sally" 2)))
(define (insert gp l)
  (cond
    [(empty? l) (cons gp '())]
    [else (if (compare-score> gp (first l))
              (cons gp l)
              (cons (first l) (insert gp (rest l))))]))

; GP GP -> Boolean
; returns true if first game player has more or equal score than second game player
(check-expect (compare-score> (make-gp "Harry" 3) (make-gp "Sally" 2)) #true)
(check-expect (compare-score> (make-gp "Sally" 2) (make-gp "Harry" 3)) #false)
(check-expect (compare-score> (make-gp "Sally" 2) (make-gp "Sally" 2)) #true)
(check-expect (compare-score> (make-gp "Sally" 2) (make-gp "Gary" 4)) #false)
(define (compare-score> gp1 gp2)
  (>= (gp-score gp1) (gp-score gp2)))