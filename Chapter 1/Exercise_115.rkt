;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_115) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define MESSAGE-FIRST
  "traffic light expected as first argument, given some other value")
(define MESSAGE-SECOND
  "traffic light expected as second argument, given some other value")
(define MESSAGE-BOTH
  "traffic light expected as both arguments, given some other values")
 
; Any Any -> Boolean
; are the two values elements of TrafficLight and, 
; if so, are they equal
(check-expect (light=? "red" "red") #true)
(check-expect (light=? "red" "green") #false)
(check-expect (light=? "green" "green") #true)
(check-expect (light=? "yellow" "yellow") #true)
(check-error (light=? #true "yellow") MESSAGE-FIRST)
(check-error (light=? "red" 20) MESSAGE-SECOND)
(check-error (light=? -3 "blue") MESSAGE-BOTH)
(define (light=? a-value another-value)
  (cond
    [(not (light? a-value)) (if (not (light? another-value))
                                (error MESSAGE-BOTH)
                                (error MESSAGE-FIRST))]
    [(not (light? another-value)) (error MESSAGE-SECOND)]
    [else (string=? a-value another-value)]))

; Any -> Boolean
; is the given value an element of TrafficLight
(define (light? x)
  (cond
    [(string? x) (or (string=? "red" x)
                     (string=? "green" x)
                     (string=? "yellow" x))]
    [else #false]))