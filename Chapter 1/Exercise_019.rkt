;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_19) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
(define (string-insert str i)
  (string-append (substring str 0 i)
                 "_"
                 (substring str i)))

(string-insert "helloworld" 5) ;"hello_world"
(string-insert "helloworld" 0) ;"_helloworld"
(string-insert "helloworld" 10) ;"helloworld_"
(string-insert "" 0) ;"_"