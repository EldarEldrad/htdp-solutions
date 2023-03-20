;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_084) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-append s t) with 
; the cursor displayed between s and t

; Editor KeyEvent -> Editor
; produses new editor based on given ke
(check-expect (edit (make-editor "hello" "world") " ") (make-editor "hello " "world"))
(check-expect (edit (make-editor "" "hello world") " ") (make-editor " " "hello world"))
(check-expect (edit (make-editor "hello world" "") " ") (make-editor "hello world " ""))
(check-expect (edit (make-editor "hello" "world") "a") (make-editor "helloa" "world"))
(check-expect (edit (make-editor "" "hello world") "a") (make-editor "a" "hello world"))
(check-expect (edit (make-editor "hello world" "") "a") (make-editor "hello worlda" ""))
(check-expect (edit (make-editor "hello" "world") "\t") (make-editor "hello" "world"))
(check-expect (edit (make-editor "" "hello world") "\t") (make-editor "" "hello world"))
(check-expect (edit (make-editor "hello world" "") "\t") (make-editor "hello world" ""))
(check-expect (edit (make-editor "hello" "world") "\r") (make-editor "hello" "world"))
(check-expect (edit (make-editor "" "hello world") "\r") (make-editor "" "hello world"))
(check-expect (edit (make-editor "hello world" "") "\r") (make-editor "hello world" ""))
(check-expect (edit (make-editor "hello" "world") "\b") (make-editor "hell" "world"))
(check-expect (edit (make-editor "" "hello world") "\b") (make-editor "" "hello world"))
(check-expect (edit (make-editor "hello world" "") "\b") (make-editor "hello worl" ""))
(check-expect (edit (make-editor "hello" "world") "left") (make-editor "hell" "oworld"))
(check-expect (edit (make-editor "" "hello world") "left") (make-editor "" "hello world"))
(check-expect (edit (make-editor "hello world" "") "left") (make-editor "hello worl" "d"))
(check-expect (edit (make-editor "hello" "world") "right") (make-editor "hellow" "orld"))
(check-expect (edit (make-editor "" "hello world") "right") (make-editor "h" "ello world"))
(check-expect (edit (make-editor "hello world" "") "right") (make-editor "hello world" ""))
(define (edit ed ke)
  (cond
    [(or (string=? ke "\t") (string=? ke "\r")) ed]
    [(string=? ke "\b")
     (if (> (string-length (editor-pre ed)) 0)
         (make-editor (string-remove-last (editor-pre ed)) (editor-post ed))
         ed)]
    [(string=? ke "left")
     (if (> (string-length (editor-pre ed)) 0)
         (make-editor (string-remove-last (editor-pre ed))
                      (string-append (string-last (editor-pre ed)) (editor-post ed)))
         ed)]
    [(string=? ke "right")
     (if (> (string-length (editor-post ed)) 0)
         (make-editor (string-append (editor-pre ed) (string-first (editor-post ed)))
                      (string-rest (editor-post ed)))
         ed)]
    [else (make-editor (string-append (editor-pre ed) ke)
                       (editor-post ed))]))

; String -> 1String
; extracts the first character from non-empty str
; given: "hello", expected: "h"
; given: "_123", expected: "_"
; given: ",", expected: ","
(define (string-first str)
  (substring str 0 1))

; String -> 1String
; extracts the last character from non-empty str
; given: "hello", expected: "o"
; given: "_123", expected: "3"
; given: ",", expected: ","
(define (string-last str)
  (substring str (- (string-length str) 1)))

; String -> String
; produces a string like Str with the first character removed
; given: "hello", expected: "ello"
; given: "_123", expected: "123"
; given: ",", expected: ""
(define (string-rest str)
  (substring str 1))

; String -> String
; produces a string like Str with the last character removed
; given: "hello", expected: "hell"
; given: "_123", expected: "_12"
; given: ",", expected: ""
(define (string-remove-last str)
  (substring str 0 (- (string-length str) 1)))