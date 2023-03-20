;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_370) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
; An XWord is '(word ((text String)))

(define word1 '(word ((text "Hello"))))
(define word2 '(word ((text "17"))))
(define word3 '(word ((text "This is a word"))))

(define ERROR "Not a word")

; Any -> Boolean
; checks whether some ISL+ value is in XWord
(check-expect (word? word1) #true)
(check-expect (word? word2) #true)
(check-expect (word? word3) #true)
(check-expect (word? 0) #false)
(check-expect (word? "Hello") #false)
(check-expect (word? #true) #false)
(check-expect (word? (make-posn 4 5)) #false)
(check-expect (word? '(word ((txt "Hi")))) #false)
(check-expect (word? '(word ((text 32)))) #false)
(define (word? x)
  (match x
    [(list 'word (list (list 'text (? string?)))) #true]
    [y #false]))

; XWord -> String
; checks whether some ISL+ value is in XWord
(check-expect (word-text word1) "Hello")
(check-expect (word-text word2) "17")
(check-expect (word-text word3) "This is a word")
(check-error (word-text 0) ERROR)
(check-error (word-text "Hello") ERROR)
(check-error (word-text #true) ERROR)
(check-error (word-text (make-posn 4 5)) ERROR)
(check-error (word-text '(word ((txt "Hi")))) ERROR)
(define (word-text x)
  (match x
    [(list 'word (list (list 'text t))) t]
    [y (error ERROR)]))