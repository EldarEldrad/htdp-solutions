;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise_230) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct fsm [initial transitions final])
(define-struct transition [current key next])
; An FSM.v2 is a structure: 
;   (make-fsm FSM-State LOT FSM-State)
; A LOT is one of: 
; – '() 
; – (cons Transition.v3 LOT)
; A Transition.v3 is a structure: 
;   (make-transition FSM-State KeyEvent FSM-State)

; FSM-State is a ExpectsToSee

; ExpectsToSee is one of:
; – AA
; – BB
; – DD 
; – ER 
 
(define AA "start, expect an 'a'")
(define BB "expect 'b', 'c', or 'd'")
(define DD "finished")
(define ER "error, illegal key")

(define fsm-regular-transitions
  (list (make-transition AA "a" BB)
        (make-transition BB "b" BB)
        (make-transition BB "c" BB)
        (make-transition BB "d" DD)))

(define fsm-regular
  (make-fsm AA
            fsm-regular-transitions
            DD))
(define fsm-regular-bb
  (make-fsm BB
            fsm-regular-transitions
            DD))
(define fsm-regular-dd
  (make-fsm DD
            fsm-regular-transitions
            DD))

; FSM-State FSM-State -> Boolean
; equality predicate for states
(check-expect (state=? BB AA) #false)
(check-expect (state=? BB DD) #false)
(check-expect (state=? AA AA) #true)
(define (state=? s1 s2)
  (and (string? s1) (string? s2) (string=? s1 s2)))

; FSM.v2 -> FSM.v2
; match the keys pressed with the given FSM
(define (fsm-simulate an-fsm)
  (big-bang an-fsm
    [to-draw state-as-colored-square]
    [on-key find-next-state]
    [stop-when final-state? state-as-colored-square]))

; FSM.v2 -> Image
; renders current state as colored square
(check-expect (state-as-colored-square fsm-regular)
              (square 100 "solid" "white"))
(check-expect (state-as-colored-square fsm-regular-bb)
              (square 100 "solid" "yellow"))
(check-expect (state-as-colored-square fsm-regular-dd)
              (square 100 "solid" "green"))
(check-expect (state-as-colored-square
               (make-fsm "wrong"
                         (list (make-transition AA "a" BB)
                               (make-transition BB "b" BB)
                               (make-transition BB "c" BB)
                               (make-transition BB "d" DD))
                         DD))
              (square 100 "solid" "red"))
(define (state-as-colored-square an-fsm)
  (square 100 "solid"
           (cond
            [(state=? AA (fsm-initial an-fsm)) "white"]
            [(state=? BB (fsm-initial an-fsm)) "yellow"]
            [(state=? DD (fsm-initial an-fsm)) "green"]
            [else "red"])))

; FSM.v2 KeyEvent -> FSM.v2
; processes KeyEvent to transit to next state if possible
(check-expect (find-next-state fsm-regular "a") fsm-regular-bb)
(check-expect (find-next-state fsm-regular "b") fsm-regular)
(check-expect (find-next-state fsm-regular "c") fsm-regular)
(check-expect (find-next-state fsm-regular "d") fsm-regular)
(check-expect (find-next-state fsm-regular "n") fsm-regular)
(check-expect (find-next-state fsm-regular-bb "a") fsm-regular-bb)
(check-expect (find-next-state fsm-regular-bb "b") fsm-regular-bb)
(check-expect (find-next-state fsm-regular-bb "c") fsm-regular-bb)
(check-expect (find-next-state fsm-regular-bb "d") fsm-regular-dd)
(check-expect (find-next-state fsm-regular-bb "n") fsm-regular-bb)
(check-expect (find-next-state fsm-regular-dd "a") fsm-regular-dd)
(check-expect (find-next-state fsm-regular-dd "b") fsm-regular-dd)
(check-expect (find-next-state fsm-regular-dd "c") fsm-regular-dd)
(check-expect (find-next-state fsm-regular-dd "d") fsm-regular-dd)
(check-expect (find-next-state fsm-regular-dd "n") fsm-regular-dd)
(define (find-next-state an-fsm ke)
  (make-fsm (find (fsm-transitions an-fsm) (fsm-initial an-fsm) ke)
            (fsm-transitions an-fsm)
            (fsm-final an-fsm)))

; FSM FSM-State KeyEvent -> FSM-State
; finds the state representing current in transitions with KeyEvent pressed
; and retrieves the next field 
(check-expect (find fsm-regular-transitions AA "a") BB)
(check-expect (find fsm-regular-transitions AA "b") AA)
(check-expect (find fsm-regular-transitions AA "c") AA)
(check-expect (find fsm-regular-transitions AA "d") AA)
(check-expect (find fsm-regular-transitions AA "e") AA)
(check-expect (find fsm-regular-transitions BB "a") BB)
(check-expect (find fsm-regular-transitions BB "b") BB)
(check-expect (find fsm-regular-transitions BB "c") BB)
(check-expect (find fsm-regular-transitions BB "d") DD)
(check-expect (find fsm-regular-transitions BB "e") BB)
(check-expect (find fsm-regular-transitions DD "a") DD)
(check-expect (find fsm-regular-transitions DD "b") DD)
(check-expect (find fsm-regular-transitions DD "c") DD)
(check-expect (find fsm-regular-transitions DD "d") DD)
(check-expect (find fsm-regular-transitions DD "e") DD)
(define (find transitions current ke)
  (cond
    [(empty? transitions) current]
    [(and (state=? current (transition-current (first transitions)))
          (key=? ke (transition-key (first transitions))))
     (transition-next (first transitions))]
    [else (find (rest transitions) current ke)]))

; FSM.v2 -> Boolean
; returns #true is final state has been reached
(check-expect (final-state? fsm-regular) #false)
(check-expect (final-state? fsm-regular-bb) #false)
(check-expect (final-state? fsm-regular-dd) #true)
(define (final-state? an-fsm)
  (state=? (fsm-initial an-fsm) (fsm-final an-fsm)))

(fsm-simulate fsm-regular)