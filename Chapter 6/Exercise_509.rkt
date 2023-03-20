;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_509) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
(define FONT-SIZE 11)
(define FONT-COLOR "black")
 
; [List-of 1String] -> Image
; renders a string as an image for the editor 
(define (editor-text s)
  (text (implode s) FONT-SIZE FONT-COLOR))
 
(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor [List-of 1String] [List-of 1String])
; interpretation if (make-editor p s) is the state of 
; an interactive editor, (reverse p) corresponds to
; the text to the left of the cursor and s to the
; text on the right

; [List-of 1String] N -> Editor
; produces editor (make-editor p s) such that
; (1) p and s make up ed and
; (2) x is larger than the image of p
; and smaller than the image of p extended with the first 1String on s (if any)
(check-expect (split-structural (explode "") 5) (make-editor '() '()))
(check-expect (split-structural (explode "hi") 7) (make-editor '("h") '("i")))
(check-expect (split-structural (explode "hi") 500) (make-editor '("h" "i") '()))
(check-expect (split-structural (explode "hello world") 23) (make-editor (explode "hello") (explode " world")))
(define (split-structural ed x)
  (local ((define (split-structural/a pre post)
            (cond
              [(empty? post) (make-editor pre post)]
              [else
               (local ((define new-pre (append pre (list (first post))))
                       (define new-post (rest post)))
                 (cond
                   [(<= (image-width (editor-text pre))
                        x
                        (image-width (editor-text new-pre))) (make-editor pre post)]
                   [else (split-structural/a new-pre new-post)]))])))
    (split-structural/a '() ed)))