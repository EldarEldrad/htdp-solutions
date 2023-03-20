;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise_194) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
; A Polygon is one of:
; – (list Posn Posn Posn)
; – (cons Posn Polygon)

(define triangle-p
  (list
    (make-posn 20 10)
    (make-posn 20 20)
    (make-posn 30 20)))
	
(define square-p
  (list
    (make-posn 10 10)
    (make-posn 20 10)
    (make-posn 20 20)
    (make-posn 10 20)))

; An NELoP is one of: 
; – (cons Posn '())
; – (cons Posn NELoP)

; a plain background image 
(define MT (empty-scene 50 50))

; Image Polygon -> Image
; renders the given polygon p into img
(check-expect
  (render-poly MT triangle-p)
  (scene+line
    (scene+line
      (scene+line MT 20 10 20 20 "red")
      20 20 30 20 "red")
    30 20 20 10 "red"))
(check-expect
  (render-poly MT square-p)
  (scene+line
    (scene+line
      (scene+line
        (scene+line MT 10 10 20 10 "red")
        20 10 20 20 "red")
      20 20 10 20 "red")
    10 20 10 10 "red"))
(define (render-poly img p)
  (connect-dots img p (first p)))

; Image Posn Posn -> Image 
; renders a line from p to q into img
(check-expect (render-line MT (make-posn 10 20) (make-posn 30 40))
              (scene+line MT 10 20 30 40 "red"))
(define (render-line img p q)
  (scene+line
    img
    (posn-x p) (posn-y p) (posn-x q) (posn-y q)
    "red"))

; Image NELoP Posn -> Image 
; connects the dots in p by rendering lines in img, then connects last dot with given one
(check-expect (connect-dots MT triangle-p (make-posn 20 10))
              (scene+line
               (scene+line
                (scene+line MT 30 20 20 10 "red")
                20 20 30 20 "red")
               20 10 20 20 "red"))
(check-expect
  (connect-dots MT square-p (make-posn 10 10))
  (scene+line
    (scene+line
      (scene+line
       (scene+line MT 10 20 10 10 "red")
       20 20 10 20 "red")
      20 10 20 20 "red")
    10 10 20 10 "red"))
(define (connect-dots img p dot)
  (cond
    [(empty? (rest p)) (render-line img (first p) dot)]
    [else
     (render-line
       (connect-dots img (rest p) dot)
       (first p)
       (second p))]))

; Polygon -> Posn
; extracts the last item from p
(check-expect (last (list (make-posn 20 10) (make-posn 0 0) (make-posn 54 87) (make-posn 43 23)))
              (make-posn 43 23))
(check-expect (last (list (make-posn 20 10) (make-posn 0 0) (make-posn 54 87))) (make-posn 54 87))
(define (last p)
  (cond
    [(empty? (rest (rest (rest p)))) (third p)]
    [else (last (rest p))]))