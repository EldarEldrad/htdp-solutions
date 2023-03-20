;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_389) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct phone-record [name number])
; A PhoneRecord is a structure:
;   (make-phone-record String String)

; [List-of String] [List-of String] -> [List-of PhoneRecord]
; consumes a list of names, represented as strings, and a list of phone numbers, also strings.
; It combines those equally long lists into a list of phone records
(check-expect (zip '() '()) '())
(check-expect (zip '("John") '("555222")) (list (make-phone-record "John" "555222")))
(check-expect (zip '("John" "Ann") '("555222" "123456"))
              (list (make-phone-record "John" "555222")
                    (make-phone-record "Ann" "123456")))
(define (zip lon lop)
  (cond
    [(empty? lon) '()]
    [else
     (cons (make-phone-record (first lon) (first lop))
           (zip (rest lon) (rest lop)))]))