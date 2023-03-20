;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_406) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
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

(define school-db
  (make-db school-schema
           school-content))

(define projected-content
  `(("Alice" #true)
    ("Bob"   #false)
    ("Carol" #true)
    ("Dave"  #false)))
 
(define projected-schema
  (list (make-spec "Name" string?) (make-spec "Present" boolean?)))
 
(define projected-db
  (make-db projected-schema projected-content))
(check-expect (db-content (project.v2 school-db '("Name" "Present")))
              projected-content)
; DB [List-of Label] -> DB
; retains a column from db if its label is in labels
(define (project.v2 db labels)
  (local ((define schema  (db-schema db))
          (define content (db-content db))
          (define specs (map spec-label schema))
          ; Spec -> Boolean
          ; does this spec belong to the new schema
          (define (keep? c) (member? (spec-label c) labels))
          ; Row -> Row
          ; retains those columns whose name is in labels
          (define (row-project row)
            (row-filter row specs))
          ; Row [List-of Label] -> Row
          ; retains those cells whose corresponding element
          ; in names is also in labels
          (define (row-filter row names)
            (cond
              [(empty? row) '()]
              [(member? (first names) labels)
               (cons (first row)
                     (row-filter (rest row) (rest names)))]
              [else (row-filter (rest row) (rest names))])))
    (make-db (filter keep? schema)
             (map row-project content))))