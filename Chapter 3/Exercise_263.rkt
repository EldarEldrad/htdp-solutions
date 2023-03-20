;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise_263) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; Nelon -> Number
; determines the smallest
; number on l
(define (inf l)
  (cond
    [(empty? (rest l)) (first l)]
    [else
     (local ((define smallest-in-rest (inf (rest l))))
       (if (< (first l) smallest-in-rest)
           (first l)
           smallest-in-rest))]))

(inf (list 2 1 3))
; -> (inf '(2 1 3))
; -> (cond
;      [(empty? (rest '(2 1 3))) (first '(2 1 3))]
;      [else
;       (local ((define smallest-in-rest (inf (rest '(2 1 3)))))
;         (if (< (first '(2 1 3)) smallest-in-rest)
;             (first '(2 1 3))
;             smallest-in-rest))])
; -> (cond
;      [(empty? '(1 3)) (first '(2 1 3))]
;      [else
;       (local ((define smallest-in-rest (inf (rest '(2 1 3)))))
;         (if (< (first '(2 1 3)) smallest-in-rest)
;             (first '(2 1 3))
;             smallest-in-rest))])
; -> (cond
;      [#false (first '(2 1 3))]
;      [else
;       (local ((define smallest-in-rest (inf (rest '(2 1 3)))))
;         (if (< (first '(2 1 3)) smallest-in-rest)
;             (first '(2 1 3))
;             smallest-in-rest))])
; -> (cond
;      [else
;       (local ((define smallest-in-rest (inf (rest '(2 1 3)))))
;         (if (< (first '(2 1 3)) smallest-in-rest)
;             (first '(2 1 3))
;             smallest-in-rest))])
; -> (local ((define smallest-in-rest (inf (rest '(2 1 3)))))
;      (if (< (first '(2 1 3)) smallest-in-rest)
;          (first '(2 1 3))
;          smallest-in-rest))
; -> (define smallest-in-rest_0 (inf (rest '(2 1 3))))
;    (if (< (first '(2 1 3)) smallest-in-rest_0)
;        (first '(2 1 3))
;        smallest-in-rest_0)
; -> (define smallest-in-rest_0 (inf '(1 3))))
;    (if (< (first '(2 1 3)) smallest-in-rest_0)
;        (first '(2 1 3))
;        smallest-in-rest_0)
; -> (define smallest-in-rest_0
;      (cond
;        [(empty? (rest '(1 3))) (first '(1 3))]
;        [else
;         (local ((define smallest-in-rest (inf (rest '(1 3)))))
;           (if (< (first '(1 3)) smallest-in-rest)
;               (first '(1 3))
;               smallest-in-rest))]))
;    (if (< (first '(2 1 3)) smallest-in-rest_0)
;        (first '(2 1 3))
;        smallest-in-rest_0)
; -> (define smallest-in-rest_0
;      (cond
;        [(empty? '(3)) (first '(1 3))]
;        [else
;         (local ((define smallest-in-rest (inf (rest '(1 3)))))
;           (if (< (first '(1 3)) smallest-in-rest)
;               (first '(1 3))
;               smallest-in-rest))]))
;    (if (< (first '(2 1 3)) smallest-in-rest_0)
;        (first '(2 1 3))
;        smallest-in-rest_0)
; -> (define smallest-in-rest_0
;      (cond
;        [#false (first '(1 3))]
;        [else
;         (local ((define smallest-in-rest (inf (rest '(1 3)))))
;           (if (< (first '(1 3)) smallest-in-rest)
;               (first '(1 3))
;               smallest-in-rest))]))
;    (if (< (first '(2 1 3)) smallest-in-rest_0)
;        (first '(2 1 3))
;        smallest-in-rest_0)
; -> (define smallest-in-rest_0
;      (cond
;        [else
;         (local ((define smallest-in-rest (inf (rest '(1 3)))))
;           (if (< (first '(1 3)) smallest-in-rest)
;               (first '(1 3))
;               smallest-in-rest))]))
;    (if (< (first '(2 1 3)) smallest-in-rest_0)
;        (first '(2 1 3))
;        smallest-in-rest_0)
; -> (define smallest-in-rest_0
;      (local ((define smallest-in-rest (inf (rest '(1 3)))))
;        (if (< (first '(1 3)) smallest-in-rest)
;            (first '(1 3))
;            smallest-in-rest))))
;    (if (< (first '(2 1 3)) smallest-in-rest_0)
;        (first '(2 1 3))
;        smallest-in-rest_0)
; -> (define smallest-in-rest_1 (inf (rest '(1 3))))
;    (define smallest-in-rest_0
;        (if (< (first '(1 3)) smallest-in-rest_1)
;            (first '(1 3))
;            smallest-in-rest_1)))
;    (if (< (first '(2 1 3)) smallest-in-rest_0)
;        (first '(2 1 3))
;        smallest-in-rest_0)
; -> (define smallest-in-rest_1 (inf '(3)))
;    (define smallest-in-rest_0
;        (if (< (first '(1 3)) smallest-in-rest_1)
;            (first '(1 3))
;            smallest-in-rest_1)))
;    (if (< (first '(2 1 3)) smallest-in-rest_0)
;        (first '(2 1 3))
;        smallest-in-rest_0)
; -> (define smallest-in-rest_1
;      (cond
;        [(empty? (rest '(3))) (first '(3))]
;        [else
;         (local ((define smallest-in-rest (inf (rest '(3)))))
;           (if (< (first '(3)) smallest-in-rest)
;               (first '(3))
;               smallest-in-rest))]))
;    (define smallest-in-rest_0
;        (if (< (first '(1 3)) smallest-in-rest_1)
;            (first '(1 3))
;            smallest-in-rest_1)))
;    (if (< (first '(2 1 3)) smallest-in-rest_0)
;        (first '(2 1 3))
; -> (define smallest-in-rest_1
;      (cond
;        [(empty? '()) (first '(3))]
;        [else
;         (local ((define smallest-in-rest (inf (rest '(3)))))
;           (if (< (first '(3)) smallest-in-rest)
;               (first '(3))
;               smallest-in-rest))]))
;    (define smallest-in-rest_0
;        (if (< (first '(1 3)) smallest-in-rest_1)
;            (first '(1 3))
;            smallest-in-rest_1)))
;    (if (< (first '(2 1 3)) smallest-in-rest_0)
;        (first '(2 1 3))
; -> (define smallest-in-rest_1
;      (cond
;        [#true (first '(3))]
;        [else
;         (local ((define smallest-in-rest (inf (rest '(3)))))
;           (if (< (first '(3)) smallest-in-rest)
;               (first '(3))
;               smallest-in-rest))]))
;    (define smallest-in-rest_0
;        (if (< (first '(1 3)) smallest-in-rest_1)
;            (first '(1 3))
;            smallest-in-rest_1)))
;    (if (< (first '(2 1 3)) smallest-in-rest_0)
;        (first '(2 1 3))
; -> (define smallest-in-rest_1 (first '(3)))
;    (define smallest-in-rest_0
;        (if (< (first '(1 3)) smallest-in-rest_1)
;            (first '(1 3))
;            smallest-in-rest_1)))
;    (if (< (first '(2 1 3)) smallest-in-rest_0)
;        (first '(2 1 3))
;        smallest-in-rest_0)
; -> (define smallest-in-rest_1 3)
;    (define smallest-in-rest_0
;        (if (< (first '(1 3)) smallest-in-rest_1)
;            (first '(1 3))
;            smallest-in-rest_1)))
;    (if (< (first '(2 1 3)) smallest-in-rest_0)
;        (first '(2 1 3))
;        smallest-in-rest_0)
; -> (define smallest-in-rest_1 3)
;    (define smallest-in-rest_0
;        (if (< 1 smallest-in-rest_1)
;            (first '(1 3))
;            smallest-in-rest_1)))
;    (if (< (first '(2 1 3)) smallest-in-rest_0)
;        (first '(2 1 3))
;        smallest-in-rest_0)
; -> (define smallest-in-rest_1 3)
;    (define smallest-in-rest_0
;        (if (< 1 3)
;            (first '(1 3))
;            smallest-in-rest_1)))
;    (if (< (first '(2 1 3)) smallest-in-rest_0)
;        (first '(2 1 3))
;        smallest-in-rest_0)
; -> (define smallest-in-rest_1 3)
;    (define smallest-in-rest_0
;        (if #true
;            (first '(1 3))
;            smallest-in-rest_1)))
;    (if (< (first '(2 1 3)) smallest-in-rest_0)
;        (first '(2 1 3))
;        smallest-in-rest_0)
; -> (define smallest-in-rest_1 3)
;    (define smallest-in-rest_0
;            (first '(1 3)))
;    (if (< (first '(2 1 3)) smallest-in-rest_0)
;        (first '(2 1 3))
;        smallest-in-rest_0)
; -> (define smallest-in-rest_1 3)
;    (define smallest-in-rest_0 1)
;    (if (< (first '(2 1 3)) smallest-in-rest_0)
;        (first '(2 1 3))
;        smallest-in-rest_0)
; -> (define smallest-in-rest_1 3)
;    (define smallest-in-rest_0 1)
;    (if (< 2 smallest-in-rest_0)
;        (first '(2 1 3))
;        smallest-in-rest_0)
; -> (define smallest-in-rest_1 3)
;    (define smallest-in-rest_0 1)
;    (if (< 2 1)
;        (first '(2 1 3))
;        smallest-in-rest_0)
; -> (define smallest-in-rest_1 3)
;    (define smallest-in-rest_0 1)
;    (if #false
;        (first '(2 1 3))
;        smallest-in-rest_0)
; -> (define smallest-in-rest_1 3)
;    (define smallest-in-rest_0 1)
;    smallest-in-rest_0
; -> (define smallest-in-rest_1 3)
;    (define smallest-in-rest_0 1)
;    1