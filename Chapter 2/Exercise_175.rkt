;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_175) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define-struct wcresult [number-1str number-words number-lines])
; WCResult is a structure:
; (make-wcresult Number Number Number)
; interpratation represents the number of 1Strings, words, and lines in a given file

(define EX
  (cons (cons "TTT" '())
        (cons '()
              (cons (cons "Put" (cons "up" (cons "in" (cons "a" (cons "place" '())))))
                    (cons (cons "where" (cons "it's" (cons "easy" (cons "to" (cons "see" '())))))
                          (cons (cons "the" (cons "cryptic" (cons "admonishment" '())))
                                (cons (cons "T.T.T." '())
                                      (cons '()
                                            (cons (cons "When" (cons "you" (cons "feel" (cons "how" (cons "depressingly" '())))))
                                                  (cons (cons "slowly" (cons "you" (cons "climb," '())))
                                                        (cons (cons "it's" (cons "well" (cons "to" (cons "remember" (cons "that" '())))))
                                                              (cons (cons "Things" (cons "Take" (cons "Time." '())))
                                                                    (cons '()
                                                                          (cons (cons "Piet" (cons "Hein" '()))
                                                                                '()))))))))))))))

(define line0 (cons "hello" (cons "world" '())))
(define line1 '())
(define line2 (cons "hello" (cons "the" (cons "world" '()))))
 
(define ln0 '())
(define ln1 (cons line0 (cons line1 '())))
(define ln2 (cons line0 (cons line2 (cons line1 '()))))

; String -> WCResult
; consumes the name of a file and produces a value that consists of three numbers:
; the number of 1Strings, words, and lines in a given file
(check-expect (wc "ttt.txt") (make-wcresult 148 33 13))
(define (wc f)
  (count-wc (read-words/line f)))

; LN -> WCResult
; counts WCResult for given text
(check-expect (count-wc ln0) (make-wcresult 0 0 0))
(check-expect (count-wc ln1) (make-wcresult 10 2 2))
(check-expect (count-wc ln2) (make-wcresult 23 5 3))
(define (count-wc ln)
  (make-wcresult (count-letters ln) (count-words ln) (length ln)))

; LN -> Number
; counts number of world in given text
(check-expect (count-words ln0) 0)
(check-expect (count-words ln1) 2)
(check-expect (count-words ln2) 5)
(define (count-words ln)
  (cond
    [(empty? ln) 0]
    [else (+ (length (first ln))
             (count-words (rest ln)))]))

; LN -> Number
; counts number of letters in given text
(check-expect (count-letters ln0) 0)
(check-expect (count-letters ln1) 10)
(check-expect (count-letters ln2) 23)
(define (count-letters ln)
  (cond
    [(empty? ln) 0]
    [else (+ (count-letters/line (first ln))
             (count-letters (rest ln)))]))

; List-of-strings -> Number
; counts number of letters in given line
(check-expect (count-letters/line line0) 10)
(check-expect (count-letters/line line1) 0)
(check-expect (count-letters/line line2) 13)
(define (count-letters/line line)
  (cond
    [(empty? line) 0]
    [else (+ (length (explode (first line)))
             (count-letters/line (rest line)))]))