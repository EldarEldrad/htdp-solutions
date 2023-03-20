;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_136) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct pair [left right])
; A ConsPair is a structure:
;   (make-pair Any Any).

; A ConsOrEmpty is one of: 
; – '()
; – (make-pair Any ConsOrEmpty)
; interpretation ConsOrEmpty is the class of all lists
 
; Any Any -> ConsOrEmpty
(define (our-cons a-value a-list)
  (cond
    [(empty? a-list) (make-pair a-value a-list)]
    [(pair? a-list) (make-pair a-value a-list)]
    [else (error "cons: second argument should be a list")]))

; ConsOrEmpty -> Any
; extracts the left part of the given pair
(define (our-first a-list)
  (if (empty? a-list)
      (error 'our-first "first: argument should be a list")
      (pair-left a-list)))

; ConsOrEmpty -> Any
; extracts the right part of the given pair
(define (our-rest a-list)
  (if (empty? a-list)
      (error 'our-rest "rest: argument should be a list")
      (pair-right a-list)))

(our-first (our-cons "a" '()))
; -> (our-first (cond
;                 [(empty? '()) (make-pair "a" '())]
;                 [(pair? '()) (make-pair "a" '())]
;                 [else (error "cons: second argument should be a list")]))
; -> (our-first (cond
;                 [#true (make-pair "a" '())]
;                 [(pair? '()) (make-pair "a" '())]
;                 [else (error "cons: second argument should be a list")]))
; -> (our-first (make-pair "a" '()))
; -> (if (empty? (make-pair "a" '()))
;        (error 'our-first "first: argument should be a list")
;        (pair-left (make-pair "a" '())))
; -> (if #false
;        (error 'our-first "first: argument should be a list")
;        (pair-left (make-pair "a" '())))
; -> (pair-left (make-pair "a" '()))
; -> "a"

(our-rest (our-cons "a" '()))
; -> (our-rest (cond
;                [(empty? '()) (make-pair "a" '())]
;                [(pair? '()) (make-pair "a" '())]
;                [else (error "cons: second argument should be a list")]))
; -> (our-rest (cond
;                [#true (make-pair "a" '())]
;                [(pair? '()) (make-pair "a" '())]
;                [else (error "cons: second argument should be a list")]))
; -> (our-rest (make-pair "a" '()))
; -> (if (empty? (make-pair "a" '()))
;        (error 'our-rest "rest: argument should be a list")
;        (pair-right (make-pair "a" '())))
; -> (if #false
;        (error 'our-rest "rest: argument should be a list")
;        (pair-right (make-pair "a" '())))
; -> (pair-right (make-pair "a" '()))
; -> '()