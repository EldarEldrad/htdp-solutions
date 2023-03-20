;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_082) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; A LetterOF is one of:
; - 1String "a" through "z"
; - #false

(define-struct word [first second third])
; A Word is a structure
;   (make-word LetterOF LetterOF LetterOF)
; interpretation represents a word consisting of three letters
; if letter is missing then appropriate field is #false

; Word Word -> Word
; produces a word that indicates where the given ones agree and disagree
(check-expect (compare-word (make-word "a" "b" "c")
                            (make-word "a" "b" "c"))
              (make-word "a" "b" "c"))
(check-expect (compare-word (make-word "a" "b" "c")
                            (make-word "c" "a" "b"))
              (make-word #false #false #false))
(check-expect (compare-word (make-word "a" "b" "c")
                            (make-word "c" "c" "c"))
              (make-word #false #false "c"))
(define (compare-word w1 w2)
  (make-word (compare-letter (word-first w1) (word-first w2))
             (compare-letter (word-second w1) (word-second w2))
             (compare-letter (word-third w1) (word-third w2))))

; LetterOF LetterOF -> LetterOF
; produces a letter if the given ones agree and #false if disagree
(check-expect (compare-letter "a" "a") "a")
(check-expect (compare-letter "a" "b") #false)
(check-expect (compare-letter "a" #false) #false)
(check-expect (compare-letter #false #false) #false)
(define (compare-letter l1 l2)
  (if (equal? l1 l2)
      l1
      #false))