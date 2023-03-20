;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_134) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; A List-of-names is one of: 
; – '()
; – (cons String List-of-names)
; interpretation a list of invitees, by last name

; List-of-names String -> Boolean
; determines whether str is in alon
(check-expect (contains? '() "Flatt") #false)
(check-expect (contains? (cons "Find" '()) "Flatt")
              #false)
(check-expect (contains? (cons "Find" '()) "Find")
              #true)
(check-expect (contains? (cons "Flatt" '()) "Flatt")
              #true)
(check-expect
  (contains?
    (cons "A" (cons "Flatt" (cons "C" '()))) "Flatt")
  #true)
(check-expect
  (contains?
    (cons "A" (cons "B" (cons "C" '()))) "Flatt")
  #false)
(check-expect
  (contains?
    (cons "A" (cons "B" (cons "C" '()))) "C")
  #true)
(define (contains? alon str)
  (cond
    [(empty? alon) #false]
    [(cons? alon)
     (or (string=? (first alon) str)
         (contains? (rest alon) str))]))
