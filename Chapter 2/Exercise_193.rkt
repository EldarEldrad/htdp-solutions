;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise_193) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
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
  (render-poly.v1 MT triangle-p)
  (scene+line
    (scene+line
      (scene+line MT 20 10 20 20 "red")
      20 20 30 20 "red")
    30 20 20 10 "red"))
(check-expect
  (render-poly.v1 MT square-p)
  (scene+line
    (scene+line
      (scene+line
        (scene+line MT 10 10 20 10 "red")
        20 10 20 20 "red")
      20 20 10 20 "red")
    10 20 10 10 "red"))
(define (render-poly.v1 img p)
  (render-line (connect-dots img p) (first p) (last p)))

; Image Polygon -> Image
; renders the given polygon p into img
(check-expect
  (render-poly.v2 MT triangle-p)
  (scene+line
    (scene+line
      (scene+line MT 20 10 20 20 "red")
      20 20 30 20 "red")
    30 20 20 10 "red"))
(check-expect
  (render-poly.v2 MT square-p)
  (scene+line
    (scene+line
      (scene+line
        (scene+line MT 10 10 20 10 "red")
        20 10 20 20 "red")
      20 20 10 20 "red")
    10 20 10 10 "red"))
(define (render-poly.v2 img p)
  (connect-dots img (cons (last p) p)))

; Image Polygon -> Image
; renders the given polygon p into img
(check-expect
  (render-poly.v3 MT triangle-p)
  (scene+line
    (scene+line
      (scene+line MT 20 10 20 20 "red")
      20 20 30 20 "red")
    30 20 20 10 "red"))
(check-expect
  (render-poly.v3 MT square-p)
  (scene+line
    (scene+line
      (scene+line
        (scene+line MT 10 10 20 10 "red")
        20 10 20 20 "red")
      20 20 10 20 "red")
    10 20 10 10 "red"))
(define (render-poly.v3 img p)
  (connect-dots img (add-at-end p (first p))))

; Polygon Posn -> Polygon
; adds given Posn at the end of the Polygon
(check-expect (add-at-end triangle-p (make-posn 10 10))
              (list (make-posn 20 10) (make-posn 20 20) (make-posn 30 20) (make-posn 10 10)))
(check-expect (add-at-end square-p (make-posn 20 30))
              (list (make-posn 10 10) (make-posn 20 10) (make-posn 20 20) (make-posn 10 20) (make-posn 20 30)))
(define (add-at-end pol p)
  (cond
    [(empty? (rest (rest (rest pol)))) (list (first pol) (second pol) (third pol) p)]
    [else (cons (first pol) (add-at-end (rest pol) p))]))

; Image Posn Posn -> Image 
; renders a line from p to q into img
(check-expect (render-line MT (make-posn 10 20) (make-posn 30 40))
              (scene+line MT 10 20 30 40 "red"))
(define (render-line img p q)
  (scene+line
    img
    (posn-x p) (posn-y p) (posn-x q) (posn-y q)
    "red"))

; Image NELoP -> Image 
; connects the dots in p by rendering lines in img
(check-expect (connect-dots MT triangle-p)
              (scene+line
               (scene+line MT 20 20 30 20 "red")
               20 10 20 20 "red"))
(check-expect
  (connect-dots MT square-p)
  (scene+line
    (scene+line
      (scene+line MT 20 20 10 20 "red")
      20 10 20 20 "red")
    10 10 20 10 "red"))
(define (connect-dots img p)
  (cond
    [(empty? (rest p)) img]
    [else
     (render-line
       (connect-dots img (rest p))
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