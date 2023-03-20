;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_083) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-append s t) with 
; the cursor displayed between s and t

(define WIDTH 200)
(define HEIGHT 20)
(define MT (empty-scene WIDTH HEIGHT))
(define CURSOR (rectangle 1 HEIGHT "solid" "red"))
(define TEXT-SIZE 16)

; Editor -> Image
; consumes ed and produces the image of graphical editor
(check-expect (render (make-editor "" "hello world"))
              (overlay/align "left" "center"
                             (beside CURSOR
                                     (text "hello world" TEXT-SIZE "black"))
                             MT))
(check-expect (render (make-editor "hello world" ""))
              (overlay/align "left" "center"
                             (beside (text "hello world" TEXT-SIZE "black")
                                     CURSOR)
                             MT))
(check-expect (render (make-editor "hello " "world"))
              (overlay/align "left" "center"
                             (beside (text "hello " TEXT-SIZE "black")
                                     CURSOR
                                     (text "world" TEXT-SIZE "black"))
                             MT))
(define (render ed)
  (overlay/align "left" "center"
                 (beside (text (editor-pre ed) TEXT-SIZE "black")
                         CURSOR
                         (text (editor-post ed) TEXT-SIZE "black"))
                 MT))