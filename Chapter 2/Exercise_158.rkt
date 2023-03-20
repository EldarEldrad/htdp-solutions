;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_158) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define HEIGHT 80) ; distances in terms of pixels 
(define WIDTH 100)
(define XSHOTS (/ WIDTH 2))
 
; graphical constants 
(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define SHOT (triangle 3 "solid" "red"))

; A ShotWorld is List-of-numbers. 
; interpretation each number on such a list
;   represents the y-coordinate of a shot

; ShotWorld -> Image
; adds the image of a shot for each  y on w 
; at (MID,y) to the background image
(check-expect (to-image '())
              BACKGROUND)
(check-expect (to-image (cons 9 '()))
              (place-image SHOT XSHOTS 9 BACKGROUND))
(check-expect (to-image (cons 9 (cons 5 '())))
              (place-image SHOT XSHOTS 9
                           (place-image SHOT XSHOTS 5 BACKGROUND)))
(define (to-image w)
  (cond
    [(empty? w) BACKGROUND]
    [else (place-image SHOT XSHOTS (first w)
                       (to-image (rest w)))]))

; ShotWorld -> ShotWorld
; moves each shot on w up by one pixel
(check-expect (tock '()) '())
(check-expect (tock (cons 4 '())) (cons 3 '()))
(check-expect (tock (cons 0 '())) '())
(check-expect (tock (cons 9 (cons 5 '())))
              (cons 8 (cons 4 '())))
(check-expect (tock (cons 9 (cons 0 (cons 5 '()))))
              (cons 8 (cons 4 '())))
(define (tock w)
  (cond
    [(empty? w) '()]
    [(zero? (first w)) (tock (rest w))]
    [else (cons (sub1 (first w)) (tock (rest w)))]))

; ShotWorld KeyEvent -> ShotWorld 
; adds a shot to the world 
; if the player presses the space bar
(check-expect (keyh '() "a") '())
(check-expect (keyh '() " ") (cons HEIGHT '()))
(check-expect (keyh (cons 4 '()) "a") (cons 4 '()))
(check-expect (keyh (cons 4 '()) " ") (cons HEIGHT (cons 4 '())))
(check-expect (keyh (cons 9 (cons 5 '())) "a")
              (cons 9 (cons 5 '())))
(check-expect (keyh (cons 9 (cons 5 '())) " ")
              (cons HEIGHT (cons 9 (cons 5 '()))))
(define (keyh w ke)
  (if (key=? ke " ") (cons HEIGHT w) w))

; ShotWorld -> ShotWorld 
(define (main w0)
  (big-bang w0
    [on-tick tock]
    [on-key keyh]
    [to-draw to-image]))

(main '())