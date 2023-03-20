;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_372) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; An Xexpr.v2 is (cons Symbol Body)

; An Body is one of:
; - '()
; - (cons Xexpr.v2 Body)
; - (cons [List-of Attribute] Body)

; An Attribute is a list of two items:
;   (cons Symbol (cons String '()))

; An XWord is '(word ((text String)))

(define word1 '(word ((text "Hello"))))
(define word2 '(word ((text "17"))))
(define word3 '(word ((text "This is a word"))))

(define ERROR "Not a word")

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

(define a0 '((initial "X")))
 
(define e0 '(machine))
(define e1 `(machine ,a0))
(define e2 '(machine (action)))
(define e3 '(machine () (action)))
(define e4 `(machine ,a0 (action) (action)))

; An XEnum.v1 is one of: 
; – (cons 'ul [List-of XItem.v1])
; – (cons 'ul (cons Attributes [List-of XItem.v1]))
; An XItem.v1 is one of:
; – (cons 'li (cons XWord '()))
; – (cons 'li (cons Attributes (cons XWord '())))

(define BT (circle 3 "solid" "black"))

(define i0
  '(li (word ((text "one")))))
(define i1
  '(li (word ((text "two")))))
(define i0-rendered
  (beside/align 'center BT (text "one" 12 'black)))
(define i1-rendered
  (beside/align 'center BT (text "two" 12 'black)))

; XItem.v1 -> Image 
; renders an item as a "word" prefixed by a bullet
(check-expect (render-item1 i0) i0-rendered)
(check-expect (render-item1 i1) i1-rendered)
(define (render-item1 i)
  (local ((define content (xexpr-content i))
          (define element (first content))
          (define a-word (word-text element))
          (define item (text a-word 12 'black)))
    (beside/align 'center BT item)))

; Xexpr.v2 -> [List-of Attribute]
; retrieves the name of xe
(check-expect (xexpr-name e0) 'machine)
(check-expect (xexpr-name e1) 'machine)
(check-expect (xexpr-name e2) 'machine)
(check-expect (xexpr-name e3) 'machine)
(check-expect (xexpr-name e4) 'machine)
(define (xexpr-name xe)
  (first xe))

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