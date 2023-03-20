;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_326) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
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
                                   (make-node 15 'c
                                              (make-node 10 'd NONE NONE)
                                              (make-node 24 'e NONE NONE))
                                   NONE)
                        (make-node 89 'f
                                   (make-node 77 'g NONE NONE)
                                   (make-node 95 'h NONE (make-node 99 'i NONE NONE)))))

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
                                    (make-node 15 'c
                                               (make-node 10 'd NONE NONE)
                                               (make-node 24 'e NONE NONE))
                                    (make-node 50 'y NONE NONE))
                         (make-node 89 'f
                                    (make-node 77 'g NONE NONE)
                                    (make-node 95 'h NONE (make-node 99 'i NONE NONE)))))
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