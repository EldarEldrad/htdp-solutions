;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_365) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
; An Xexpr.v2 is (cons Symbol Body)

; An Body is one of:
; - '()
; - (cons Xexpr.v2 Body)
; - (cons [List-of Attribute] Body)

; An Attribute is a list of two items:
;   (cons Symbol (cons String '()))

'(server ((name "example.org")))
; <server name="example.org"></server>

'(carcas (board (grass)) (player ((name "sam"))))
; <carcas><board><grass /></board><player name="sam"></player></carcas>

'(start)
; <start />
; also element of Xexpr.v0 and Xexpr.v1