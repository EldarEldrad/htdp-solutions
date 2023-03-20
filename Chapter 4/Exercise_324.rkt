;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_324) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
(define-struct no-info [])
(define NONE (make-no-info))
 
(define-struct node [ssn name left right])
; A BT (short for BinaryTree) is one of:
; – NONE
; – (make-node Number Symbol BT BT)

(define bt1
  (make-node 15 'd NONE (make-node 24 'i NONE NONE)))

(define bt2
  (make-node 15 'd (make-node 87 'h NONE NONE) NONE))

(define bt3
  (make-node 10 'a bt1 bt2))

; BT -> [List-of Number]
; produces the sequence of all the ssn numbers in the tree
; as they show up from left to right when looking at a tree drawing
(check-expect (inorder NONE) '())
(check-expect (inorder bt1) '(15 24))
(check-expect (inorder bt2) '(87 15))
(check-expect (inorder bt3) '(15 24 10 87 15))
(define (inorder bt)
  (cond
    [(no-info? bt) '()]
    [else (append (inorder (node-left bt))
                  (list (node-ssn bt))
                  (inorder (node-right bt)))]))

; for BST it produces sorted [List-of Number]