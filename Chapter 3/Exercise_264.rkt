;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise_264) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; Nelon -> Number
; determines the largest
; number on l
(define (sup l)
  (cond
    [(empty? (rest l)) (first l)]
    [else
     (local ((define largest-in-rest (sup (rest l))))
       (if (> (first l) largest-in-rest)
           (first l)
           largest-in-rest))]))

(sup (list 2 1 3))
; -> (sup '(2 1 3))
; -> (cond
;      [(empty? (rest '(2 1 3))) (first '(2 1 3))]
;      [else
;       (local ((define largest-in-rest (sup (rest '(2 1 3)))))
;         (if (> (first '(2 1 3)) largest-in-rest)
;             (first '(2 1 3))
;             largest-in-rest))])
; -> (cond
;      [(empty? '(1 3)) (first '(2 1 3))]
;      [else
;       (local ((define largest-in-rest (sup (rest '(2 1 3)))))
;         (if (> (first '(2 1 3)) largest-in-rest)
;             (first '(2 1 3))
;             largest-in-rest))])
; -> (cond
;      [#false (first '(2 1 3))]
;      [else
;       (local ((define largest-in-rest (sup (rest '(2 1 3)))))
;         (if (> (first '(2 1 3)) largest-in-rest)
;             (first '(2 1 3))
;             largest-in-rest))])
; -> (cond
;      [else
;       (local ((define largest-in-rest (sup (rest '(2 1 3)))))
;         (if (> (first '(2 1 3)) largest-in-rest)
;             (first '(2 1 3))
;             largest-in-rest))])
; -> (local ((define largest-in-rest (sup (rest '(2 1 3)))))
;      (if (> (first '(2 1 3)) largest-in-rest)
;          (first '(2 1 3))
;          largest-in-rest))
; -> (define largest-in-rest_0 (sup (rest '(2 1 3))))
;    (if (> (first '(2 1 3)) largest-in-rest_0)
;        (first '(2 1 3))
;        largest-in-rest_0)
; -> (define largest-in-rest_0 (sup '(1 3))))
;    (if (> (first '(2 1 3)) largest-in-rest_0)
;        (first '(2 1 3))
;        largest-in-rest_0)
; -> (define largest-in-rest_0
;      (cond
;        [(empty? (rest '(1 3))) (first '(1 3))]
;        [else
;         (local ((define largest-in-rest (sup (rest '(1 3)))))
;           (if (> (first '(1 3)) largest-in-rest)
;               (first '(1 3))
;               largest-in-rest))]))
;    (if (> (first '(2 1 3)) largest-in-rest_0)
;        (first '(2 1 3))
;        largest-in-rest_0)
; -> (define largest-in-rest_0
;      (cond
;        [(empty? '(3)) (first '(1 3))]
;        [else
;         (local ((define largest-in-rest (sup (rest '(1 3)))))
;           (if (> (first '(1 3)) largest-in-rest)
;               (first '(1 3))
;               largest-in-rest))]))
;    (if (> (first '(2 1 3)) largest-in-rest_0)
;        (first '(2 1 3))
;        largest-in-rest_0)
; -> (define largest-in-rest_0
;      (cond
;        [#false (first '(1 3))]
;        [else
;         (local ((define largest-in-rest (sup (rest '(1 3)))))
;           (if (> (first '(1 3)) largest-in-rest)
;               (first '(1 3))
;               largest-in-rest))]))
;    (if (> (first '(2 1 3)) largest-in-rest_0)
;        (first '(2 1 3))
;        largest-in-rest_0)
; -> (define largest-in-rest_0
;      (cond
;        [else
;         (local ((define largest-in-rest (sup (rest '(1 3)))))
;           (if (> (first '(1 3)) largest-in-rest)
;               (first '(1 3))
;               largest-in-rest))]))
;    (if (> (first '(2 1 3)) largest-in-rest_0)
;        (first '(2 1 3))
;        largest-in-rest_0)
; -> (define largest-in-rest_0
;      (local ((define largest-in-rest (sup (rest '(1 3)))))
;        (if (> (first '(1 3)) largest-in-rest)
;            (first '(1 3))
;            largest-in-rest))))
;    (if (> (first '(2 1 3)) largest-in-rest_0)
;        (first '(2 1 3))
;        largest-in-rest_0)
; -> (define largest-in-rest_1 (sup (rest '(1 3))))
;    (define largest-in-rest_0
;        (if (> (first '(1 3)) largest-in-rest_1)
;            (first '(1 3))
;            largest-in-rest_1)))
;    (if (> (first '(2 1 3)) largest-in-rest_0)
;        (first '(2 1 3))
;        largest-in-rest_0)
; -> (define largest-in-rest_1 (sup '(3)))
;    (define largest-in-rest_0
;        (if (> (first '(1 3)) largest-in-rest_1)
;            (first '(1 3))
;            largest-in-rest_1)))
;    (if (> (first '(2 1 3)) largest-in-rest_0)
;        (first '(2 1 3))
;        largest-in-rest_0)
; -> (define largest-in-rest_1
;      (cond
;        [(empty? (rest '(3))) (first '(3))]
;        [else
;         (local ((define largest-in-rest (sup (rest '(3)))))
;           (if (> (first '(3)) largest-in-rest)
;               (first '(3))
;               largest-in-rest))]))
;    (define largest-in-rest_0
;        (if (> (first '(1 3)) largest-in-rest_1)
;            (first '(1 3))
;            largest-in-rest_1)))
;    (if (> (first '(2 1 3)) largest-in-rest_0)
;        (first '(2 1 3))
; -> (define largest-in-rest_1
;      (cond
;        [(empty? '()) (first '(3))]
;        [else
;         (local ((define largest-in-rest (sup (rest '(3)))))
;           (if (> (first '(3)) largest-in-rest)
;               (first '(3))
;               largest-in-rest))]))
;    (define largest-in-rest_0
;        (if (> (first '(1 3)) largest-in-rest_1)
;            (first '(1 3))
;            largest-in-rest_1)))
;    (if (> (first '(2 1 3)) largest-in-rest_0)
;        (first '(2 1 3))
; -> (define largest-in-rest_1
;      (cond
;        [#true (first '(3))]
;        [else
;         (local ((define largest-in-rest (sup (rest '(3)))))
;           (if (> (first '(3)) largest-in-rest)
;               (first '(3))
;               largest-in-rest))]))
;    (define largest-in-rest_0
;        (if (> (first '(1 3)) largest-in-rest_1)
;            (first '(1 3))
;            largest-in-rest_1)))
;    (if (> (first '(2 1 3)) largest-in-rest_0)
;        (first '(2 1 3))
; -> (define largest-in-rest_1 (first '(3)))
;    (define largest-in-rest_0
;        (if (> (first '(1 3)) largest-in-rest_1)
;            (first '(1 3))
;            largest-in-rest_1)))
;    (if (> (first '(2 1 3)) largest-in-rest_0)
;        (first '(2 1 3))
;        largest-in-rest_0)
; -> (define largest-in-rest_1 3)
;    (define largest-in-rest_0
;        (if (> (first '(1 3)) largest-in-rest_1)
;            (first '(1 3))
;            largest-in-rest_1)))
;    (if (> (first '(2 1 3)) largest-in-rest_0)
;        (first '(2 1 3))
;        largest-in-rest_0)
; -> (define largest-in-rest_1 3)
;    (define largest-in-rest_0
;        (if (> 1 largest-in-rest_1)
;            (first '(1 3))
;            largest-in-rest_1)))
;    (if (> (first '(2 1 3)) largest-in-rest_0)
;        (first '(2 1 3))
;        largest-in-rest_0)
; -> (define largest-in-rest_1 3)
;    (define largest-in-rest_0
;        (if (> 1 3)
;            (first '(1 3))
;            largest-in-rest_1)))
;    (if (> (first '(2 1 3)) largest-in-rest_0)
;        (first '(2 1 3))
;        largest-in-rest_0)
; -> (define largest-in-rest_1 3)
;    (define largest-in-rest_0
;        (if #false
;            (first '(1 3))
;            largest-in-rest_1)))
;    (if (> (first '(2 1 3)) largest-in-rest_0)
;        (first '(2 1 3))
;        largest-in-rest_0)
; -> (define largest-in-rest_1 3)
;    (define largest-in-rest_0
;            largest-in-rest_1)
;    (if (> (first '(2 1 3)) largest-in-rest_0)
;        (first '(2 1 3))
;        largest-in-rest_0)
; -> (define largest-in-rest_1 3)
;    (define largest-in-rest_0 3)
;    (if (> (first '(2 1 3)) largest-in-rest_0)
;        (first '(2 1 3))
;        largest-in-rest_0)
; -> (define largest-in-rest_1 3)
;    (define largest-in-rest_0 3)
;    (if (> 2 largest-in-rest_0)
;        (first '(2 1 3))
;        largest-in-rest_0)
; -> (define largest-in-rest_1 3)
;    (define largest-in-rest_0 3)
;    (if (> 2 3)
;        (first '(2 1 3))
;        largest-in-rest_0)
; -> (define largest-in-rest_1 3)
;    (define largest-in-rest_0 3)
;    (if #false
;        (first '(2 1 3))
;        largest-in-rest_0)
; -> (define largest-in-rest_1 3)
;    (define largest-in-rest_0 3)
;    largest-in-rest_0
; -> (define largest-in-rest_1 3)
;    (define largest-in-rest_0 3)
;    3