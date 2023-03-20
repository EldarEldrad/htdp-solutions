;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_097) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
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

; SIGS -> Image
; adds TANK, UFO, and possibly MISSILE to 
; the BACKGROUND scene
(check-expect (si-render (make-aim (make-posn 20 10) (make-tank 28 -3)))
              (place-image UFO 20 10
                           (place-image TANK
                                        28 Y-TANK
                                        BACKGROUND)))

(check-expect (si-render (make-fired (make-posn 20 10)
                                     (make-tank 28 -3)
                                     (make-posn 28 (- MT-HEIGHT TANK-HEIGHT))))
              (place-image ROCKET
                           28 (- MT-HEIGHT TANK-HEIGHT)
                           (place-image UFO 20 10
                                        (place-image TANK
                                                     28 Y-TANK
                                                     BACKGROUND))))
(check-expect (si-render (make-fired (make-posn 20 100)
                                     (make-tank 100 3)
                                     (make-posn 22 103)))
              (place-image ROCKET
                           22 103
                           (place-image UFO 20 100
                                        (place-image TANK
                                                     100 Y-TANK
                                                     BACKGROUND))))
(define (si-render s)
  (cond
    [(aim? s)
     (tank-render (aim-tank s)
                  (ufo-render (aim-ufo s) BACKGROUND))]
    [(fired? s)
     (missile-render
       (fired-missile s)
       (ufo-render (fired-ufo s)
                   (tank-render (fired-tank s)
                                BACKGROUND)))]))

; Tank Image -> Image 
; adds t to the given image im
(check-expect (tank-render (make-tank 22 -2) BACKGROUND)
              (place-image TANK 22 Y-TANK BACKGROUND))
(check-expect (tank-render (make-tank 50 2) BACKGROUND)
              (place-image TANK 50 Y-TANK BACKGROUND))
(check-expect (tank-render (make-tank 22 103)
                           (place-image ROCKET 20 100
                                        (place-image UFO
                                                     100 50
                                                     BACKGROUND)))
              (place-image TANK 22 Y-TANK (place-image ROCKET 20 100
                                                       (place-image UFO
                                                                    100 50
                                                                    BACKGROUND))))
(define (tank-render t im)
  (place-image TANK (tank-loc t) Y-TANK im))
 
; UFO Image -> Image 
; adds u to the given image im
(check-expect (ufo-render (make-posn 22 103) BACKGROUND)
              (place-image UFO 22 103 BACKGROUND))
(check-expect (ufo-render (make-posn 50 50) BACKGROUND)
              (place-image UFO 50 50 BACKGROUND))
(check-expect (ufo-render (make-posn 22 103)
                          (place-image ROCKET 20 100
                                       (place-image TANK
                                                    100 Y-TANK
                                                    BACKGROUND)))
              (place-image UFO 22 103 (place-image ROCKET 20 100
                                                   (place-image TANK
                                                                100 Y-TANK
                                                                BACKGROUND))))
(define (ufo-render u im)
  (place-image UFO (posn-x u) (posn-y u) im))

; Missile Image -> Image 
; adds m to the given image im
(check-expect (missile-render (make-posn 22 103) BACKGROUND)
              (place-image ROCKET 22 103 BACKGROUND))
(check-expect (missile-render (make-posn 50 50) BACKGROUND)
              (place-image ROCKET 50 50 BACKGROUND))
(check-expect (missile-render (make-posn 22 103)
                              (place-image UFO 20 100
                                           (place-image TANK
                                                        100 Y-TANK
                                                        BACKGROUND)))
              (place-image ROCKET 22 103 (place-image UFO 20 100
                                                      (place-image TANK
                                                                   100 Y-TANK
                                                                   BACKGROUND))))
(define (missile-render m im)
  (place-image ROCKET (posn-x m) (posn-y m) im))

; Generally speaking,
; (tank-render
;   (fired-tank s)
;   (ufo-render (fired-ufo s)
;               (missile-render (fired-missile s)
;                               BACKGROUND)))
; and
; (ufo-render
;   (fired-ufo s)
;   (tank-render (fired-tank s)
;                (missile-render (fired-missile s)
;                                BACKGROUND)))
; produce different results because ufo and tank can overlap each other and in that case order differs.
; Otherwise they generate the same image.