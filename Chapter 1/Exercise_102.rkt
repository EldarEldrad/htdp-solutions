;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_102) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; A UFO is a Posn. 
; interpretation (make-posn x y) is the UFO's location 
; (using the top-down, left-to-right convention)
 
(define-struct tank [loc vel])
; A Tank is a structure:
;   (make-tank Number Number). 
; interpretation (make-tank x dx) specifies the position:
; (x, Y-TANK) and the tank's speed: dx pixels/tick 
 
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
(define INITIAL-Y-UFO (/ (image-height UFO) 2))

(define TANK-SPEED 5)
(define UFO-SPEED 6)
(define UFO-RANDOM-STEP (* 2 UFO-SPEED))
(define MISSILE-SPEED 15)
(define HIT-DISTANCE 6)

(define WIN-SCENE (place-image (text "You win" 36 "green")
                               (/ MT-WIDTH 2) (/ MT-HEIGHT 2)
                               BACKGROUND))
(define LOSE-SCENE (place-image (text "You lose" 36 "red")
                                (/ MT-WIDTH 2) (/ MT-HEIGHT 2)
                                BACKGROUND))

(define INITIAL-STATE (make-sigs (make-posn (/ MT-WIDTH 2) INITIAL-Y-UFO)
                                 (make-tank 0 TANK-SPEED)
                                 #false))

; SIGS.v2 -> Boolean
; returns #true if the UFO lands or if the missile hits the UFO
(check-expect (si-game-over.v2? (make-sigs (make-posn 50 0)
                                           (make-tank 40 -2)
                                           #false))
              #false)
(check-expect (si-game-over.v2? (make-sigs (make-posn 50 (/ Y-TANK 2))
                                           (make-tank 40 -2)
                                           #false))
              #false)
(check-expect (si-game-over.v2? (make-sigs (make-posn 50 Y-TANK)
                                           (make-tank 40 -2)
                                           #false))
              #true)
(check-expect (si-game-over.v2? (make-sigs (make-posn 50 (+ 50 Y-TANK))
                                           (make-tank 40 -2)
                                           #false))
              #true)
(check-expect (si-game-over.v2? (make-sigs (make-posn 50 0)
                                           (make-tank 40 -2)
                                           (make-posn 48 (/ Y-TANK 2))))
              #false)
(check-expect (si-game-over.v2? (make-sigs (make-posn 50 (/ Y-TANK 2))
                                           (make-tank 40 -2)
                                           (make-posn 48 (/ Y-TANK 2))))
              #true)
(check-expect (si-game-over.v2? (make-sigs (make-posn 50 Y-TANK)
                                           (make-tank 40 -2)
                                           (make-posn 48 (/ Y-TANK 2))))
              #true)
(check-expect (si-game-over.v2? (make-sigs (make-posn 50 (+ 50 Y-TANK))
                                           (make-tank 40 -2)
                                           (make-posn 48 (/ Y-TANK 2))))
              #true)
(define (si-game-over.v2? s)
  (or (ufo-lands.v2? s) (missile-hits.v2? s)))

; SIGS.v2 -> Boolean
; returns #true if the UFO lands
(check-expect (ufo-lands.v2? (make-sigs (make-posn 50 0)
                                        (make-tank 40 -2)
                                        #false))
              #false)
(check-expect (ufo-lands.v2? (make-sigs (make-posn 50 (/ Y-TANK 2))
                                        (make-tank 40 -2)
                                        #false))
              #false)
(check-expect (ufo-lands.v2? (make-sigs (make-posn 50 Y-TANK)
                                        (make-tank 40 -2)
                                        #false))
              #true)
(check-expect (ufo-lands.v2? (make-sigs (make-posn 50 (+ 50 Y-TANK))
                                        (make-tank 40 -2)
                                        #false))
              #true)
(check-expect (ufo-lands.v2? (make-sigs (make-posn 50 0)
                                        (make-tank 40 -2)
                                        (make-posn 48 (/ Y-TANK 2))))
              #false)
(check-expect (ufo-lands.v2? (make-sigs (make-posn 50 (/ Y-TANK 2))
                                        (make-tank 40 -2)
                                        (make-posn 48 (/ Y-TANK 2))))
              #false)
(check-expect (ufo-lands.v2? (make-sigs (make-posn 50 Y-TANK)
                                        (make-tank 40 -2)
                                        (make-posn 48 (/ Y-TANK 2))))
              #true)
(check-expect (ufo-lands.v2? (make-sigs (make-posn 50 (+ 50 Y-TANK))
                                        (make-tank 40 -2)
                                        (make-posn 48 (/ Y-TANK 2))))
              #true)
(define (ufo-lands.v2? s)
  (>= (posn-y (sigs-ufo s)) Y-TANK))

; SIGS.v2 -> Boolean
; returns #true if the UFO lands
(check-expect (missile-hits.v2? (make-sigs (make-posn 50 0)
                                           (make-tank 40 -2)
                                           #false))
              #false)
(check-expect (missile-hits.v2? (make-sigs (make-posn 50 (/ Y-TANK 2))
                                           (make-tank 40 -2)
                                           #false))
              #false)
(check-expect (missile-hits.v2? (make-sigs (make-posn 50 Y-TANK)
                                           (make-tank 40 -2)
                                           #false))
              #false)
(check-expect (missile-hits.v2? (make-sigs (make-posn 50 (+ 50 Y-TANK))
                                           (make-tank 40 -2)
                                           #false))
              #false)
(check-expect (missile-hits.v2? (make-sigs (make-posn 50 0)
                                           (make-tank 40 -2)
                                           (make-posn 48 (/ Y-TANK 2))))
              #false)
(check-expect (missile-hits.v2? (make-sigs (make-posn 50 (/ Y-TANK 2))
                                           (make-tank 40 -2)
                                           (make-posn 48 (/ Y-TANK 2))))
              #true)
(check-expect (missile-hits.v2? (make-sigs (make-posn 50 Y-TANK)
                                           (make-tank 40 -2)
                                           (make-posn 48 (/ Y-TANK 2))))
              #false)
(check-expect (missile-hits.v2? (make-sigs (make-posn 50 (+ 50 Y-TANK))
                                           (make-tank 40 -2)
                                           (make-posn 48 (/ Y-TANK 2))))
              #false)
(define (missile-hits.v2? s)
  (cond
    [(posn? (sigs-missile s))
     (<= (distance-to (sigs-missile s) (sigs-ufo s)) HIT-DISTANCE)]
    [else #false]))

; Posn Posn -> Number
; returns distance between two posns
(check-expect (distance-to (make-posn 0 0) (make-posn 0 0)) 0)
(check-expect (distance-to (make-posn 3 -4) (make-posn 3 -4)) 0)
(check-expect (distance-to (make-posn 0 0) (make-posn 3 -4)) 5)
(check-expect (distance-to (make-posn -12 -0.7) (make-posn -12 64.3)) 65)
(check-expect (distance-to (make-posn -34 50) (make-posn -39 62)) 13)
(define (distance-to p1 p2)
  (sqrt (+ (sqr (- (posn-x p1) (posn-x p2)))
           (sqr (- (posn-y p1) (posn-y p2))))))

; SIGS.v2 -> Image?
; renders final state of the game, #false if current state is not final
(check-expect (si-render-final.v2 (make-sigs (make-posn 50 0)
                                             (make-tank 40 -2)
                                             #false))
              #false)
(check-expect (si-render-final.v2 (make-sigs (make-posn 50 (/ Y-TANK 2))
                                             (make-tank 40 -2)
                                             #false))
              #false)
(check-expect (si-render-final.v2 (make-sigs (make-posn 50 Y-TANK)
                                             (make-tank 40 -2)
                                             #false))
              LOSE-SCENE)
(check-expect (si-render-final.v2 (make-sigs (make-posn 50 (+ 50 Y-TANK))
                                             (make-tank 40 -2)
                                             #false))
              LOSE-SCENE)
(check-expect (si-render-final.v2 (make-sigs (make-posn 50 0)
                                             (make-tank 40 -2)
                                             (make-posn 48 (/ Y-TANK 2))))
              #false)
(check-expect (si-render-final.v2 (make-sigs (make-posn 50 (/ Y-TANK 2))
                                             (make-tank 40 -2)
                                             (make-posn 48 (/ Y-TANK 2))))
              WIN-SCENE)
(check-expect (si-render-final.v2 (make-sigs (make-posn 50 Y-TANK)
                                             (make-tank 40 -2)
                                             (make-posn 48 (/ Y-TANK 2))))
              LOSE-SCENE)
(check-expect (si-render-final.v2 (make-sigs (make-posn 50 (+ 50 Y-TANK))
                                             (make-tank 40 -2)
                                             (make-posn 48 (/ Y-TANK 2))))
              LOSE-SCENE)
(define (si-render-final.v2 s)
  (cond
    [(ufo-lands.v2? s) LOSE-SCENE]
    [(missile-hits.v2? s) WIN-SCENE]
    [else #false]))

; SIGS.v2 KeyEvent -> SIGS.v2
; consumes game state and pressed key and produce new game state
; it reacts to three different keys: left and right changes tank direction,\
; spacebar fires the missile (is not fired yet)
(check-expect (si-control.v2 (make-sigs (make-posn 50 0)
                                        (make-tank 40 (- TANK-SPEED))
                                        #false)
                          "left")
              (make-sigs (make-posn 50 0)
                         (make-tank 40 (- TANK-SPEED))
                         #false))
(check-expect (si-control.v2 (make-sigs (make-posn 50 0)
                                        (make-tank 40 (- TANK-SPEED))
                                        #false)
                          "right")
              (make-sigs (make-posn 50 0)
                         (make-tank 40 TANK-SPEED)
                         #false))
(check-expect (si-control.v2 (make-sigs (make-posn 50 0)
                                        (make-tank 40 (- TANK-SPEED))
                                        #false)
                          "a")
              (make-sigs (make-posn 50 0)
                         (make-tank 40 (- TANK-SPEED))
                         #false))
(check-expect (si-control.v2 (make-sigs (make-posn 50 0)
                                        (make-tank 40 (- TANK-SPEED))
                                        #false)
                          " ")
              (make-sigs (make-posn 50 0)
                         (make-tank 40 (- TANK-SPEED))
                         (make-posn 40 Y-TANK)))
(check-expect (si-control.v2 (make-sigs (make-posn 50 (/ Y-TANK 2))
                                        (make-tank 40 (- TANK-SPEED))
                                        #false)
                          "right")
              (make-sigs (make-posn 50 (/ Y-TANK 2))
                         (make-tank 40 TANK-SPEED)
                         #false))
(check-expect (si-control.v2 (make-sigs (make-posn 50 0)
                                        (make-tank 40 (- TANK-SPEED))
                                        (make-posn 48 (/ Y-TANK 2)))
                          " ")
              (make-sigs (make-posn 50 0)
                         (make-tank 40 (- TANK-SPEED))
                         (make-posn 48 (/ Y-TANK 2))))
(check-expect (si-control.v2 (make-sigs (make-posn 50 0)
                                        (make-tank 40 (- TANK-SPEED))
                                        (make-posn 48 (/ Y-TANK 2)))
                          "left")
              (make-sigs (make-posn 50 0)
                         (make-tank 40 (- TANK-SPEED))
                         (make-posn 48 (/ Y-TANK 2))))
(check-expect (si-control.v2 (make-sigs (make-posn 50 0)
                                        (make-tank 40 (- TANK-SPEED))
                                        (make-posn 48 (/ Y-TANK 2)))
                          "right")
              (make-sigs (make-posn 50 0)
                         (make-tank 40 TANK-SPEED)
                         (make-posn 48 (/ Y-TANK 2))))
(define (si-control.v2 s ke)
  (cond
    [(and (string=? ke " ") (boolean? (sigs-missile s)))
     (make-sigs (sigs-ufo s)
                (sigs-tank s)
                (make-posn (tank-loc (sigs-tank s)) Y-TANK))]
    [(string=? ke "left")
     (make-sigs (sigs-ufo s)
                (make-tank (tank-loc (sigs-tank s)) (- TANK-SPEED))
                (sigs-missile s))]
    [(string=? ke "right")
     (make-sigs (sigs-ufo s)
                (make-tank (tank-loc (sigs-tank s)) TANK-SPEED)
                (sigs-missile s))]
    [else s]))

; SIGS.v2 -> SIGS.v2
; determine new SIGS after one clock tick. Moves missile and tank straightforward,
; moves UFO randomly
(check-random (si-move.v2 (make-sigs (make-posn 50 0)
                                     (make-tank 40 (- TANK-SPEED))
                                     #false))
              (make-sigs (make-posn (+ 50 (random UFO-RANDOM-STEP) (- UFO-SPEED)) UFO-SPEED)
                         (make-tank (- 40 TANK-SPEED) (- TANK-SPEED))
                         #false))
(check-random (si-move.v2 (make-sigs (make-posn 50 (/ Y-TANK 2))
                                     (make-tank 40 (- TANK-SPEED))
                                     #false))
              (make-sigs (make-posn (+ 50 (random UFO-RANDOM-STEP) (- UFO-SPEED)) (+ (/ Y-TANK 2) UFO-SPEED))
                         (make-tank (- 40 TANK-SPEED) (- TANK-SPEED))
                         #false))
(check-random (si-move.v2 (make-sigs (make-posn 50 (/ Y-TANK 2))
                                     (make-tank 0 (- TANK-SPEED))
                                     #false))
              (make-sigs (make-posn (+ 50 (random UFO-RANDOM-STEP) (- UFO-SPEED)) (+ (/ Y-TANK 2) UFO-SPEED))
                         (make-tank 0 (- TANK-SPEED))
                         #false))
(check-random (si-move.v2 (make-sigs (make-posn 35 10)
                                     (make-tank 40 TANK-SPEED)
                                     (make-posn 48 (/ Y-TANK 2))))
              (make-sigs (make-posn (+ 35 (random UFO-RANDOM-STEP) (- UFO-SPEED)) (+ 10 UFO-SPEED))
                         (make-tank (+ 40 TANK-SPEED) TANK-SPEED)
                         (make-posn 48 (- (/ Y-TANK 2) MISSILE-SPEED))))
(check-random (si-move.v2 (make-sigs (make-posn 35 10)
                                     (make-tank MT-WIDTH TANK-SPEED)
                                     (make-posn 48 (/ Y-TANK 2))))
              (make-sigs (make-posn (+ 35 (random UFO-RANDOM-STEP) (- UFO-SPEED)) (+ 10 UFO-SPEED))
                         (make-tank MT-WIDTH TANK-SPEED)
                         (make-posn 48 (- (/ Y-TANK 2) MISSILE-SPEED))))
(define (si-move.v2 s)
  (make-sigs (make-posn (min MT-WIDTH (max 0 (+ (posn-x (sigs-ufo s)) (random UFO-RANDOM-STEP) (- UFO-SPEED))))
                        (+ (posn-y (sigs-ufo s)) UFO-SPEED))
             (make-tank (min MT-WIDTH (max 0 (+ (tank-loc (sigs-tank s)) (tank-vel (sigs-tank s)))))
                        (tank-vel (sigs-tank s)))
             (cond
               [(posn? (sigs-missile s))
                (make-posn (posn-x (sigs-missile s))
                           (- (posn-y (sigs-missile s)) MISSILE-SPEED))]
               [else #false])))

; SIGS.v2 -> Image
; adds TANK, UFO, and possibly MISSILE to 
; the BACKGROUND scene
(check-expect (si-render.v2 (make-sigs (make-posn 20 10) (make-tank 28 -3) #false))
              (place-image UFO 20 10
                           (place-image TANK
                                        28 Y-TANK
                                        BACKGROUND)))

(check-expect (si-render.v2 (make-sigs (make-posn 20 10)
                                       (make-tank 28 -3)
                                       (make-posn 28 (- MT-HEIGHT TANK-HEIGHT))))
              (place-image ROCKET
                           28 (- MT-HEIGHT TANK-HEIGHT)
                           (place-image UFO 20 10
                                        (place-image TANK
                                                     28 Y-TANK
                                                     BACKGROUND))))
(check-expect (si-render.v2 (make-sigs (make-posn 20 100)
                                       (make-tank 100 3)
                                       (make-posn 22 103)))
              (place-image ROCKET
                           22 103
                           (place-image UFO 20 100
                                        (place-image TANK
                                                     100 Y-TANK
                                                     BACKGROUND))))
(define (si-render.v2 s)
  (cond
    [(boolean? (sigs-missile s))
     (tank-render (sigs-tank s)
                  (ufo-render (sigs-ufo s) BACKGROUND))]
    [(posn? (sigs-missile s))
     (missile-render.v2
       (sigs-missile s)
       (ufo-render (sigs-ufo s)
                   (tank-render (sigs-tank s)
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

; MissileOrNot Image -> Image 
; adds an image of missile m to scene s
(check-expect (missile-render.v2 #false BACKGROUND) BACKGROUND)
(check-expect (missile-render.v2 (make-posn 32 (- MT-HEIGHT TANK-HEIGHT 10)) BACKGROUND)
              (place-image ROCKET 32 (- MT-HEIGHT TANK-HEIGHT 10) BACKGROUND))
(check-expect (missile-render.v2 (make-posn 60 80) BACKGROUND)
              (place-image ROCKET 60 80 BACKGROUND))
(define (missile-render.v2 m s)
  (cond
    [(boolean? m) s]
    [(posn? m) (place-image ROCKET (posn-x m) (posn-y m) s)]))

; SIGS -> SIGS
; main function that runs the game
(define (si-main.v2 s)
  (big-bang s
    [on-tick si-move.v2 0.05]
    [on-key si-control.v2]
    [to-draw si-render.v2]
    [stop-when si-game-over.v2? si-render-final.v2]))

(si-main.v2 INITIAL-STATE)