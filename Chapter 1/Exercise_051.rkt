;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_51) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; A TrafficLight is one of the following Strings:
; – "red"
; – "green"
; – "yellow"
; interpretation the three strings represent the three 
; possible states that a traffic light may assume

(define CIRCLE-RADIUS 50)
(define INITIAL-STATE "yellow")

; TrafficLight -> TrafficLight
; yields the next state given current state s
(check-expect (traffic-light-next "red") "green")
(check-expect (traffic-light-next "green") "yellow")
(check-expect (traffic-light-next "yellow") "red")
(define (traffic-light-next s)
  (cond
    [(string=? "red" s) "green"]
    [(string=? "green" s) "yellow"]
    [(string=? "yellow" s) "red"]))

; TrafficLight -> Image
; renders a solid circle of the appropriate color
(check-expect (render "red") (circle CIRCLE-RADIUS "solid" "red"))
(check-expect (render "green") (circle CIRCLE-RADIUS "solid" "green"))
(check-expect (render "yellow") (circle CIRCLE-RADIUS "solid" "yellow"))
(define (render tl)
  (circle CIRCLE-RADIUS "solid" tl))

(define (main s)
  (big-bang INITIAL-STATE
    [to-draw render]
    [on-tick traffic-light-next 1]))