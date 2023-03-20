;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_390) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct branch [left right])
 
; A TOS is one of:
; – Symbol
; – (make-branch TOS TOS)
 
; A Direction is one of:
; – 'left
; – 'right
 
; A list of Directions is also called a path.

(define ERROR "path not valid")

; TOS [List-of Direction] -> TOS
; retrieves TOS in the tree by given list of directions
(check-expect (tree-pick 'a '()) 'a)
(check-expect (tree-pick (make-branch 'a 'b) '()) (make-branch 'a 'b))
(check-expect (tree-pick (make-branch 'a 'b) '(left)) 'a)
(check-error (tree-pick (make-branch 'a 'b) '(down)) ERROR)
(check-error (tree-pick (make-branch 'a 'b) '(left right)) ERROR)
(check-expect (tree-pick (make-branch (make-branch (make-branch 'a 'b) (make-branch 'c 'd))
                                      (make-branch (make-branch 'e 'f) (make-branch 'g 'h)))
                         '(left right))
              (make-branch 'c 'd))
(check-expect (tree-pick (make-branch (make-branch (make-branch 'a 'b) (make-branch 'c 'd))
                                      (make-branch (make-branch 'e 'f) (make-branch 'g 'h)))
                         '(right right left))
              'g)
(define (tree-pick tos lod)
  (cond
    [(and (empty? lod) (symbol? tos)) tos]
    [(and (empty? lod) (branch? tos)) tos]
    [(and (cons? lod) (symbol? tos)) (error ERROR)]
    [(and (cons? lod) (branch? tos)) (tree-pick (cond
                                                  [(equal? 'left (first lod)) (branch-left tos)]
                                                  [(equal? 'right (first lod)) (branch-right tos)]
                                                  [else (error ERROR)])
                                                (rest lod))]))