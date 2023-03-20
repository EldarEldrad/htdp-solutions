;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_399) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; [List-of String] -> [List-of String] 
; picks a random non-identity arrangement of names
(define (gift-pick names)
  (random-pick
    (non-same names (arrangements names))))
 
; Word -> List-of-words
; finds all rearrangements of word
(check-expect (arrangements (list "d" "e")) (list (list "d" "e") (list "e" "d")))
(define (arrangements w)
  (cond
    [(empty? w) (list '())]
    [else (insert-everywhere/in-all-words (first w)
            (arrangements (rest w)))]))

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

; [NEList-of X] -> X 
; returns a random item from the list
(check-random (random-pick '(1 2 3 4 5)) (list-ref '(1 2 3 4 5) (random 5)))
(check-expect (random-pick '(3)) 3)
(define (random-pick l)
  (list-ref l (random (length l))))
 
; [List-of String] [List-of [List-of String]] -> [List-of [List-of String]]
; produces the list of those lists in ll that do 
; not agree with names at any place
(check-expect (non-same '() '()) '())
(check-expect (non-same '("a" "b") '()) '())
(check-expect (non-same '() '(("a" "b"))) '(("a" "b")))
(check-expect (non-same '("c") '(("a" "b") ())) '(("a" "b") ()))
(check-expect (non-same '("a" "b") '(("b" "c") ("a" "c") ("b" "b"))) '(("b" "c")))
(define (non-same names ll)
  (local ((define (not-agree lst)
            (or (not (equal? (length names) (length lst)))
                (andmap (lambda (a b) (not (equal? a b))) lst names))))
    (filter not-agree ll)))

(gift-pick '("Louise" "Jane" "Laura" "Dana" "Mary"))