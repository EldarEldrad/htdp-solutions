;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_388) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct employee [name ssn pay-rate])
; An Employee is a structure:
;   (make-employee String Number Number)

(define-struct work-record [name hours])
; A WorkRecord is a structure:
;   (make-work-record String Number)

(define-struct wage [name wage])
; A WeeklyWage is a structure:
;   (make-wage String Number)

; [List-of Employee] [List-of WorkRecord] -> [List-of Wage]
; multiplies the corresponding items on 
; hours and wages/h 
; assume the two lists are of equal length
(check-expect (wages*.v2 '() '()) '())
(check-expect (wages*.v2 (list (make-employee "John" 34 5.65)) (list (make-work-record "John" 40)))
              (list (make-wage "John" 226.0)))
(check-expect (wages*.v2 (list (make-employee "John" 34 5.65) (make-employee "Ann" 56 8.75))
                         (list (make-work-record "John" 40.0) (make-work-record "Ann" 30.0)))
              (list (make-wage "John" 226.0) (make-wage "Ann" 262.5)))
(define (wages*.v2 loe low)
  (cond
    [(empty? loe) '()]
    [else
     (cons
       (make-wage (employee-name (first loe))
                  (weekly-wage (employee-pay-rate (first loe)) (work-record-hours (first low))))
       (wages*.v2 (rest loe) (rest low)))]))

; Number Number -> Number
; computes the weekly wage from pay-rate and hours
(define (weekly-wage pay-rate hours)
  (* pay-rate hours))