;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_451) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct table [length array])
; A Table is a structure:
;   (make-table N [N -> Number])

(define table1 (make-table 3 (lambda (i) i)))
 
; N -> Number
(define (a2 i)
  (if (= i 0)
      pi
      (error "table2 is not defined for i =!= 0")))
(define table2 (make-table 1 a2))

; Table N -> Number
; looks up the ith value in array of t
(define (table-ref t i)
  ((table-array t) i))

; Table -> Number
; consumes a monotonically increasing table
; and finds the smallest index for a root of the table by linear search
(check-expect (find-linear table1) 0)
(check-expect (find-linear table2) 0)
(check-expect (find-linear (make-table 1024 (lambda (i) (- i 1023)))) 1023)
(check-expect (find-linear (make-table 1024 (lambda (i) (- i 523.2)))) 523)
(define (find-linear t)
  (local ((define tl (table-length t))
          (define (find-linear/internal i)
            (cond
              [(= i (- tl 1)) (- tl 1)]
              [(<= (abs (table-ref t i)) (abs (table-ref t (+ i 1)))) i]
              [else (find-linear/internal (+ i 1))])))
    (find-linear/internal 0)))

; Table -> Number
; consumes a monotonically increasing table
; and finds the smallest index for a root of the table by binary search
; termination size reduced twice each step thus size 1 will be eventually reached which is trivial case
(check-expect (find-binary table1) 0)
(check-expect (find-binary table2) 0)
(check-expect (find-binary (make-table 1024 (lambda (i) (- i 1023)))) 1023)
(check-expect (find-binary (make-table 1024 (lambda (i) (- i 523.2)))) 523)
(define (find-binary t)
  (local ((define tl (table-length t))
          (define (find-binary/internal left t@left right t@right)
            (cond
              [(<= (- right left) 1)
               (if (< (abs t@left) (abs t@right)) left right)]
              [else
               (local ((define mid (quotient (+ right left) 2))
                       (define t@mid (table-ref t mid)))
                 (cond
                   [(<= t@left 0 t@mid) (find-binary/internal left t@left mid t@mid)]
                   [(<= t@mid 0 t@right) (find-binary/internal mid t@mid right t@right)]))])))
    (find-binary/internal 0 (table-ref t 0) (- tl 1) (table-ref t (- tl 1)))))