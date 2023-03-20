;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_339) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
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

; Dir String -> Boolean
; determines whether or not a file with this name occurs in the directory tree.
(check-expect (find? (make-dir "Hi" '() '()) "Hi") #false)
(check-expect (find? (make-dir "Dir" '() (list (make-file "hi" 10 ""))) "hi") #true)
(check-expect (find? (make-dir "Dir" (list (make-dir "Dir2" '() '())) '()) "Dir2") #false)
(check-expect (find? (make-dir "AAA"
                               (list (make-dir "BBB" '() (list (make-file "part1" 34 ""))))
                               (list (make-file "part2" 22 "")
                                     (make-file "part3" 76 "")))
                     "part2") #true)
(check-expect (find? dir-tree "read!") #true)
(check-expect (find? dir-tree "read") #false)
(define (find? dir name)
  (or (ormap (lambda (fle) (string=? name (file-name fle)))
             (dir-files dir))
      (ormap (lambda (d) (find? d name))
             (dir-dirs dir))))