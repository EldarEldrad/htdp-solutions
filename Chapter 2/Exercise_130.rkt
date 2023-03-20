;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_130) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; A List-of-names is one of: 
; – '()
; – (cons String List-of-names)
; interpretation a list of invitees, by last name

(cons "Abe"
      (cons "Bob"
            (cons "Charlie"
                  (cons "Dean"
                        (cons "Eugene" '())))))

(cons "1" (cons "2" '()))
; it is List-of-names, because its
; (cons String (cons String '()))
; (cons String (cons String List-of-names))
; (cons String List-of-names)
; List-of-names

(cons 2 '())
; it is not List-of-names, because
; (cons Number List-of-names)
; is not List-of-names