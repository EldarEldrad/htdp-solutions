;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_409) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct db [schema content])
; A DB is a structure: (make-db Schema Content)
 
; A Schema is a [List-of Spec]

(define-struct spec [label predicate])
; Spec is a structure: (make-spec Label Predicate)

; A Label is a String
; A Predicate is a [Any -> Boolean]
 
; A (piece of) Content is a [List-of Row]
; A Row is a [List-of Cell]
; A Cell is Any
; constraint cells do not contain functions 
 
; integrity constraint In (make-db sch con), 
; for every row in con,
; (I1) its length is the same as sch's, and
; (I2) its ith Cell satisfies the ith Predicate in sch

(define school-schema
  (list (make-spec "Name" string?)
        (make-spec "Age" integer?)
        (make-spec "Present" boolean?)))

(define school-content
  `(("Alice" 35 #true)
    ("Bob"   25 #false)
    ("Carol" 30 #true)
    ("Dave"  32 #false)))


(define reodreder-school-content
  `(("Alice" #true  35)
    ("Bob"   #false 25)
    ("Carol" #true  30)
    ("Dave"  #false 32)))

(define school-db
  (make-db school-schema
           school-content))

(define ERROR-NO-LABEL "No such label exist in DB")

(check-expect (db-content (reorder school-db '("Name" "Present" "Age")))
              reodreder-school-content)
(check-expect (db-content (reorder school-db '("Present")))
              `((#true) (#false) (#true) (#false)))
(check-error (db-content (reorder school-db '("Name" "Sex")))
             ERROR-NO-LABEL)
; DB [List-of Label] -> DB
; produces a database like db but with its columns reordered according to lol
(define (reorder db labels)
  (local ((define schema  (db-schema db))
          (define content (db-content db))
          ; Label -> Number
          ; produces index for generating new spec
          (define (get-spec-number label schema)
            (cond
              [(empty? schema) (error ERROR-NO-LABEL)]
              [(equal? label (spec-label (first schema))) 0]
              [else (+ 1 (get-spec-number label (rest schema)))]))
          (define spec-numbers (map (lambda (label) (get-spec-number label schema)) labels))
          ; Row -> Row 
          ; reorder columns in given row
          (define (row-project row)
            (foldr (lambda (number base) (cons (list-ref row number) base))
                   '()
                   spec-numbers)))
    (make-db (map (lambda (n) (list-ref schema n)) spec-numbers)
             (map row-project content))))