;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise_262) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; Number -> [List-of [List-of Number]]
; creates diagonal squares of 0s and 1s
(check-expect (identityM 0) '())
(check-expect (identityM 1) (list (list 1)))
(check-expect (identityM 2) (list (list 1 0) (list 0 1)))
(check-expect (identityM 3) (list (list 1 0 0) (list 0 1 0) (list 0 0 1)))
(check-expect (identityM 4) (list (list 1 0 0 0) (list 0 1 0 0) (list 0 0 1 0) (list 0 0 0 1)))
(define (identityM m)
  (local (; Number -> [List-of [List-of Number]]
          ; creates rows recursively
          (define (identityM-internal rn)
            (cond
              [(= rn m) '()]
              [else
               (cons (create-row 0 rn)
                     (identityM-internal (add1 rn)))]))
          ; Number Number -> [List-of Number]
          ; creates row
          (define (create-row cur rn)
            (cond
              [(= cur m) '()]
              [else
               (cons (if (= cur rn) 1 0)
                     (create-row (add1 cur) rn))])))
    (identityM-internal 0)))