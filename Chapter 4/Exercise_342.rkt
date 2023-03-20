;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_342) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
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

; Dir String -> Path?
; If (find? d f) is #true, find produces a path to a file with name f; otherwise it produces #false
(check-expect (find (make-dir "Hi" '() '()) "Hi") #false)
(check-expect (find (make-dir "Dir" '() (list (make-file "hi" 10 ""))) "hi") '("Dir" "hi"))
(check-expect (find (make-dir "Dir" (list (make-dir "Dir2" '() '())) '()) "Dir2") #false)
(check-expect (find (make-dir "AAA"
                               (list (make-dir "BBB" '() (list (make-file "part1" 34 ""))))
                               (list (make-file "part2" 22 "")
                                     (make-file "part3" 76 "")))
                     "part1")
              '("AAA" "BBB" "part1"))
(check-expect (find dir-tree "hang") '("TS" "Libs" "Code" "hang"))
(check-expect (find dir-tree "read") #false)
(define (find dr str)
  (local (; [List-of File] -> Path?
          (define (find-in-files lof)
            (cond
              [(empty? lof) #false]
              [(string=? (file-name (first lof))
                         str) (list str)]
              [else (find-in-files (rest lof))]))
          ; [List-of Dir] -> Path?
          (define (find-in-dirs drs)
            (cond
              [(empty? drs) #false]
              [(cons? (find (first drs) str)) (find (first drs) str)]
              [else (find-in-dirs (rest drs))]))
          (define file-hit? (find-in-files (dir-files dr)))
          (define dir-hit? (find-in-dirs (dir-dirs dr))))
    (cond
      [(cons? file-hit?) (cons (dir-name dr) file-hit?)]
      [(cons? dir-hit?) (cons (dir-name dr) dir-hit?)]
      [else #false])))

; Dir String -> [List-of Path]
; produces the list of all paths that lead to f in d
(check-expect (find-all (make-dir "Hi" '() '()) "Hi") '())
(check-expect (find-all (make-dir "Dir" '() (list (make-file "hi" 10 ""))) "hi") '(("Dir" "hi")))
(check-expect (find-all (make-dir "Dir" (list (make-dir "Dir2" '() '())) '()) "Dir2") '())
(check-expect (find-all (make-dir "AAA"
                               (list (make-dir "BBB" '() (list (make-file "part1" 34 ""))))
                               (list (make-file "part2" 22 "")
                                     (make-file "part3" 76 "")))
                     "part1")
              '(("AAA" "BBB" "part1")))
(check-expect (find-all dir-tree "hang") '(("TS" "Libs" "Code" "hang")))
(check-expect (find-all dir-tree "read!")
              '(("TS" "read!") ("TS" "Libs" "Docs" "read!")))
(define (find-all dr str)
  (local (; [List-of File] -> [List-of Path]
          (define (find-in-files lof)
            (cond
              [(empty? lof) '()]
              [(string=? (file-name (first lof)) str)
               (cons (list str)
                     (find-in-files (rest lof)))]
              [else (find-in-files (rest lof))]))
          ; [List-of Dir] -> [List-of Path]
          (define (find-in-dirs drs)
            (cond
              [(empty? drs) '()]
              [else (append (find-all (first drs) str)
                            (find-in-dirs (rest drs)))]))
          ; [List-of Path] -> [List-of Path]
          (define (add-current-dir-name x)
            (cons (dir-name dr) x)))
     (map add-current-dir-name
          (append (find-in-files (dir-files dr))
                  (find-in-dirs (dir-dirs dr))))))