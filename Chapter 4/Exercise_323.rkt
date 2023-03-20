;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_323) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
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

; BT Number -> Boolean
; determines whether a given number occurs in some given BT
(check-expect (contains-bt? NONE 24) #false)
(check-expect (contains-bt? bt1 15) #true)
(check-expect (contains-bt? bt2 87) #true)
(check-expect (contains-bt? bt2 24) #false)
(define (contains-bt? bt n)
  (cond
    [(no-info? bt) #false]
    [else (or (= n (node-ssn bt))
              (contains-bt? (node-left bt) n)
              (contains-bt? (node-right bt) n))]))

; BT Number -> Symbol?
; The function consumes a number n and a BT.
; If the tree contains a node structure whose ssn field is n,
; the function produces the value of the name field in that node.
; Otherwise, the function produces #false
(check-expect (search-bt NONE 24) #false)
(check-expect (search-bt bt1 15) 'd)
(check-expect (search-bt bt2 87) 'h)
(check-expect (search-bt bt2 24) #false)
(define (search-bt bt n)
  (cond
    [(no-info? bt) #false]
    [(= n (node-ssn bt)) (node-name bt)]
    [else (local ((define search-left-result (search-bt (node-left bt) n)))
            (cond
              [(symbol? search-left-result) search-left-result]
              [else (search-bt (node-right bt) n)]))]))