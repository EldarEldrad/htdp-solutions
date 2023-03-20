;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_338) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
(define dir-tree (make-dir "TS"
                           (list (make-dir "Text"
                                           '()
                                           (list (make-file "part1" 99 "")
                                                 (make-file "part2" 52 "")
                                                 (make-file "part3" 17 "")))
                                 (make-dir "Libs"
                                           (list (make-dir "Code"
                                                           '()
                                                           (list (make-file "hang" 8 "")
                                                                 (make-file "draw" 2 "")))
                                                 (make-dir "Docs"
                                                           '()
                                                           (list (make-file "read!" 19 ""))))
                                           '()))
                           (list (make-file "read!" 10 ""))))

; Dir -> Number
; determines how many files a given Dir contains
(check-expect (how-many (make-dir "Hi" '() '())) 0)
(check-expect (how-many (make-dir "Dir" '() (list (make-file "hi" 10 "")))) 1)
(check-expect (how-many (make-dir "Dir" (list (make-dir "Dir2" '() '())) '())) 0)
(check-expect (how-many (make-dir "AAA"
                                  (list (make-dir "BBB" '() (list (make-file "part1" 34 ""))))
                                  (list (make-file "part2" 22 "")
                                        (make-file "part3" 76 "")))) 3)
(check-expect (how-many dir-tree) 7)
(define (how-many dir)
  (+ (length (dir-files dir))
     (foldl (lambda (x rst) (+ (how-many x) rst)) 0 (dir-dirs dir))))

(define surv-books (create-dir "D:\\Denis\\Books\\Surv"))

(how-many surv-books)