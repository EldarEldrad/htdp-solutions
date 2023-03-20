;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_400) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; DNA-Letter is one of 'a, 'c, 'g or 't

; DNA is a [List-of DNA-Letter]

(define ERROR "Error")

; DNA DNA -> Boolean
; The function returns #true if the pattern is identical to the initial part of the search string
; otherwise it returns #false
(check-expect (dna-prefix '() '()) #true)
(check-expect (dna-prefix '() '(a c g)) #true)
(check-expect (dna-prefix '(a c g) '()) #false)
(check-expect (dna-prefix '(a c) '(a c g)) #true)
(check-expect (dna-prefix '(a c t) '(a c g t)) #false)
(check-expect (dna-prefix '(a c t) '(g a c t)) #false)
(define (dna-prefix pattern search-string)
  (cond
    [(empty? pattern) #true]
    [(empty? search-string) #false]
    [(equal? (first pattern) (first search-string))
     (dna-prefix (rest pattern) (rest search-string))]
    [else #false]))

; DNA DNA -> [Maybe DNA-Letter]
; returns the first item in the search string beyond the pattern.
; If the lists are identical and there is no DNA letter beyond the pattern, the function signals an error.
; If the pattern does not match the beginning of the search string, it returns #false.
(check-error (dna-delta '() '()) ERROR)
(check-expect (dna-delta '() '(a c g)) 'a)
(check-expect (dna-delta '(a c g) '()) #false)
(check-expect (dna-delta '(a c) '(a c g)) 'g)
(check-expect (dna-delta '(a c t) '(a c g t)) #false)
(check-expect (dna-delta '(a c t) '(g a c t)) #false)
(define (dna-delta pattern search-string)
  (cond
    [(empty? pattern) (if (empty? search-string) (error ERROR) (first search-string))]
    [(empty? search-string) #false]
    [(equal? (first pattern) (first search-string))
     (dna-delta (rest pattern) (rest search-string))]
    [else #false]))