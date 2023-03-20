;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_283) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct IR
  [name price])
; An IR is a structure:
;   (make-IR String Number)
; An Inventory is one of: 
; – '()
; – (cons IR Inventory)

(define th 15)

((lambda (ir) (<= (IR-price ir) th))
 (make-IR "bear" 10))
; -> (<= (IR-price (make-IR "bear" 10)) th)
; -> (<= 10 th)
; -> (<= 10 15)
; -> #true

(map (lambda (x) (* 10 x))
     '(1 2 3))
; -> ( ... (* 10 1) ... )
; -> ( ... 10 ... )
; -> ( ... (* 10 2) ... )
; -> ( ... 20 ... )
; -> ( ... (* 10 3) ... )
; -> ( ... 30 ... )
; -> '(10 20 30)

(foldl (lambda (name rst)
         (string-append name ", " rst))
       "etc."
       '("Matthew" "Robby"))
; -> ( ... (string-append "Matthew" ", " "etc.") ... )
; -> ( ... "Matthew, etc." ... )
; -> ( ... (string-append "Robby" ", " "Matthew, etc.") ...)
; -> ( ... "Robby, Matthew, etc." ...)
; -> "Robby, Matthew, etc."

(filter (lambda (ir) (<= (IR-price ir) th))
        (list (make-IR "bear" 10)
              (make-IR "doll" 33)))
; -> ( ... (<= (IR-price (make-IR "bear" 10)) th)  ... )
; -> ( ... (<= 10 th)  ... )
; -> ( ... (<= 10 15)  ... )
; -> ( ... #true  ... )
; -> ( ... (<= (IR-price (make-IR "doll" 33)) th)  ... )
; -> ( ... (<= 33 th)  ... )
; -> ( ... (<= 33 15)  ... )
; -> ( ... #false  ... )
; -> (list (make-IR "bear" 10))