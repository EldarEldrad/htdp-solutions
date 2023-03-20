;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_397) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct employee [name number pay-rate])
; An Employee is a structure:
;   (make-employee String Number Number)
; interpretation contains data about given employee

(define-struct etc [number hours])
; An ETC is a structure:
;   (make-etc Number Number)
; interpretation contains data on Electronic Time Card for specific amployee number

(define-struct wage-record [name wage])
; A Wage-Record is a structure:
;   (make-wage-record String Number)
; interpretation contain the name and weekly wage of an employee

(define ERROR "Inconsistent data")

; [List-of Employee] [List-of ETC] -> [List-of Wage-Record]
; produces a list of wage records
; the function signals an error if it cannot find an employee record for a time card or vice versa
; Assumption There is at most one time card per employee number
(check-expect (wages*.v3 '() '()) '())
(check-error (wages*.v3 `(,(make-employee "AAA" 1 15)) '()) ERROR)
(check-expect (wages*.v3 `(,(make-employee "AAA" 1 15)) `(,(make-etc 1 8)))
              `(,(make-wage-record "AAA" 120)))
(check-error (wages*.v3 '() `(,(make-etc 1 8))) ERROR)
(check-expect (wages*.v3 `(,(make-employee "AAA" 1 15) ,(make-employee "BBB" 2 16) ,(make-employee "CCC" 3 10))
                         `(,(make-etc 2 6) ,(make-etc 3 5) ,(make-etc 1 8)))
              `(,(make-wage-record "AAA" 120) ,(make-wage-record "BBB" 96) ,(make-wage-record "CCC" 50)))
(check-error (wages*.v3 `(,(make-employee "AAA" 1 15) ,(make-employee "BBB" 2 16) ,(make-employee "CCC" 3 10))
                        `(,(make-etc 2 6) ,(make-etc 4 5) ,(make-etc 1 8)))
              ERROR)
(check-error (wages*.v3 `(,(make-employee "AAA" 1 15) ,(make-employee "BBB" 2 16) ,(make-employee "CCC" 3 10) ,(make-employee "DDD" 4 20))
                        `(,(make-etc 2 6) ,(make-etc 3 5) ,(make-etc 1 8)))
             ERROR)
(check-error (wages*.v3 `(,(make-employee "AAA" 1 15) ,(make-employee "BBB" 2 16) ,(make-employee "CCC" 3 10))
                        `(,(make-etc 2 6) ,(make-etc 3 5) ,(make-etc 4 10) ,(make-etc 1 8)))
             ERROR)
(define (wages*.v3 loe loetc)
  (cond
    [(empty? loe) (if (empty? loetc) '() (error ERROR))]
    [(empty? loetc) (error ERROR)]
    [else (cons (get-wage-record (first loe) loetc)
                (wages*.v3 (rest loe) (remove-etc (employee-number (first loe)) loetc)))]))

; Employee [List-of ETC] -> Wage-Record
; generate Wage-Record for given Employee
(check-error (get-wage-record (make-employee "AAA" 1 15) '()) ERROR)
(check-expect (get-wage-record (make-employee "AAA" 1 15) `(,(make-etc 1 8)))
              (make-wage-record "AAA" 120))
(check-expect (get-wage-record (make-employee "AAA" 1 15) `(,(make-etc 3 6) ,(make-etc 2 10) ,(make-etc 1 8)))
              (make-wage-record "AAA" 120))
(check-error (get-wage-record (make-employee "AAA" 1 15) `(,(make-etc 3 6) ,(make-etc 2 10) ,(make-etc 5 8)))
             ERROR)
(define (get-wage-record emp loetc)
  (cond
    [(empty? loetc) (error ERROR)]
    [(equal? (employee-number emp) (etc-number (first loetc)))
     (make-wage-record (employee-name emp) (* (employee-pay-rate emp)
                                              (etc-hours (first loetc))))]
    [else (get-wage-record emp (rest loetc))]))

; Number [List-of ETC] -> [List-of ETC]
; removes ETC from list based on given Employee Number
(check-expect (remove-etc 5 '()) '())
(check-expect (remove-etc 5 `(,(make-etc 2 8))) `(,(make-etc 2 8)))
(check-expect (remove-etc 5 `(,(make-etc 5 8))) '())
(check-expect (remove-etc 5 `(,(make-etc 1 8) ,(make-etc 2 6) ,(make-etc 3 10)))
              `(,(make-etc 1 8) ,(make-etc 2 6) ,(make-etc 3 10)))
(check-expect (remove-etc 5 `(,(make-etc 2 8))) `(,(make-etc 2 8)))
(define (remove-etc n loetc)
  (cond
    [(empty? loetc) '()]
    [(equal? n (etc-number (first loetc))) (remove-etc n (rest loetc))]
    [else (cons (first loetc) (remove-etc n (rest loetc)))]))