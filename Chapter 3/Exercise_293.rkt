;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_293) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; [X] X [List-of X] -> [Maybe [List-of X]]
; returns the first sublist of l that starts
; with x, #false otherwise
(check-satisfied (find 5 '(1 2 3 4)) (found 5 '(1 2 3 4)))
(check-satisfied (find 5 '(1 2 3 4 5 6)) (found 5 '(1 2 3 4 5 6)))
(check-satisfied (find "a" '("a" "b" "c")) (found "a" '("a" "b" "c")))
(check-satisfied (find "a" '()) (found "a" '()))
(define (find x l)
  (cond
    [(empty? l) #false]
    [else
     (if (equal? (first l) x) l (find x (rest l)))]))

; [X] X [List-of X] -> [[Maybe [List-of X]] -> Boolean]
; checks if s is sublist of l starting with e
(define (found e l)
  (lambda (s)
    (cond
      [(false? s) (not (member? e l))]
      [else (local ((define (sublist? sl lst)
                      (cond
                        [(empty? lst) (empty? sl)]
                        [(and (equal? (first sl) (first lst))
                              (equal? (length sl) (length lst)))
                         (sublist? (rest sl) (rest lst))]
                        [else (sublist? sl (rest lst))])))
              (and (equal? e (first s))
                   (sublist? s l)))])))