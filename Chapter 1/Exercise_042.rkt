;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_42) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define HEIGHT-OF-WORLD 40)
(define WIDTH-OF-WORLD 200)

(define TREE
  (underlay/xy (circle 10 "solid" "green")
               9 15
               (rectangle 2 20 "solid" "brown")))

(define MT (empty-scene WIDTH-OF-WORLD HEIGHT-OF-WORLD))
(define BACKGROUND (overlay/xy TREE (* -0.6 WIDTH-OF-WORLD) (- (image-height TREE) HEIGHT-OF-WORLD) MT))

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

(define Y-CAR (- HEIGHT-OF-WORLD (/ (image-height CAR) 2)))

; A WorldState is a Number.
; interpretation the number of pixels between
; the left border of the scene and the right-most edge of the car

; WorldState -> Image
; places the car into the BACKGROUND scene,
; according to the given world state 
(define (render cw)
  (place-image CAR (- cw (/ (image-width CAR) 2)) Y-CAR BACKGROUND))
 
; WorldState -> WorldState 
; moves the car by 3 pixels for every clock tick
(check-expect (tock 20) 23)
(check-expect (tock 78) 81)
(define (tock cw)
  (+ cw 3))

; WorldState -> Boolean
; returns #true is car disappears on the right-side
(check-expect (stop? 0) #false)
(check-expect (stop? WIDTH-OF-WORLD) #false)
(check-expect (stop? (+ WIDTH-OF-WORLD (image-width CAR))) #false)
(check-expect (stop? (+ WIDTH-OF-WORLD (* 2 (image-width CAR)))) #true)
(define (stop? cw)
  (> cw (+ WIDTH-OF-WORLD (image-width CAR))))

; WorldState -> WorldState
; launches the program from some initial state 
(define (main ws)
   (big-bang ws
     [on-tick tock]
     [to-draw render]
     [stop-when stop?]))

(main 0)