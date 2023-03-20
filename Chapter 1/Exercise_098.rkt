;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_098) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
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

(define HIT-DISTANCE 5)

(define WIN-SCENE (place-image (text "You win" 36 "green")
                               (/ MT-WIDTH 2) (/ MT-HEIGHT 2)
                               BACKGROUND))
(define LOSE-SCENE (place-image (text "You lose" 36 "red")
                                (/ MT-WIDTH 2) (/ MT-HEIGHT 2)
                                BACKGROUND))

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