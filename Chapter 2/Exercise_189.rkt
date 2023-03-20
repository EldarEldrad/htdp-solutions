;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise_189) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; Number List-of-numbers -> Boolean
; determines whether some number occurs in a sorted list of numbers
(check-expect (search-sorted 5 '()) #false)
(check-expect (search-sorted 5 (list 5)) #true)
(check-expect (search-sorted 5 (list 4)) #false)
(check-expect (search-sorted 5 (list 6)) #false)
(check-expect (search-sorted 5 (list 6 4)) #false)
(check-expect (search-sorted 5 (list 6 5 4)) #true)
(define (search-sorted n alon)
  (cond
    [(or (empty? alon) (< (first alon) n)) #false]
    [else (or (= (first alon) n)
              (search-sorted n (rest alon)))]))