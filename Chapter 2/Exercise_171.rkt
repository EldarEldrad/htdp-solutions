;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_171) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; A List-of-list-of-strings is one of:
; - '()
; - (cons List-of-strings List-of-list-of-strings)
; interpretaion: contains list, each element of which is list of strings

; The example is
(define EX
  (cons (cons "TTT" '())
        (cons '()
              (cons (cons "Put" (cons "up" (cons "in" (cons "a" (cons "place" '())))))
                    (cons (cons "where" (cons "it's" (cons "easy" (cons "to" (cons "see" '())))))
                          (cons (cons "the" (cons "cryptic" (cons "admonishment" '())))
                                (cons (cons "T.T.T." '())
                                      (cons '()
                                            (cons (cons "When" (cons "you" (cons "feel" (cons "how" (cons "depressingly" '())))))
                                                  (cons (cons "slowly" (cons "you" (cons "climb," '())))
                                                        (cons (cons "it's" (cons "well" (cons "to" (cons "remember" (cons "that" '())))))
                                                              (cons (cons "Things" (cons "Take" (cons "Time." '())))
                                                                    (cons '()
                                                                          (cons (cons "Piet" (cons "Hein" '()))
                                                                                '()))))))))))))))

(check-expect (read-words/line "ttt.txt") EX)