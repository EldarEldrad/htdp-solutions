;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_482) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; Board N -> [Maybe [List-of QP]]
; places n queens on board; otherwise, returns #false
(define (place-queens a-board n)
  (local ((define spots (find-open-spots a-board))
          (define (place-at-spots los)
            (cond
              [(empty? los) #false]
              [else (local ((define new-board (place-queens (add-queen a-board (first los)) (- n 1))))
                      (if (cons? new-board)
                          new-board
                          (place-at-spots (rest los))))])))
    (cond
      [(= n 0) (board->loqp a-board)]
      [else (place-at-spots spots)])))

; N -> Board 
; creates the initial n by n board
(define (board0 n) ...)
 
; Board QP -> Board 
; places a queen at qp on a-board
(define (add-queen a-board qp)
  a-board)
 
; Board -> [List-of QP]
; finds spots where it is still safe to place a queen
(define (find-open-spots a-board)
  '())

; Board -> [List-of QP]
; returns list of placed queens for given Board
(define (board->loqp a-board)
  '())
