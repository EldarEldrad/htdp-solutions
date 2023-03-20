;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise_198) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define LOCATION "words.dat")
 
; A Dictionary is a List-of-strings.
(define AS-LIST (read-lines LOCATION))

; A Letter is one of the following 1Strings: 
; – "a"
; – ... 
; – "z"
; or, equivalently, a member? of this list: 
(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz"))

; A Letter-Count is a structure
(define-struct letter-count [letter count])
;   (make-letter-count Letter Number)
; interpretation shows how often each letter is used as the first one of a word in the given dictionary

; Dictionary -> List-of-Dictionarys
; consumes a Dictionary and produces a list of Dictionarys, one per Letter
(check-expect (words-by-first-letter '())
              (list '()
                    '()
                    '()
                    '()
                    '()
                    '()
                    '()
                    '()
                    '()
                    '()
                    '()
                    '()
                    '()
                    '()
                    '()
                    '()
                    '()
                    '()
                    '()
                    '()
                    '()
                    '()
                    '()
                    '()
                    '()
                    '()))
(check-expect (words-by-first-letter (list "apple" "basket" "Bob" "tree"))
              (list (list "apple")
                    (list "basket" "Bob")
                    '()
                    '()
                    '()
                    '()
                    '()
                    '()
                    '()
                    '()
                    '()
                    '()
                    '()
                    '()
                    '()
                    '()
                    '()
                    '()
                    '()
                    (list "tree")
                    '()
                    '()
                    '()
                    '()
                    '()
                    '()))
(define (words-by-first-letter d)
  (words-by-first-letter-internal LETTERS d))

; List-of-Letters Dictionary -> List-of-Dictionary
; consumes a Dictionary and produces a list of Dictionarys, one per Letter
(check-expect (words-by-first-letter-internal '() '()) '())
(check-expect (words-by-first-letter-internal (list "a") '()) (list '()))
(check-expect (words-by-first-letter-internal (list "a" "b") '()) (list '() '()))
(check-expect (words-by-first-letter-internal '() (list "apple")) '())
(check-expect (words-by-first-letter-internal (list "a" "b") (list "apple" "basket" "Bob"))
              (list (list "apple") (list "basket" "Bob")))
(check-expect (words-by-first-letter-internal (list "a" "b" "c") (list "apple" "basket" "Bob" "tree"))
              (list (list "apple") (list "basket" "Bob") '()))
(define (words-by-first-letter-internal letters d)
  (cond
    [(empty? letters) '()]
    [else (cons (letter-dictionary (first letters) d)
                (words-by-first-letter-internal (rest letters) d))]))

; Letter Dictionary -> Dictionary
; produces a Dictionary for given starting letter
(check-expect (letter-dictionary "a" '()) '())
(check-expect (letter-dictionary "a" (list "apple" "basket" "Bob" "tree")) (list "apple"))
(check-expect (letter-dictionary "b" (list "apple" "basket" "Bob" "tree")) (list "basket" "Bob"))
(check-expect (letter-dictionary "c" (list "apple" "basket" "Bob" "tree")) '())
(define (letter-dictionary l d)
  (cond
    [(empty? d) '()]
    [(string-ci=? (string-ith (first d) 0) l) (cons (first d) (letter-dictionary l (rest d)))]
    [else (letter-dictionary l (rest d))]))

; Dictionary -> Letter-Count
; produces the Letter-Count for the letter that occurs most often as the first one in the given Dictionary
(check-expect (most-frequent.v1 '()) (make-letter-count "a" 0))
(check-expect (most-frequent.v1 (list "apple" "basket" "Bob" "tree")) (make-letter-count "b" 2))
(define (most-frequent.v1 d)
  (get-maximum-count (count-by-letter d)))

; List-of-Letter-Counts -> Letter-Count
; picks the pair with the maximum count
(check-expect (get-maximum-count '()) '())
(check-expect (get-maximum-count (list (make-letter-count "a" 5))) (make-letter-count "a" 5))
(check-expect (get-maximum-count (list (make-letter-count "a" 5) (make-letter-count "b" 5)))
              (make-letter-count "a" 5))
(check-expect (get-maximum-count (list (make-letter-count "a" 6) (make-letter-count "b" 5)))
              (make-letter-count "a" 6))
(check-expect (get-maximum-count (list (make-letter-count "a" 5) (make-letter-count "b" 6) (make-letter-count "c" 3)))
              (make-letter-count "b" 6))
(define (get-maximum-count llc)
  (cond
    [(empty? llc) '()]
    [(empty? (rest llc)) (first llc)]
    [else (maximum-letter-count (first llc) (get-maximum-count (rest llc)))]))

; Letter-Count Letter-Count -> Letter-Count
; returns letter count with maximum count
(check-expect (maximum-letter-count (make-letter-count "a" 5) (make-letter-count "b" 5))
              (make-letter-count "a" 5))
(check-expect (maximum-letter-count (make-letter-count "a" 7) (make-letter-count "b" 5))
              (make-letter-count "a" 7))
(check-expect (maximum-letter-count (make-letter-count "a" 5) (make-letter-count "b" 8))
              (make-letter-count "b" 8))
(define (maximum-letter-count lc1 lc2)
  (if (>= (letter-count-count lc1) (letter-count-count lc2)) lc1 lc2))

; Dictionary -> Letter-Count
; produces the Letter-Count for the letter that occurs most often as the first one in the given Dictionary
(check-expect (most-frequent.v2 '()) (make-letter-count "a" 0))
(check-expect (most-frequent.v2 (list "apple" "basket" "Bob" "tree")) (make-letter-count "b" 2))
(define (most-frequent.v2 d)
  (first (sort> (count-by-letter d))))

; List-of-Letter-Counts -> List-of-Letter-Counts
; produces a sorted version of l
(check-expect (sort> '()) '())
(check-expect (sort> (list (make-letter-count "a" 5))) (list (make-letter-count "a" 5)))
(check-expect (sort> (list (make-letter-count "a" 4) (make-letter-count "b" 5)))
              (list (make-letter-count "b" 5) (make-letter-count "a" 4)))
(check-expect (sort> (list (make-letter-count "a" 5) (make-letter-count "b" 6) (make-letter-count "c" 3)))
              (list (make-letter-count "b" 6) (make-letter-count "a" 5) (make-letter-count "c" 3)))
(define (sort> l)
  (cond
    [(empty? l) '()]
    [(cons? l) (insert (first l) (sort> (rest l)))]))
 
; Letter-Count List-of-Letter-Counts -> List-of-Letter-Counts
; inserts n into the sorted list of letter counts
(check-expect (insert (make-letter-count "a" 5) '()) (list (make-letter-count "a" 5)))
(check-expect (insert (make-letter-count "b" 4) (list (make-letter-count "a" 5)))
              (list (make-letter-count "a" 5) (make-letter-count "b" 4)))
(check-expect (insert (make-letter-count "b" 6) (list (make-letter-count "a" 5)))
              (list (make-letter-count "b" 6) (make-letter-count "a" 5)))
(check-expect (insert (make-letter-count "a" 5) (list (make-letter-count "b" 6) (make-letter-count "c" 3)))
              (list (make-letter-count "b" 6) (make-letter-count "a" 5) (make-letter-count "c" 3)))
(define (insert n l)
  (cond
    [(empty? l) (cons n '())]
    [else (if (>= (letter-count-count n) (letter-count-count (first l)))
              (cons n l)
              (cons (first l) (insert n (rest l))))]))

; Dictionary -> List-of-Letter-Counts
; counts how often each letter is used as the first one of a word in the given dictionary
(check-expect (count-by-letter '())
              (list (make-letter-count "a" 0)
                    (make-letter-count "b" 0)
                    (make-letter-count "c" 0)
                    (make-letter-count "d" 0)
                    (make-letter-count "e" 0)
                    (make-letter-count "f" 0)
                    (make-letter-count "g" 0)
                    (make-letter-count "h" 0)
                    (make-letter-count "i" 0)
                    (make-letter-count "j" 0)
                    (make-letter-count "k" 0)
                    (make-letter-count "l" 0)
                    (make-letter-count "m" 0)
                    (make-letter-count "n" 0)
                    (make-letter-count "o" 0)
                    (make-letter-count "p" 0)
                    (make-letter-count "q" 0)
                    (make-letter-count "r" 0)
                    (make-letter-count "s" 0)
                    (make-letter-count "t" 0)
                    (make-letter-count "u" 0)
                    (make-letter-count "v" 0)
                    (make-letter-count "w" 0)
                    (make-letter-count "x" 0)
                    (make-letter-count "y" 0)
                    (make-letter-count "z" 0)))
(check-expect (count-by-letter (list "apple" "basket" "Bob" "tree"))
              (list (make-letter-count "a" 1)
                    (make-letter-count "b" 2)
                    (make-letter-count "c" 0)
                    (make-letter-count "d" 0)
                    (make-letter-count "e" 0)
                    (make-letter-count "f" 0)
                    (make-letter-count "g" 0)
                    (make-letter-count "h" 0)
                    (make-letter-count "i" 0)
                    (make-letter-count "j" 0)
                    (make-letter-count "k" 0)
                    (make-letter-count "l" 0)
                    (make-letter-count "m" 0)
                    (make-letter-count "n" 0)
                    (make-letter-count "o" 0)
                    (make-letter-count "p" 0)
                    (make-letter-count "q" 0)
                    (make-letter-count "r" 0)
                    (make-letter-count "s" 0)
                    (make-letter-count "t" 1)
                    (make-letter-count "u" 0)
                    (make-letter-count "v" 0)
                    (make-letter-count "w" 0)
                    (make-letter-count "x" 0)
                    (make-letter-count "y" 0)
                    (make-letter-count "z" 0)))
(define (count-by-letter d)
  (count-by-letter-internal LETTERS d))

; List-of-Letters Dictionary -> List-of-Letter-Counts
; counts how often each letter is used as the first one of a word in the given dictionary
(check-expect (count-by-letter-internal '() '()) '())
(check-expect (count-by-letter-internal (list "a") '()) (list (make-letter-count "a" 0)))
(check-expect (count-by-letter-internal (list "a" "b") '()) (list (make-letter-count "a" 0) (make-letter-count "b" 0)))
(check-expect (count-by-letter-internal '() (list "apple")) '())
(check-expect (count-by-letter-internal (list "a" "b") (list "apple" "basket" "Bob"))
              (list (make-letter-count "a" 1) (make-letter-count "b" 2)))
(check-expect (count-by-letter-internal (list "a" "b" "c") (list "apple" "basket" "Bob" "tree"))
              (list (make-letter-count "a" 1) (make-letter-count "b" 2) (make-letter-count "c" 0)))
(define (count-by-letter-internal letters d)
  (cond
    [(empty? letters) '()]
    [else (cons (make-letter-count (first letters) (starts-with# (first letters) d))
                (count-by-letter-internal (rest letters) d))]))

; Letter Dictionary -> Number
; counts how many words in the given Dictionary start with the given Letter
(check-expect (starts-with# "a" '()) 0)
(check-expect (starts-with# "a" (list "apple" "basket" "Bob" "tree")) 1)
(check-expect (starts-with# "b" (list "apple" "basket" "Bob" "tree")) 2)
(check-expect (starts-with# "c" (list "apple" "basket" "Bob" "tree")) 0)
(define (starts-with# l d)
  (cond
    [(empty? d) 0]
    [else (+ (starts-with# l (rest d))
             (if (string-ci=? (string-ith (first d) 0) l)
                 1
                 0))]))