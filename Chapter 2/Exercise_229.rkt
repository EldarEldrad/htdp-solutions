;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise_229) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; An FSM is one of:
;   – '()
;   – (cons Transition.v2 FSM)
 
(define-struct ktransition [current key next])
; A Transition.v2 is a structure:
;   (make-ktransition FSM-State KeyEvent FSM-State)
 
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
 
; interpretation An FSM represents the transitions that a
; finite state machine can take from one state to another 
; in reaction to keystrokes

(define fsm-regular
  (list (make-ktransition AA "a" BB)
        (make-ktransition BB "b" BB)
        (make-ktransition BB "c" BB)
        (make-ktransition BB "d" DD)))

; A SimulationState.v1 is an FSM-State.

(define-struct fs [fsm current])
; A SimulationState.v2 is a structure: 
;   (make-fs FSM FSM-State)

; FSM-State FSM-State -> Boolean
; equality predicate for states
(check-expect (state=? "green" "blue") #false)
(check-expect (state=? "red" "yellow") #false)
(check-expect (state=? "violet" "violet") #true)
(check-expect (state=? BB DD) #false)
(check-expect (state=? AA AA) #true)
(define (state=? s1 s2)
  (and (string? s1) (string? s2) (string=? s1 s2)))

; FSM FSM-State -> SimulationState.v2
; match the keys pressed with the given FSM 
(define (simulate.v3 an-fsm s0)
  (big-bang (make-fs an-fsm s0)
    [to-draw state-as-colored-square]
    [on-key find-next-state]))

; SimulationState.v2 -> Image 
; renders current world state as a colored square 
(check-expect (state-as-colored-square
                (make-fs fsm-regular AA))
              (square 100 "solid" "white"))
(check-expect (state-as-colored-square
                (make-fs fsm-regular BB))
              (square 100 "solid" "yellow"))
(check-expect (state-as-colored-square
                (make-fs fsm-regular DD))
              (square 100 "solid" "green"))
(define (state-as-colored-square an-fsm)
  (square 100 "solid"
          (cond
            [(state=? AA (fs-current an-fsm)) "white"]
            [(state=? BB (fs-current an-fsm)) "yellow"]
            [(state=? DD (fs-current an-fsm)) "green"]
            [else "red"])))
 
; SimulationState.v2 KeyEvent -> SimulationState.v2
; finds the next state from an-fsm and ke
(check-expect
  (find-next-state (make-fs fsm-regular AA) "a")
  (make-fs fsm-regular BB))
(check-expect
  (find-next-state (make-fs fsm-regular AA) "b")
  (make-fs fsm-regular AA))
(check-expect
  (find-next-state (make-fs fsm-regular AA) "c")
  (make-fs fsm-regular AA))
(check-expect
  (find-next-state (make-fs fsm-regular AA) "d")
  (make-fs fsm-regular AA))
(check-expect
  (find-next-state (make-fs fsm-regular AA) "n")
  (make-fs fsm-regular AA))
(check-expect
  (find-next-state (make-fs fsm-regular BB) "a")
  (make-fs fsm-regular BB))
(check-expect
  (find-next-state (make-fs fsm-regular BB) "b")
  (make-fs fsm-regular BB))
(check-expect
  (find-next-state (make-fs fsm-regular BB) "c")
  (make-fs fsm-regular BB))
(check-expect
  (find-next-state (make-fs fsm-regular BB) "d")
  (make-fs fsm-regular DD))
(check-expect
  (find-next-state (make-fs fsm-regular BB) "n")
  (make-fs fsm-regular BB))
(check-expect
  (find-next-state (make-fs fsm-regular DD) "a")
  (make-fs fsm-regular DD))
(check-expect
  (find-next-state (make-fs fsm-regular DD) "b")
  (make-fs fsm-regular DD))
(check-expect
  (find-next-state (make-fs fsm-regular DD) "c")
  (make-fs fsm-regular DD))
(check-expect
  (find-next-state (make-fs fsm-regular DD) "d")
  (make-fs fsm-regular DD))
(check-expect
  (find-next-state (make-fs fsm-regular DD) "n")
  (make-fs fsm-regular DD))
(define (find-next-state an-fsm ke)
  (make-fs
    (fs-fsm an-fsm)
    (find (fs-fsm an-fsm) (fs-current an-fsm) ke)))

; FSM FSM-State KeyEvent -> FSM-State
; finds the state representing current in transitions with KeyEvent pressed
; and retrieves the next field 
(check-expect (find fsm-regular AA "a") BB)
(check-expect (find fsm-regular AA "b") AA)
(check-expect (find fsm-regular AA "c") AA)
(check-expect (find fsm-regular AA "d") AA)
(check-expect (find fsm-regular AA "e") AA)
(check-expect (find fsm-regular BB "a") BB)
(check-expect (find fsm-regular BB "b") BB)
(check-expect (find fsm-regular BB "c") BB)
(check-expect (find fsm-regular BB "d") DD)
(check-expect (find fsm-regular BB "e") BB)
(check-expect (find fsm-regular DD "a") DD)
(check-expect (find fsm-regular DD "b") DD)
(check-expect (find fsm-regular DD "c") DD)
(check-expect (find fsm-regular DD "d") DD)
(check-expect (find fsm-regular DD "e") DD)
(define (find transitions current ke)
  (cond
    [(empty? transitions) current]
    [(and (state=? current (ktransition-current (first transitions)))
          (key=? ke (ktransition-key (first transitions))))
     (ktransition-next (first transitions))]
    [else (find (rest transitions) current ke)]))

(simulate.v3 fsm-regular AA)