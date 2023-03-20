;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_503) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define ERROR "All rows start with 0s")

; Matrix -> Matrix 
; finds a row that doesn't start with 0 and
; uses it as the first one
; generative moves the first row to last place 
; no termination if all rows start with 0
(check-expect (rotate '((0 4 5) (1 2 3)))
              '((1 2 3) (0 4 5)))
(check-expect (rotate '((0 4 5) (6 7 8) (1 2 3)))
              '((6 7 8) (1 2 3) (0 4 5)))
(check-expect (rotate '((0 4 5) (0 7 8) (1 2 3)))
              '((1 2 3) (0 4 5) (0 7 8)))
(check-error (rotate '((0 4 5) (0 7 8) (0 2 3))) ERROR)
(define (rotate M)
  (cond
    [(not (= (first (first M)) 0)) M]
    [(andmap (lambda (row) (= (first row) 0)) M) (error ERROR)]
    [else
     (rotate (append (rest M) (list (first M))))]))

; Matrix -> Matrix 
; finds a row that doesn't start with 0 and
; uses it as the first one
; generative moves the first row to last place 
; no termination if all rows start with 0
(check-expect (rotate.v2 '((0 4 5) (1 2 3)))
              '((1 2 3) (0 4 5)))
(check-expect (rotate.v2 '((0 4 5) (6 7 8) (1 2 3)))
              '((6 7 8) (1 2 3) (0 4 5)))
(check-expect (rotate.v2 '((0 4 5) (0 7 8) (1 2 3)))
              '((1 2 3) (0 7 8) (0 4 5)))
(check-error (rotate.v2 '((0 4 5) (0 7 8) (0 2 3))) ERROR)
(define (rotate.v2 M0)
  (local (; Matrix Row -> Matrix 
          ; accumulator seen are rows that starts with 0s
          (define (rotate/a M seen)
            (cond
              [(empty? M) (error ERROR)]
              [(not (= (first (first M)) 0)) (append M seen)]
              [else (rotate/a (rest M) (cons (first M) seen))])))
    (rotate/a M0 '())))

; N -> Matrix
; generates matrix with N rows
(check-expect (build-matrix 0) '(()))
(check-expect (build-matrix 1) '((1)))
(check-expect (build-matrix 2) '((0 1) (1 2)))
(check-expect (build-matrix 3) '((0 1 2) (0 1 2) (1 2 3)))
(check-expect (build-matrix 4) '((0 1 2 3) (0 1 2 3) (0 1 2 3) (1 2 3 4)))
(define (build-matrix n)
  (local ((define (build-row m)
            (cond
              [(= m 0) '(())]
              [(= m 1) (list (build-list n add1))]
              [else (cons (build-list n (lambda (x) x))
                          (build-row (sub1 m)))])))
    (build-row n)))

; (time (rotate (build-matrix 1000)))
; real time: 171
; (time (rotate.v2 (build-matrix 1000)))
; real time: 13