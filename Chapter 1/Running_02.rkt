;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Running_02) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define WIDTH-OF-WORLD 200)
 
(define WHEEL-RADIUS 5)
(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))
(define SPACE
  (rectangle (* 2 WHEEL-RADIUS) 0  "solid" "white"))
(define BOTH-WHEELS
  (beside WHEEL SPACE WHEEL))
(define MAIN-CAR
  (rectangle (* 8 WHEEL-RADIUS) (* 2 WHEEL-RADIUS) "solid" "red"))
(define TOP-CAR
  (rectangle (* 4 WHEEL-RADIUS) WHEEL-RADIUS "solid" "red"))
(define RED-CAR
  (above TOP-CAR MAIN-CAR))
(define CAR
  (underlay/align/offset "middle" "bottom" RED-CAR 0 WHEEL-RADIUS BOTH-WHEELS))

; A WorldState is a Number.
; interpretation the number of pixels between
; the left border of the scene and the car

; WorldState -> Image
; places the car into the BACKGROUND scene,
; according to the given world state 
(define (render cw)
  (place-image CAR cw Y-CAR BACKGROUND))
 
; WorldState -> WorldState 
; moves the car by 3 pixels for every clock tick
(check-expect (tock 20) 23)
(check-expect (tock 78) 81)
(define (tock cw)
  (+ cw 3))

; WorldState -> WorldState
; launches the program from some initial state 
(define (main ws)
   (big-bang ws
     [on-tick tock]
     [to-draw render]))