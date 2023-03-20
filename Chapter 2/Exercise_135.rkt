;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_135) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; A List-of-names is one of: 
; – '()
; – (cons String List-of-names)
; interpretation a list of invitees, by last name

; List-of-names -> Boolean
; determines whether "Flatt" occurs on alon
(define (contains-flatt? alon)
  (cond
    [(empty? alon) #false]
    [(cons? alon)
     (or (string=? (first alon) "Flatt")
         (contains-flatt? (rest alon)))]))

(contains-flatt?
  (cons "A" (cons "Flatt" (cons "C" '()))))
; -> (cond
;      [(empty? (cons "A" (cons "Flatt" (cons "C" '())))) #false]
;      [(cons? (cons "A" (cons "Flatt" (cons "C" '()))))
;       (or (string=? (first (cons "A" (cons "Flatt" (cons "C" '())))) "Flatt")
;           (contains-flatt? (rest (cons "A" (cons "Flatt" (cons "C" '()))))))])
; -> (cond
;      [#false #false]
;      [(cons? (cons "A" (cons "Flatt" (cons "C" '()))))
;       (or (string=? (first (cons "A" (cons "Flatt" (cons "C" '())))) "Flatt")
;           (contains-flatt? (rest (cons "A" (cons "Flatt" (cons "C" '()))))))])
; -> (cond
;      [(cons? (cons "A" (cons "Flatt" (cons "C" '()))))
;       (or (string=? (first (cons "A" (cons "Flatt" (cons "C" '())))) "Flatt")
;           (contains-flatt? (rest (cons "A" (cons "Flatt" (cons "C" '()))))))])
; -> (cond
;      [#true
;       (or (string=? (first (cons "A" (cons "Flatt" (cons "C" '())))) "Flatt")
;           (contains-flatt? (rest (cons "A" (cons "Flatt" (cons "C" '()))))))])
; -> (or (string=? (first (cons "A" (cons "Flatt" (cons "C" '())))) "Flatt")
;        (contains-flatt? (rest (cons "A" (cons "Flatt" (cons "C" '()))))))
; -> (or (string=? "A" "Flatt")
;        (contains-flatt? (rest (cons "A" (cons "Flatt" (cons "C" '()))))))
; -> (or #false
;        (contains-flatt? (rest (cons "A" (cons "Flatt" (cons "C" '()))))))
; -> (or #false
;        (contains-flatt? (cons "Flatt" (cons "C" '()))))
; -> (or #false
;        (cond
;          [(empty? (cons "Flatt" (cons "C" '()))) #false]
;          [(cons? (cons "Flatt" (cons "C" '())))
;           (or (string=? (first (cons "Flatt" (cons "C" '()))) "Flatt")
;               (contains-flatt? (rest (cons "Flatt" (cons "C" '())))))]))
; -> (or #false
;        (cond
;          [#false #false]
;          [(cons? (cons "Flatt" (cons "C" '())))
;           (or (string=? (first (cons "Flatt" (cons "C" '()))) "Flatt")
;               (contains-flatt? (rest (cons "Flatt" (cons "C" '())))))]))
; -> (or #false
;        (cond
;          [(cons? (cons "Flatt" (cons "C" '())))
;           (or (string=? (first (cons "Flatt" (cons "C" '()))) "Flatt")
;               (contains-flatt? (rest (cons "Flatt" (cons "C" '())))))]))
; -> (or #false
;        (cond
;          [#true
;           (or (string=? (first (cons "Flatt" (cons "C" '()))) "Flatt")
;               (contains-flatt? (rest (cons "Flatt" (cons "C" '())))))]))
; -> (or #false
;        (or (string=? (first (cons "Flatt" (cons "C" '()))) "Flatt")
;            (contains-flatt? (rest (cons "Flatt" (cons "C" '()))))))
; -> (or #false
;        (or (string=? "Flatt" "Flatt")
;            (contains-flatt? (rest (cons "Flatt" (cons "C" '()))))))
; -> (or #false
;        (or #true
;            (contains-flatt? (rest (cons "Flatt" (cons "C" '()))))))
; -> (or #false
;        #true)
; -> #true

(contains-flatt?
  (cons "A" (cons "B" (cons "C" '()))))
; -> (cond
;      [(empty? (cons "A" (cons "B" (cons "C" '())))) #false]
;      [(cons? (cons "A" (cons "B" (cons "C" '()))))
;       (or (string=? (first (cons "A" (cons "B" (cons "C" '())))) "Flatt")
;           (contains-flatt? (rest (cons "A" (cons "B" (cons "C" '()))))))])
; -> (cond
;      [#false #false]
;      [(cons? (cons "A" (cons "B" (cons "C" '()))))
;       (or (string=? (first (cons "A" (cons "B" (cons "C" '())))) "Flatt")
;           (contains-flatt? (rest (cons "A" (cons "B" (cons "C" '()))))))])
; -> (cond
;      [(cons? (cons "A" (cons "B" (cons "C" '()))))
;       (or (string=? (first (cons "A" (cons "B" (cons "C" '())))) "Flatt")
;           (contains-flatt? (rest (cons "A" (cons "B" (cons "C" '()))))))])
; -> (cond
;      [#true
;       (or (string=? (first (cons "A" (cons "B" (cons "C" '())))) "Flatt")
;           (contains-flatt? (rest (cons "A" (cons "B" (cons "C" '()))))))])
; -> (or (string=? (first (cons "A" (cons "B" (cons "C" '())))) "Flatt")
;        (contains-flatt? (rest (cons "A" (cons "B" (cons "C" '()))))))
; -> (or (string=? "A" "Flatt")
;        (contains-flatt? (rest (cons "A" (cons "B" (cons "C" '()))))))
; -> (or #false
;        (contains-flatt? (rest (cons "A" (cons "B" (cons "C" '()))))))
; -> (or #false
;        (contains-flatt? (cons "B" (cons "C" '()))))
; -> (or #false
;        (cond
;          [(empty? (cons "B" (cons "C" '()))) #false]
;          [(cons? (cons "B" (cons "C" '())))
;           (or (string=? (first (cons "B" (cons "C" '()))) "Flatt")
;               (contains-flatt? (rest (cons "B" (cons "C" '())))))]))
; -> (or #false
;        (cond
;          [#false #false]
;          [(cons? (cons "B" (cons "C" '())))
;           (or (string=? (first (cons "B" (cons "C" '()))) "Flatt")
;               (contains-flatt? (rest (cons "B" (cons "C" '())))))]))
; -> (or #false
;        (cond
;          [(cons? (cons "B" (cons "C" '())))
;           (or (string=? (first (cons "B" (cons "C" '()))) "Flatt")
;               (contains-flatt? (rest (cons "B" (cons "C" '())))))]))
; -> (or #false
;        (cond
;          [#true
;           (or (string=? (first (cons "B" (cons "C" '()))) "Flatt")
;               (contains-flatt? (rest (cons "B" (cons "C" '())))))]))
; -> (or #false
;        (or (string=? (first (cons "B" (cons "C" '()))) "Flatt")
;            (contains-flatt? (rest (cons "B" (cons "C" '()))))))
; -> (or #false
;        (or (string=? "B" "Flatt")
;            (contains-flatt? (rest (cons "B" (cons "C" '()))))))
; -> (or #false
;        (or #false
;            (contains-flatt? (rest (cons "B" (cons "C" '()))))))
; -> (or #false
;        (or #false
;            (contains-flatt? (cons "C" '()))))
; -> (or #false
;        (or #false
;            (cond
;              [(empty? (cons "C" '())) #false]
;              [(cons? (cons "C" '()))
;               (or (string=? (first (cons "C" '())) "Flatt")
;                   (contains-flatt? (rest (cons "C" '()))))])))
; -> (or #false
;        (or #false
;            (cond
;              [#false #false]
;              [(cons? (cons "C" '()))
;               (or (string=? (first (cons "C" '())) "Flatt")
;                   (contains-flatt? (rest (cons "C" '()))))])))
; -> (or #false
;        (or #false
;            (cond
;              [(cons? (cons "C" '()))
;               (or (string=? (first (cons "C" '())) "Flatt")
;                   (contains-flatt? (rest (cons "C" '()))))])))
; -> (or #false
;        (or #false
;            (cond
;              [#true
;               (or (string=? (first (cons "C" '())) "Flatt")
;                   (contains-flatt? (rest (cons "C" '()))))])))
; -> (or #false
;        (or #false
;            (or (string=? (first (cons "C" '())) "Flatt")
;                (contains-flatt? (rest (cons "C" '()))))))
; -> (or #false
;        (or #false
;            (or (string=? "C" "Flatt")
;                (contains-flatt? (rest (cons "C" '()))))))
; -> (or #false
;        (or #false
;            (or #false
;                (contains-flatt? (rest (cons "C" '()))))))
; -> (or #false
;        (or #false
;            (or #false
;                (contains-flatt? '()))))
; -> (or #false
;        (or #false
;            (or #false
;                (cond
;                  [(empty? '()) #false]
;                  [(cons? '())
;                   (or (string=? (first '()) "Flatt")
;                       (contains-flatt? (rest '())))]))))
; -> (or #false
;        (or #false
;            (or #false
;                (cond
;                  [#true #false]
;                  [(cons? '())
;                   (or (string=? (first '()) "Flatt")
;                       (contains-flatt? (rest '())))]))))
; -> (or #false
;        (or #false
;            (or #false
;                #false)))
; -> (or #false
;        (or #false
;            #false))
; -> (or #false
;        #false)
; -> #false