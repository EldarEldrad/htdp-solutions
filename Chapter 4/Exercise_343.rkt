;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_343) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
; A Path is [List-of String].
; interpretation directions into a directory tree

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

; Dir -> [List-of Path]
; lists the paths to all files contained in a given Dir
(check-expect (ls-R (make-dir "Hi" '() '())) '())
(check-expect (ls-R (make-dir "Dir" '() (list (make-file "hi" 10 "")))) '(("Dir" "hi")))
(check-expect (ls-R (make-dir "Dir" (list (make-dir "Dir2" '() '())) '())) '())
(check-expect (ls-R (make-dir "AAA"
                               (list (make-dir "BBB" '() (list (make-file "part1" 34 ""))))
                               (list (make-file "part2" 22 "")
                                     (make-file "part3" 76 "")))) '(("AAA" "part2") ("AAA" "part3") ("AAA" "BBB" "part1")))
(check-expect (ls-R dir-tree)
              '(("TS" "read!") ("TS" "Text" "part1") ("TS" "Text" "part2") ("TS" "Text" "part3")
                               ("TS" "Libs" "Code" "hang") ("TS" "Libs" "Code" "draw")
                               ("TS" "Libs" "Docs" "read!")))
(define (ls-R dr)
  (local (; [List-of Path] -> [List-of Path]
          (define (add-current-dir-name x)
            (cons (dir-name dr) x)))
    (append (map add-current-dir-name (map (lambda (f) (list (file-name f))) (dir-files dr)))
            (map add-current-dir-name
               (foldr (lambda (d rst) (append (ls-R d) rst)) '() (dir-dirs dr))))))