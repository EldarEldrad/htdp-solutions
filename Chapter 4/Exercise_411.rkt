;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_411) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
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

(define presence-schema
  (list (make-spec "Present" boolean?)
        (make-spec "Description" string?)))

(define presence-content-1
  `((#true "presence")
    (#false "absence")))

(define presence-content-2
  `((#true "presence")
    (#false "absence")
    (#true "here")
    (#false "there")))

(define school-db
  (make-db school-schema
           school-content))

(define presence-db-1
  (make-db presence-schema
           presence-content-1))

(define presence-db-2
  (make-db presence-schema
           presence-content-2))

(define school-content-joined-1
  `(("Alice" 35 "presence")
    ("Bob"   25 "absence")
    ("Carol" 30 "presence")
    ("Dave"  32 "absence")))

(define school-content-joined-2
  `(("Alice" 35 "presence")
    ("Alice" 35 "here")
    ("Bob"   25 "absence")
    ("Bob"   25 "there")
    ("Carol" 30 "presence")
    ("Carol" 30 "here")
    ("Dave"  32 "absence")
    ("Dave"  32 "there")))

(check-expect (db-content (join.v1 school-db presence-db-1)) school-content-joined-1)
(check-expect (db-content (join.v1 school-db presence-db-2)) school-content-joined-1)
; DB DB -> DB
; consumes two databases: db-1 and db-2
; The schema of db-2 starts with the exact same Spec that the schema of db-1 ends in
; The function creates a database from db-1 by replacing the last cell in each row
; with the translation of the cell in db-2
(define (join.v1 db-1 db-2)
  (local (; Scheme Scheme -> Scheme
          ; produces new scheme for joined DB
          (define (produce-new-schema schema-1 schema-2)
            (cond
              [(empty? (rest schema-1)) (rest schema-2)]
              [else (cons (first schema-1)
                          (produce-new-schema (rest schema-1) schema-2))]))
          ; Row -> Row
          ; translates last cell in the row
          (define (translate row)
            (cond
              [(empty? (rest row)) (list (get-cell (first row)))]
              [else (cons (first row) (translate (rest row)))]))
          ; Cell -> Cell
          ; translates cell using content of db-2
          (define (get-cell c)
            (second (assoc c (db-content db-2)))))
    (make-db (produce-new-schema (db-schema db-1) (db-schema db-2))
             (foldr (lambda (row lor) (cons (translate row) lor))
                    '() (db-content db-1)))))

(check-expect (db-content (join.v2 school-db presence-db-1)) school-content-joined-1)
(check-expect (db-content (join.v2 school-db presence-db-2)) school-content-joined-2)
; DB DB -> DB
; consumes two databases: db-1 and db-2
; The schema of db-2 starts with the exact same Spec that the schema of db-1 ends in
; The function creates a database from db-1 by replacing the last cell in each row
; with the translation of the cell in db-2
(define (join.v2 db-1 db-2)
  (local (; Scheme Scheme -> Scheme
          ; produces new scheme for joined DB
          (define (produce-new-schema schema-1 schema-2)
            (cond
              [(empty? (rest schema-1)) (rest schema-2)]
              [else (cons (first schema-1)
                          (produce-new-schema (rest schema-1) schema-2))]))
          ; Row -> [List-of-Row]
          ; translates last cell in the row and creates list of Rows with all possible translations
          (define (translate row)
            (local ((define rvrse (reverse row))
                    (define lst (first rvrse))
                    (define without-lst (reverse (rest rvrse)))
                    (define loc (get-cell lst)))
              (map (lambda (cell) (append without-lst (list cell))) loc)))
          ; Cell -> [List-of-Cell]
          ; translates cell using content of db-2 and list all possible translations
          (define (get-cell c)
            (foldr (lambda (row rst) (if (equal? (first row) c)
                                         (cons (second row) rst)
                                         rst))
                     '() (db-content db-2))))
    (make-db (produce-new-schema (db-schema db-1) (db-schema db-2))
             (foldr (lambda (row lor) (append (translate row) lor))
                    '() (db-content db-1)))))