;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_079) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; A Color is one of: 
; — "white"
; — "yellow"
; — "orange"
; — "green"
; — "red"
; — "blue"
; — "black"

(define color1 "orange")
(define color2 "red")

; H is a Number between 0 and 100.
; interpretation represents a happiness value

(define happiness1 0)
(define happiness2 45)
(define happiness3 100)

(define-struct person [fstname lstname male?])
; A Person is a structure:
;   (make-person String String Boolean)

(define person1 (make-person "Jack" "Brown" #true))
(define person2 (make-person "Mary" "Russel" #false))

(define-struct dog [owner name age happiness])
; A Dog is a structure:
;   (make-dog Person String PositiveInteger H)
; interpration represents dog with name, appropriate owner, given age and happiness level H

(define dog1 (make-dog "Jack" "Charlie" 6 happiness2))
(define dog2 (make-dog "Mary" "Bob" 2 happiness3))

; A Weapon is one of: 
; — #false
; — Posn
; interpretation #false means the missile hasn't 
; been fired yet; a Posn means it is in flight

(define weapon1 #false)
(define weapon2 (make-posn 4 6))