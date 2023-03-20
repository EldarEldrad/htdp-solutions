;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise_231) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
'(1 "a" 2 #false 3 "c")
; -> (list '1 '"a" '2 '#false '3 '"c")
; -> (list 1 "a" 2 #false 3 "c")
; -> (cons 1 (cons "a" (cons 2 (cons #false (cons 3 (cons "c" '()))))))

'()
; -> '()

'(("alan" 1000)
  ("barb" 2000)
  ("carl" 1500))
; -> (list '("alan" 1000) '("barb" 2000) '("carl" 1500))
; -> (list (list '"alan" '1000) '("barb" 2000) '("carl" 1500))
; -> (list (list "alan" 1000) '("barb" 2000) '("carl" 1500))
; -> (list (list "alan" 1000) (list '"barb" '2000) '("carl" 1500))
; -> (list (list "alan" 1000) (list "barb" 2000) '("carl" 1500))
; -> (list (list "alan" 1000) (list "barb" 2000) (list '"carl" '1500))
; -> (list (list "alan" 1000) (list "barb" 2000) (list "carl" 1500))
; -> (cons (list "alan" 1000) (cons (list "barb" 2000) (cons (list "carl" 1500) '())))
; -> (cons (cons "alan" (cons 1000 '())) (cons (cons "barb" (cons 2000 '())) (cons (cons "carl" (cons 1500 '())) '())))