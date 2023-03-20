;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise_225) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct fire-fight [plane waters fires])
(define-struct plane [position direction])

; A Fire-Fight is a structure:
;   (make-fire-fight Plane List-of-Posns List-of-Numbers)
; A Plane is a structure: 
;   (make-plane Number String)
 
; interpretations
; (make-plane x y) depicts a plane flying at constant HEIGHT,
; given X position and direction ("left" or "right")
; (make-fire-fight p (list w1 w2 ...) (list n1 n2 ...)) means plane, dropping loads of water
; and fires at given positions

(define WIDTH 400)
(define HEIGHT 300)
(define MT (empty-scene WIDTH HEIGHT))

(define PLANE-HEIGHT 20)
(define PLANE (rectangle 20 5 "solid" "green"))
(define PLANE-SPEED 8)

(define WATER-SPEED 8)
(define WATER-RADIUS 5)

(define WATER (circle WATER-RADIUS "outline" "blue"))
(define FIRE (ellipse (* WATER-RADIUS 2) (* WATER-RADIUS 5) "solid" "red"))

(define INITIAL (make-fire-fight (make-plane 0 "right")
                                 '()
                                 (list (random WIDTH) (random WIDTH) (random WIDTH) (random WIDTH)
                                       (random WIDTH) (random WIDTH) (random WIDTH) (random WIDTH))))

; Fire-Fight -> Image
; renders Fire Fight game state
(check-expect (fire-fight-render INITIAL)
              (fire-fight-render/plane (fire-fight-plane INITIAL)
                           (fire-fight-render/waters (fire-fight-waters INITIAL)
                                                     (fire-fight-render/fires (fire-fight-fires INITIAL)
                                                                              MT))))
(define (fire-fight-render ff)
  (fire-fight-render/plane (fire-fight-plane ff)
                           (fire-fight-render/waters (fire-fight-waters ff)
                                                     (fire-fight-render/fires (fire-fight-fires ff)
                                                                              MT))))

; Plane Image -> Image
; renders Plane on given image
(check-expect (fire-fight-render/plane (make-plane 0 "right") MT)
              (place-image PLANE 0 PLANE-HEIGHT MT))
(check-expect (fire-fight-render/plane (make-plane (/ WIDTH 2) "left") MT)
              (place-image PLANE (/ WIDTH 2) PLANE-HEIGHT MT))
(define (fire-fight-render/plane p img)
  (place-image PLANE (plane-position p) PLANE-HEIGHT img))

; List-of-Posns Image -> Image
; renders Waters on given image
(check-expect (fire-fight-render/waters '() MT) MT)
(check-expect (fire-fight-render/waters (list (make-posn 60 40)) MT)
              (place-image WATER 60 40 MT))
(check-expect (fire-fight-render/waters (list (make-posn 60 40) (make-posn 80 70)) MT)
              (place-image WATER 60 40 (place-image WATER 80 70 MT)))
(define (fire-fight-render/waters w img)
  (cond
    [(empty? w) img]
    [else (place-image WATER (posn-x (first w)) (posn-y (first w)) (fire-fight-render/waters (rest w) img))]))

; List-of-Numbers Image -> Image
; renders Fires on given image
(check-expect (fire-fight-render/fires '() MT) MT)
(check-expect (fire-fight-render/fires (list 60) MT)
              (place-image FIRE 60 HEIGHT MT))
(check-expect (fire-fight-render/fires (list 60 80 70) MT)
              (place-image FIRE 60 HEIGHT (place-image FIRE 80 HEIGHT (place-image FIRE 70 HEIGHT MT))))
(define (fire-fight-render/fires f img)
  (cond
    [(empty? f) img]
    [else (place-image FIRE (first f) HEIGHT (fire-fight-render/fires (rest f) img))]))

; Fire-Fight KeyEvent -> Fire-Fight
; changes direction of planes and drops water
(check-expect (fire-fight-key (make-fire-fight (make-plane 20 "right") '() '()) "right")
              (make-fire-fight (make-plane 20 "right") '() '()))
(check-expect (fire-fight-key (make-fire-fight (make-plane 40 "right") '() '()) "left")
              (make-fire-fight (make-plane 40 "left") '() '()))
(check-expect (fire-fight-key (make-fire-fight (make-plane 50 "right") '() '()) "k")
              (make-fire-fight (make-plane 50 "right") '() '()))
(check-expect (fire-fight-key (make-fire-fight (make-plane 30 "right") '() '()) " ")
              (make-fire-fight (make-plane 30 "right") (list (make-posn 30 PLANE-HEIGHT)) '()))
(check-expect (fire-fight-key (make-fire-fight (make-plane 70 "right") (list (make-posn 60 50)) '()) " ")
              (make-fire-fight (make-plane 70 "right") (list (make-posn 70 PLANE-HEIGHT) (make-posn 60 50)) '()))
(define (fire-fight-key ff ke)
  (cond
    [(key=? ke "right")
     (make-fire-fight (make-plane (plane-position (fire-fight-plane ff)) "right")
                      (fire-fight-waters ff) (fire-fight-fires ff))]
    [(key=? ke "left")
     (make-fire-fight (make-plane (plane-position (fire-fight-plane ff)) "left")
                      (fire-fight-waters ff) (fire-fight-fires ff))]
    [(key=? ke " ")
     (make-fire-fight (fire-fight-plane ff)
                      (cons (make-posn (plane-position (fire-fight-plane ff)) PLANE-HEIGHT)
                            (fire-fight-waters ff))
                      (fire-fight-fires ff))]
    [else ff]))

; Fire-Fight -> Fire-Fight
; moves the plane, fall the waters and extinguish fires
(check-expect (fire-fight-tick (make-fire-fight (make-plane 0 "right") '() '()))
              (make-fire-fight (make-plane PLANE-SPEED "right") '() '()))
(check-expect (fire-fight-tick (make-fire-fight (make-plane 0 "left") '() '()))
              (make-fire-fight (make-plane 0 "left") '() '()))
(check-expect (fire-fight-tick (make-fire-fight (make-plane 45 "right") '() '()))
              (make-fire-fight (make-plane (+ 45 PLANE-SPEED) "right") '() '()))
(check-expect (fire-fight-tick (make-fire-fight (make-plane 45 "left") '() '()))
              (make-fire-fight (make-plane (- 45 PLANE-SPEED) "left") '() '()))
(check-expect (fire-fight-tick (make-fire-fight (make-plane WIDTH "left") '() '()))
              (make-fire-fight (make-plane (- WIDTH PLANE-SPEED) "left") '() '()))
(check-expect (fire-fight-tick (make-fire-fight (make-plane WIDTH "right") '() '()))
              (make-fire-fight (make-plane WIDTH "right") '() '()))
(check-expect (fire-fight-tick (make-fire-fight (make-plane WIDTH "right") (list (make-posn 40 50)) '()))
              (make-fire-fight (make-plane WIDTH "right")
                               (list (make-posn 40 (+ 50 WATER-SPEED))) '()))
(check-expect (fire-fight-tick (make-fire-fight (make-plane WIDTH "right")
                                                (list (make-posn 40 50) (make-posn 55 65) (make-posn 60 70)) '()))
              (make-fire-fight (make-plane WIDTH "right")
                               (list (make-posn 40 (+ 50 WATER-SPEED))
                                     (make-posn 55 (+ 65 WATER-SPEED))
                                     (make-posn 60 (+ 70 WATER-SPEED))) '()))
(check-expect (fire-fight-tick (make-fire-fight (make-plane WIDTH "right")
                                                (list (make-posn 40 50) (make-posn 55 65) (make-posn 60 70))
                                                (list 45 35 55)))
              (make-fire-fight (make-plane WIDTH "right")
                               (list (make-posn 40 (+ 50 WATER-SPEED))
                                     (make-posn 55 (+ 65 WATER-SPEED))
                                     (make-posn 60 (+ 70 WATER-SPEED))) (list 45 35 55)))
(check-expect (fire-fight-tick (make-fire-fight (make-plane WIDTH "right")
                                                (list (make-posn 60 50) (make-posn 55 65) (make-posn 41 HEIGHT))
                                                (list 45 35 55)))
              (make-fire-fight (make-plane WIDTH "right")
                               (list (make-posn 60 (+ 50 WATER-SPEED))
                                     (make-posn 55 (+ 65 WATER-SPEED))) (list 35 55)))
(define (fire-fight-tick ff)
  (make-fire-fight (move-plane (fire-fight-plane ff))
                   (move-waters (fire-fight-waters ff))
                   (extinguish-fires (fire-fight-waters ff) (fire-fight-fires ff))))

; Plane -> Plane
; moves plane
(check-expect (move-plane (make-plane 0 "right"))
              (make-plane PLANE-SPEED "right"))
(check-expect (move-plane (make-plane 0 "left"))
              (make-plane 0 "left"))
(check-expect (move-plane (make-plane 45 "right"))
              (make-plane (+ 45 PLANE-SPEED) "right"))
(check-expect (move-plane (make-plane 45 "left"))
              (make-plane (- 45 PLANE-SPEED) "left"))
(check-expect (move-plane (make-plane WIDTH "left"))
              (make-plane (- WIDTH PLANE-SPEED) "left"))
(check-expect (move-plane (make-plane WIDTH "right"))
              (make-plane WIDTH "right"))
(check-error (move-plane (make-plane WIDTH "up"))
             "Wrong direction")
(define (move-plane p)
  (cond
    [(string=? (plane-direction p) "right")
     (make-plane (min (+ (plane-position p) PLANE-SPEED) WIDTH) "right")]
    [(string=? (plane-direction p) "left")
     (make-plane (max (- (plane-position p) PLANE-SPEED) 0) "left")]
    [else (error "Wrong direction")]))

; List-of-Posns -> List-of-Posns
; moves waters
(check-expect (move-waters '()) '())
(check-expect (move-waters (list (make-posn 40 50))) (list (make-posn 40 (+ 50 WATER-SPEED))))
(check-expect (move-waters (list (make-posn 40 50) (make-posn 55 65) (make-posn 60 70)))
              (list (make-posn 40 (+ 50 WATER-SPEED))
                    (make-posn 55 (+ 65 WATER-SPEED))
                    (make-posn 60 (+ 70 WATER-SPEED))))
(define (move-waters w)
  (cond
    [(empty? w) '()]
    [(>= (posn-y (first w)) HEIGHT) (move-waters (rest w))]
    [else (cons (make-posn (posn-x (first w))
                           (+ (posn-y (first w)) WATER-SPEED))
                (move-waters (rest w)))]))

; List-of-Posns List-of-Numbers -> List-of-Numbers
; extinguishes fires
(check-expect (extinguish-fires '() (list 45)) (list 45))
(check-expect (extinguish-fires (list (make-posn 43 20)) '()) '())
(check-expect (extinguish-fires (list (make-posn 43 20)) (list 45 35 55)) (list 45 35 55))
(check-expect (extinguish-fires (list (make-posn 43 HEIGHT)) (list 45 35 55)) (list 35 55))
(define (extinguish-fires w f)
  (cond
    [(empty? f) '()]
    [else (append (extinguish-fires/fire w (first f))
                  (extinguish-fires w (rest f)))]))

; List-of-Posns Number -> List-of-Numbers
; returns list with given number is it is not extinguished
; the list is empty otherwise
(check-expect (extinguish-fires/fire '() 45) (list 45))
(check-expect (extinguish-fires/fire (list (make-posn 43 20)) 45) (list 45))
(check-expect (extinguish-fires/fire (list (make-posn 43 HEIGHT)) 45) '())
(check-expect (extinguish-fires/fire (list (make-posn 33 HEIGHT)) 45) (list 45))
(define (extinguish-fires/fire w f)
  (cond
    [(empty? w) (list f)]
    [(< (posn-y (first w)) HEIGHT) (extinguish-fires/fire (rest w) f)]
    [(<= (abs (- (posn-x (first w)) f)) WATER-RADIUS) '()]
    [else (extinguish-fires/fire (rest w) f)]))

; Fire-Fight -> Boolean
; returns #true if no fires left
(check-expect (fire-fight-no-fires? INITIAL) #false)
(check-expect (fire-fight-no-fires? (make-fire-fight (make-plane 20 "left") (list (make-posn 40 -1)) '()))
              #true)
(define (fire-fight-no-fires? ff)
  (empty? (fire-fight-fires ff)))

; Fire-Fight -> Number
; main function
(define (fire-fight-main ff)
  (big-bang ff
    [to-draw fire-fight-render]
    [on-key fire-fight-key]
    [on-tick fire-fight-tick 0.1]
    [stop-when fire-fight-no-fires?]))

(fire-fight-main INITIAL)