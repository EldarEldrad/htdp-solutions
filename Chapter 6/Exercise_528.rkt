;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_528) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; Image Posn Posn Posn -> Image
; generates Bezie curve between two points A and C with B as the perspective point
(define (draw-bezier im a c b)
  (cond
    [(too-small? a c) (draw-segment im a c)]
    [else
     (local ((define a-b (mid-point a b))
             (define b-c (mid-point b c))
             (define a-b-c (mid-point a-b b-c))
             (define scene1 (draw-bezier im a a-b-c a-b)))
       (draw-bezier scene1 a-b-c c b-c))]))

; Image Posn Posn -> Image
; draws line on given image between A and B
(check-expect (draw-segment (empty-scene 100 100) (make-posn 30 40) (make-posn 70 20))
              (scene+line (empty-scene 100 100) 30 40 70 20 "red"))
(define (draw-segment im a b)
  (scene+line im (posn-x a) (posn-y a) (posn-x b) (posn-y b) "red"))

(define THRESHOLD 5)

; Posn Posn-> Boolean 
; is the distance between a and b is too small to be divided
(check-expect (too-small? (make-posn 0 0) (make-posn 5 5)) #false)
(check-expect (too-small? (make-posn 0 0) (make-posn 0 11)) #false)
(check-expect (too-small? (make-posn 0 0) (make-posn 4 4)) #false)
(check-expect (too-small? (make-posn 0 0) (make-posn 3 4)) #true)
(check-expect (too-small? (make-posn 0 0) (make-posn 0 -3)) #true)
(define (too-small? a b)
  (<= (sqrt (+ (sqr (- (posn-x a) (posn-x b)))
               (sqr (- (posn-y a) (posn-y b)))))
      THRESHOLD))

; Posn Posn -> Posn 
; determines the midpoint between a and b
(check-expect (mid-point (make-posn 0 0) (make-posn 4 0)) (make-posn 2 0))
(check-expect (mid-point (make-posn 0 0) (make-posn 0 6)) (make-posn 0 3))
(check-expect (mid-point (make-posn 0 0) (make-posn 8 -2)) (make-posn 4 -1))
(check-expect (mid-point (make-posn 43 -2) (make-posn 1 -48)) (make-posn 22 -25))
(define (mid-point a b)
  (make-posn (/ (+ (posn-x a) (posn-x b)) 2)
             (/ (+ (posn-y a) (posn-y b)) 2)))

(draw-bezier (empty-scene 200 200) (make-posn 30 10) (make-posn 150 100) (make-posn 60 190))