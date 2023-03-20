;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_481) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define QUEENS 8)
; A QP is a structure:
;   (make-posn CI CI)
; A CI is an N in [0,QUEENS).
; interpretation (make-posn r c) denotes the square at 
; the r-th row and c-th column

; N -> [[List-of QP] -> Boolean]
; produces a predicate on queen placements that determines
; whether a given placement is a solution to an n queens puzzle
(check-satisfied (list (make-posn 0 1) (make-posn 1 3) (make-posn 2 0) (make-posn 3 2))
                 (n-queens-solution? 4))
(check-satisfied (list (make-posn 0 0))
                 (n-queens-solution? 1))
(define (n-queens-solution? n)
  (local ((define (non-treating-other? loqp)
            (cond
              [(or (empty? loqp) (empty? (rest loqp))) #true]
              [else
               (and (andmap (lambda (qp) (not (threatening? qp (first loqp)))) (rest loqp))
                    (non-treating-other? (rest loqp)))])))
    (lambda (loqp)
      (and (equal? (length loqp) n)
           (non-treating-other? loqp)))))

; QP QP -> Boolean
; determines whether queens placed on the two respective squares would threaten each other
(check-expect (threatening? (make-posn 5 1) (make-posn 0 1)) #true)
(check-expect (threatening? (make-posn 5 1) (make-posn 0 0)) #false)
(check-expect (threatening? (make-posn 5 1) (make-posn 5 6)) #true)
(check-expect (threatening? (make-posn 5 1) (make-posn 2 4)) #true)
(check-expect (threatening? (make-posn 5 1) (make-posn 7 3)) #true)
(check-expect (threatening? (make-posn 1 0) (make-posn 0 2)) #false)
(check-expect (threatening? (make-posn 2 0) (make-posn 1 2)) #false)
(check-expect (threatening? (make-posn 1 2) (make-posn 4 3)) #false)
(define (threatening? qp1 qp2)
  (or (equal? (posn-x qp1) (posn-x qp2))
      (equal? (posn-y qp1) (posn-y qp2))
      (equal? (+ (posn-x qp1) (posn-y qp1))
              (+ (posn-x qp2) (posn-y qp2)))
      (equal? (- (posn-x qp1) (posn-x qp2))
              (- (posn-y qp1) (posn-y qp2)))))