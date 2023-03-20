;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_327) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
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
(define bst3 (make-node 63 'a
                        (make-node 29 'b
                                   (make-node 15 'd
                                              (make-node 10 'h NONE NONE)
                                              (make-node 24 'i NONE NONE))
                                   NONE)
                        (make-node 89 'c
                                   (make-node 77 'l NONE NONE)
                                   (make-node 95 'g NONE (make-node 99 'o NONE NONE)))))

; BST Number Symbol -> BST
; inserts new node with given number and symbol into BST
(check-expect (create-bst bst1 43 'f) (make-node 43 'f NONE NONE))
(check-expect (create-bst bst2 40 'r)
              (make-node 43 'd
                         (make-node 22 'b
                                    (make-node 15 'a NONE NONE)
                                    (make-node 29 'c NONE (make-node 40 'r NONE NONE)))
                         (make-node 67 'g
                                    (make-node 49 'e
                                               NONE
                                               (make-node 56 'f NONE NONE))
                                    NONE)))
(check-expect (create-bst bst2 54 't)
              (make-node 43 'd
                         (make-node 22 'b
                                    (make-node 15 'a NONE NONE)
                                    (make-node 29 'c NONE NONE))
                         (make-node 67 'g
                                    (make-node 49 'e
                                               NONE
                                               (make-node 56 'f
                                                          (make-node 54 't NONE NONE)
                                                          NONE))
                                   NONE)))
(check-expect (create-bst bst2 49 't) bst2)
(check-expect (create-bst bst3 50 'y)
              (make-node 63 'a
                         (make-node 29 'b
                                    (make-node 15 'd
                                               (make-node 10 'h NONE NONE)
                                               (make-node 24 'i NONE NONE))
                                    (make-node 50 'y NONE NONE))
                         (make-node 89 'c
                                    (make-node 77 'l NONE NONE)
                                    (make-node 95 'g NONE (make-node 99 'o NONE NONE)))))
(define (create-bst bst n s)
  (cond
    [(no-info? bst) (make-node n s NONE NONE)]
    [(< n (node-ssn bst))
     (make-node (node-ssn bst)
                (node-name bst)
                (create-bst (node-left bst) n s)
                (node-right bst))]
    [(> n (node-ssn bst))
     (make-node (node-ssn bst)
                (node-name bst)
                (node-left bst)
                (create-bst (node-right bst) n s))]
    [else bst]))

; [List-of [List Number Symbol]] -> BST
; consumes a list of numbers and names and produces a BST by repeatedly applying create-bst
(check-expect (create-bst-from-list '()) NONE)
(check-expect (create-bst-from-list '((43 d) (22 b) (15 a) (29 c) (67 g) (49 e) (56 f))) bst2)
(check-expect (create-bst-from-list (reverse '((99 o) (77 l) (24 i) (10 h) (95 g) (15 d) (89 c) (29 b) (63 a)))) bst3)
(define (create-bst-from-list l)
  (foldl (lambda (x rst) (create-bst rst (first x) (second x))) NONE l))