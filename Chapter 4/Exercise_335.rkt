;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_335) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
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