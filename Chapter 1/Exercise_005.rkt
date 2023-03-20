;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_05) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
(define BOAT-COLOR "brown")
(define BOAT-HEIGHT 40)
(define BOAT-WIDTH (* 2.5 BOAT-HEIGHT))
(define BOAT-ANGLE 45)
(define STRAIGHT-ANGLE 90)

(define TREE-TRUNK-WIDTH 10)
(define TREE-TRUNK-HEIGHT 60)
(define TREE-LEAVES-WIDTH 30)
(define TREE-LEAVES-HEIGHT 100)

(beside (triangle/saa BOAT-HEIGHT STRAIGHT-ANGLE BOAT-ANGLE "solid" BOAT-COLOR)
        (rectangle BOAT-WIDTH BOAT-HEIGHT "solid" BOAT-COLOR)) ;boat

(overlay/offset (ellipse TREE-LEAVES-WIDTH TREE-LEAVES-HEIGHT "solid" "green")
                0
                (/ TREE-LEAVES-HEIGHT 2)
                (rectangle TREE-TRUNK-WIDTH TREE-TRUNK-HEIGHT "solid" "brown")) ;tree