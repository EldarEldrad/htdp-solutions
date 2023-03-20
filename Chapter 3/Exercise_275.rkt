;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_275) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
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
      [else (local
              ((define (maximum-letter-count lc1 lc2)
                 (if (> (letter-count-count lc1) (letter-count-count lc2)) lc1 lc2)))
              (foldl maximum-letter-count (first llc) llc))]))

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
  (local ((define (create-letter-count l)
            (local ((define (process-starting-letter word num)
                      (if (string-ci=? (string-ith word 0) l)
                          (add1 num)
                          num)))
              (make-letter-count l (foldr process-starting-letter 0 d)))))
    (map create-letter-count LETTERS)))

; Dictionary -> List-of-Dictionarys
; consumes a Dictionary and produces a list of Dictionarys, one per Letter
(check-expect (words-by-first-letter '())
              '())
(check-expect (words-by-first-letter (list "apple" "basket" "Bob" "tree"))
              (list (list "apple")
                    (list "basket" "Bob")
                    (list "tree")))
(define (words-by-first-letter d)
  (local ((define (process-letter l)
            (local ((define (filter-words word)
                      (string-ci=? (string-ith word 0) l)))
              (filter filter-words d)))
          (define (not-empty? l)
            (not (empty? l))))
    (filter not-empty? (map process-letter LETTERS))))
