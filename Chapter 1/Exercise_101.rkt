;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_101) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct sigs [ufo tank missile])
; A SIGS.v2 (short for SIGS version 2) is a structure:
;   (make-sigs UFO Tank MissileOrNot)
; interpretation represents the complete state of a
; space invader game
 
; A MissileOrNot is one of: 
; – #false
; – Posn
; interpretation#false means the missile is in the tank;
; Posn says the missile is at that location

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

(define TEST-BACKGROUND (place-image UFO 50 50
                                        (place-image TANK
                                                     40 Y-TANK
                                                     BACKGROUND)))

; MissileOrNot Image -> Image 
; adds an image of missile m to scene s
(check-expect (missile-render.v2 #false TEST-BACKGROUND) TEST-BACKGROUND)
(check-expect (missile-render.v2 (make-posn 32 (- MT-HEIGHT TANK-HEIGHT 10)) TEST-BACKGROUND)
              (place-image ROCKET 32 (- MT-HEIGHT TANK-HEIGHT 10) TEST-BACKGROUND))
(define (missile-render.v2 m s)
  (cond
    [(boolean? m) s]
    [(posn? m) (place-image ROCKET (posn-x m) (posn-y m) s)]))