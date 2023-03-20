;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_141) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; List-of-string -> String
; concatenates all strings in l into one long string
(check-expect (cat '()) "")
(check-expect (cat (cons "a" (cons "b" '()))) "ab")
(check-expect
  (cat (cons "ab" (cons "cd" (cons "ef" '()))))
  "abcdef")
(define (cat l)
  (cond
    [(empty? l) ""]
    [else (string-append (first l) (cat (rest l)))]))

; (cons "a"
;  (cons "b"
;   '()))
; (first l) == "a"
; (rest l) == (cons "b" '())
; (cat (rest l)) == "b"

; (cons
;  "ab"
;  (cons "cd"
;    (cons "ef"
;      '())))
; (first l) == "ab"
; (rest l) == (cons "cd" (cons "ef" '()))
; (cat (rest l)) == "cdef"

(cat (cons "a" '()))
; -> (cond
;      [(empty? (cons "a" '())) ""]
;      [else (string-append (first (cons "a" '())) (cat (rest (cons "a" '()))))])
; -> (cond
;      [#false ""]
;      [else (string-append (first (cons "a" '())) (cat (rest (cons "a" '()))))])
; -> (cond
;      [else (string-append (first (cons "a" '())) (cat (rest (cons "a" '()))))])
; -> (string-append (first (cons "a" '())) (cat (rest (cons "a" '()))))
; -> (string-append "a" (cat (rest (cons "a" '()))))
; -> (string-append "a" (cat '()))
; -> (string-append "a"
;                   (cond
;                     [(empty? '()) ""]
;                     [else (string-append (first '()) (cat (rest '())))]))
; -> (string-append "a"
;                   (cond
;                     [#true ""]
;                     [else (string-append (first '()) (cat (rest '())))]))
; -> (string-append "a"
;                   "")
; -> "a"