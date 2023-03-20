;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise_192) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
; A Polygon is one of:
; – (list Posn Posn Posn)
; – (cons Posn Polygon)

; An NELoP is one of: 
; – (cons Posn '())
; – (cons Posn NELoP)

; Polygon -> Posn
; extracts the last item from p
(check-expect (last (list (make-posn 20 10) (make-posn 0 0) (make-posn 54 87) (make-posn 43 23)))
              (make-posn 43 23))
(check-expect (last (list (make-posn 20 10) (make-posn 0 0) (make-posn 54 87))) (make-posn 54 87))
(define (last p)
  (cond
    [(empty? (rest (rest (rest p)))) (third p)]
    [else (last (rest p))]))

; it is acceptable to use last on Polygon, because Polygon always has at least three elements in its list
; thus it is always has last element

; this template can be adapted from connect-dots because both functions take NELoP as an argument