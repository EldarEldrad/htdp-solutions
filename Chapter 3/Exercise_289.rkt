;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_289) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
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
  (ormap (lambda (n) (string-contains? name n)) los))

; [List-of String] -> Boolean
; checks if all names on a list of names that start with the letter "a"
(check-expect (start-with-a? '()) #true)
(check-expect (start-with-a? '("Ann")) #true)
(check-expect (start-with-a? '("Bill")) #false)
(check-expect (start-with-a? '("")) #false)
(check-expect (start-with-a? '("Ann" "Arch" "Ascold" "Abraham")) #true)
(check-expect (start-with-a? '("Ann" "arch" "Ascold" "Abraham")) #true)
(check-expect (start-with-a? '("Ann" "Bill" "Ascold" "Abraham")) #false)
(define (start-with-a? los)
  (andmap (lambda (n)
            (and (not (string=? "" n))
                 (string-ci=? "a" (first (explode n)))))
          los))

; Should you use ormap or andmap to define a function that ensures
; that no name on some list exceeds a given width?

; both can be used