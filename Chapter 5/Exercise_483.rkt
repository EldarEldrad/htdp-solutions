;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_483) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct board [size queens])
; A Board of a structure:
;   - (make-board N [List-of QP])
; interpratation repsesents board with size N and placed queens on it

(define QUEENS 8)
; A QP is a structure:
;   (make-posn CI CI)
; A CI is an N in [0,QUEENS).
; interpretation (make-posn r c) denotes the square at 
; the r-th row and c-th column

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

; Board N -> [Maybe [List-of QP]]
; places n queens on board; otherwise, returns #false
(check-satisfied (place-queens (board0 4) 4)
                 (n-queens-solution? 4))
(check-satisfied (place-queens (board0 1) 1)
                 (n-queens-solution? 1))
(check-satisfied (place-queens (board0 QUEENS) QUEENS)
                 (n-queens-solution? QUEENS))
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
(define (board0 n) (make-board n '()))
 
; Board QP -> Board 
; places a queen at qp on a-board
(define (add-queen a-board qp)
  (make-board (board-size a-board)
              (cons qp (board-queens a-board))))
 
; Board -> [List-of QP]
; finds spots where it is still safe to place a queen
(define (find-open-spots a-board)
  (local ((define size (board-size a-board))
          ; Number -> [List-of QP]
          (define (find-open-spots/row n-row)
             (cond
               [(= n-row 0) '()]
               [else (append (find-open-spots/column n-row size)
                             (find-open-spots/row (- n-row 1)))]))
          ; Number -> [List-of QP]
          (define (find-open-spots/column n-row n-column)
             (cond
               [(= n-column 0) '()]
               [(not (ormap (lambda (queen) (threatening? queen (make-posn n-row n-column))) (board-queens a-board)))
                (cons (make-posn n-row n-column) (find-open-spots/column n-row (- n-column 1)))]
               [else (find-open-spots/column n-row (- n-column 1))])))
    (find-open-spots/row size)))

; Board -> [List-of QP]
; returns list of placed queens for given Board
(define (board->loqp a-board)
  (board-queens a-board))

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