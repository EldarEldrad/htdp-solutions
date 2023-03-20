;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_507) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; [X Y] [X Y -> Y] Y [List-of X] -> Y
(define (f*ldl f e l0)
  (local (; Y [List-of X] -> Y
          ; accumulator a is running result after appliying f*ldl to part of the given list
          ; which is diffirence between l0 and l
          (define (fold/a a l)
            (cond
              [(empty? l) a]
              [else
               (fold/a (f (first l) a) (rest l))])))
    (fold/a e l0)))

; N [N -> X] -> [List-of X]
; build-list, developed using an accumulator-style approach
(check-expect (build-l*st 0 add1) (build-list 0 add1))
(check-expect (build-l*st 1 add1) (build-list 1 add1))
(check-expect (build-l*st 2 add1) (build-list 2 add1))
(check-expect (build-l*st 500 add1) (build-list 500 add1))
(check-expect (build-l*st 500 number->string) (build-list 500 number->string))
(define (build-l*st n f)
  (local (; N [List-of X] -> [List-of X]
          ; accumulator res is resulting list after applying numbers from cur+1 to n-1
          (define (build-l*st/a cur res)
            (cond
              [(< cur 0) res]
              [else (build-l*st/a (sub1 cur)
                                  (cons (f cur) res))])))
    (build-l*st/a (- n 1) '())))