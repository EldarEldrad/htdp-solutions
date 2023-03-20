;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_320) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
; An S-expr.v2 is one of: 
; – Number
; – String
; – Symbol
; – SL
 
; An SL.v2 is [List-of S-expr.v2]

; S-expr.v2 Symbol -> N 
; counts all occurrences of sy in sexp
(check-expect (count.v2 'world 'hello) 0)
(check-expect (count.v2 '(world hello) 'hello) 1)
(check-expect (count.v2 '(((world) hello) hello) 'hello) 2)
(check-expect (count.v2 '(((5 world) hello) "abc" hello) 'hello) 2)
(define (count.v2 sexp sy)
  (local (; SL.v2 -> N
          ; counts all occurrences of sy in sl
          (define (count-sl sl)
            (foldr (lambda (s rst) (+ (count.v2 s sy) rst))
                   0
                   sl)))
    (cond
      [(number? sexp) 0]
      [(string? sexp) 0]
      [(symbol? sexp) (if (symbol=? sexp sy) 1 0)]
      [else (count-sl sexp)])))

; An S-expr.v3 is one of: 
; – Number
; – String
; – Symbol
; – [List-of S-expr.v3]

; S-expr.v3 Symbol -> N 
; counts all occurrences of sy in sexp
(check-expect (count.v3 'world 'hello) 0)
(check-expect (count.v3 '(world hello) 'hello) 1)
(check-expect (count.v3 '(((world) hello) hello) 'hello) 2)
(check-expect (count.v3 '(((5 world) hello) "abc" hello) 'hello) 2)
(define (count.v3 sexp sy)
  (cond
    [(number? sexp) 0]
    [(string? sexp) 0]
    [(symbol? sexp) (if (symbol=? sexp sy) 1 0)]
    [else
     (foldr (lambda (s rst) (+ (count.v3 s sy) rst))
            0
            sexp)]))