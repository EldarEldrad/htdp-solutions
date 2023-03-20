;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_331) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
; A Dir.v1 (short for directory) is one of: 
; – '()
; – (cons File.v1 Dir.v1)
; – (cons Dir.v1 Dir.v1)
 
; A File.v1 is a String.

(define dir-tree '(("part1" "part2" "part3")
                   "read!"
                   (("hang" "draw")
                    ("read!"))))

; Dir.v1 -> Number
; determines how many files a given Dir.v1 contains
(check-expect (how-many '()) 0)
(check-expect (how-many '("hi")) 1)
(check-expect (how-many '(())) 0)
(check-expect (how-many '(("part1") "part2" "part3")) 3)
(check-expect (how-many dir-tree) 7)
(define (how-many dir)
  (cond
    [(empty? dir) 0]
    [(string? (first dir)) (add1 (how-many (rest dir)))]
    [else (+ (how-many (first dir))
             (how-many (rest dir)))]))