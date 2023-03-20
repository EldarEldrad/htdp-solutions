;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_174) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; An LN is one of: 
; – '()
; – (cons Los LN)
; interpretation a list of lines, each is a list of Strings
 
(define line0 (cons "hello" (cons "world" '())))
(define line1 '())
(define line2 (cons "hello" (cons "the" (cons "world" '()))))
 
(define ln0 '())
(define ln1 (cons line0 (cons line1 '())))
(define ln2 (cons line0 (cons line2 (cons line1 '()))))
 
; LN -> LN
; encodes given text
(check-expect (encode-words/line ln0) ln0)
(check-expect (encode-words/line ln1) (cons (encode-line line0)
                                            (cons (encode-line line1) '())))
(check-expect (encode-words/line ln2) (cons (encode-line line0)
                                            (cons (encode-line line2)
                                                  (cons (encode-line line1) '()))))
(define (encode-words/line ln)
  (cond
    [(empty? ln) '()]
    [else (cons (encode-line (first ln))
                (encode-words/line (rest ln)))]))

; List-of-string -> List-of-string
; encodes given line
(check-expect (encode-line line0) (cons (encode-word (explode "hello"))
                                              (cons (encode-word (explode "world"))
                                                    '())))
(check-expect (encode-line line1) line1)
(check-expect (encode-line line2) (cons (encode-word (explode "hello"))
                                        (cons (encode-word (explode "the"))
                                              (cons (encode-word (explode "world"))
                                                    '()))))
(define (encode-line los)
  (cond
   [(empty? los) '()]
   [else (cons (encode-word (explode (first los)))
               (encode-line (rest los)))]))

; List-of-string -> String
; encodes given word
(check-expect (encode-word '()) "")
(check-expect (encode-word (cons "z" '())) (encode-letter "z"))
(check-expect (encode-word (cons "a" (cons "b" (cons "c" '()))))
              (string-append (encode-letter "a") (encode-letter "b") (encode-letter "c")))
(define (encode-word los)
  (cond
   [(empty? los) ""]
   [else (string-append (encode-letter (first los))
                        (encode-word (rest los)))]))

; 1String -> String
; converts the given 1String to a 3-letter numeric String
(check-expect (encode-letter "z") (code1 "z"))
(check-expect (encode-letter "\t")
              (string-append "00" (code1 "\t")))
(check-expect (encode-letter "a")
              (string-append "0" (code1 "a")))
(define (encode-letter s)
  (cond
    [(>= (string->int s) 100) (code1 s)]
    [(< (string->int s) 10)
     (string-append "00" (code1 s))]
    [(< (string->int s) 100)
     (string-append "0" (code1 s))]))
 
; 1String -> String
; converts the given 1String into a String
(check-expect (code1 "z") "122")
(define (code1 c)
  (number->string (string->int c)))

; LN -> String
; converts a list of lines into a string
; The strings should be separated by blank spaces (" ")
; The lines should be separated with a newline ("\n")
(check-expect (collapse ln0) "")
(check-expect (collapse ln1) "hello world\n")
(define (collapse ln)
  (cond
    [(empty? ln) ""]
    [(empty? (rest ln)) (line-collapse (first ln))]
    [else (string-append (line-collapse (first ln))
                         "\n"
                         (collapse (rest ln)))]))

; List-of-string -> String
; converts a list of string into a string
; The string should be separated by blank spaces (" ")
(check-expect (line-collapse line0) "hello world")
(check-expect (line-collapse line1) "")
(define (line-collapse los)
  (cond
   [(empty? los) ""]
   [(empty? (rest los)) (first los)]
   [else (string-append (first los)
                        " "
                        (line-collapse (rest los)))]))

(define EX
  (cons (encode-line (cons "TTT" '()))
        (cons '()
              (cons (encode-line (cons "Put" (cons "up" (cons "in" (cons "a" (cons "place" '()))))))
                    (cons (encode-line (cons "where" (cons "it's" (cons "easy" (cons "to" (cons "see" '()))))))
                          (cons (encode-line (cons "the" (cons "cryptic" (cons "admonishment" '()))))
                                (cons (encode-line (cons "T.T.T." '()))
                                      (cons '()
                                            (cons (encode-line (cons "When" (cons "you" (cons "feel" (cons "how" (cons "depressingly" '()))))))
                                                  (cons (encode-line (cons "slowly" (cons "you" (cons "climb," '()))))
                                                        (cons (encode-line (cons "it's" (cons "well" (cons "to" (cons "remember" (cons "that" '()))))))
                                                              (cons (encode-line (cons "Things" (cons "Take" (cons "Time." '()))))
                                                                    (cons '()
                                                                          (cons (encode-line (cons "Piet" (cons "Hein" '())))
                                                                                '()))))))))))))))

; String -> String
; encodes text files numerically
(check-expect (read-words/line (encode-file "ttt.txt")) EX)
(define (encode-file f)
  (write-file (string-append "encoded-" f)
              (collapse (encode-words/line (read-words/line f)))))