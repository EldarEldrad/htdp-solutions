;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise_188) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define-struct email [from date message])
; An Email Message is a structure: 
;   (make-email String Number String)
; interpretation (make-email f d m) represents text m 
; sent by f, d seconds after the beginning of time 

; List-of-Emails -> List-of-Emails
; produces a sorted version of given list of emails by date
(check-expect (sort-by-date> '()) '())
(check-expect (sort-by-date> (list (make-email "Harry" 300 "Hi"))) (list (make-email "Harry" 300 "Hi")))
(check-expect (sort-by-date> (list (make-email "Harry" 300 "Hi") (make-email "Sally" 200 "Hello")))
              (list (make-email "Harry" 300 "Hi") (make-email "Sally" 200 "Hello")))
(check-expect (sort-by-date> (list (make-email "Sally" 200 "Hello") (make-email "Harry" 300 "Hi")))
              (list (make-email "Harry" 300 "Hi") (make-email "Sally" 200 "Hello")))
(check-expect (sort-by-date> (list (make-email "Sally" 200 "Hello") (make-email "Harry" 300 "Hi") (make-email "Gary" 400 "Howdy")))
              (list (make-email "Gary" 400 "Howdy") (make-email "Harry" 300 "Hi") (make-email "Sally" 200 "Hello")))
(check-expect (sort-by-date> (list  (make-email "Harry" 300 "Hi") (make-email "Gary" 400 "Howdy") (make-email "Sally" 200 "Hello")))
              (list (make-email "Gary" 400 "Howdy") (make-email "Harry" 300 "Hi") (make-email "Sally" 200 "Hello")))
(define (sort-by-date> aloe)
  (cond
    [(empty? aloe) '()]
    [else
     (insert-by-date> (first aloe) (sort-by-date> (rest aloe)))]))

; Email List-of-Emails -> List-of-Emails
; inserts Email into the sorted list of Emails
(check-expect (insert-by-date> (make-email "Harry" 300 "Hi") '()) (list (make-email "Harry" 300 "Hi")))
(check-expect (insert-by-date> (make-email "Harry" 300 "Hi") (list (make-email "Sally" 200 "Hello")))
              (list (make-email "Harry" 300 "Hi") (make-email "Sally" 200 "Hello")))
(check-expect (insert-by-date> (make-email "Sally" 200 "Hello") (list (make-email "Harry" 300 "Hi")))
              (list (make-email "Harry" 300 "Hi") (make-email "Sally" 200 "Hello")))
(check-expect (insert-by-date> (make-email "Harry" 300 "Hi") (list (make-email "Gary" 400 "Howdy") (make-email "Sally" 200 "Hello")))
              (list (make-email "Gary" 400 "Howdy") (make-email "Harry" 300 "Hi") (make-email "Sally" 200 "Hello")))
(define (insert-by-date> e l)
  (cond
    [(empty? l) (cons e '())]
    [else (if (compare-date> e (first l))
              (cons e l)
              (cons (first l) (insert-by-date> e (rest l))))]))

; Email Email -> Boolean
; returns true if first email has more or equal date value than second email
(check-expect (compare-date> (make-email "Harry" 300 "Hi") (make-email "Sally" 200 "Hello")) #true)
(check-expect (compare-date> (make-email "Sally" 200 "Hello") (make-email "Harry" 300 "Hi")) #false)
(check-expect (compare-date> (make-email "Sally" 200 "Hello") (make-email "Sally" 200 "Hello")) #true)
(check-expect (compare-date> (make-email "Sally" 200 "Hello") (make-email "Gary" 400 "Howdy")) #false)
(define (compare-date> e1 e2)
  (>= (email-date e1) (email-date e2)))

; List-of-Emails -> List-of-Emails
; produces a sorted version of given list of emails by name
(check-expect (sort-by-name> '()) '())
(check-expect (sort-by-name> (list (make-email "Harry" 300 "Hi"))) (list (make-email "Harry" 300 "Hi")))
(check-expect (sort-by-name> (list (make-email "Harry" 300 "Hi") (make-email "Sally" 200 "Hello")))
              (list (make-email "Harry" 300 "Hi") (make-email "Sally" 200 "Hello")))
(check-expect (sort-by-name> (list (make-email "Sally" 200 "Hello") (make-email "Harry" 300 "Hi")))
              (list (make-email "Harry" 300 "Hi") (make-email "Sally" 200 "Hello")))
(check-expect (sort-by-name> (list (make-email "Sally" 200 "Hello") (make-email "Harry" 300 "Hi") (make-email "Gary" 400 "Howdy")))
              (list (make-email "Gary" 400 "Howdy") (make-email "Harry" 300 "Hi") (make-email "Sally" 200 "Hello")))
(check-expect (sort-by-name> (list  (make-email "Harry" 300 "Hi") (make-email "Gary" 400 "Howdy") (make-email "Sally" 200 "Hello")))
              (list (make-email "Gary" 400 "Howdy") (make-email "Harry" 300 "Hi") (make-email "Sally" 200 "Hello")))
(define (sort-by-name> aloe)
  (cond
    [(empty? aloe) '()]
    [else
     (insert-by-name> (first aloe) (sort-by-name> (rest aloe)))]))

; Email List-of-Emails -> List-of-Emails
; inserts Email into the sorted list of Emails
(check-expect (insert-by-name> (make-email "Harry" 300 "Hi") '()) (list (make-email "Harry" 300 "Hi")))
(check-expect (insert-by-name> (make-email "Harry" 300 "Hi") (list (make-email "Sally" 200 "Hello")))
              (list (make-email "Harry" 300 "Hi") (make-email "Sally" 200 "Hello")))
(check-expect (insert-by-name> (make-email "Sally" 200 "Hello") (list (make-email "Harry" 300 "Hi")))
              (list (make-email "Harry" 300 "Hi") (make-email "Sally" 200 "Hello")))
(check-expect (insert-by-name> (make-email "Harry" 300 "Hi") (list (make-email "Gary" 400 "Howdy") (make-email "Sally" 200 "Hello")))
              (list (make-email "Gary" 400 "Howdy") (make-email "Harry" 300 "Hi") (make-email "Sally" 200 "Hello")))
(define (insert-by-name> e l)
  (cond
    [(empty? l) (cons e '())]
    [else (if (string<? (email-from e) (email-from (first l)))
              (cons e l)
              (cons (first l) (insert-by-name> e (rest l))))]))