;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_269) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define-struct IR [name description acq-price sales-price])
; An IR is a structure:
;   (make-IR String String Number Number)
; interpretation
; inventory record specifies the name of an item, a description,
; the acquisition price, and the recommended sales price

; Number [List-of IR] -> [List-of IR]
; produces a list of all those structures whose sales price is below ua
(check-expect (eliminate-expensive 35 '()) '())
(check-expect (eliminate-expensive
               35
               (list (make-IR "a" "aaa" 30 40)))
              '())
(check-expect (eliminate-expensive
               35
               (list (make-IR "a" "aaa" 30 40) (make-IR "b" "bbb" 5 23)))
              (list (make-IR "b" "bbb" 5 23)))
(check-expect (eliminate-expensive
               35
               (list (make-IR "a" "aaa" 30 40) (make-IR "b" "bbb" 5 23) (make-IR "c" "ccc" 40 51)))
              (list (make-IR "b" "bbb" 5 23)))
(check-expect (eliminate-expensive
               35
               (list (make-IR "a" "aaa" 30 40) (make-IR "b" "bbb" 5 23) (make-IR "c" "ccc" 40 51) (make-IR "d" "ddd" 25 35)))
              (list (make-IR "b" "bbb" 5 23)))
(define (eliminate-expensive ua loir)
  (local ((define (cheap-enough? ir)
            (< (IR-sales-price ir) ua)))
    (filter cheap-enough? loir)))

; String [List-of IR] -> [List-of IR]
; produces a list of inventory records that do not use the name ty
(check-expect (recall "b" '()) '())
(check-expect (recall
               "b"
               (list (make-IR "a" "aaa" 30 40)))
              (list (make-IR "a" "aaa" 30 40)))
(check-expect (recall
               "b"
               (list (make-IR "a" "aaa" 30 40) (make-IR "b" "bbb" 5 23)))
              (list (make-IR "a" "aaa" 30 40)))
(check-expect (recall
               "b"
               (list (make-IR "a" "aaa" 30 40) (make-IR "b" "bbb" 5 23) (make-IR "c" "ccc" 40 51)))
              (list (make-IR "a" "aaa" 30 40) (make-IR "c" "ccc" 40 51)))
(check-expect (recall
               "b"
               (list (make-IR "a" "aaa" 30 40) (make-IR "b" "bbb" 5 23) (make-IR "c" "ccc" 40 51) (make-IR "d" "ddd" 25 35)))
              (list (make-IR "a" "aaa" 30 40) (make-IR "c" "ccc" 40 51) (make-IR "d" "ddd" 25 35)))
(define (recall ty loir)
  (local ((define (not-same-name? ir)
            (not (string=? (IR-name ir) ty))))
    (filter not-same-name? loir)))

; [List-of String] [List-of String] -> [List-of String]
; consumes two lists of names and selects all those from the second one that are also on the first
(check-expect (selection '() '()) '())
(check-expect (selection '("a") '()) '())
(check-expect (selection '("a" "b") '()) '())
(check-expect (selection '("a" "b" "c") '()) '())
(check-expect (selection '("a") '("b")) '())
(check-expect (selection '("a" "b") '("b")) '("b"))
(check-expect (selection '("a" "b" "c") '("b")) '("b"))
(check-expect (selection '("a") '("a" "c" "d")) '("a"))
(check-expect (selection '("a" "b") '("a" "c" "d")) '("a"))
(check-expect (selection '("a" "b" "c") '("a" "c" "d")) '("a" "c"))
(define (selection los1 los2)
  (local (; String -> Boolean
          (define (is-in-los2? str)
            (member? str los2)))
    (filter is-in-los2? los1)))