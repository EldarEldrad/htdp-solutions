;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_307) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
; String [List-of String] -> Boolean
; consumes a name and a list of names.
; It determines whether any of the names on the latter are equal to or an extension of the former.
(check-expect (find-name "Jo" '()) #false)
(check-expect (find-name "Jo" '("Jo")) #true)
(check-expect (find-name "Jo" '("Bill")) #false)
(check-expect (find-name "Jo" '("Bill" "Mike" "Dan" "Nora")) #false)
(check-expect (find-name "Jo" '("Bill" "Mike" "Jo" "Nora")) #true)
(check-expect (find-name "Jo" '("Bill" "Mike" "Jose" "Nora")) #true)
(define (find-name name los)
  (for/or ([l los])
    (string-contains? name l)))

; Number [List-of String] -> Boolean
; ensures that no name on some list of names exceeds some given width
(check-expect (no-exceeds-width? 2 '()) #true)
(check-expect (no-exceeds-width? 2 '("Jo")) #true)
(check-expect (no-exceeds-width? 2 '("Bill")) #false)
(check-expect (no-exceeds-width? 3 '("Bill" "Mike" "Dan" "Nora")) #false)
(check-expect (no-exceeds-width? 4 '("Bill" "Mike" "Jo" "Nora")) #true)
(check-expect (no-exceeds-width? 5 '("Bill" "Mike" "Jose" "Nora")) #true)
(define (no-exceeds-width? width los)
  (for/and ([l los])
    (<= (string-length l) width)))
