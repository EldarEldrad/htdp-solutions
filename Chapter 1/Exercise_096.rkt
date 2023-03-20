;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_096) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])

; A UFO is a Posn. 
; interpretation (make-posn x y) is the UFO's location 
; (using the top-down, left-to-right convention)
 
(define-struct tank [loc vel])
; A Tank is a structure:
;   (make-tank Number Number). 
; interpretation (make-tank x dx) specifies the position:
; (x, Y-TANK) and the tank's speed: dx pixels/tick 
 
; A Missile is a Posn. 
; interpretation (make-posn x y) is the missile's place

; A SIGS is one of: 
; – (make-aim UFO Tank)
; – (make-fired UFO Tank Missile)
; interpretation represents the complete state of a 
; space invader game

(define MT-WIDTH 150)
(define MT-HEIGHT 300)
(define MT (empty-scene MT-WIDTH MT-HEIGHT))

(define TANK-WIDTH 20)
(define TANK-HEIGHT 10)
(define TANK (rectangle TANK-WIDTH TANK-HEIGHT "solid" "black"))
(define Y-TANK (- MT-HEIGHT (/ TANK-HEIGHT 2)))

(define ROCKET-SIZE 5)
(define ROCKET (triangle ROCKET-SIZE "solid" "red"))

(define UFO-RADIUS 10)
(define UFO (overlay (circle UFO-RADIUS "solid" "green")
                     (ellipse (* 4 UFO-RADIUS) UFO-RADIUS "solid" "green")))
(define INITIAL-Y-UFO (/ (image-height UFO) 2))


; (make-aim (make-posn 20 10) (make-tank 28 -3))
(place-image UFO 20 10
              (place-image TANK
                           28 Y-TANK
                           MT))

; (make-fired (make-posn 20 10)
;             (make-tank 28 -3)
;             (make-posn 28 (- MT-HEIGHT TANK-HEIGHT)))
(place-image ROCKET
             28 (- MT-HEIGHT TANK-HEIGHT)
             (place-image UFO 20 10
                          (place-image TANK
                                       28 Y-TANK
                                       MT)))

; (make-fired (make-posn 20 100)
;             (make-tank 100 3)
;             (make-posn 22 103))
(place-image ROCKET
             22 103
             (place-image UFO 20 100
                          (place-image TANK
                                       100 Y-TANK
                                       MT)))

