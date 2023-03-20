;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_386) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; An Xexpr.v3 is one of:
;  – Symbol
;  – String
;  – Number
;  – (cons Symbol (cons Attribute*.v3 [List-of Xexpr.v3]))
;  – (cons Symbol [List-of Xexpr.v3])
; 
; An Attribute*.v3 is a [List-of Attribute.v3].
;   
; An Attribute.v3 is a list of two items:
;   (list Symbol String)

; Xexpr.v3 String -> String
; retrieves the value of the "content" attribute 
; from a 'meta element that has attribute "itemprop"
; with value s
(check-expect
  (get '(meta ((content "+1") (itemprop "F"))) "F")
  "+1")
(check-expect
  (get '(meta ((content "+1") (itemprop "X"))) "X")
  "+1")
(check-error
  (get '(meta ((content "+1") (itemprop "X"))) "F")
  "not found")
(define (get x s)
  (local ((define result (get-xexpr x s)))
    (if (string? result)
        result
        (error "not found"))))

; Xexpr.v3 String -> [Maybe String]
; searches an arbitrary Xexpr.v3 for the desired attribute
(check-expect
  (get-xexpr '(meta ((content "+1") (itemprop "F"))) "F")
  "+1")
(check-expect
  (get-xexpr '(meta ((content "+1") (itemprop "X"))) "X")
  "+1")
(check-expect
  (get-xexpr '(meta ((content "+1") (itemprop "X"))) "F")
  #false)
(check-expect
  (get-xexpr 's "F")
  #false)
(check-expect
  (get-xexpr "hi" "F")
  #false)
(check-expect
  (get-xexpr 5 "F")
  #false)
(check-expect
  (get-xexpr '(meta ("META")) "F")
  #false)
(check-expect
  (get-xexpr '(meta ()) "F")
  #false)
(define (get-xexpr x s)
  (cond
    [(symbol? x) #false]
    [(string? x) #false]
    [(number? x) #false]
    [(cons? x)
     (local ((define loa (xexpr-attr x))
             (define attr-itemprop (find-attr loa 'itemprop))
             (define attr-content (find-attr loa 'content)))
       (if (equal? attr-itemprop s)
           attr-content
           #false))]))

(define (xexpr-attr xe)
  (local ((define optional-loa+content (rest xe)))
    (cond
      [(empty? optional-loa+content) '()]
      [else
       (local ((define loa-or-x
                 (first optional-loa+content)))
         (if (list-of-attributes? loa-or-x)
             loa-or-x
             '()))])))

(define (find-attr loa s)
  (local ((define value (assq s loa)))
    (if (cons? value) (second value) value)))

(define (list-of-attributes? x)
  (cond
    [(empty? x) #true]
    [else
     (local ((define possible-attribute (first x)))
       (cons? possible-attribute))]))