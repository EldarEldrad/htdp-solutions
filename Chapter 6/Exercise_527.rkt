;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_527) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define LEFT-FACTOR 0.65)
(define RIGHT-FACTOR 0.8)
(define LEFT-ANGLE -0.2)
(define RIGHT-ANGLE 0.25)

; Image Number Number Number Number -> Image 
; generative adds the line with x and y are coordinates of line's base point 
; given length and angle then adds two new lines at specific points
; unless the line is too short
; accumulator the function accumulates the savannah tree of scene0
(define (add-savannah scene0 x y l a)
  (cond
    [(too-small? l) scene0]
    [else
     (local
       ((define scene1 (add-savannah-line scene0 x y l a))
        (define left-base-x (+ x (* 1/2 l (sin a))))
        (define left-base-y (- y (* 1/2 l (cos a))))
        (define right-base-x (/ (+ (+ x (* l (sin a))) left-base-x) 2))
        (define right-base-y (/ (+ (- y (* l (cos a))) left-base-y) 2))
        (define scene2
          (add-savannah scene1 left-base-x left-base-y (* l LEFT-FACTOR) (+ a LEFT-ANGLE))))
       ; —IN—
       (add-savannah scene2 right-base-x right-base-y (* l RIGHT-FACTOR) (+ a RIGHT-ANGLE)))]))

(define THRESHOLD 5)

; Number -> Boolean 
; is the line too small to create another branch of savannah tree
(check-expect (too-small? (/ THRESHOLD 2)) #true)
(check-expect (too-small? THRESHOLD) #true)
(check-expect (too-small? (+ THRESHOLD 1)) #false)
(define (too-small? l)
  (<= l THRESHOLD))

; Image Posn Posn Posn -> Image 
; adds the black triangle a, b, c to scene
(check-expect (add-savannah-line (empty-scene 50 100) 25 100 50 0)
              (scene+line (empty-scene 50 100) 25 50 25 100 "red"))
(define (add-savannah-line scene x y l a)
  (scene+line scene x y (+ x (* l (sin a))) (- y (* l (cos a))) "red"))

(add-savannah (empty-scene 140 140) 70 140 40 0)