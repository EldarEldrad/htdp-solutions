;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_169) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; List-of-posns -> List-of-posns
; consumes and produces a list of Posns
; the result contains all those Posns whose x-coordinates are between 0 and 100
; and whose y-coordinates are between 0 and 200.
(check-expect (legal '()) '())
(check-expect (legal (cons (make-posn 1 2) '())) (cons (make-posn 1 2) '()))
(check-expect (legal (cons (make-posn -3 0) (cons (make-posn 3 5) '())))
              (cons (make-posn 3 5) '()))
(check-expect (legal (cons (make-posn 2 6) (cons (make-posn -3 -1) '())))
              (cons (make-posn 2 6) '()))
(check-expect (legal (cons (make-posn 45 76) (cons (make-posn 114 234) (cons (make-posn 0 0) '()))))
              (cons (make-posn 45 76) (cons (make-posn 0 0) '())))
(define (legal lop)
  (cond
    [(empty? lop) '()]
    [(legal-posn? (first lop))
     (cons (first lop)
           (legal (rest lop)))]
    [else (legal (rest lop))]))

; Posn -> Boolean
; returns true, if x-coordinate is between 0 and 100
; and y-coordinates is between 0 and 200
; otherwise returns false
(check-expect (legal-posn? (make-posn 0 0)) #true)
(check-expect (legal-posn? (make-posn 3 6)) #true)
(check-expect (legal-posn? (make-posn 13.6 -0.4)) #false)
(check-expect (legal-posn? (make-posn -13.6 67)) #false)
(check-expect (legal-posn? (make-posn 123 45)) #false)
(check-expect (legal-posn? (make-posn 98 201)) #false)
(define (legal-posn? p)
  (and (<= 0 (posn-x p) 100)
       (<= 0 (posn-y p) 200)))