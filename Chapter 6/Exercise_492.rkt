;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_492) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; A Node is a Symbol.

; A Path is a [List-of Node].
; interpretation The list of nodes specifies a sequence
; of immediate neighbors that leads from the first 
; Node on the list to the last one.

; A Graph is [List-of Edges]

; An Edges is a
; (list Node [List-of Node])
; interpretation determines Node and all edges coming from it to other Nodes

(define sample-graph
  '((A (B E))
    (B (E F))
    (C (D))
    (D ())
    (E (C F))
    (F (D G))
    (G ())))

(define sample-graph-2
  '((A (B E))
    (B (E F))
    (C (B D))
    (D ())
    (E (C F))
    (F (D G))
    (G ())))

; Node Node Graph -> [Maybe Path]
; finds a path from origination to destination in G
; if there is no path, the function produces #false
(check-expect (find-path 'C 'D sample-graph)
              '(C D))
(check-member-of (find-path 'E 'D sample-graph)
                 '(E F D) '(E C D))
(check-expect (find-path 'C 'D sample-graph-2)
              '(C B E F D))
(check-expect (find-path 'C 'G sample-graph)
              #false)
(define (find-path origination destination G)
  (local ((define (find-path/a origination seen)
          (cond
            [(symbol=? origination destination) (list destination)]
            [(member? origination seen) #false]
            [else (local ((define next (neighbors origination G))
                          (define candidate
                            (find-path/list next (cons origination seen))))
                    (cond
                      [(boolean? candidate) #false]
                      [else (cons origination candidate)]))]))
          (define (find-path/list lo-Os seen)
            (cond
              [(empty? lo-Os) #false]
              [else (local ((define candidate
                              (find-path/a (first lo-Os) seen)))
                      (cond
                        [(boolean? candidate)
                         (find-path/list (rest lo-Os) seen)]
                        [else candidate]))])))
    (find-path/a origination '())))

; Node Graph -> [List-of Node]
; determine nodes that are connected to a-node in sg
(check-expect (neighbors 'A sample-graph) '(B E))
(check-expect (neighbors 'G sample-graph) '())
(check-error (neighbors 'H sample-graph) "neighbor: not a node")
(define (neighbors a-node sg)
  (cond
    [(empty? sg) (error "neighbor: not a node")]
    [else (if (symbol=? (first (first sg)) a-node)
              (second (first sg))
              (neighbors a-node (rest sg)))]))
