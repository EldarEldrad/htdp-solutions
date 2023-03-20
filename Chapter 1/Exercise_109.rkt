;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_109) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; ExpectsToSee is one of:
; – AA
; – BB
; – DD 
; – ER 
 
(define AA "start, expect an 'a'")
(define BB "expect 'b', 'c', or 'd'")
(define DD "finished")
(define ER "error, illegal key")

(define SIZE 100)

; ExpectsToSee -> Image
; renders colored rectangles depending on current sequence status
(check-expect (render AA) (square 100 "solid" "white"))
(check-expect (render BB) (square 100 "solid" "yellow"))
(check-expect (render DD) (square 100 "solid" "green"))
(check-expect (render ER) (square 100 "solid" "red"))
(define (render e)
  (square 100 "solid"
          (cond
            [(string=? e AA) "white"]
            [(string=? e BB) "yellow"]
            [(string=? e DD) "green"]
            [(string=? e ER) "red"])))

; ExpectedToSee KeyEvent -> ExpectedToSee
; processes next symbol in KeyEvent sequence
(check-expect (press AA "a") BB)
(check-expect (press AA "b") ER)
(check-expect (press AA "c") ER)
(check-expect (press AA "d") ER)
(check-expect (press AA "e") ER)
(check-expect (press BB "a") ER)
(check-expect (press BB "b") BB)
(check-expect (press BB "c") BB)
(check-expect (press BB "d") DD)
(check-expect (press BB "e") ER)
(check-expect (press DD "a") DD)
(check-expect (press DD "b") DD)
(check-expect (press DD "c") DD)
(check-expect (press DD "d") DD)
(check-expect (press DD "e") DD)
(check-expect (press ER "a") ER)
(check-expect (press ER "b") ER)
(check-expect (press ER "c") ER)
(check-expect (press ER "d") ER)
(check-expect (press ER "e") ER)
(define (press e ke)
  (cond
    [(and (string=? ke "a") (string=? e AA)) BB]
    [(and (string=? ke "d") (string=? e BB)) DD]
    [(and (or (string=? ke "b") (string=? ke "c"))
          (string=? e BB)) BB]
    [(or (string=? e AA) (string=? e BB)) ER]
    [else e]))

; ExpectedToSee -> Boolean
; returns #true if reached DD or ER
(check-expect (final-state? AA) #false)
(check-expect (final-state? BB) #false)
(check-expect (final-state? DD) #true)
(check-expect (final-state? ER) #true)
(define (final-state? e)
  (or (string=? e DD) (string=? e ER)))

; ExpectsToSee -> ExpectsToSee
; recognizes a pattern in a sequence of KeyEvents
(define main
  (big-bang AA
    [to-draw render]
    [on-key press]
    [stop-when final-state? render]))