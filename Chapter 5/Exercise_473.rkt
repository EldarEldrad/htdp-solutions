;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_473) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
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

(define cyclic-graph
  '((A (B E))
    (B (E F))
    (C (B D))
    (D ())
    (E (C F))
    (F (D G))
    (G ())))

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

; A Path is a [List-of Node].
; interpretation The list of nodes specifies a sequence
; of immediate neighbors that leads from the first 
; Node on the list to the last one.

; Node Node Graph -> [Maybe Path]
; finds a path from origination to destination in G
; if there is no path, the function produces #false
(check-expect (find-path 'C 'D sample-graph)
              '(C D))
(check-member-of (find-path 'E 'D sample-graph)
                 '(E F D) '(E C D))
(check-expect (find-path 'C 'G sample-graph)
              #false)
(check-expect (find-path 'A 'G sample-graph)
              '(A B E F G))
(define (find-path origination destination G)
  (cond
    [(symbol=? origination destination) (list destination)]
    [else (local ((define next (neighbors origination G))
                  (define candidate
                    (find-path/list next destination G)))
            (cond
              [(boolean? candidate) #false]
              [else (cons origination candidate)]))]))

; [List-of Node] Node Graph -> [Maybe Path]
; finds a path from some node on lo-originations to
; destination; otherwise, it produces #false
(define (find-path/list lo-Os D G)
  (cond
    [(empty? lo-Os) #false]
    [else (local ((define candidate
                    (find-path (first lo-Os) D G)))
            (cond
              [(boolean? candidate)
               (find-path/list (rest lo-Os) D G)]
              [else candidate]))]))

; Graph -> Boolean
; determines whether there is a path between every pair of nodes
(check-expect (test-on-all-nodes sample-graph) #false)
(check-expect (test-on-all-nodes '((a (b))
                                   (b (c))
                                   (c ()))) #true)
(define (test-on-all-nodes g)
  (cond
    [(or (empty? g) (empty? (rest g))) #true]
    [else (and (andmap (lambda (edge) (cons? (find-path (first (first g)) (first edge) g))) (rest g))
               (test-on-all-nodes (rest g)))]))

(find-path 'B 'C cyclic-graph) ; '(B E C)
(test-on-all-nodes cyclic-graph) ; infinite loop