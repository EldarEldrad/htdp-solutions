;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_076) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct movie [title producer year])
; (make-movie String String Number)

(define-struct person [name hair eyes phone])
; (make-person String String String Phone)

(define-struct pet [name number])
; (make-pet String Number)

(define-struct CD [artist title price])
; (make-CD String String Number)

(define-struct sweater [material size producer])
; (make-sweater String Number String)