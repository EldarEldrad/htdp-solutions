;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_336) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
(define-struct file [name size content])

; A File.v3 is a structure: 
;   (make-file String N String)

(define-struct dir.v3 [name dirs files])

; A Dir.v3 is a structure: 
;   (make-dir.v3 String Dir* File*)
 
; A Dir* is one of: 
; – '()
; – (cons Dir.v3 Dir*)
 
; A File* is one of: 
; – '()
; – (cons File.v3 File*)

(define dir-tree (make-dir.v3 "TS"
                              (list (make-dir.v3 "Text"
                                                 '()
                                                 (list (make-file "part1" 99 "")
                                                       (make-file "part2" 52 "")
                                                       (make-file "part3" 17 "")))
                                    (make-dir.v3 "Libs"
                                                 (list (make-dir.v3 "Code"
                                                                    '()
                                                                    (list (make-file "hang" 8 "")
                                                                          (make-file "draw" 2 "")))
                                                       (make-dir.v3 "Docs"
                                                                    '()
                                                                    (list (make-file "read!" 19 ""))))
                                                 '()))
                              (list (make-file "read!" 10 ""))))

; Dir.v3 -> Number
; determines how many files a given Dir.v3 contains
(check-expect (how-many (make-dir.v3 "Hi" '() '())) 0)
(check-expect (how-many (make-dir.v3 "Dir" '() (list (make-file "hi" 10 "")))) 1)
(check-expect (how-many (make-dir.v3 "Dir" (list (make-dir.v3 "Dir2" '() '())) '())) 0)
(check-expect (how-many (make-dir.v3 "AAA"
                                     (list (make-dir.v3 "BBB" '() (list (make-file "part1" 34 ""))))
                                     (list (make-file "part2" 22 "")
                                           (make-file "part3" 76 "")))) 3)
(check-expect (how-many dir-tree) 7)
(define (how-many dir)
  (local (; File* -> Number
          (define (how-many/file* f*)
            (cond
              [(empty? f*) 0]
              [else (add1 (how-many/file* (rest f*)))]))
          ; Dir* -> Number
          (define (how-many/dir* d*)
            (cond
              [(empty? d*) 0]
              [else (+ (how-many (first d*))
                       (how-many/dir* (rest d*)))])))
  (+ (how-many/dir* (dir.v3-dirs dir))
     (how-many/file* (dir.v3-files dir)))))