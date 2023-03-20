;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_180) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define FONT-SIZE 16) ; the font size 
(define FONT-COLOR "black") ; the font color

; Lo1s -> Image
; renders a list of 1Strings as a text image
(check-expect
  (editor-text
   '())
  (text "" FONT-SIZE FONT-COLOR))
(check-expect
  (editor-text
   (cons "p" (cons "o" (cons "s" (cons "t" '())))))
  (text "post" FONT-SIZE FONT-COLOR))
(check-expect
  (editor-text
   (cons "e" (cons "r" (cons "p" '()))))
  (text "erp" FONT-SIZE FONT-COLOR))
(define (editor-text s)
  (text (implode-string s) FONT-SIZE FONT-COLOR))

; Lo1S -> String
; implodes given Lo1s into a string
(check-expect (implode-string '()) "")
(check-expect (implode-string (cons "p" (cons "o" (cons "s" (cons "t" '()))))) "post")
(check-expect (implode-string (cons "e" (cons "r" (cons "p" '())))) "erp")
(define (implode-string l)
  (cond
    [(empty? l) ""]
    [else (string-append (first l) (implode-string (rest l)))]))