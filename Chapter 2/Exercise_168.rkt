;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_168) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; List-of-posns -> List-of-posns
; consumes a list of Posns and produces the list of Posns where all y coordinates are increased by one
(check-expect (translate '()) '())
(check-expect (translate (cons (make-posn 1 2) '())) (cons (make-posn 1 3) '()))
(check-expect (translate (cons (make-posn -3 0) (cons (make-posn 3 5) '())))
              (cons (make-posn -3 1) (cons (make-posn 3 6) '())))
(check-expect (translate (cons (make-posn 2 6) (cons (make-posn -3 -1) '())))
              (cons (make-posn 2 7) (cons (make-posn -3 0) '())))
(define (translate lop)
  (cond
    [(empty? lop) '()]
    [else
     (cons (translate-posn (first lop))
           (translate (rest lop)))]))

; Posn -> Posn
; changes posn by increasing its y-coordinate by one
(check-expect (translate-posn (make-posn 0 0)) (make-posn 0 1))
(check-expect (translate-posn (make-posn 3 6)) (make-posn 3 7))
(check-expect (translate-posn (make-posn 13.6 -0.4)) (make-posn 13.6 0.6))
(define (translate-posn p)
  (make-posn (posn-x p)
             (+ (posn-y p) 1)))