;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_099) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
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
(define BACKGROUND (empty-scene MT-WIDTH MT-HEIGHT))

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

(define UFO-SPEED 5)
(define UFO-RANDOM-STEP (* 2 UFO-SPEED))
(define MISSILE-SPEED 15)
(define TANK-SPEED 3)

; SIGS -> SIGS
; determine new SIGS after one clock tick. Moves missile and tank straightforward,
; moves UFO randomly
(check-random (si-move (make-aim (make-posn 50 0)
                                 (make-tank 40 (- TANK-SPEED))))
              (make-aim (make-posn (+ 50 (random UFO-RANDOM-STEP) (- UFO-SPEED)) UFO-SPEED)
                        (make-tank (- 40 TANK-SPEED) (- TANK-SPEED))))
(check-random (si-move (make-aim (make-posn 50 (/ Y-TANK 2))
                                 (make-tank 40 (- TANK-SPEED))))
              (make-aim (make-posn (+ 50 (random UFO-RANDOM-STEP) (- UFO-SPEED)) (+ (/ Y-TANK 2) UFO-SPEED))
                        (make-tank (- 40 TANK-SPEED) (- TANK-SPEED))))
(check-random (si-move (make-aim (make-posn 50 (/ Y-TANK 2))
                                 (make-tank 0 (- TANK-SPEED))))
              (make-aim (make-posn (+ 50 (random UFO-RANDOM-STEP) (- UFO-SPEED)) (+ (/ Y-TANK 2) UFO-SPEED))
                        (make-tank 0 (- TANK-SPEED))))
(check-random (si-move (make-fired (make-posn 35 10)
                                   (make-tank 40 TANK-SPEED)
                                   (make-posn 48 (/ Y-TANK 2))))
              (make-fired (make-posn (+ 35 (random UFO-RANDOM-STEP) (- UFO-SPEED)) (+ 10 UFO-SPEED))
                          (make-tank (+ 40 TANK-SPEED) TANK-SPEED)
                          (make-posn 48 (- (/ Y-TANK 2) MISSILE-SPEED))))
(check-random (si-move (make-fired (make-posn 35 10)
                                   (make-tank MT-WIDTH TANK-SPEED)
                                   (make-posn 48 (/ Y-TANK 2))))
              (make-fired (make-posn (+ 35 (random UFO-RANDOM-STEP) (- UFO-SPEED)) (+ 10 UFO-SPEED))
                          (make-tank MT-WIDTH TANK-SPEED)
                          (make-posn 48 (- (/ Y-TANK 2) MISSILE-SPEED))))
(define (si-move s)
  (cond
    [(aim? s) (make-aim (make-posn (min MT-WIDTH (max 0 (+ (posn-x (aim-ufo s)) (random UFO-RANDOM-STEP) (- UFO-SPEED))))
                                   (+ (posn-y (aim-ufo s)) UFO-SPEED))
                        (make-tank (min MT-WIDTH (max 0 (+ (tank-loc (aim-tank s)) (tank-vel (aim-tank s)))))
                                   (tank-vel (aim-tank s))))]
    [(fired? s) (make-fired (make-posn (min MT-WIDTH (max 0 (+ (posn-x (fired-ufo s)) (random UFO-RANDOM-STEP) (- UFO-SPEED))))
                                       (+ (posn-y (fired-ufo s)) UFO-SPEED))
                            (make-tank (min MT-WIDTH (max 0 (+ (tank-loc (fired-tank s)) (tank-vel (fired-tank s)))))
                                       (tank-vel (fired-tank s)))
                            (make-posn (posn-x (fired-missile s))
                                       (- (posn-y (fired-missile s)) MISSILE-SPEED)))]))