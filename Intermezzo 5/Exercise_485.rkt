;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_485) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; An NumberTree is one of
; - Number
; - (list NumberTree NumberTree)

; NumberTree -> Number
; determines the sum of the numbers in a tree
(check-expect (sum-tree 5) 5)
(check-expect (sum-tree (list 2 5)) 7)
(check-expect (sum-tree (list (list 0 1) (list 4 (list 2 5)))) 12)
(define (sum-tree tree)
  (cond
    [(number? tree) tree]
    [else
     (+ (sum-tree (first tree))
        (sum-tree (second tree)))]))

; acceptable measure of the size of the tree is its depth
; T(N) = T(N-1) + T(N-1)
; thus, abstract time is O(2^N)
; worst possible shape is one long single branch
; best possible shape is the tree with minumum possible depth