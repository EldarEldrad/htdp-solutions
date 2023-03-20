;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_303) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
(lambda (x1 y)
  ;---------------
  (+ x1 (* x1 y)))
  ;---------------

(lambda (x2 y)
  ;--------------------
  (+ x2
     ;=========================== hole for x2
     (local ((define x2 (* y y)))
       (+ (* 3 x2)
          (/ 1 x2)))))
     ;===========================
  ;--------------------

(lambda (x3 y)
  ;--------------------
  (+ x3
     ;=========================== hole for x3
     ((lambda (x3)
        (+ (* 3 x3)
           (/ 1 x3)))
      (* y y))))
     ;===========================
  ;--------------------