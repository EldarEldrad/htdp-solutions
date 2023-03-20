;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_081) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct time [hours minutes seconds])
; A Time is a structure
;   (make-time Number Number Number)
; interpratation represents a time since midnight in hours, minutes and seconds

; Time -> Number
; produces the number of seconds that have passed since midnight
(check-expect (time->seconds (make-time 0 0 0)) 0)
(check-expect (time->seconds (make-time 0 0 1)) 1)
(check-expect (time->seconds (make-time 0 1 0)) 60)
(check-expect (time->seconds (make-time 1 0 0)) 3600)
(check-expect (time->seconds (make-time 12 30 2)) 45002)
(define (time->seconds t)
  (+ (* 60
        (+ (* 60 (time-hours t))
           (time-minutes t)))
     (time-seconds t)))