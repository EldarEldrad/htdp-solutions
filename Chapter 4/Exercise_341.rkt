;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_341) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
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
; computes the total size of all the files in the entire directory tree
(check-expect (du (make-dir "Hi" '() '())) 1)
(check-expect (du (make-dir "Dir" '() (list (make-file "hi" 10 "")))) 11)
(check-expect (du (make-dir "Dir" (list (make-dir "Dir2" '() '())) '())) 2)
(check-expect (du (make-dir "AAA"
                            (list (make-dir "BBB" '() (list (make-file "part1" 34 ""))))
                            (list (make-file "part2" 22 "")
                                  (make-file "part3" 76 ""))))
              134)
(check-expect (du dir-tree) 212)
(define (du dir)
  (+ (foldl (lambda (x rst) (+ (file-size x) rst))
            0
            (dir-files dir))
     (foldl (lambda (x rst) (+ (du x) rst))
            0
            (dir-dirs dir))
     1))