;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_362) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
(define-struct func [name param body])
; A BSL-fun-def is a structure:
;   (make-func Symbol Symbol BSL-fun-expr)

; An Association is a list of two items:
;   (cons Symbol (cons Number '())).

; BSL-da-all is one of:
; - '()
; - (cons Association BSL-da-all)
; - (cons BSL-fun-def BSL-da-all)

(define-struct add [left right])
(define-struct mul [left right])

; (define (f x) (+ 3 x))
(define f (make-func 'f 'x (make-add 3 'x)))

; (define (g y) (f (* 2 y)))
(define g (make-func 'g 'y `(f ,(make-mul 2 'y))))

; (define (h v) (+ (f v) (g v)))
(define h (make-func 'h 'v (make-add '(f v) '(g v))))

(define da-ex `((k 0) ,f (x 4) ,g (y 7) ,h (z 10)))

(define da-ex/np '((k 0)
                   (f x (+ 3 x))
                   (x 4)
                   (g y (f (* 2 y)))
                   (y 7)
                   (h v (+ (f v) (g v)))
                   (z 10)))

(define ERROR "Can't evaluate given expression")

(define ERROR-CON "No such constant definition exists")
(define ERROR-FUN "No such function exists")

; A BSL-fun-expr is one of: 
; – Number
; – Symbol 
; – (make-add BSL-fun-expr BSL-fun-expr)
; – (make-mul BSL-fun-expr BSL-fun-expr)
; - (Symbol BSL-fun-expr)

; BSL-da-all Symbol -> Association
; produces the representation of a constant definition whose name is x, if such a piece of data exists in da
; otherwise the function signals an error saying that no such constant definition can be found.
(check-error (lookup-con-def '((k 0) (x 4) (y 7) (z 10)) 'close-to-pi) ERROR-CON)
(check-expect (lookup-con-def '((k 0) (x 4) (y 7) (z 10)) 'y) '(y 7))
(check-expect (lookup-con-def '((k 0) (x 4) (y 7) (z 10)) 'z) '(z 10))
(check-expect (lookup-con-def '((k 0) (x 4) (y 7) (z 10)) 'k) '(k 0))
(define (lookup-con-def da x)
  (cond
    [(empty? da) (error ERROR-CON)]
    [(func? (first da)) (lookup-con-def (rest da) x)]
    [(list? (first da))
     (if (equal? x (first (first da)))
         (first da)
         (lookup-con-def (rest da) x))]))

; BSL-da-all Symbol -> BSL-fun-def
; produces the representation of a function definition whose name is f, if such a piece of data exists in da
; otherwise the function signals an error saying that no such function definition can be found
(check-error (lookup-fun-def da-ex 'close-to-pi) ERROR-FUN)
(check-error (lookup-fun-def da-ex 'x) ERROR-FUN)
(check-expect (lookup-fun-def da-ex 'g) g)
(check-expect (lookup-fun-def da-ex 'h) h)
(check-error (lookup-fun-def '() 'close-to-pi) ERROR-FUN)
(define (lookup-fun-def da f)
  (cond
    [(empty? da) (error ERROR-FUN)]
    [(list? (first da)) (lookup-fun-def (rest da) f)]
    [(func? (first da))
     (if (equal? f (func-name (first da)))
         (first da)
         (lookup-fun-def (rest da) f))]))

; BSL-fun-expr Symbol Number -> BSL-fun-expr
; produces a BSL-fun-expr like ex with all occurrences of x replaced by v
(check-expect (subst 2 'x 5) 2)
(check-expect (subst 'x 'x 5) 5)
(check-expect (subst 'x 'y 5) 'x)
(check-expect (subst (make-add 'x 3) 'x 5) (make-add 5 3))
(check-expect (subst (make-add (make-mul 'x 'x) (make-mul 'y 'y)) 'y 4)
              (make-add (make-mul 'x 'x) (make-mul 4 4)))
(check-expect (subst '(f x) 'x 5) '(f 5))
(check-expect (subst `(f ,(make-add 'x 3)) 'x 5) `(f ,(make-add 5 3)))
(define (subst ex x v)
  (cond
    [(number? ex) ex]
    [(symbol? ex) (if (symbol=? ex x) v ex)]
    [(add? ex) (make-add (subst (add-left ex) x v)
                         (subst (add-right ex) x v))]
    [(mul? ex) (make-mul (subst (mul-left ex) x v)
                         (subst (mul-right ex) x v))]
    [(list? ex)
     (list (first ex) (subst (second ex) x v))]))

; BSL-fun-expr BSL-da-all -> Number
; determines value of ex regarding given definition area da
(check-expect (eval-all 3 da-ex) 3)
(check-expect (eval-all (make-add 1 1) da-ex) 2)
(check-expect (eval-all (make-mul 3 10) da-ex) 30)
(check-expect (eval-all (make-add (make-mul 1 1) 10) da-ex) 11)
(check-expect (eval-all 'x da-ex) 4)
(check-error (eval-all 'r da-ex) ERROR-CON)
(check-error (eval-all (make-posn 3 4) da-ex) ERROR)
(check-expect (eval-all (make-add 'k 3) da-ex) 3)
(check-expect (eval-all (make-add (make-mul 'x 'x) (make-mul 'y 'y)) da-ex) 65)
(check-expect (eval-all (make-add (make-mul 'z 'z) (make-mul 'k 'k)) da-ex) 100)
(check-expect (eval-all '(f 4) da-ex) 7)
(check-expect (eval-all '(g 3) da-ex) 9)
(check-expect (eval-all '(h 2) da-ex) 12)
(check-expect (eval-all '(f z) da-ex) 13)
(check-error (eval-all '(i 2) da-ex) ERROR-FUN)
(check-error (eval-all '(f 2) '()) ERROR-FUN)
(define (eval-all ex da)
  (cond
    [(number? ex) ex]
    [(symbol? ex) (second (lookup-con-def da ex))]
    [(add? ex) (+ (eval-all (add-left ex) da)
                  (eval-all (add-right ex) da))]
    [(mul? ex) (* (eval-all (mul-left ex) da)
                  (eval-all (mul-right ex) da))]
    [(list? ex)
     (local ((define f-def (lookup-fun-def da (first ex)))
             (define value (eval-all (second ex) da))
             (define plugd (subst (func-body f-def) (func-param f-def) value)))
       (eval-all plugd da))]
    [else (error ERROR)]))

; S-expr -> BSL-expr
(define (parse s)
  (cond
    [(atom? s) s]
    [else (parse-sl s)]))

; SL -> BSL-da-all
(check-expect (parse-lod da-ex/np) da-ex)
(define (parse-lod s)
  (map parse-def s))

; SL -> [Association or BSL-fun-def]
(check-expect (parse-def '(k 0)) '(k 0))
(check-expect (parse-def '(f x (+ 3 x))) f)
(check-expect (parse-def '(x 4)) '(x 4))
(check-expect (parse-def '(g y (f (* 2 y)))) g)
(check-expect (parse-def '(y 7)) '(y 7))
(check-expect (parse-def '(h v (+ (f v) (g v)))) h)
(check-expect (parse-def '(z 10)) '(z 10))
(check-error (parse-def '(5 + 10)) ERROR)
(define (parse-def s)
  (cond
    [(and (consists-of-2 s) (symbol? (first s)))
     (list (first s) (parse (second s)))]
    [(and (consists-of-3 s) (symbol? (first s)))
     (make-func (first s) (second s) (parse (third s)))]
    [else (error ERROR)]))
 
; SL -> BSL-expr
(define (parse-sl s)
  (cond
    [(and (consists-of-2 s) (symbol? (first s)))
     (list (first s) (parse (second s)))]
    [(and (consists-of-3 s) (symbol? (first s)))
     (cond
       [(symbol=? (first s) '+)
        (make-add (parse (second s)) (parse (third s)))]
       [(symbol=? (first s) '*)
        (make-mul (parse (second s)) (parse (third s)))]
       [else (error ERROR)])]
    [else (error ERROR)]))
 
; SL -> Boolean
(define (consists-of-3 s)
  (and (cons? s) (cons? (rest s)) (cons? (rest (rest s)))
       (empty? (rest (rest (rest s))))))

; SL -> Boolean
(define (consists-of-2 s)
  (and (cons? s) (cons? (rest s))
       (empty? (rest (rest s)))))

; Any -> Boolean
; returns #true if given argument is Atom
(check-expect (atom? #true) #false)
(check-expect (atom? '()) #false)
(check-expect (atom? 5) #true)
(check-expect (atom? "ab") #true)
(check-expect (atom? 'r) #true)
(check-expect (atom? (make-posn 4 5)) #false)
(check-expect (atom? (cons 3 '())) #false)
(define (atom? x)
  (or (number? x)
      (string? x)
      (symbol? x)))

; S-expr SL -> Number
; parses both with the appropriate parsing functions and then uses eval-all to evaluate the expression
(check-expect (interpreter 3 da-ex/np) 3)
(check-expect (interpreter '(+ 1 1) da-ex/np) 2)
(check-expect (interpreter '(* 3 10) da-ex/np) 30)
(check-expect (interpreter '(+ (* 1 1) 10) da-ex/np) 11)
(check-expect (interpreter 'x da-ex/np) 4)
(check-error (interpreter 'r da-ex/np) ERROR-CON)
(check-error (interpreter (make-posn 3 4) da-ex/np) ERROR)
(check-expect (interpreter '(+ k 3) da-ex/np) 3)
(check-expect (interpreter '(+ (* x x) (* y y)) da-ex/np) 65)
(check-expect (interpreter '(+ (* z z) (* k k)) da-ex/np) 100)
(check-expect (interpreter '(f 4) da-ex/np) 7)
(check-expect (interpreter '(g 3) da-ex/np) 9)
(check-expect (interpreter '(h 2) da-ex/np) 12)
(check-expect (interpreter '(f z) da-ex/np) 13)
(check-error (interpreter '(i 2) da-ex/np) ERROR-FUN)
(check-error (interpreter '(f 2) '()) ERROR-FUN)
(check-error (interpreter '(/ 5 2) '()) ERROR)
(define (interpreter s-expr sl)
  (eval-all (parse s-expr) (parse-lod sl)))