;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_340) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
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

; Dir -> [List-of String]
; lists the names of all files and directories in a given Dir
(check-expect (ls (make-dir "Hi" '() '())) '())
(check-expect (ls (make-dir "Dir" '() (list (make-file "hi" 10 "")))) '("hi"))
(check-expect (ls (make-dir "Dir" (list (make-dir "Dir2" '() '())) '())) '("Dir2"))
(check-expect (ls (make-dir "AAA"
                            (list (make-dir "BBB" '() (list (make-file "part1" 34 ""))))
                            (list (make-file "part2" 22 "")
                                  (make-file "part3" 76 ""))))
              '("BBB" "part2" "part3"))
(check-expect (ls dir-tree) '("Text" "Libs" "read!"))
(define (ls dir)
  (append (map dir-name (dir-dirs dir))
          (map file-name (dir-files dir))))