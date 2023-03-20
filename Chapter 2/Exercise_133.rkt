;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_133) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; A List-of-names is one of: 
; – '()
; – (cons String List-of-names)
; interpretation a list of invitees, by last name

; List-of-names -> Boolean
; determines whether "Flatt" is on a-list-of-names
(check-expect (contains-flatt.v2? '()) #false)
(check-expect (contains-flatt.v2? (cons "Find" '()))
              #false)
(check-expect (contains-flatt.v2? (cons "Flatt" '()))
              #true)
(check-expect
  (contains-flatt.v2?
    (cons "A" (cons "Flatt" (cons "C" '()))))
  #true)
(check-expect
  (contains-flatt.v2?
    (cons "A" (cons "B" (cons "C" '()))))
  #false)
(define (contains-flatt.v2? alon)
  (cond
    [(empty? alon) #false]
    [(cons? alon)
     (cond
       [(string=? (first alon) "Flatt") #true]
       [else (contains-flatt.v2? (rest alon))])]))

; the previous form is (or A B)
; but (or A B) == (cond [A #true] [else B])
; thus contains-flatt.v2? is the same as contains-flatt?