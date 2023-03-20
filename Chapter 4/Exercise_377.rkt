;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_377) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
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
 
; XEnum.v2 -> XEnum.v2
; replaces all "hello"s with "bye" in an enumeration
(check-expect (replace-hello o0)
              '(ul
                (li (word ((text "bye"))))
                (li (word ((text "two"))))))
(check-expect (replace-hello o1)
              '(ul
                (li (word ((text "one"))))
                (li (ul
                     (li (word ((text "bye"))))
                     (li (word ((text "three"))))))))
(check-expect (replace-hello o2) o2)
(check-expect (replace-hello o3)
              '(ul
                (li (word ((text "bye"))))
                (li (ul
                     (li (word ((text "bye"))))
                     (li (word ((text "bye"))))))))
(check-expect (replace-hello '(ul ((name "List")))) '(ul ((name "List"))))
(define (replace-hello xe)
  (local ((define (add-item it rst) (cons (replace-hello/item it) rst))
          (define attrs (xexpr-attr xe)))
    (cond
      [(empty? attrs)
       (cons 'ul (foldr add-item '() (xexpr-content xe)))]
      [else
       (cons 'ul (cons (xexpr-attr xe) (foldr add-item '() (xexpr-content xe))))])))

; XItem.v2 -> XItem.v2
; replaces all "hello"s with "bye" in an item
(check-expect (replace-hello/item i0) i0)
(check-expect (replace-hello/item i1) '(li (word ((text "bye")))))
(check-expect (replace-hello/item i2)
              '(li (ul
                    (li (word ((text "bye"))))
                    (li (word ((text "three")))))))
(define (replace-hello/item it)
  (local ((define content (first (xexpr-content it))))
    (list 'li (cond
                 [(word? content) (if (equal? (word-text content) "hello")
                                      '(word ((text "bye")))
                                      content)]
                 [else (replace-hello content)]))))

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