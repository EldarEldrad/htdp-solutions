;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_470) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
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

(define M-1
  (list (list 2 2  3 10)
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

(define S '(1 1 2))

(define ERROR "No solutions")

; Equation -> [List-of Number]
; extracts the left-hand side from a row in a matrix
(check-expect (lhs (first M-1)) '(2 2 3))
(define (lhs e)
  (reverse (rest (reverse e))))
 
; Equation -> Number
; extracts the right-hand side from a row in a matrix
(check-expect (rhs (first M-1)) 10)
(define (rhs e)
  (first (reverse e)))

; Equation Equation -> Equation
; consumes two Equations of equal length.
; It “subtracts” a multiple of the second equation from the first, item by item,
; so that the resulting Equation has a 0 in the first position.
; Since the leading coefficient is known to be 0,
; subtract returns the rest of the list that results from the subtractions.
(check-expect (subtract '(2 5 12 31) '(2 2 3 10)) '(3 9 21))
(check-expect (subtract '(4 1 -2 1) '(2 2 3 10)) '(-3 -8 -19))
(check-expect (subtract '(-3 -8 -19) '(3 9 21)) '(1 2))
(define (subtract eq1 eq2)
  (local ((define coeff (/ (first eq1) (first eq2))))
    (map (lambda (e1 e2) (- e1 (* coeff e2))) (rest eq1) (rest eq2))))

; SOE -> TM
; triangulates the given system of equations
(check-expect (triangulate '(())) '(()))
(check-expect (triangulate '((1 2))) '((1 2)))
(check-expect (triangulate M-1) M-2)
(check-expect (triangulate
               '((2  3  3 8)
                 (2  3 -2 3)
                 (4 -2  2 4)))
              '((2  3  3   8)
                (  -8 -4 -12)
                (     -5  -5)))
(check-error (triangulate '((2 2 2 6)
                            (2 2 4 8)
                            (2 2 1 2)))
             ERROR)
(define (triangulate M)
  (local ((define (triangulate-inner eq loe)
            (map (lambda (e) (subtract e eq)) loe)))
    (cond
      [(or (empty? M) (empty? (rest M))) M]
      [(equal? (first (first M)) 0)
       (if (andmap (lambda (eq) (equal? (first eq) 0)) (rest M))
           (error ERROR)
           (triangulate (append (rest M) (list (first M)))))]
      [else (cons (first M)
                  (triangulate (triangulate-inner (first M) (rest M))))])))

; TM -> Solution
; consumes triangular SOEs and produces a solution
(check-expect (solve '((1 2))) '(2))
(check-expect (solve M-2) S)
(check-expect (solve '((2  3  3   8)
                       (  -8 -4 -12)
                       (     -5  -5))) '(1 1 1))
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

; SOE -> Solution
; solves given SOE
(check-expect (gauss M-1) S)
(check-error (gauss '((2 2 2 6)
                      (2 2 4 8)
                      (2 2 1 2)))
             ERROR)
(define (gauss soe)
  (solve (triangulate soe)))