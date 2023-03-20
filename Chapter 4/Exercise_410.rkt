;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_410) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
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

(define school-content-1
  `(("Alice" 35 #true)
    ("Bob"   25 #false)
    ("Carol" 30 #true)
    ("Dave"  32 #false)))

(define school-content-2
  `(("Alice" 35 #true)
    ("Bart"  24 #false)
    ("Carol" 30 #true)
    ("Dan"   32 #true)))

(define school-db-1
  (make-db school-schema
           school-content-1))

(define school-db-2
  (make-db school-schema
           school-content-2))

(check-expect (db-content (db-union (make-db school-schema '()) (make-db school-schema '())))
              '())
(check-expect (db-content (db-union school-db-1 (make-db school-schema '())))
              school-content-1)
(check-expect (db-content (db-union (make-db school-schema '()) school-db-2))
              school-content-2)
(check-expect (db-content (db-union school-db-1 school-db-2))
              `(("Alice" 35 #true)
                ("Bob"   25 #false)
                ("Carol" 30 #true)
                ("Dave"  32 #false)
                ("Bart"  24 #false)
                ("Dan"   32 #true)))
; DB DB -> DB
; consumes two databases with the exact same schema
; and produces a new database with this schema and the joint content of both
(define (db-union db1 db2)
  (local (; Row Content -> Contene
          ; adds row if it is not exist in content already
          (define (add-row row content)
            (if (row-exist? row content)
                content
                (append content (list row))))
          ; Row Content -> Boolean
          ; checks if row exist in given content
          (define (row-exist? row content)
            (cond
              [(empty? content) #false]
              [(and (equal? (length row) (length (first content)))
                    (equal-row? row (first content))) #true]
              [else (row-exist? row (rest content))]))
          ; Row Row -> Boolean
          ; returns #true if given Rows of equal lengths are equal
          (define (equal-row? r1 r2)
            (cond
              [(empty? r1) #true]
              [(equal? (first r1) (first r2)) (equal-row? (rest r1) (rest r2))]
              [else #false])))
    (make-db (db-schema db1)
             (foldl add-row (db-content db1) (db-content db2)))))