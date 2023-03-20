;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise_214) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; A Word is one of:
; – '() or
; – (cons 1String Word)
; interpretation a Word is a list of 1Strings (letters)

(define LOCATION "words.dat")
 
; A Dictionary is a List-of-strings.
(define DICTIONARY (read-lines LOCATION))

; String -> List-of-strings
; finds all words that use the same letters as s
(check-member-of (alternative-words "cat")
                 (list "act" "cat")
                 (list "cat" "act"))
(check-satisfied (alternative-words "rat")
                 all-words-from-rat?)
(define (alternative-words s)
  (in-dictionary
    (words->strings (arrangements (string->word s)))))
 
; List-of-words -> List-of-strings
; turns all Words in low into Strings
(check-expect (words->strings '()) '())
(check-expect (words->strings (list '())) (list ""))
(check-expect (words->strings (list (list "a"))) (list "a"))
(check-expect (words->strings (list (list "a" "n"))) (list "an"))
(check-expect (words->strings (list (list "a" "n") '())) (list "an" ""))
(check-expect (words->strings (list (list "a" "n") (list "a" "p" "p" "l" "e"))) (list "an" "apple"))
(define (words->strings low)
  (cond
    [(empty? low) '()]
    [else (cons (word->string (first low))
                (words->strings (rest low)))]))
 
; List-of-strings -> List-of-strings
; picks out all those Strings that occur in the dictionary
(check-expect (in-dictionary '()) '())
(check-expect (in-dictionary (list (first DICTIONARY))) (list (first DICTIONARY)))
(check-expect (in-dictionary (list "word" "nonexistentword" "sentence")) (list "word" "sentence"))
(define (in-dictionary los)
  (cond
    [(empty? los) '()]
    [(member? (first los) DICTIONARY)
     (cons (first los) (in-dictionary (rest los)))]
    [else (in-dictionary (rest los))]))

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

; String -> Word
; converts s to the chosen word representation
(check-expect (string->word "") '())
(check-expect (string->word "a") (list "a"))
(check-expect (string->word "word") (list "w" "o" "r" "d"))
(check-expect (string->word "Big") (list "B" "i" "g"))
(define (string->word s) (explode s))
 
; Word -> String
; converts w to a string
(check-expect (word->string '()) "")
(check-expect (word->string (list "a")) "a")
(check-expect (word->string (list "w" "o" "r" "d")) "word")
(check-expect (word->string (list "B" "i" "g")) "Big")
(define (word->string w) (implode w))

; List-of-strings -> Boolean
(define (all-words-from-rat? w)
  (and (member? "rat" w)
       (member? "art" w)
       (member? "tar" w)))