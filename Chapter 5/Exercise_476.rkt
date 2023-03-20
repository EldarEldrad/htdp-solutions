;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_476) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct transition [current key next])
(define-struct fsm [initial transitions final])
 
; An FSM is a structure:
;   (make-fsm FSM-State [List-of 1Transition] FSM-State)
; A 1Transition is a structure:
;   (make-transition FSM-State 1String FSM-State)
; An FSM-State is String.
 
; data example: see exercise 109
 
(define fsm-a-bc*-d
  (make-fsm
   "AA"
   (list (make-transition "AA" "a" "BC")
         (make-transition "BC" "b" "BC")
         (make-transition "BC" "c" "BC")
         (make-transition "BC" "d" "DD"))
   "DD"))

; FSM String -> Boolean 
; does an-fsm recognize the given string
(check-expect (fsm-match? fsm-a-bc*-d "abcd") #true)
(check-expect (fsm-match? fsm-a-bc*-d "ad") #true)
(check-expect (fsm-match? fsm-a-bc*-d "abd") #true)
(check-expect (fsm-match? fsm-a-bc*-d "acbd") #true)
(check-expect (fsm-match? fsm-a-bc*-d "acbcbcbd") #true)
(check-expect (fsm-match? fsm-a-bc*-d "da") #false)
(check-expect (fsm-match? fsm-a-bc*-d "aa") #false)
(check-expect (fsm-match? fsm-a-bc*-d "d") #false)
(define (fsm-match? an-fsm a-string)
  (local ((define final-state (fsm-final an-fsm))
          (define transitions (fsm-transitions an-fsm))
          ; FSM-State 1String -> [Maybe FSM-State]
          ; find new state for given 1String
          ; returns #false in on relevant trabsistion exists
          (define (find-new-state state key)
            (foldr (lambda (cur rst) (if (and (equal? state (transition-current cur))
                                              (equal? key (transition-key cur)))
                                         (transition-next cur)
                                         rst))
                   #false
                   transitions))
          ; FSM-State [List-of 1String] -> Boolean
          ; simulates FSM on given list
          ; returns #true if final state reached
          (define (fsm-simulate state lo1s)
            (cond
              [(empty? lo1s) (equal? state final-state)]
              [else (local ((define new-state (find-new-state state (first lo1s))))
                      (if (string? new-state)
                          (fsm-simulate new-state (rest lo1s))
                          #false))])))
    (fsm-simulate (fsm-initial an-fsm) (explode a-string))))

