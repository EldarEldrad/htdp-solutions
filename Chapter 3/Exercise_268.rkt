;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_268) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define-struct IR [name description acq-price sales-price])
; An IR is a structure:
;   (make-IR String String Number Number)
; interpretation
; inventory record specifies the name of an item, a description,
; the acquisition price, and the recommended sales price

; [List-of IR] -> [List-of IR]
(check-expect (sort-by-price-diff '()) '())
(check-expect (sort-by-price-diff
               (list (make-IR "a" "aaa" 30 40)))
              (list (make-IR "a" "aaa" 30 40)))
(check-expect (sort-by-price-diff
               (list (make-IR "a" "aaa" 30 40) (make-IR "b" "bbb" 5 23)))
              (list (make-IR "b" "bbb" 5 23) (make-IR "a" "aaa" 30 40)))
(check-expect (sort-by-price-diff
               (list (make-IR "a" "aaa" 30 40) (make-IR "b" "bbb" 5 23) (make-IR "c" "ccc" 40 51)))
              (list (make-IR "b" "bbb" 5 23) (make-IR "c" "ccc" 40 51) (make-IR "a" "aaa" 30 40)))
(check-expect (sort-by-price-diff
               (list (make-IR "a" "aaa" 30 40) (make-IR "b" "bbb" 5 23) (make-IR "c" "ccc" 40 51) (make-IR "d" "ddd" 25 35)))
              (list (make-IR "b" "bbb" 5 23) (make-IR "c" "ccc" 40 51) (make-IR "a" "aaa" 30 40) (make-IR "d" "ddd" 25 35)))
(define (sort-by-price-diff loir)
  (local (; IR IR -> Boolean
          ; returns true is first IR has bigger diff price
          (define (bigger-diff-price? ir1 ir2)
            (> (- (IR-sales-price ir1) (IR-acq-price ir1))
               (- (IR-sales-price ir2) (IR-acq-price ir2)))))
    (sort loir bigger-diff-price?)))