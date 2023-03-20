;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_301) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define (insertion-sort alon)
  ;========================================================
  (local ((define (sort alon) ; binding sort
            ;-----------------------------------------------------
            (cond
              [(empty? alon) '()]
              [else
               (add (first alon) (sort (rest alon)))])) ; bounded sort
            ;-----------------------------------------------------
          (define (add an alon)
            ;-=-=-=-=-=--=-=-=-=-=--=-=--=-=-=-=-=--=-=-=-=--=-=-
            (cond
              [(empty? alon) (list an)]
              [else
               (cond
                 [(> an (first alon)) (cons an alon)]
                 [else (cons (first alon)
                             (add an (rest alon)))])])))
            ;-=-=-=-=-=--=-=-=-=-=--=-=--=-=-=-=-=--=-=-=-=--=-=-
    (sort alon))) ; bounded sort
   ;===========================================================

(define (sort0 alon) ; binding sort-1
  ;========================================================
  (local ((define (sort0 alon) ; binding sort-2
            ;-----------------------------------------------------
            (cond
              [(empty? alon) '()]
              [else
               (add (first alon) (sort0 (rest alon)))])) ; bounded sort-2
            ;-----------------------------------------------------
          (define (add an alon)
            ;-=-=-=-=-=--=-=-=-=-=--=-=--=-=-=-=-=--=-=-=-=--=-=-
            (cond
              [(empty? alon) (list an)]
              [else
                (cond
                  [(> an (first alon)) (cons an alon)]
                  [else (cons (first alon)
                              (add an (rest alon)))])])))
            ;-=-=-=-=-=--=-=-=-=-=--=-=--=-=-=-=-=--=-=-=-=--=-=-
    (sort0 alon))) ; bounded sort-2
  ;========================================================

; these functions are the same