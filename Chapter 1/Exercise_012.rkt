;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_12) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
(define (cvolume l)
  (expt l 3))

(define (csurface l)
  (* 6 (sqr l)))

(cvolume 1) ;1
(cvolume 2) ;8
(cvolume 6) ;216

(csurface 1) ;6
(csurface 2) ;24
(csurface 6) ;216