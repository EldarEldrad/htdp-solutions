;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_59) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; A TrafficLight is one of the following Strings:
; – "red"
; – "green"
; – "yellow"
; interpretation the three strings represent the three 
; possible states that a traffic light may assume

(define WIDTH 90)
(define HEIGHT 30)
(define BULB-RADIUS (/ HEIGHT 3))
(define X-RED (* WIDTH 1/6))
(define X-YELLOW (* WIDTH 1/2))
(define X-GREEN (* WIDTH 5/6))
(define Y (/ HEIGHT 2))

(define MT (empty-scene WIDTH HEIGHT))

; TrafficLight -> TrafficLight
; yields the next state, given current state cs
(check-expect (tl-next "yellow") "red")
(check-expect (tl-next "red") "green")
(check-expect (tl-next "green") "yellow")
(define (tl-next cs)
  (cond
    [(string=? cs "yellow") "red"]
    [(string=? cs "red") "green"]
    [(string=? cs "green") "yellow"]))
 
; TrafficLight -> Image
; renders the current state cs as an image
(check-expect (tl-render "red") (place-image (circle BULB-RADIUS "solid" "red")
                                             X-RED Y
                                             (place-image (circle BULB-RADIUS "outline" "yellow")
                                                          X-YELLOW Y
                                                          (place-image (circle BULB-RADIUS "outline" "green")
                                                                       X-GREEN Y
                                                                       MT))))
(check-expect (tl-render "yellow")
              (place-image (circle BULB-RADIUS "outline" "red")
                           X-RED Y
                           (place-image (circle BULB-RADIUS "solid" "yellow")
                                        X-YELLOW Y
                                        (place-image (circle BULB-RADIUS "outline" "green")
                                                     X-GREEN Y
                                                     MT))))
(check-expect (tl-render "green")
              (place-image (circle BULB-RADIUS "outline" "red")
                           X-RED Y
                           (place-image (circle BULB-RADIUS "outline" "yellow")
                                        X-YELLOW Y
                                        (place-image (circle BULB-RADIUS "solid" "green")
                                                     X-GREEN Y
                                                     MT))))
(define (tl-render current-state)
  (place-image (circle BULB-RADIUS (is-solid current-state "red") "red")
                           X-RED Y
                           (place-image (circle BULB-RADIUS (is-solid current-state "yellow") "yellow")
                                        X-YELLOW Y
                                        (place-image (circle BULB-RADIUS (is-solid current-state "green") "green")
                                                     X-GREEN Y
                                                     MT))))

;TrafficLight TrafficLight -> String
; returns "solid" if both TLs are the same
; otherwise returns "outline"
(check-expect (is-solid "yellow" "red") "outline")
(check-expect (is-solid "green" "green") "solid")
(define (is-solid tl1 tl2)
  (if (string=? tl1 tl2)
      "solid"
      "outline"))

; TrafficLight -> TrafficLight
; simulates a clock-based American traffic light
(define (traffic-light-simulation initial-state)
  (big-bang initial-state
    [to-draw tl-render]
    [on-tick tl-next 1]))

(traffic-light-simulation "yellow")