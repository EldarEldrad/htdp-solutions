;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_087) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct editor [text pos])
; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is text and pos is the position of cusor starting with 0

(define WIDTH 200)
(define HEIGHT 20)
(define MT (empty-scene WIDTH HEIGHT))
(define CURSOR (rectangle 1 HEIGHT "solid" "red"))
(define TEXT-SIZE 16)

; Editor -> Image
; consumes ed and produces the image of graphical editor
(check-expect (render (make-editor "hello world" 0))
              (overlay/align "left" "center"
                             (beside CURSOR
                                     (text "hello world" TEXT-SIZE "black"))
                             MT))
(check-expect (render (make-editor "hello world" 11))
              (overlay/align "left" "center"
                             (beside (text "hello world" TEXT-SIZE "black")
                                     CURSOR)
                             MT))
(check-expect (render (make-editor "hello world" 6))
              (overlay/align "left" "center"
                             (beside (text "hello " TEXT-SIZE "black")
                                     CURSOR
                                     (text "world" TEXT-SIZE "black"))
                             MT))
(define (render ed)
  (overlay/align "left" "center"
                 (beside (text (substring (editor-text ed) 0 (editor-pos ed)) TEXT-SIZE "black")
                         CURSOR
                         (text (substring (editor-text ed) (editor-pos ed)) TEXT-SIZE "black"))
                 MT))

; Editor KeyEvent -> Editor
; produses new editor based on given ke
(check-expect (edit (make-editor "helloworld" 5) " ") (make-editor "hello world" 6))
(check-expect (edit (make-editor "hello world" 0) " ") (make-editor " hello world" 1))
(check-expect (edit (make-editor "hello world" 11) " ") (make-editor "hello world " 12))
(check-expect (edit (make-editor "helloworld" 5) "a") (make-editor "helloaworld" 6))
(check-expect (edit (make-editor "hello world" 0) "a") (make-editor "ahello world" 1))
(check-expect (edit (make-editor "hello world" 11) "a") (make-editor "hello worlda" 12))
(check-expect (edit (make-editor "helloworld" 5) "\t") (make-editor "helloworld" 5))
(check-expect (edit (make-editor "hello world" 0) "\t") (make-editor "hello world" 0))
(check-expect (edit (make-editor "hello world" 11) "\t") (make-editor "hello world" 11))
(check-expect (edit (make-editor "helloworld" 5) "\r") (make-editor "helloworld" 5))
(check-expect (edit (make-editor "hello world" 0) "\r") (make-editor "hello world" 0))
(check-expect (edit (make-editor "hello world" 11) "\r") (make-editor "hello world" 11))
(check-expect (edit (make-editor "helloworld" 5) "\b") (make-editor "hellworld" 4))
(check-expect (edit (make-editor "hello world" 0) "\b") (make-editor "hello world" 0))
(check-expect (edit (make-editor "hello world" 11) "\b") (make-editor "hello worl" 10))
(check-expect (edit (make-editor "helloworld" 5) "left") (make-editor "helloworld" 4))
(check-expect (edit (make-editor "hello world" 0) "left") (make-editor "hello world" 0))
(check-expect (edit (make-editor "hello world" 11) "left") (make-editor "hello world" 10))
(check-expect (edit (make-editor "helloworld" 5) "right") (make-editor "helloworld" 6))
(check-expect (edit (make-editor "hello world" 0) "right") (make-editor "hello world" 1))
(check-expect (edit (make-editor "hello world" 11) "right") (make-editor "hello world" 11))
(define (edit ed ke)
  (cond
    [(or (string=? ke "\t") (string=? ke "\r")) ed]
    [(string=? ke "\b")
     (if (> (editor-pos ed) 0)
         (make-editor (string-append (substring (editor-text ed) 0 (- (editor-pos ed) 1))
                                     (substring (editor-text ed) (editor-pos ed)))
                      (- (editor-pos ed) 1))
         ed)]
    [(string=? ke "left")
     (if (> (editor-pos ed) 0)
         (make-editor (editor-text ed)
                      (- (editor-pos ed) 1))
         ed)]
    [(string=? ke "right")
     (if (> (string-length (editor-text ed)) (editor-pos ed))
         (make-editor (editor-text ed)
                      (+ (editor-pos ed) 1))
         ed)]
    [(too-wide-text? ed ke) ed]
    [else (make-editor (string-append (substring (editor-text ed) 0 (editor-pos ed))
                                      ke
                                      (substring (editor-text ed) (editor-pos ed)))
                       (+ (editor-pos ed) 1))]))

; Editor KeyEvent -> Boolean
; returns #true if text too wide too add in editor
(check-expect (too-wide-text? (make-editor "hello world" 6) " ") #false)
(check-expect (too-wide-text? (make-editor "hello world" 0) " ") #false)
(check-expect (too-wide-text? (make-editor "hello world" 11) " ") #false)
(check-expect (too-wide-text? (make-editor "hellosadfjskdfjkfjksdfjdskfjdskfdfdfkjworlddsfasfsfdsfdfdfdf" 0)
                              " ")
              #true)
(check-expect (too-wide-text? (make-editor "hellosadfjskdfjkfjksdfjdskfjdskfdfdfkjworlddsfasfsfdsfdfdfdf" 60)
                              " ")
              #true)
(check-expect (too-wide-text? (make-editor "hellosadfjskdfjkfjksdfjdskfjdskfdfdfkjworlddsfasfsfdsfdfdfdf" 25)
                              " ")
              #true)
(define (too-wide-text? ed ke)
  (>= (image-width (text (string-append ke (editor-text ed))
                         TEXT-SIZE "black"))
      WIDTH))

; String -> Editor
(define (run text)
  (big-bang (make-editor text (string-length text))
    [on-key edit]
    [to-draw render]))

(run "")