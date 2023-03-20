;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_165) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; List-of-strings -> List-of-strings
; consumes a list of toy descriptions (one-word strings) and replaces all occurrences of "robot" with "r2d2"
; all other descriptions remain the same.
(check-expect (subst-robot '()) '())
(check-expect (subst-robot (cons "android" '())) (cons "android" '()))
(check-expect (subst-robot (cons "robot" '())) (cons "r2d2" '()))
(check-expect (subst-robot (cons "android" (cons "robot" '()))) (cons "android" (cons "r2d2" '())))
(define (subst-robot words)
  (cond
    [(empty? words) '()]
    [else (cons (robot-to-r2d2 (first words)) (subst-robot (rest words)))]))

; String -> String
; replace given string "robot" with "r2d2"
; otherwise returns given string
(check-expect (robot-to-r2d2 "") "")
(check-expect (robot-to-r2d2 "abc") "abc")
(check-expect (robot-to-r2d2 "robot") "r2d2")
(define (robot-to-r2d2 str)
  (if (string=? str "robot")
      "r2d2"
      str))

; List-of-strings String String -> List-of-strings
; consumes a list of toy descriptions (one-word strings) and replaces all occurrences of old with new
; all other descriptions remain the same.
(check-expect (substitute '() "robot" "r2d2") '())
(check-expect (substitute (cons "android" '()) "robot" "r2d2") (cons "android" '()))
(check-expect (substitute (cons "android" '()) "android" "r2d2") (cons "r2d2" '()))
(check-expect (substitute (cons "robot" '()) "robot" "r2d2") (cons "r2d2" '()))
(check-expect (substitute (cons "android" (cons "robot" '())) "robot" "r2d2")
              (cons "android" (cons "r2d2" '())))
(check-expect (substitute (cons "android" (cons "robot" '())) "android" "r2d2")
              (cons "r2d2" (cons "robot" '())))
(check-expect (substitute (cons "android" (cons "robot" '())) "old" "new")
              (cons "android" (cons "robot" '())))
(define (substitute words old new)
  (cond
    [(empty? words) '()]
    [else (cons (old-to-new (first words) old new) (substitute (rest words) old new))]))

; String -> String
; replace given string with new if its old
; otherwise returns given string
(check-expect (old-to-new "" "robot" "r2d2") "")
(check-expect (old-to-new "abc" "robot" "r2d2") "abc")
(check-expect (old-to-new "abc" "abc" "def") "def")
(check-expect (old-to-new "robot" "robot" "r2d2") "r2d2")
(define (old-to-new str old new)
  (if (string=? str old)
      new
      str))