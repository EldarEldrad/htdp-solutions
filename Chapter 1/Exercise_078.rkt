;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_078) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; A LetterOF is one of:
; - 1String "a" through "z"
; - #false

(define-struct word [first second third])
; A Word is a structure
;   (make-word LetterOF LetterOF LetterOF)
; interpretation represents a word consisting of three letters
; if letter is missing then appropriate field is #false