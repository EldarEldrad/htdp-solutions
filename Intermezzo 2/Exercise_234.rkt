;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise_234) (read-case-sensitive #t) (teachpacks ((lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "web-io.rkt" "teachpack" "2htdp")) #f)))
(define one-list
  '("Asia: Heat of the Moment"
    "U2: One"
    "The White Stripes: Seven Nation Army"))

; A Row is an (list Number String)

; List-of-Strings -> List-of-Row
; create ranking based on given List-of-Strings
(define (ranking los)
  (reverse (add-ranks (reverse los))))

; List-of-Strings -> List-of-Row
; create ranks based on given List-of-Strings
(define (add-ranks los)
  (cond
    [(empty? los) '()]
    [else (cons (list (number->string (length los)) (first los))
                (add-ranks (rest los)))]))

; List-of-numbers -> ... nested list ...
; creates a row for an HTML table from l
(define (make-row l)
  (cond
    [(empty? l) '()]
    [else (cons (make-cell (first l))
                (make-row (rest l)))]))

; Number -> ... nested list ...
; creates a cell for an HTML table from a number 
(define (make-cell n)
  `(td ,n))

; List-of-Strings -> HTML-Page
; creates HTML page with rankings based on given List-of-Strings
(define (make-ranking l)
  `(html
    (head
     (title "Top 3 Songs from the 80s, 90s, 00s"))
   (body
     (table ((border "1"))
       ,@(create-table (ranking l))))))

; List-of-Row -> HTML-Page
; creates table of rankings based on given List-of-Row
(define (create-table r)
  (cond
    [(empty? r) '()]
    [else (cons `(tr ((width "200"))
                     ,@(make-row (first r)))
                (create-table (rest r)))]))

(show-in-browser (make-ranking one-list))