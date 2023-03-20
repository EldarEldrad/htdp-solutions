;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_376) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; An XItem.v2 is one of: 
; – (cons 'li (cons XWord '()))
; – (cons 'li (cons [List-of Attribute] (cons XWord '())))
; – (cons 'li (cons XEnum.v2 '()))
; – (cons 'li (cons [List-of Attribute] (cons XEnum.v2 '())))
; 
; An XEnum.v2 is one of:
; – (cons 'ul [List-of XItem.v2])
; – (cons 'ul (cons [List-of Attribute] [List-of XItem.v2]))

(define word1 '(word ((text "Hello"))))
(define word2 '(word ((text "17"))))
(define word3 '(word ((text "This is a word"))))

(define ERROR "Not a word")

(define a0 '((initial "X")))
 
(define e0 '(machine))
(define e1 `(machine ,a0))
(define e2 '(machine (action)))
(define e3 '(machine () (action)))
(define e4 `(machine ,a0 (action) (action)))

(define i0
  '(li (word ((text "one")))))
(define i1
  '(li (word ((text "hello")))))
(define i2
  '(li (ul
         (li (word ((text "hello"))))
         (li (word ((text "three")))))))

(define o0
  '(ul
    (li (word ((text "hello"))))
    (li (word ((text "two"))))))
(define o1
  '(ul
    (li (word ((text "one"))))
    (li (ul
         (li (word ((text "hello"))))
         (li (word ((text "three"))))))))
(define o2
  '(ul
    (li (word ((text "one"))))
    (li (ul
         (li (word ((text "two"))))
         (li (word ((text "three"))))))))
(define o3
  '(ul
    (li (word ((text "hello"))))
    (li (ul
         (li (word ((text "hello"))))
         (li (word ((text "hello"))))))))
 
; XEnum.v2 -> Number
; counts all "hello"s in an instance of XEnum.v2
(check-expect (count-hello o0) 1)
(check-expect (count-hello o1) 1)
(check-expect (count-hello o2) 0)
(check-expect (count-hello o3) 3)
(check-expect (count-hello '(ul ((name "List")))) 0)
(define (count-hello xe)
  (local ((define (add-count it rst) (+ rst (count-hello/item it))))
    (foldr add-count 0 (xexpr-content xe))))

; XItem.v2 -> Number
; counts all "hello"s in an instance of XItem.v2
(check-expect (count-hello/item i0) 0)
(check-expect (count-hello/item i1) 1)
(check-expect (count-hello/item i2) 1)
(define (count-hello/item it)
  (local ((define content (first (xexpr-content it))))
    (cond
      [(word? content) (if (equal? (word-text content) "hello")
                           1 0)]
      [else (count-hello content)])))

; Xexpr.v2 -> Body
; retrieves the content of xe
(check-expect (xexpr-content e0) '())
(check-expect (xexpr-content e1) '())
(check-expect (xexpr-content e2) '((action)))
(check-expect (xexpr-content e3) '((action)))
(check-expect (xexpr-content e4) '((action) (action)))
(define (xexpr-content xe)
  (local ((define optional-loa+content (rest xe)))
    (cond
      [(empty? optional-loa+content) '()]
      [else
       (if (list-of-attributes? (first optional-loa+content))
           (rest optional-loa+content)
           optional-loa+content)])))

; [List-of Attribute] or Xexpr.v2 -> Boolean
; is x a list of attributes
(define (list-of-attributes? x)
  (cond
    [(empty? x) #true]
    [else
     (local ((define possible-attribute (first x)))
       (cons? possible-attribute))]))

; Any -> Boolean
; checks whether some ISL+ value is in XWord
(check-expect (word? word1) #true)
(check-expect (word? word2) #true)
(check-expect (word? word3) #true)
(check-expect (word? 0) #false)
(check-expect (word? "Hello") #false)
(check-expect (word? #true) #false)
(check-expect (word? (make-posn 4 5)) #false)
(check-expect (word? '(word ((txt "Hi")))) #false)
(check-expect (word? '(word ((text 32)))) #false)
(define (word? x)
  (match x
    [(list 'word (list (list 'text (? string?)))) #true]
    [y #false]))

; XWord -> String
; checks whether some ISL+ value is in XWord
(check-expect (word-text word1) "Hello")
(check-expect (word-text word2) "17")
(check-expect (word-text word3) "This is a word")
(check-error (word-text 0) ERROR)
(check-error (word-text "Hello") ERROR)
(check-error (word-text #true) ERROR)
(check-error (word-text (make-posn 4 5)) ERROR)
(check-error (word-text '(word ((txt "Hi")))) ERROR)
(define (word-text x)
  (match x
    [(list 'word (list (list 'text t))) t]
    [y (error ERROR)]))