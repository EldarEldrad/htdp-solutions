;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_450) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define EPSILON 0.001)
(define ERROR "Interval has no roots")

; [Number -> Number] Number Number -> Number
; determines R such that f has a root in [R,(+ R ε)]
; assume f is monotonicall increasing
; (2) (or (<= (f left) 0 (f right)) (<= (f right) 0 (f left)))
; generative divides interval in half, the root is in 
; one of the two halves, picks according to (2)
; termination each next step has (- right left) which is two times smaller
; thus, for any [right>left] we will eventually get size smaller than EPSILON
(check-satisfied (poly (find-root poly 3.5 6)) (lambda (result) (< (abs result) EPSILON)))
(check-error (find-root poly 0 3) ERROR)
(define (find-root f left right)
  (local ((define (find-root/internal left f@left right f@right)
            (cond
              [(<= (- right left) EPSILON) left]
              [else
               (local ((define mid (/ (+ left right) 2))
                       (define f@mid (f mid)))
                 (cond
                   [(<= f@left 0 f@mid)
                    (find-root/internal left f@left mid f@mid)]
                   [(<= f@mid 0 f@right)
                    (find-root/internal mid f@mid right f@right)]
                   [else (error ERROR)]))])))
    (find-root/internal left (f left) right (f right))))

; Number -> Number
(define (poly x)
  (* (- x 2) (- x 4)))