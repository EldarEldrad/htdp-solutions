;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_333) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
(define-struct dir [name content])
; A Dir.v2 is a structure: 
;   (make-dir String LOFD)
 
; An LOFD (short for list of files and directories) is one of:
; – '()
; – (cons File.v2 LOFD)
; – (cons Dir.v2 LOFD)
 
; A File.v2 is a String.

(define dir-tree (make-dir "TS"
                           (list (make-dir "Text" (list "part1" "part2" "part3"))
                                 "read!"
                                 (make-dir "Libs"
                                           (list (make-dir "Code" (list "hang" "draw"))
                                                 (make-dir "Docs" (list "read!")))))))

; Dir.v2 -> Number
; determines how many files a given Dir.v2 contains
(check-expect (how-many (make-dir "Hi" '())) 0)
(check-expect (how-many (make-dir "Dir" (list "hi"))) 1)
(check-expect (how-many (make-dir "Dir" (list (make-dir "Dir2" '())))) 0)
(check-expect (how-many (make-dir "AAA" (list (make-dir "BBB" (list "part1")) "part2" "part3"))) 3)
(check-expect (how-many dir-tree) 7)
(define (how-many dir)
  (local (; LOFD -> Number
          ; determines how many files a given LOFD contains
          (define (how-many/content lofd)
            (cond
              [(empty? lofd) 0]
              [(string? (first lofd)) (add1 (how-many/content (rest lofd)))]
              [else (+ (how-many (first lofd))
                       (how-many/content (rest lofd)))])))
    (how-many/content (dir-content dir))))