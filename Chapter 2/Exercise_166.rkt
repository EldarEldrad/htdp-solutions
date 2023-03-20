;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_166) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct work [employee number rate hours])
; A (piece of) Work is a structure: 
;   (make-work String Number Number Number)
; interpretation (make-work n r h) combines the name 
; with the unique employee number, the pay rate r and the number of hours h

(define-struct paycheck [employee number amount])
; A Paycheck is a structure
;   (make-paycheck String NumberNumber)
; interpretation (make-paycheck n a) combines the name with the unique employee number and the amount

; Low (short for list of works) is one of: 
; – '()
; – (cons Work Low)
; interpretation an instance of Low represents the 
; hours worked for a number of employees

; Lop (short for list of paychecks) is one of:
; - '()
; - (cons Paycheck Lop)
; interpretation an instance of Lop represents the
; paychecks with specific amounts for each employee

; Low -> Lop
; computes the weekly wages for all weekly work records 
(check-expect
  (wage*.v4 (cons (make-work "Robby" 543 11.95 39) '()))
  (cons (make-paycheck "Robby" 543 (* 11.95 39)) '()))
(define (wage*.v4 an-low)
  (cond
    [(empty? an-low) '()]
    [(cons? an-low) (cons (wage.v4 (first an-low))
                          (wage*.v4 (rest an-low)))]))
 
; Work -> Paycheck
; computes the paycheck for the given work record w
(define (wage.v4 w)
  (make-paycheck (work-employee w)
                 (work-number w)
                 (* (work-rate w) (work-hours w))))