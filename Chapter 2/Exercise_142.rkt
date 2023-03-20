;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_142) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; ImageOrFalse is one of:
; – Image
; – #false 

; List-of-images Number -> ImageOfFalse
; produces the first image on loi that is not an n by n square
; if it cannot find such image, it produces #false
(check-expect (ill-sized? '() 5) #false)
(check-expect (ill-sized? (cons (square 5 "solid" "black") '()) 5) #false)
(check-expect (ill-sized? (cons (circle 2.5 "solid" "black") '()) 5) #false)
(check-expect (ill-sized? (cons (rectangle 5 10 "solid" "black") '()) 5) (rectangle 5 10 "solid" "black"))
(check-expect (ill-sized? (cons (rectangle 5 5 "solid" "black")
                                (cons (square 5 "solid" "black") '()))
                          5) #false)
(check-expect (ill-sized? (cons (rectangle 5 10 "solid" "black")
                                (cons (square 5 "solid" "black") '()))
                          5) (rectangle 5 10 "solid" "black"))
(check-expect (ill-sized? (cons (rectangle 5 5 "solid" "black")
                                (cons (circle 5 "solid" "black") '()))
                          5) (circle 5 "solid" "black"))
(define (ill-sized? loi n)
  (cond
    [(empty? loi) #false]
    [(and (= (image-width (first loi)) n)
          (= (image-height (first loi)) n))
     (ill-sized? (rest loi) n)]
    [else (first loi)]))