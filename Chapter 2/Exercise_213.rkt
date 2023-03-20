;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise_213) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; A Word is one of:
; – '() or
; – (cons 1String Word)
; interpretation a Word is a list of 1Strings (letters)

; A List-of-words is one of:
; - '()
; - (cons Word List-of-words)
; interpretation a List of Words

; 1String List-of-words -> List-of-words
; the result is a list of words like its second argument,
; but with the first argument inserted at the beginning,
; between all letters, and at the end of all words of the given list
(check-expect (insert-everywhere/in-all-words "a" '()) '())
(check-expect (insert-everywhere/in-all-words "a" (list '())) (list (list "a")))
(check-expect (insert-everywhere/in-all-words "a" (list (list "b"))) (list (list "a" "b") (list "b" "a")))
(check-expect (insert-everywhere/in-all-words "f" (list (list "c" "a" "t")))
              (list (list "f" "c" "a" "t") (list "c" "f" "a" "t") (list "c" "a" "f" "t") (list "c" "a" "t" "f")))
(check-expect (insert-everywhere/in-all-words "f" (list (list "c" "a" "t") (list "e" "d")))
              (list (list "f" "c" "a" "t") (list "c" "f" "a" "t")
                    (list "c" "a" "f" "t") (list "c" "a" "t" "f")
                    (list "f" "e" "d") (list "e" "f" "d") (list "e" "d" "f")))
(define (insert-everywhere/in-all-words l low)
  (cond
    [(empty? low) '()]
    [else (append (insert-everywhere/word l (first low))
                  (insert-everywhere/in-all-words l (rest low)))]))

; 1String Word -> List-of-words
; produces the list of words that are created by inserting given letter at the beginning,
; between all letters, and at the end of given word
(check-expect (insert-everywhere/word "a" '()) (list (list "a")))
(check-expect (insert-everywhere/word "a" (list "b")) (list (list "a" "b") (list "b" "a")))
(check-expect (insert-everywhere/word "f" (list "c" "a" "t"))
              (list (list "f" "c" "a" "t") (list "c" "f" "a" "t")
                    (list "c" "a" "f" "t") (list "c" "a" "t" "f")))
(define (insert-everywhere/word l word)
  (cond
    [(empty? word) (list (list l))]
    [else (cons (append (list l) word)
                (append-each (first word) (insert-everywhere/word l (rest word))))]))

; 1String List-of-words
; inserts given letter at the beginning of each word in given list
(check-expect (append-each "a" '()) '())
(check-expect (append-each "a" (list '())) (list (list "a")))
(check-expect (append-each "a" (list (list "b"))) (list (list "a" "b")))
(check-expect (append-each "f" (list (list "c" "a" "t")))
              (list (list "f" "c" "a" "t")))
(check-expect (append-each "f" (list (list "c" "a" "t") (list "e" "d")))
              (list (list "f" "c" "a" "t") (list "f" "e" "d")))
(define (append-each l low)
  (cond
    [(empty? low) '()]
    [else (cons (append (list l) (first low))
                (append-each l (rest low)))]))