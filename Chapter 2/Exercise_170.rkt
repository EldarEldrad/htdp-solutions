;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_170) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct phone [area switch four])
; A Phone is a structure: 
;   (make-phone Three Three Four)
; A Three is a Number between 100 and 999. 
; A Four is a Number between 1000 and 9999.

; List-of-phones -> List-of-phones
; consumes and produces a list of Phones
; It replaces all occurrence of area code 713 with 281
(check-expect (replace '()) '())
(check-expect (replace (cons (make-phone 221 781 9832) '())) (cons (make-phone 221 781 9832) '()))
(check-expect (replace (cons (make-phone 713 781 9832) '())) (cons (make-phone 281 781 9832) '()))
(check-expect (replace (cons (make-phone 221 781 9832) (cons (make-phone 123 456 7890) '())))
                       (cons (make-phone 221 781 9832) (cons (make-phone 123 456 7890) '())))
(check-expect (replace (cons (make-phone 123 456 7890) (cons (make-phone 713 781 9832) '())))
              (cons (make-phone 123 456 7890) (cons (make-phone 281 781 9832) '())))
(define (replace lop)
  (cond
    [(empty? lop) '()]
    [else
     (cons (replace-area (first lop))
           (replace (rest lop)))]))

; Phone -> Phone
; replaces area code 713 with 281
; otherwise returns the same phone
(check-expect (replace-area (make-phone 123 456 7890)) (make-phone 123 456 7890))
(check-expect (replace-area (make-phone 713 713 7130)) (make-phone 281 713 7130))
(define (replace-area p)
  (make-phone
   (if (= 713 (phone-area p)) 281 (phone-area p))
   (phone-switch p)
   (phone-four p)))