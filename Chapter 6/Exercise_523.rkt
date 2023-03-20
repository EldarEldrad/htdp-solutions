;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_523) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; A PuzzleState is a [NEList-of SingleState]

(define-struct ps [left-side right-side boat])
; A SingleState is a structure:
;   (make-ps RiverSideState RiverSideState BoatState)
; interpretation represents a state of puzzle with missionaries

(define-struct rs [missionaries cannibals])
; A RiverSideState is a structure:
;   (make-rs Number Number)
; interpretation represents number of missionaries and cannibals on the side of the river

; A BoatState is one of
; - "left"
; - "right"

(define INITIAL (make-ps (make-rs 3 3) (make-rs 0 0) "left"))

; [List-of PuzzleState] -> [List-of PuzzleState]
; consumes lists of missionary-and-cannibal states
; and generates the list of all those states that a boat ride can reach
(check-expect (create-next-states '()) '())
(check-expect (create-next-states (list (list INITIAL)))
              (list (list (make-ps (make-rs 3 2) (make-rs 0 1) "right") INITIAL)
                    (list (make-ps (make-rs 3 1) (make-rs 0 2) "right") INITIAL)
                    (list (make-ps (make-rs 2 2) (make-rs 1 1) "right") INITIAL)))
(check-expect (create-next-states (list (list (make-ps (make-rs 2 2) (make-rs 1 1) "right") INITIAL)))
              (list (list (make-ps (make-rs 3 2) (make-rs 0 1) "left") (make-ps (make-rs 2 2) (make-rs 1 1) "right") INITIAL)))
(check-expect (create-next-states (list (list INITIAL)
                                        (list (make-ps (make-rs 2 2) (make-rs 1 1) "right") INITIAL)))
              (list (list (make-ps (make-rs 3 2) (make-rs 0 1) "right") INITIAL)
                    (list (make-ps (make-rs 3 1) (make-rs 0 2) "right") INITIAL)
                    (list (make-ps (make-rs 2 2) (make-rs 1 1) "right") INITIAL)
                    (list (make-ps (make-rs 3 2) (make-rs 0 1) "left") (make-ps (make-rs 2 2) (make-rs 1 1) "right") INITIAL)))
(define (create-next-states lops)
  (local (; SingleState SingleState [List-of SingleState] -> [List-of PuzzleState]
          (define (generate-if-valid new-state cur-state prev-states)
            (if (and (<= 0 (rs-missionaries (ps-left-side new-state)) 3)
                     (<= 0 (rs-cannibals (ps-left-side new-state)) 3)
                     (<= 0 (rs-missionaries (ps-right-side new-state)) 3)
                     (<= 0 (rs-cannibals (ps-right-side new-state)) 3)
                     (or (= 0 (rs-missionaries (ps-left-side new-state)))
                         (<= (rs-cannibals (ps-left-side new-state)) (rs-missionaries (ps-left-side new-state))))
                     (or (= 0 (rs-missionaries (ps-right-side new-state)))
                         (<= (rs-cannibals (ps-right-side new-state)) (rs-missionaries (ps-right-side new-state))))
                     (not (member? new-state prev-states)))
                (list (append (list new-state cur-state) prev-states))
                '()))
          ; PuzzleState -> [List-of PuzzleState]
          (define (create-next-states/ps ps)
            (local ((define cur-state (first ps))
                    (define prev-states (rest ps))
                    (define new-state-c
                      (if (equal? "left" (ps-boat cur-state))
                          (make-ps (make-rs (rs-missionaries (ps-left-side cur-state))
                                            (sub1 (rs-cannibals (ps-left-side cur-state))))
                                   (make-rs (rs-missionaries (ps-right-side cur-state))
                                            (add1 (rs-cannibals (ps-right-side cur-state))))
                                   "right")
                          (make-ps (make-rs (rs-missionaries (ps-left-side cur-state))
                                            (add1 (rs-cannibals (ps-left-side cur-state))))
                                   (make-rs (rs-missionaries (ps-right-side cur-state))
                                            (sub1 (rs-cannibals (ps-right-side cur-state))))
                                   "left")))
                    (define new-state-cc
                      (if (equal? "left" (ps-boat cur-state))
                          (make-ps (make-rs (rs-missionaries (ps-left-side cur-state))
                                            (- (rs-cannibals (ps-left-side cur-state)) 2))
                                   (make-rs (rs-missionaries (ps-right-side cur-state))
                                            (+ (rs-cannibals (ps-right-side cur-state)) 2))
                                   "right")
                          (make-ps (make-rs (rs-missionaries (ps-left-side cur-state))
                                            (+ (rs-cannibals (ps-left-side cur-state)) 2))
                                   (make-rs (rs-missionaries (ps-right-side cur-state))
                                            (- (rs-cannibals (ps-right-side cur-state)) 2))
                                   "left")))
                    (define new-state-mc
                      (if (equal? "left" (ps-boat cur-state))
                          (make-ps (make-rs (sub1 (rs-missionaries (ps-left-side cur-state)))
                                            (sub1 (rs-cannibals (ps-left-side cur-state))))
                                   (make-rs (add1 (rs-missionaries (ps-right-side cur-state)))
                                            (add1 (rs-cannibals (ps-right-side cur-state))))
                                   "right")
                          (make-ps (make-rs (add1 (rs-missionaries (ps-left-side cur-state)))
                                            (add1 (rs-cannibals (ps-left-side cur-state))))
                                   (make-rs (sub1 (rs-missionaries (ps-right-side cur-state)))
                                            (sub1 (rs-cannibals (ps-right-side cur-state))))
                                   "left")))
                    (define new-state-mm
                      (if (equal? "left" (ps-boat cur-state))
                          (make-ps (make-rs (- (rs-missionaries (ps-left-side cur-state)) 2)
                                            (rs-cannibals (ps-left-side cur-state)))
                                   (make-rs (+ (rs-missionaries (ps-right-side cur-state)) 2)
                                            (rs-cannibals (ps-right-side cur-state)))
                                   "right")
                          (make-ps (make-rs (+ (rs-missionaries (ps-left-side cur-state)) 2)
                                            (rs-cannibals (ps-left-side cur-state)))
                                   (make-rs (- (rs-missionaries (ps-right-side cur-state)) 2)
                                            (rs-cannibals (ps-right-side cur-state)))
                                   "left")))
                    (define new-state-m
                      (if (equal? "left" (ps-boat cur-state))
                          (make-ps (make-rs (sub1 (rs-missionaries (ps-left-side cur-state)))
                                            (rs-cannibals (ps-left-side cur-state)))
                                   (make-rs (add1 (rs-missionaries (ps-right-side cur-state)))
                                            (rs-cannibals (ps-right-side cur-state)))
                                   "right")
                          (make-ps (make-rs (add1 (rs-missionaries (ps-left-side cur-state)))
                                            (rs-cannibals (ps-left-side cur-state)))
                                   (make-rs (sub1 (rs-missionaries (ps-right-side cur-state)))
                                            (rs-cannibals (ps-right-side cur-state)))
                                   "left"))))
              (append (generate-if-valid new-state-c cur-state prev-states)
                      (generate-if-valid new-state-cc cur-state prev-states)
                      (generate-if-valid new-state-mc cur-state prev-states)
                      (generate-if-valid new-state-mm cur-state prev-states)
                      (generate-if-valid new-state-m cur-state prev-states)))))
    (foldr (lambda (x rst) (append (create-next-states/ps x) rst)) '() lops)))