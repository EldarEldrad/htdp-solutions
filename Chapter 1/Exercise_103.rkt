;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_103) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct spider [legs volume])
; A Spider is a structure:
;   (make-spider Number Number)
; interpretation represents the spider, whose relevant attributes are
; the number of remaining legs (we assume that spiders can lose legs in accidents)
; and the space they need in case of transport

(define-struct elephant [volume])
; An Elephant is a structure:
;   (make-elephant Number)
; interpretation represents the elephant, whose only attributes are the space they need in case of transport

(define-struct boa-constrictor [length girth])
; A BoaConstricotr is a structure:
;   (make-boa-constrictor Number Number)
; interpretation represents the boa constrictor, whose attributes include length and girth

(define-struct armadillo [age volume])
; A BoaConstricotr is a structure:
;   (make-armadillo Number Number)
; interpretation represents the armadillo, whose attributes include age
; and the space they need in case of transport

; A ZooAnimal is one of:
; - Spider
; - Elephant
; - BoaConstrictor
; - Armadillo

; ZooAnimal -> Any
; template for function that consumes ZooAnimal
; (define (func za)
;   (cond
;     [(spider? za) ( ... (spider-legs za) ... (spider-volume za) ... )]
;     [(elephant? za) ( ... (elephant-volume za) ... )]
;     [(boa-constrictor? za) ( ... (boa-constrictor-length za) ... (boa-constrictor-girth za) ... )]
;     [(armadillo? za) ( ... (armadillo-age za) ... (armadillo-volume za) ... )]
;     [else ...]))

; ZooAnimal Number -> Boolean
; consumes a zoo animal and a description of a cage.
; It determines whether the cage’s volume is large enough for the animal
(check-expect (fits? (make-spider 8 20) 10) #false)
(check-expect (fits? (make-spider 8 20) 20) #true)
(check-expect (fits? (make-spider 8 20) 30) #true)
(check-expect (fits? (make-elephant 200) 100) #false)
(check-expect (fits? (make-elephant 200) 200) #true)
(check-expect (fits? (make-elephant 200) 300) #true)
(check-expect (fits? (make-boa-constrictor 10 40) (* 0.9 10 pi (sqr 40))) #false)
(check-expect (fits? (make-boa-constrictor 10 40) (* 10 pi (sqr 40))) #true)
(check-expect (fits? (make-boa-constrictor 10 40) (*  2 10 pi (sqr 40))) #true)
(check-expect (fits? (make-armadillo 30 40) 30) #false)
(check-expect (fits? (make-armadillo 30 40) 40) #true)
(check-expect (fits? (make-armadillo 30 40) 50) #true)
(check-expect (fits? (make-posn 30 40) 50) #false)
(define (fits? za v)
  (cond
    [(spider? za) (>= v (spider-volume za))]
    [(elephant? za) (>= v (elephant-volume za))]
    [(boa-constrictor? za) (>= v (* (boa-constrictor-length za) pi (sqr (boa-constrictor-girth za))))]
    [(armadillo? za) (>= v (armadillo-volume za))]
    [else #false]))