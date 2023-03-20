;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_369) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
; An Attribute is a list of two items:
;   (cons Symbol (cons String '()))

; [List-of Attribute] Symbol -> String?
;function consumes a list of attributes and a symbol.
; If the attributes list associates the symbol with a string, the function retrieves this string
; otherwise it returns #false
(check-expect (find-attr '() 's) #false)
(check-expect (find-attr '((s "hi")) 's) "hi")
(check-expect (find-attr '((name "box") (width "34") (height "20")) 's) #false)
(check-expect (find-attr '((name "box") (width "34") (height "20")) 'name) "box")
(check-expect (find-attr '((name "box") (width "34") (height "20")) 'width) "34")
(check-expect (find-attr '((name "box") (width "34") (height "20")) 'height) "20")
(define (find-attr loa s)
  (local ((define value (assq s loa)))
    (if (cons? value) (second value) value)))