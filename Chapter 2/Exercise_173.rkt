;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_173) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
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

(define EX
  (cons (cons "TTT" '())
        (cons '()
              (cons (cons "Put" (cons "up" (cons "in" (cons "place" '()))))
                    (cons (cons "where" (cons "it's" (cons "easy" (cons "to" (cons "see" '())))))
                          (cons (cons "cryptic" (cons "admonishment" '()))
                                (cons (cons "T.T.T." '())
                                      (cons '()
                                            (cons (cons "When" (cons "you" (cons "feel" (cons "how" (cons "depressingly" '())))))
                                                  (cons (cons "slowly" (cons "you" (cons "climb," '())))
                                                        (cons (cons "it's" (cons "well" (cons "to" (cons "remember" (cons "that" '())))))
                                                              (cons (cons "Things" (cons "Take" (cons "Time." '())))
                                                                    (cons '()
                                                                          (cons (cons "Piet" (cons "Hein" '()))
                                                                                '()))))))))))))))
 
; LN -> LN
; removes articles "a", "an" and "the" from given text
(check-expect (remove-articles-words/line ln0) ln0)
(check-expect (remove-articles-words/line ln1) ln1)
(check-expect (remove-articles-words/line ln2) (cons line0 (cons line0 (cons line1 '()))))
(define (remove-articles-words/line ln)
  (cond
    [(empty? ln) '()]
    [else (cons (remove-articles-line (first ln))
                (remove-articles-words/line (rest ln)))]))

; List-of-string -> List-of-string
; removes articles "a", "an" and "the" from given line
(check-expect (remove-articles-line line0) line0)
(check-expect (remove-articles-line line1) line1)
(check-expect (remove-articles-line line2) line0)
(define (remove-articles-line los)
  (cond
   [(empty? los) '()]
   [(or (string=? (first los) "a")
        (string=? (first los) "an")
        (string=? (first los) "the")) (remove-articles-line (rest los))]
   [else (cons (first los)
               (remove-articles-line (rest los)))]))

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

; String -> String
; consumes the name n of a file, reads the file, removes the articles,
; and writes the result out to a file whose name is the result of concatenating "no-articles-" with n
(check-expect (read-words/line (remove-articles "ttt.txt")) EX)
(define (remove-articles f)
  (write-file (string-append "no-articles-" f)
              (collapse (remove-articles-words/line (read-words/line f)))))

