;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_100) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
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

(define INITIAL-STATE (make-aim (make-posn (/ MT-WIDTH 2) INITIAL-Y-UFO)
                                (make-tank 0 TANK-SPEED)))

; SIGS -> Boolean
; returns #true if the UFO lands or if the missile hits the UFO
(check-expect (si-game-over? (make-aim (make-posn 50 0)
                                       (make-tank 40 -2)))
              #false)
(check-expect (si-game-over? (make-aim (make-posn 50 (/ Y-TANK 2))
                                       (make-tank 40 -2)))
              #false)
(check-expect (si-game-over? (make-aim (make-posn 50 Y-TANK)
                                       (make-tank 40 -2)))
              #true)
(check-expect (si-game-over? (make-aim (make-posn 50 (+ 50 Y-TANK))
                                       (make-tank 40 -2)))
              #true)
(check-expect (si-game-over? (make-fired (make-posn 50 0)
                                         (make-tank 40 -2)
                                         (make-posn 48 (/ Y-TANK 2))))
              #false)
(check-expect (si-game-over? (make-fired (make-posn 50 (/ Y-TANK 2))
                                         (make-tank 40 -2)
                                         (make-posn 48 (/ Y-TANK 2))))
              #true)
(check-expect (si-game-over? (make-fired (make-posn 50 Y-TANK)
                                         (make-tank 40 -2)
                                         (make-posn 48 (/ Y-TANK 2))))
              #true)
(check-expect (si-game-over? (make-fired (make-posn 50 (+ 50 Y-TANK))
                                         (make-tank 40 -2)
                                         (make-posn 48 (/ Y-TANK 2))))
              #true)
(define (si-game-over? s)
  (or (ufo-lands? s) (missile-hits? s)))

; SIGS -> Boolean
; returns #true if the UFO lands
(check-expect (ufo-lands? (make-aim (make-posn 50 0)
                                    (make-tank 40 -2)))
              #false)
(check-expect (ufo-lands? (make-aim (make-posn 50 (/ Y-TANK 2))
                                    (make-tank 40 -2)))
              #false)
(check-expect (ufo-lands? (make-aim (make-posn 50 Y-TANK)
                                    (make-tank 40 -2)))
              #true)
(check-expect (ufo-lands? (make-aim (make-posn 50 (+ 50 Y-TANK))
                                    (make-tank 40 -2)))
              #true)
(check-expect (ufo-lands? (make-fired (make-posn 50 0)
                                      (make-tank 40 -2)
                                      (make-posn 48 (/ Y-TANK 2))))
              #false)
(check-expect (ufo-lands? (make-fired (make-posn 50 (/ Y-TANK 2))
                                      (make-tank 40 -2)
                                      (make-posn 48 (/ Y-TANK 2))))
              #false)
(check-expect (ufo-lands? (make-fired (make-posn 50 Y-TANK)
                                      (make-tank 40 -2)
                                      (make-posn 48 (/ Y-TANK 2))))
              #true)
(check-expect (ufo-lands? (make-fired (make-posn 50 (+ 50 Y-TANK))
                                      (make-tank 40 -2)
                                      (make-posn 48 (/ Y-TANK 2))))
              #true)
(define (ufo-lands? s)
  (cond
    [(aim? s)
     (>= (posn-y (aim-ufo s)) Y-TANK)]
    [(fired? s)
     (>= (posn-y (fired-ufo s)) Y-TANK)]
    [else #false]))

; SIGS -> Boolean
; returns #true if the UFO lands
(check-expect (missile-hits? (make-aim (make-posn 50 0)
                                       (make-tank 40 -2)))
              #false)
(check-expect (missile-hits? (make-aim (make-posn 50 (/ Y-TANK 2))
                                       (make-tank 40 -2)))
              #false)
(check-expect (missile-hits? (make-aim (make-posn 50 Y-TANK)
                                       (make-tank 40 -2)))
              #false)
(check-expect (missile-hits? (make-aim (make-posn 50 (+ 50 Y-TANK))
                                       (make-tank 40 -2)))
              #false)
(check-expect (missile-hits? (make-fired (make-posn 50 0)
                                         (make-tank 40 -2)
                                         (make-posn 48 (/ Y-TANK 2))))
              #false)
(check-expect (missile-hits? (make-fired (make-posn 50 (/ Y-TANK 2))
                                         (make-tank 40 -2)
                                         (make-posn 48 (/ Y-TANK 2))))
              #true)
(check-expect (missile-hits? (make-fired (make-posn 50 Y-TANK)
                                         (make-tank 40 -2)
                                         (make-posn 48 (/ Y-TANK 2))))
              #false)
(check-expect (missile-hits? (make-fired (make-posn 50 (+ 50 Y-TANK))
                                         (make-tank 40 -2)
                                         (make-posn 48 (/ Y-TANK 2))))
              #false)
(define (missile-hits? s)
  (cond
    [(fired? s)
     (<= (distance-to (fired-missile s) (fired-ufo s)) HIT-DISTANCE)]
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

; SIGS -> Image?
; renders final state of the game, #false if current state is not final
(check-expect (si-render-final (make-aim (make-posn 50 0)
                                         (make-tank 40 -2)))
              #false)
(check-expect (si-render-final (make-aim (make-posn 50 (/ Y-TANK 2))
                                         (make-tank 40 -2)))
              #false)
(check-expect (si-render-final (make-aim (make-posn 50 Y-TANK)
                                         (make-tank 40 -2)))
              LOSE-SCENE)
(check-expect (si-render-final (make-aim (make-posn 50 (+ 50 Y-TANK))
                                         (make-tank 40 -2)))
              LOSE-SCENE)
(check-expect (si-render-final (make-fired (make-posn 50 0)
                                           (make-tank 40 -2)
                                           (make-posn 48 (/ Y-TANK 2))))
              #false)
(check-expect (si-render-final (make-fired (make-posn 50 (/ Y-TANK 2))
                                           (make-tank 40 -2)
                                           (make-posn 48 (/ Y-TANK 2))))
              WIN-SCENE)
(check-expect (si-render-final (make-fired (make-posn 50 Y-TANK)
                                           (make-tank 40 -2)
                                           (make-posn 48 (/ Y-TANK 2))))
              LOSE-SCENE)
(check-expect (si-render-final (make-fired (make-posn 50 (+ 50 Y-TANK))
                                           (make-tank 40 -2)
                                           (make-posn 48 (/ Y-TANK 2))))
              LOSE-SCENE)
(define (si-render-final s)
  (cond
    [(ufo-lands? s) LOSE-SCENE]
    [(missile-hits? s) WIN-SCENE]
    [else #false]))

; SIGS KeyEvent -> SIGS
; consumes game state and pressed key and produce new game state
; it reacts to three different keys: left and right changes tank direction,\
; spacebar fires the missile (is not fired yet)
(check-expect (si-control (make-aim (make-posn 50 0)
                                    (make-tank 40 (- TANK-SPEED)))
                          "left")
              (make-aim (make-posn 50 0)
                        (make-tank 40 (- TANK-SPEED))))
(check-expect (si-control (make-aim (make-posn 50 0)
                                    (make-tank 40 (- TANK-SPEED)))
                          "right")
              (make-aim (make-posn 50 0)
                        (make-tank 40 TANK-SPEED)))
(check-expect (si-control (make-aim (make-posn 50 0)
                                    (make-tank 40 (- TANK-SPEED)))
                          "a")
              (make-aim (make-posn 50 0)
                        (make-tank 40 (- TANK-SPEED))))
(check-expect (si-control (make-aim (make-posn 50 0)
                                    (make-tank 40 (- TANK-SPEED)))
                          " ")
              (make-fired (make-posn 50 0)
                          (make-tank 40 (- TANK-SPEED))
                          (make-posn 40 Y-TANK)))
(check-expect (si-control (make-aim (make-posn 50 (/ Y-TANK 2))
                                    (make-tank 40 (- TANK-SPEED)))
                          "right")
              (make-aim (make-posn 50 (/ Y-TANK 2))
                        (make-tank 40 TANK-SPEED)))
(check-expect (si-control (make-fired (make-posn 50 0)
                                      (make-tank 40 (- TANK-SPEED))
                                      (make-posn 48 (/ Y-TANK 2)))
                          " ")
              (make-fired (make-posn 50 0)
                          (make-tank 40 (- TANK-SPEED))
                          (make-posn 48 (/ Y-TANK 2))))
(check-expect (si-control (make-fired (make-posn 50 0)
                                      (make-tank 40 (- TANK-SPEED))
                                      (make-posn 48 (/ Y-TANK 2)))
                          "left")
              (make-fired (make-posn 50 0)
                          (make-tank 40 (- TANK-SPEED))
                          (make-posn 48 (/ Y-TANK 2))))
(check-expect (si-control (make-fired (make-posn 50 0)
                                      (make-tank 40 (- TANK-SPEED))
                                      (make-posn 48 (/ Y-TANK 2)))
                          "right")
              (make-fired (make-posn 50 0)
                          (make-tank 40 TANK-SPEED)
                          (make-posn 48 (/ Y-TANK 2))))
(define (si-control s ke)
  (cond
    [(and (string=? ke " ") (aim? s))
     (make-fired (aim-ufo s)
                 (aim-tank s)
                 (make-posn (tank-loc (aim-tank s)) Y-TANK))]
    [(string=? ke "left")
     (cond
       [(aim? s) (make-aim (aim-ufo s)
                           (make-tank (tank-loc (aim-tank s)) (- TANK-SPEED)))]
       [(fired? s) (make-fired (fired-ufo s)
                               (make-tank (tank-loc (fired-tank s)) (- TANK-SPEED))
                               (fired-missile s))])]
    [(string=? ke "right")
     (cond
       [(aim? s) (make-aim (aim-ufo s)
                           (make-tank (tank-loc (aim-tank s)) TANK-SPEED))]
       [(fired? s) (make-fired (fired-ufo s)
                               (make-tank (tank-loc (fired-tank s)) TANK-SPEED)
                               (fired-missile s))])]
    [else s]))

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

; SIGS -> SIGS
; main function that runs the game
(define (si-main s)
  (big-bang s
    [on-tick si-move 0.05]
    [on-key si-control]
    [to-draw si-render]
    [stop-when si-game-over? si-render-final]))

(si-main INITIAL-STATE)