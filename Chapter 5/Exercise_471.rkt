;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_471) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; A Graph is [List-of Edges]

; An Edges is a
; (list Node [List-of Node])
; interpretation determines Node and all edges coming from it to other Nodes

; A Node is a Symbol.


(define sample-graph
  (list (list 'A (list 'B 'E))
        (list 'B (list 'E 'F))
        (list 'C (list 'D))
        (list 'D '())
        (list 'E (list 'C 'F))
        (list 'F (list 'D 'G))
        (list 'G '())))

(define ERROR-NODE "Node is not presented in graph")

; Node Graph -> [List-of Node]
; consumes a Node n and a Graph g and produces the list of immediate neighbors of n in g
(check-expect (neighbors 'A sample-graph) '(B E))
(check-expect (neighbors 'D sample-graph) '())
(check-expect (neighbors 'F sample-graph) '(D G))
(check-error (neighbors 'H sample-graph) ERROR-NODE)
(define (neighbors n g)
  (local ((define edges (assoc n g)))
    (if (and (list? edges) (>= (length edges) 2))
        (second edges)
        (error ERROR-NODE))))