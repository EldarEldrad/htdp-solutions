;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_57) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; An LRCD (for launching rocket countdown) is one of:
; – "resting"
; – a Number between -3 and -1
; – a NonnegativeNumber 
; interpretation a grounded rocket, in countdown mode,
; a number denotes the number of pixels between the
; bottom of the canvas and the bottom of the rocket (its height)

(define HEIGHT 300) ; distances in pixels 
(define WIDTH  100)
(define YDELTA 3)
 
(define BACKG  (empty-scene WIDTH HEIGHT))
(define ROCKET (rectangle 5 30 "solid" "red"))
 
(define CENTER (/ (image-height ROCKET) 2))
(define INIT-POS (- HEIGHT CENTER))

; LRCD -> Image
; renders the state as a resting or flying rocket
(check-expect
 (show "resting")
 (place-image ROCKET 10 INIT-POS BACKG))
(check-expect
 (show -2)
 (place-image (text "-2" 20 "red")
              10 (* 3/4 WIDTH)
              (place-image ROCKET 10 INIT-POS BACKG)))
(check-expect
 (show 53)
 (place-image ROCKET 10 (- INIT-POS 53) BACKG))
(define (show x)
  (cond
    [(and (string? x) (string=? x "resting"))
     (place-rocket 0)]
    [(<= -3 x -1)
     (place-image (text (number->string x) 20 "red")
                  10 (* 3/4 WIDTH)
                  (place-rocket 0))]
    [(>= x 0)
     (place-rocket x)]))

; Number -> Image
; places rocket at specified position on canvas
(check-expect (place-rocket 0) (place-image ROCKET 10 INIT-POS BACKG))
(check-expect (place-rocket HEIGHT) (place-image ROCKET 10 (- INIT-POS HEIGHT) BACKG))
(define (place-rocket y)
  (place-image ROCKET 10 (- INIT-POS y) BACKG))
 
; LRCD KeyEvent -> LRCD
; starts the countdown when space bar is pressed, 
; if the rocket is still resting
(check-expect (launch "resting" " ") -3)
(check-expect (launch "resting" "a") "resting")
(check-expect (launch -3 " ") -3)
(check-expect (launch -1 " ") -1)
(check-expect (launch 33 " ") 33)
(check-expect (launch 33 "a") 33)
(define (launch x ke)
  (cond
    [(and (string? x) (string=? " " ke)) -3]
    [else x]))
 
; LRCD -> LRCD
; raises the rocket by YDELTA if it is moving already 
(check-expect (fly "resting") "resting")
(check-expect (fly -3) -2)
(check-expect (fly -2) -1)
(check-expect (fly -1) 0)
(check-expect (fly 10) (+ 10 YDELTA))
(check-expect (fly 22) (+ 22 YDELTA))
(define (fly x)
  (cond
    [(string? x) x]
    [(<= -3 x -1) (+ x 1)]
    [(>= x 0) (+ x YDELTA)]))

; LRCD -> Boolean
; returns #true when rocket moves out of sight
(check-expect (stop? HEIGHT) #true)
(check-expect (stop? 0) #false)
(check-expect (stop? "resting") #false)
(check-expect (stop? -1) #false)
(check-expect (stop? (/ HEIGHT 2)) #false)
(define (stop? x)
  (cond
    [(and (number? x) (>= x HEIGHT)) #true]
    [else #false]))

; LRCD -> LRCD
(define (main3 s)
  (big-bang s
    [on-tick fly 0.1]
    [stop-when stop?]
    [to-draw show]
    [on-key launch]))