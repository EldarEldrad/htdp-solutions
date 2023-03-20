;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_469) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; A TM is an [NEList-of Equation]
; such that the Equations are of decreasing length: 
;   n + 1, n, n - 1, ..., 2. 
; interpretation represents a triangular matrix

; An SOE is a non-empty Matrix.
; constraint for (list r1 ... rn), (length ri) is (+ n 1)
; interpretation represents a system of linear equations
 
; An Equation is a [List-of Number].
; constraint an Equation contains at least two numbers. 
; interpretation if (list a1 ... an b) is an Equation, 
; a1, ..., an are the left-hand-side variable coefficients 
; and b is the right-hand side
 
; A Solution is a [List-of Number]

(define M ; an SOE 
  (list (list 2 2  3 10) ; an Equation 
        (list 2 5 12 31)
        (list 4 1 -2  1)))

(define M-2
  (list (list 2 2  3 10)
        (list 3 9 21)
        (list 1 2)))

(define M-3
  (list (list 2 2  3 10)
        (list 3 9 21)
        (list -3 -8 -19)))
 
(define S '(1 1 2)) ; a Solution

; Equation -> [List-of Number]
; extracts the left-hand side from a row in a matrix
(check-expect (lhs (first M)) '(2 2 3))
(define (lhs e)
  (reverse (rest (reverse e))))
 
; Equation -> Number
; extracts the right-hand side from a row in a matrix
(check-expect (rhs (first M)) 10)
(define (rhs e)
  (first (reverse e)))

; SOE Solution -> Boolean
; result is #true if plugging in the numbers from the Solution for the variables
; in the Equations of the SOE produces equal left-hand-side values and right-hand-side values
; otherwise the function produces #false
(check-expect (check-solution M S) #true)
(check-expect (check-solution '((2 2 1 0)) S) #false)
(check-expect (check-solution M-2 S) #true)
(check-expect (check-solution M-3 S) #true)
(define (check-solution soe sol)
  (local ((define sol-reverse (reverse sol))
          (define (plug-in lon sol)
            (cond
              [(empty? lon) 0]
              [else (+ (* (first lon) (first sol))
                       (plug-in (rest lon) (rest sol)))])))
    (andmap (lambda (eq)
              (equal? (rhs eq) (plug-in (reverse (lhs eq)) sol-reverse)))
            soe)))

; TM -> Solution
; consumes triangular SOEs and produces a solution
(check-expect (solve '((1 2))) '(2))
(check-expect (solve M-2) S)
(check-expect (solve '((2  3  3   8)
                       (  -8 -4 -12)
                       (     -5  -5))) '(1 1 1))
(check-satisfied (solve M-2) (lambda (s) (check-solution M-2 S)))
(define (solve soe)
  (local ((define eq (first soe)))
    (cond
      [(and (empty? (rest soe))
            (equal? (length eq) 2))
       (list (/ (second eq) (first eq)))]
      [else (local ((define inner-solve (solve (rest soe))))
              (cons (/ (- (rhs eq) (foldr + 0 (map * (lhs (rest eq)) inner-solve)))
                       (first eq))
                    inner-solve))])))