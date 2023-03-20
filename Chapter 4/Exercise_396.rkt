;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_396) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; An HM-Word is a [List-of Letter or "_"]
; interpretation "_" represents a letter to be guessed

(define LETTERS '("a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m"
                      "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z"))
 
; HM-Word N -> String
; runs a simplistic hangman game, produces the current state
(define (play the-pick time-limit)
  (local ((define the-word  (explode the-pick))
          (define the-guess (make-list (length the-word) "_"))
          ; HM-Word -> HM-Word
          (define (do-nothing s) s)
          ; HM-Word KeyEvent -> HM-Word 
          (define (checked-compare current-status ke)
            (if (member? ke LETTERS)
                (compare-word the-word current-status ke)
                current-status)))
    (implode
     (big-bang the-guess ; HM-Word
       [to-draw render-word]
       [on-tick do-nothing 1 time-limit]
       [on-key  checked-compare]))))
 
; HM-Word -> Image
(define (render-word w)
  (text (implode w) 22 "black"))

; HM-Word HM-Word KeyEvent -> HM-Word
; compare KeyEvent guess with the word, producing new current status
(check-expect (compare-word '() '() "a") '())
(check-expect (compare-word '("c" "a" "t") '("_" "_" "_") "a") '("_" "a" "_"))
(check-expect (compare-word '("c" "a" "t") '("_" "a" "_") "a") '("_" "a" "_"))
(check-expect (compare-word '("c" "a" "t") '("_" "_" "_") "b") '("_" "_" "_"))
(check-expect (compare-word '("h" "e" "l" "l" "o") '("_" "e" "_" "_" "_") "l") '("_" "e" "l" "l" "_"))
(define (compare-word the-word current-status ke)
  (cond
    [(empty? current-status) '()]
    [else
     (cons (if (equal? ke (first the-word)) (first the-word) (first current-status))
           (compare-word (rest the-word) (rest current-status) ke))]))

(define AS-LIST (read-lines "words.dat"))
(define SIZE (length AS-LIST))
(play (list-ref AS-LIST (random SIZE)) 10)