;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_113) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])

; A UFO is a Posn. 
; interpretation (make-posn x y) is the UFO's location 
; (using the top-down, left-to-right convention)
 
(define-struct tank [loc vel])
; A Tank is a structure:
;   (make-tank Number Number). 
; interpretation (make-tank x dx) specifies the position:
; (x, HEIGHT) and the tank's speed: dx pixels/tick 
 
; A Missile is a Posn. 
; interpretation (make-posn x y) is the missile's place

; A SIGS is one of: 
; – (make-aim UFO Tank)
; – (make-fired UFO Tank Missile)
; interpretation represents the complete state of a 
; space invader game

; Any -> Boolean
; is v an element of the SIGS collection
(check-expect (sigs-or-not? #false) #false)
(check-expect (sigs-or-not? (make-posn 9 2)) #false)
(check-expect (sigs-or-not? "yellow") #false)
(check-expect (sigs-or-not? #true) #false)
(check-expect (sigs-or-not? 10) #false)
(check-expect (sigs-or-not? empty-image) #false)
(check-expect (sigs-or-not? (make-aim (make-posn 3 4) (make-tank 5 5))) #true)
(check-expect (sigs-or-not? (make-aim (make-posn 3 #false) (make-tank 5 5))) #false)
(check-expect (sigs-or-not? (make-aim (make-posn 3 -6) (make-tank 5 "right"))) #false)
(check-expect (sigs-or-not? (make-fired (make-posn 3 2) (make-tank 5 5) (make-posn 7 2))) #true)
(check-expect (sigs-or-not? (make-fired (make-posn "4" 2) (make-tank 5 5) (make-posn 7 -2))) #false)
(check-expect (sigs-or-not? (make-fired (make-posn 3 2) (make-tank 5 "left") (make-posn 7 -2))) #false)
(check-expect (sigs-or-not? (make-fired (make-posn 3 2) (make-tank 5 5) (make-posn #true #true))) #false)
(define (sigs-or-not? v)
  (cond
    [(aim? v) (and (posn? (aim-ufo v))
                   (number? (posn-x (aim-ufo v))) (positive? (posn-x (aim-ufo v)))
                   (number? (posn-y (aim-ufo v))) (positive? (posn-y (aim-ufo v)))
                   (tank? (aim-tank v))
                   (number? (tank-loc (aim-tank v))) (positive? (tank-loc (aim-tank v)))
                   (number? (tank-vel (aim-tank v))))]
    [(fired? v)
     (and (posn? (fired-ufo v))
          (number? (posn-x (fired-ufo v))) (positive? (posn-x (fired-ufo v)))
          (number? (posn-y (fired-ufo v))) (positive? (posn-y (fired-ufo v)))
          (tank? (fired-tank v))
          (number? (tank-loc (fired-tank v))) (positive? (tank-loc (fired-tank v)))
          (number? (tank-vel (fired-tank v)))
          (posn? (fired-missile v))
          (number? (posn-x (fired-missile v))) (positive? (posn-x (fired-missile v)))
          (number? (posn-y (fired-missile v))) (positive? (posn-y (fired-missile v))))]
    [else #false]))

; A Coordinate is one of: 
; – a NegativeNumber 
; interpretation on the y axis, distance from top
; – a PositiveNumber 
; interpretation on the x axis, distance from left
; – a Posn
; interpretation an ordinary Cartesian point

; Any -> Boolean
; is c an element of the Coordinate collection
(check-expect (coordinate-or-not? 5) #true)
(check-expect (coordinate-or-not? -5) #true)
(check-expect (coordinate-or-not? pi) #true)
(check-expect (coordinate-or-not? 0) #false)
(check-expect (coordinate-or-not? "five") #false)
(check-expect (coordinate-or-not? #false) #false)
(check-expect (coordinate-or-not? #true) #false)
(check-expect (coordinate-or-not? (make-posn 4 6)) #true)
(check-expect (coordinate-or-not? (make-posn 4 -6)) #true)
(check-expect (coordinate-or-not? (make-posn 0 0)) #true)
(check-expect (coordinate-or-not? (make-posn "three" 6)) #false)
(check-expect (coordinate-or-not? (make-posn pi #true)) #false)
(define (coordinate-or-not? c)
  (cond
    [(posn? c) (and (number? (posn-x c)) (number? (posn-y c)))]
    [(number? c) (or (positive? c) (negative? c))]
    [else #false]))

(define-struct vcat [x happiness])
; A VCat is a structure:
;   (make-vcat Number Number)
; interpretation represents cat that has x coordinate on canvas
; and given happiness level

(define-struct vcham [x color happiness])
; A VCham is a structure:
;   (make-vcham Number String Number)
; interpretation represents cham that has x coordinate on canvas,
; given color (red, green or blue)
; and given happiness level

; A VAnimal is either
; – a VCat
; – a VCham

; Any -> Boolean
; is v an element of the VAnimal collection
(check-expect (vanimal-or-not? 3) #false)
(check-expect (vanimal-or-not? "cat") #false)
(check-expect (vanimal-or-not? #true) #false)
(check-expect (vanimal-or-not? (make-vcat 5 50)) #true)
(check-expect (vanimal-or-not? (make-vcat -45.7 0)) #true)
(check-expect (vanimal-or-not? (make-vcat 5 -5)) #false)
(check-expect (vanimal-or-not? (make-vcat "zero" -5)) #false)
(check-expect (vanimal-or-not? (make-vcat 0 "unhappy")) #false)
(check-expect (vanimal-or-not? (make-vcham 5 "red" 50)) #true)
(check-expect (vanimal-or-not? (make-vcham -5 "green" 0)) #true)
(check-expect (vanimal-or-not? (make-vcham 55 "blue" 150)) #true)
(check-expect (vanimal-or-not? (make-vcham 55 "yellow" 150)) #false)
(check-expect (vanimal-or-not? (make-vcham 55 "blue" -10)) #false)
(check-expect (vanimal-or-not? (make-vcham "left" "red" 150)) #false)
(check-expect (vanimal-or-not? (make-vcham 55 "green" #false)) #false)
(check-expect (vanimal-or-not? (make-vcham -5 45 0)) #false)
(define (vanimal-or-not? v)
  (cond
    [(vcat? v) (and (number? (vcat-x v))
                    (number? (vcat-happiness v))
                    (not (negative? (vcat-happiness v))))]
    [(vcham? v) (and (number? (vcham-x v))
                     (string? (vcham-color v))
                     (or (string=? (vcham-color v) "red")
                         (string=? (vcham-color v) "green")
                         (string=? (vcham-color v) "blue"))
                     (number? (vcham-happiness v))
                     (not (negative? (vcham-happiness v))))]
    [else #false]))