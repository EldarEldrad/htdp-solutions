;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_484) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define (infL l)
  (cond
    [(empty? (rest l)) (first l)]
    [else (local ((define s (infL (rest l))))
            (if (< (first l) s) (first l) s))]))

(infL (list 3 2 1 0))
; -> (cond
;      [(empty? (rest (list 3 2 1 0))) (first (list 3 2 1 0))]
;      [else (local ((define s (infL (rest (list 3 2 1 0)))))
;              (if (< (first (list 3 2 1 0)) s) (first (list 3 2 1 0)) s))])
; -> (cond
;      [(empty? (list 2 1 0)) (first (list 3 2 1 0))]
;      [else (local ((define s (infL (rest (list 3 2 1 0)))))
;              (if (< (first (list 3 2 1 0)) s) (first (list 3 2 1 0)) s))])
; -> (cond
;      [#false (first (list 3 2 1 0))]
;      [else (local ((define s (infL (rest (list 3 2 1 0)))))
;              (if (< (first (list 3 2 1 0)) s) (first (list 3 2 1 0)) s))])
; -> (cond
;      [else (local ((define s (infL (rest (list 3 2 1 0)))))
;              (if (< (first (list 3 2 1 0)) s) (first (list 3 2 1 0)) s))])
; -> (local ((define s (infL (rest (list 3 2 1 0)))))
;      (if (< (first (list 3 2 1 0)) s) (first (list 3 2 1 0)) s))
; -> (local ((define s (infL (list 2 1 0))))
;      (if (< (first (list 3 2 1 0)) s) (first (list 3 2 1 0)) s))
; -> ...
; -> (local ((define s (infL (list 1 0))))
;      (if (< (first (list 2 1 0)) s) (first (list 2 1 0)) s))
; -> ...
; -> (local ((define s (infL (list 0))))
;      (if (< (first (list 1 0)) s) (first (list 1 0)) s))
; -> ...
; -> (local ((define s 0))
;      (if (< (first (list 1 0)) s) (first (list 1 0)) s))
; -> (if (< (first (list 1 0)) 0) (first (list 1 0)) 0)
; -> (if (< 1 0) (first (list 1 0)) 0)
; -> (if #false (first (list 1 0)) 0)
; -> 0
; -> (if (< (first (list 2 1 0)) 0) (first (list 2 1 0)) 0)
; -> (if (< 2 0) (first (list 2 1 0)) 0)
; -> (if #false (first (list 2 1 0)) 0)
; -> 0
; -> (if (< (first (list 3 2 1 0)) 0) (first (list 3 2 1 0)) 0)
; -> (if (< 3 0) (first (list 3 2 1 0)) 0)
; -> (if #false (first (list 3 2 1 0)) 0)
; -> 0

; thus it requires N steps of recursion and then N steps of going through IF case
; in both best and worst cases