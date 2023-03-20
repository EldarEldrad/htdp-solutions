;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_069) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct movie [title producer year])
; ------------------ movie --
; |       |          |      |
; | title | producer | year |
; |       |          |      |
; ---------------------------

(define-struct person [name hair eyes phone])
; -------------------- person --
; |      |      |      |       |
; | name | hair | eyes | phone |
; |      |      |      |       |
; ------------------------------

(define-struct pet [name number])
; ---------- pet --
; |      |        |
; | name | number |
; |      |        |
; -----------------

(define-struct CD [artist title price])
; -------------------- CD --
; |        |       |       |
; | artist | title | price |
; |        |       |       |
; --------------------------

(define-struct sweater [material size producer])
; ------------------- sweater --
; |          |      |          |
; | material | size | producer |
; |          |      |          |
; ------------------------------