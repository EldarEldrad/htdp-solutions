;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_177) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor Lo1S Lo1S) 
; An Lo1S is one of: 
; – '()
; – (cons 1String Lo1S)

; Lo1s -> Lo1s 
; produces a reverse version of the given list
(check-expect (rev '()) '())
(check-expect (rev (cons "c" '())) (rev (cons "c" '())))
(check-expect
  (rev (cons "a" (cons "b" (cons "b" '()))))
  (cons "b" (cons "b" (cons "a" '()))))
(check-expect
  (rev (cons "a" (cons "b" (cons "c" '()))))
  (cons "c" (cons "b" (cons "a" '()))))
(define (rev l)
  (cond
    [(empty? l) '()]
    [else (add-at-end (rev (rest l)) (first l))]))

; Lo1s 1String -> Lo1s
; creates a new list by adding s to the end of l
(check-expect (add-at-end '() "a") (cons "a" '()))
(check-expect (add-at-end (cons "b" '()) "a") (cons "b" (cons "a" '())))
(check-expect
  (add-at-end (cons "c" (cons "b" '())) "a")
  (cons "c" (cons "b" (cons "a" '()))))
(define (add-at-end l s)
  (cond
    [(empty? l) (cons s l)]
    [else (cons (first l) (add-at-end (rest l) s))]))

; String String -> Editor
; produces the editor: first string is the text to the left of the cursor
; and the second string is the text to the right of the cursor
(check-expect (create-editor "" "") (make-editor '() '()))
(check-expect (create-editor "" "def") (make-editor '() (cons "d" (cons "e" (cons "f" '())))))
(check-expect (create-editor "abc" "") (make-editor (cons "c" (cons "b" (cons "a" '()))) '()))
(check-expect (create-editor "abc" "def")
              (make-editor (cons "c" (cons "b" (cons "a" '())))
                           (cons "d" (cons "e" (cons "f" '())))))
(define (create-editor str1 str2)
  (make-editor (rev (explode str1)) (explode str2)))