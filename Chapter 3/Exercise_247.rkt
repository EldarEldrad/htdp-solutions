;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise_247) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f () #f)))
(define (extract R l t)
  (cond
    [(empty? l) '()]
    [else (cond
            [(R (first l) t)
             (cons (first l)
                   (extract R (rest l) t))]
            [else
             (extract R (rest l) t)])]))

(extract < (cons 8 (cons 4 '())) 5)
; -> (extract < (cons 8 '(4)) 5)
; -> (extract < '(8 4) 5)
; -> (cond
;      [(empty? '(8 4)) '()]
;      [else (cond
;              [(< (first '(8 4)) 5)
;               (cons (first '(8 4))
;                     (extract < (rest '(8 4)) 5))]
;              [else
;               (extract < (rest '(8 4)) 5)])])
; -> (cond
;      [#false '()]
;      [else (cond
;              [(< (first '(8 4)) 5)
;               (cons (first '(8 4))
;                     (extract < (rest '(8 4)) 5))]
;              [else
;               (extract < (rest '(8 4)) 5)])])
; -> (cond
;      [else (cond
;              [(< (first '(8 4)) 5)
;               (cons (first '(8 4))
;                     (extract < (rest '(8 4)) 5))]
;              [else
;               (extract < (rest '(8 4)) 5)])])
; -> (cond
;      [(< (first '(8 4)) 5)
;       (cons (first '(8 4))
;             (extract < (rest '(8 4)) 5))]
;      [else
;       (extract < (rest '(8 4)) 5)])
; -> (cond
;      [(< 8 5)
;       (cons (first '(8 4))
;             (extract < (rest '(8 4)) 5))]
;      [else
;       (extract < (rest '(8 4)) 5)])
; -> (cond
;      [#false
;       (cons (first '(8 4))
;             (extract < (rest '(8 4)) 5))]
;      [else
;       (extract < (rest '(8 4)) 5)])
; -> (cond
;      [else
;       (extract < (rest '(8 4)) 5)])
; -> (extract < (rest '(8 4)) 5)
; -> (extract < '(4) 5)
; -> (cond
;      [(empty? '(4)) '()]
;      [else (cond
;              [(< (first '(4)) 5)
;               (cons (first '(4))
;                     (extract < (rest '(4)) 5))]
;              [else
;               (extract < (rest '(4)) 5)])])
; -> (cond
;      [#false '()]
;      [else (cond
;              [(< (first '(4)) 5)
;               (cons (first '(4))
;                     (extract < (rest '(4)) 5))]
;              [else
;               (extract < (rest '(4)) 5)])])
; -> (cond
;      [else (cond
;              [(< (first '(4)) 5)
;               (cons (first '(4))
;                     (extract < (rest '(4)) 5))]
;              [else
;               (extract < (rest '(4)) 5)])])
; -> (cond
;      [(< (first '(4)) 5)
;       (cons (first '(4))
;             (extract < (rest '(4)) 5))]
;      [else
;       (extract < (rest '(4)) 5)])
; -> (cond
;      [(< 4 5)
;       (cons (first '(4))
;             (extract < (rest '(4)) 5))]
;      [else
;       (extract < (rest '(4)) 5)])
; -> (cond
;      [#true
;       (cons (first '(4))
;             (extract < (rest '(4)) 5))]
;      [else
;       (extract < (rest '(4)) 5)])
; -> (cons (first '(4))
;          (extract < (rest '(4)) 5))
; -> (cons 4
;          (extract < (rest '(4)) 5))
; -> (cons 4
;          (extract < '() 5))
; -> (cons 4
;          (cond
;           [(empty? '()) '()]
;           [else (cond
;                   [(< (first '()) 5)
;                    (cons (first '())
;                          (extract < (rest '()) 5))]
;                   [else
;                    (extract < (rest '()) 5)])]))
; -> (cons 4
;          (cond
;           [#true '()]
;           [else (cond
;                   [(< (first '()) 5)
;                    (cons (first '())
;                          (extract < (rest '()) 5))]
;                   [else
;                    (extract < (rest '()) 5)])]))
; -> (cons 4
;          '())
; -> '(4)