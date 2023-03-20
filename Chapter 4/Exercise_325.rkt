;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_325) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
(define-struct no-info [])
(define NONE (make-no-info))
 
(define-struct node [ssn name left right])
; A BT (short for BinaryTree) is one of:
; – NONE
; – (make-node Number Symbol BT BT)

(define bst1 NONE)
(define bst2 (make-node 43 'd
                        (make-node 22 'b
                                   (make-node 15 'a NONE NONE)
                                   (make-node 29 'c NONE NONE))
                        (make-node 67 'g
                                   (make-node 49 'e
                                              NONE
                                              (make-node 56 'f NONE NONE))
                                   NONE)))

; BST Number -> [Symbol or NONE]
; function consumes a number n and a BST.
; If the tree contains a node whose ssn field is n,
; the function produces the value of the name field in that node.
; Otherwise, the function produces NONE.
(check-expect (search-bst bst1 43) NONE)
(check-expect (search-bst bst2 43) 'd)
(check-expect (search-bst bst2 29) 'c)
(check-expect (search-bst bst2 56) 'f)
(check-expect (search-bst bst2 61) NONE)
(define (search-bst bst n)
  (cond
    [(no-info? bst) NONE]
    [(= n (node-ssn bst)) (node-name bst)]
    [(< n (node-ssn bst)) (search-bst (node-left bst) n)]
    [(> n (node-ssn bst)) (search-bst (node-right bst) n)]))