;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise_190) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; Lo1S -> List-of-Lo1S
; consumes a list of 1Strings and produces the list of all prefixes
(check-expect (prefixes '()) '())
(check-expect (prefixes (list "a")) (list (list "a")))
(check-expect (prefixes (list "a" "b")) (list (list "a") (list "a" "b")))
(check-expect (prefixes (list "a" "b" "c")) (list (list "a") (list "a" "b") (list "a" "b" "c")))
(define (prefixes l)
  (cond
    [(empty? l) '()]
    [else (cons (list (first l)) (add1s (first l) (prefixes (rest l))))]))

; 1String List-of-Lo1S -> List-of-Lo1S
; adds given 1String at the beginning of each Lo1S
(check-expect (add1s "x" '()) '())
(check-expect (add1s "x" (list '())) (list (list "x")))
(check-expect (add1s "x" (list (list "a"))) (list (list "x" "a")))
(check-expect (add1s "x" (list (list "a") (list "b" "c")))
              (list (list "x" "a") (list "x" "b" "c")))
(define (add1s s l)
  (cond
    [(empty? l) '()]
    [else (cons (cons s (first l)) (add1s s (rest l)))]))

; Lo1S -> List-of-Lo1S
; consumes a list of 1Strings and produces the list of all suffixes
(check-expect (suffixes '()) '())
(check-expect (suffixes (list "a")) (list (list "a")))
(check-expect (suffixes (list "a" "b")) (list (list "a" "b") (list "b")))
(check-expect (suffixes (list "a" "b" "c")) (list (list "a" "b" "c") (list "b" "c") (list "c")))
(define (suffixes l)
  (reverse (reverse-each-list (prefixes (reverse l)))))

; List-of-Lo1S -> List-of-Lo1S
; reverses each list in given List-of-Lo1S
(check-expect (reverse-each-list '()) '())
(check-expect (reverse-each-list (list (list "a"))) (list (list "a")))
(check-expect (reverse-each-list (list (list "a" "b"))) (list (list "b" "a")))
(check-expect (reverse-each-list (list (list "a" "b") (list "c" "d" "f") (list "e")))
              (list (list "b" "a") (list "f" "d" "c") (list "e")))
(define (reverse-each-list lol)
  (cond
    [(empty? lol) '()]
    [else (cons (reverse (first lol)) (reverse-each-list (rest lol)))]))