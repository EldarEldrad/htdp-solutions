;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_104) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct vehicle [seats number fuel-cons type])
; A Vehicle is a structure:
;   (make-vehicle Number Number Number VehicleType)
; interpretation describes the vehicle with  the number of passengers that it can carry,
; its license plate number, and its fuel consumption (miles per gallon)

; A VehicleType is one of:
; - "automobile"
; - "van"
; - "bus"
; - "SUV"

(define AUTOMOBILE "automodile")
(define VAN "van")
(define BUS "bus")
(define SUV "suv")

; Vehicle -> Any
; template for functions that consume vehicles
; (define (func v)
;   (cond
;     [(string=? (vehicle-type v) AUTOMOBILE)
;      (... (vehicle-seats v) ... (vehicle-number v) ... (vehicle-fuel-cons v) ... )]
;     [(string=? (vehicle-type v) VAN)
;      (... (vehicle-seats v) ... (vehicle-number v) ... (vehicle-fuel-cons v) ... )]
;     [(string=? (vehicle-type v) BUS)
;      (... (vehicle-seats v) ... (vehicle-number v) ... (vehicle-fuel-cons v) ... )]
;     [(string=? (vehicle-type v) SUV)
;      (... (vehicle-seats v) ... (vehicle-number v) ... (vehicle-fuel-cons v) ... )]
;     [else ...]))