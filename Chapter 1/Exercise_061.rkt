;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_61) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define RED "red")
(define GREEN "green")
(define YELLOW "yellow")

; also works
; (define RED 0)
; (define GREEN 1)
; (define YELLOW 2)
 
; An S-TrafficLight is one of:
; – RED
; – GREEN
; – YELLOW

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
(check-expect (tl-next-symbolic YELLOW) RED)
(check-expect (tl-next-symbolic RED) GREEN)
(check-expect (tl-next-symbolic GREEN) YELLOW)
(define (tl-next-symbolic cs)
  (cond
    [(equal? cs YELLOW) RED]
    [(equal? cs RED) GREEN]
    [(equal? cs GREEN) YELLOW]))
 
; TrafficLight -> Image
; renders the current state cs as an image
(check-expect (tl-render RED)
              (place-image (circle BULB-RADIUS "solid" (get-color RED))
                           X-RED Y
                           (place-image (circle BULB-RADIUS "outline" (get-color YELLOW))
                                        X-YELLOW Y
                                        (place-image (circle BULB-RADIUS "outline" (get-color GREEN))
                                                     X-GREEN Y
                                                     MT))))
(check-expect (tl-render YELLOW)
              (place-image (circle BULB-RADIUS "outline" (get-color RED))
                           X-RED Y
                           (place-image (circle BULB-RADIUS "solid" (get-color YELLOW))
                                        X-YELLOW Y
                                        (place-image (circle BULB-RADIUS "outline" (get-color GREEN))
                                                     X-GREEN Y
                                                     MT))))
(check-expect (tl-render GREEN)
              (place-image (circle BULB-RADIUS "outline" (get-color RED))
                           X-RED Y
                           (place-image (circle BULB-RADIUS "outline" (get-color YELLOW))
                                        X-YELLOW Y
                                        (place-image (circle BULB-RADIUS "solid" (get-color GREEN))
                                                     X-GREEN Y
                                                     MT))))
(define (tl-render current-state)
  (place-image (circle BULB-RADIUS (is-solid current-state RED) (get-color RED))
                           X-RED Y
                           (place-image (circle BULB-RADIUS (is-solid current-state YELLOW) (get-color YELLOW))
                                        X-YELLOW Y
                                        (place-image (circle BULB-RADIUS (is-solid current-state GREEN) (get-color GREEN))
                                                     X-GREEN Y
                                                     MT))))

; TrafficLight TrafficLight -> String
; returns "solid" if both TLs are the same
; otherwise returns "outline"
(check-expect (is-solid YELLOW RED) "outline")
(check-expect (is-solid GREEN GREEN) "solid")
(define (is-solid tl1 tl2)
  (if (equal? tl1 tl2)
      "solid"
      "outline"))

; TrafficLight -> String
; returns color based on given tl
(check-expect (get-color RED) "red")
(check-expect (get-color YELLOW) "yellow")
(check-expect (get-color GREEN) "green")
(define (get-color tl)
  (cond
    [(equal? tl YELLOW) "yellow"]
    [(equal? tl RED) "red"]
    [(equal? tl GREEN) "green"]))

; TrafficLight -> TrafficLight
; simulates a clock-based American traffic light
(define (traffic-light-simulation initial-state)
  (big-bang initial-state
    [to-draw tl-render]
    [on-tick tl-next-symbolic 1]))

(traffic-light-simulation YELLOW)