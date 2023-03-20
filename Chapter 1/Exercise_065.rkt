;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_065) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct movie [title producer year])
; make-movie, movie-title, movie-producer, movie-year, movie?

(define-struct person [name hair eyes phone])
; make-person, person-name, person-hair, person-eyes, person-pnohe, person?

(define-struct pet [name number])
; make-pet, pet-name, pet-number, pet?

(define-struct CD [artist title price])
; make-CD, CD-artist, CD-title, CD-price, CD?

(define-struct sweater [material size producer])
; make-sweater, sweater-material, sweater-size, sweater-producer, sweater?