;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_179) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define HEIGHT 20) ; the height of the editor 
(define WIDTH 200) ; its width 
(define FONT-SIZE 16) ; the font size 
(define FONT-COLOR "black") ; the font color 
 
(define MT (empty-scene WIDTH HEIGHT))
(define CURSOR (rectangle 1 HEIGHT "solid" "red"))

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

; Editor -> Image
; renders an editor as an image of the two texts
; separated by the cursor 
(define (editor-render e) MT)

; Lo1s -> Image
; renders a list of 1Strings as a text image
(check-expect
  (editor-text
   (cons "p" (cons "o" (cons "s" (cons "t" '())))))
  (text "post" FONT-SIZE FONT-COLOR))
(check-expect
  (editor-text
   (cons "e" (cons "r" (cons "p" '()))))
  (text "erp" FONT-SIZE FONT-COLOR))
(define (editor-text s)
  (text (implode s) FONT-SIZE FONT-COLOR))
 
; Editor KeyEvent -> Editor
; deals with a key event, given some editor
(check-expect (editor-kh (create-editor "" "") "e")
              (create-editor "e" ""))
(check-expect
  (editor-kh (create-editor "cd" "fgh") "e")
  (create-editor "cde" "fgh"))
(check-expect (editor-kh (create-editor "" "") "\b")
              (create-editor "" ""))
(check-expect
  (editor-kh (create-editor "cd" "fgh") "\b")
  (create-editor "c" "fgh"))
(check-expect (editor-kh (create-editor "" "") "left")
              (create-editor "" ""))
(check-expect
  (editor-kh (create-editor "cd" "fgh") "left")
  (create-editor "c" "dfgh"))
(check-expect
  (editor-kh (create-editor "" "fgh") "left")
  (create-editor "" "fgh"))
(check-expect (editor-kh (create-editor "" "") "right")
              (create-editor "" ""))
(check-expect
  (editor-kh (create-editor "cd" "fgh") "right")
  (create-editor "cdf" "gh"))
(check-expect
  (editor-kh (create-editor "cd" "") "right")
  (create-editor "cd" ""))
(check-expect (editor-kh (create-editor "" "") "\t")
              (create-editor "" ""))
(check-expect
  (editor-kh (create-editor "cd" "fgh") "\r")
  (create-editor "cd" "fgh"))
(define (editor-kh ed k)
  (cond
    [(key=? k "left") (editor-lft ed)]
    [(key=? k "right") (editor-rgt ed)]
    [(key=? k "\b") (editor-del ed)]
    [(key=? k "\t") ed]
    [(key=? k "\r") ed]
    [(= (string-length k) 1) (editor-ins ed k)]
    [else ed]))

; Editor -> Editor
; moves the cursor position one 1String left, 
; if possible
(check-expect (editor-lft (make-editor '() '())) (make-editor '() '()))
(check-expect (editor-lft (make-editor '() (cons "b" '()))) (make-editor '() (cons "b" '())))
(check-expect (editor-lft (make-editor (cons "b" '()) '())) (make-editor '() (cons "b" '())))
(check-expect (editor-lft (make-editor (cons "a" '()) (cons "b" '())))
              (make-editor '() (cons "a" (cons "b" '()))))
(check-expect (editor-lft (make-editor (cons "c" (cons "a" '())) (cons "b" '())))
              (make-editor (cons "a" '()) (cons "c" (cons "b" '()))))
(define (editor-lft ed)
  (if (empty? (editor-pre ed))
      ed
      (make-editor (rest (editor-pre ed)) (cons (first (editor-pre ed)) (editor-post ed)))))
 
; Editor -> Editor
; moves the cursor position one 1String right, 
; if possible
(check-expect (editor-rgt (make-editor '() '())) (make-editor '() '()))
(check-expect (editor-rgt (make-editor '() (cons "b" '()))) (make-editor (cons "b" '()) '()))
(check-expect (editor-rgt (make-editor (cons "b" '()) '())) (make-editor (cons "b" '()) '()))
(check-expect (editor-rgt (make-editor (cons "a" '()) (cons "b" '())))
              (make-editor (cons "b" (cons "a" '())) '()))
(check-expect (editor-rgt (make-editor (cons "a" '()) (cons "b" (cons "c" '()))))
              (make-editor (cons "b" (cons "a" '())) (cons "c" '())))
(define (editor-rgt ed)
  (if (empty? (editor-post ed))
      ed
      (make-editor (cons (first (editor-post ed)) (editor-pre ed)) (rest (editor-post ed)))))
 
; Editor -> Editor
; deletes a 1String to the left of the cursor,
; if possible
(check-expect (editor-del (make-editor '() '())) (make-editor '() '()))
(check-expect (editor-del (make-editor '() (cons "b" '()))) (make-editor '() (cons "b" '())))
(check-expect (editor-del (make-editor (cons "b" '()) '())) (make-editor '() '()))
(check-expect (editor-del (make-editor (cons "a" '()) (cons "b" '())))
              (make-editor '() (cons "b" '())))
(check-expect (editor-del (make-editor (cons "c" (cons "a" '())) (cons "b" '())))
              (make-editor (cons "a" '()) (cons "b" '())))
(define (editor-del ed)
  (if (empty? (editor-pre ed))
              ed
              (make-editor (rest (editor-pre ed)) (editor-post ed))))

; Editor 1String -> Editor
; insert the 1String k between pre and post
(check-expect
  (editor-ins (make-editor '() '()) "e")
  (make-editor (cons "e" '()) '())) 
(check-expect
  (editor-ins
    (make-editor (cons "d" '())
                 (cons "f" (cons "g" '())))
    "e")
  (make-editor (cons "e" (cons "d" '()))
               (cons "f" (cons "g" '()))))
(define (editor-ins ed k)
  (make-editor (cons k (editor-pre ed))
               (editor-post ed)))

; main : String -> Editor
; launches the editor given some initial string 
(define (main s)
   (big-bang (create-editor s "")
     [on-key editor-kh]
     [to-draw editor-render]))