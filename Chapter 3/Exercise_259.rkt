;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise_259) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
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
  (local (; List-of-strings -> List-of-strings
          ; picks out all those Strings that occur in the dictionary
         
          (define (in-dictionary los)
            (cond
              [(empty? los) '()]
              [(member? (first los) DICTIONARY)
               (cons (first los) (in-dictionary (rest los)))]
              [else (in-dictionary (rest los))]))
          ; List-of-words -> List-of-strings
          ; turns all Words in low into Strings
          (define (words->strings low)
            (cond
              [(empty? low) '()]
              [else (cons (word->string (first low))
                          (words->strings (rest low)))]))
          ; Word -> List-of-words
          ; finds all rearrangements of word
          (define (arrangements w)
            (cond
              [(empty? w) (list '())]
              [else (insert-everywhere/in-all-words (first w)
                                                    (arrangements (rest w)))]))
          ; 1String List-of-words -> List-of-words
          ; the result is a list of words like its second argument,
          ; but with the first argument inserted at the beginning,
          ; between all letters, and at the end of all words of the given list
          (define (insert-everywhere/in-all-words l low)
            (cond
              [(empty? low) '()]
              [else (append (insert-everywhere/word l (first low))
                            (insert-everywhere/in-all-words l (rest low)))]))
          ; 1String Word -> List-of-words
          ; produces the list of words that are created by inserting given letter at the beginning,
          ; between all letters, and at the end of given word
          (define (insert-everywhere/word l word)
            (cond
              [(empty? word) (list (list l))]
              [else (cons (append (list l) word)
                          (append-each (first word) (insert-everywhere/word l (rest word))))]))
          ; 1String List-of-words
          ; inserts given letter at the beginning of each word in given list
          (define (append-each l low)
            (cond
              [(empty? low) '()]
              [else (cons (append (list l) (first low))
                          (append-each l (rest low)))]))
          ; String -> Word
          ; converts s to the chosen word representation
          (define (string->word s) (explode s))
          ; Word -> String
          ; converts w to a string
          (define (word->string w) (implode w)))
    (in-dictionary
     (words->strings (arrangements (string->word s))))))

; List-of-strings -> Boolean
(define (all-words-from-rat? w)
  (and (member? "rat" w)
       (member? "art" w)
       (member? "tar" w)))