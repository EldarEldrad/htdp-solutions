;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise_218) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct worm [positions direction])
; A WormState is a structure:
;   (make-worm List-of-Posns String)
; interpretation create worm with its body in given positions and moving in specified direction

(define INITIAL (make-worm
                 (list (make-posn 1 1) (make-posn 2 1) (make-posn 3 1) (make-posn 4 1) (make-posn 5 1))
                 "right"))

(define FIELD-SIZE 15)
(define WORM-SIZE 4)
(define WORM-BODY (circle WORM-SIZE "solid" "red"))
(define SCENE-SIZE (* 2 FIELD-SIZE WORM-SIZE))
(define MT (empty-scene SCENE-SIZE SCENE-SIZE))

(define TEXT-HIT-BORDER "worm hit border")
(define TEXT-HIT-ITSELF "worm hit itself")
(define TEXT-SIZE 16)

(define NOT-FINAL-RENDER-ERROR "render-final: reached final render but WormState is not final")

; WormState -> Image
; draws current WormState
(check-expect (render (make-worm '() "down")) MT)
(check-expect (render (make-worm (list (make-posn 1 1)) "up"))
              (place-image WORM-BODY WORM-SIZE WORM-SIZE MT))
(check-expect (render (make-worm (list (make-posn 2 1)) "right"))
              (place-image WORM-BODY (* 3 WORM-SIZE) WORM-SIZE MT))
(check-expect (render (make-worm (list (make-posn 1 2)) "left"))
              (place-image WORM-BODY WORM-SIZE (* 3 WORM-SIZE) MT))
(check-expect (render (make-worm (list (make-posn 5 6)) "right"))
              (place-image WORM-BODY (* 9 WORM-SIZE) (* 11 WORM-SIZE) MT))
(check-expect (render (make-worm (list (make-posn 3 4) (make-posn 5 6)) "up"))
              (place-image WORM-BODY (* 5 WORM-SIZE) (* 7 WORM-SIZE)
                           (place-image WORM-BODY (* 9 WORM-SIZE) (* 11 WORM-SIZE) MT)))
(define (render ws)
  (render-positions (worm-positions ws) MT))

; List-of-Posns Image -> Image
; renders body of worm in given list of Posns on given Image
(check-expect (render-positions '() MT) MT)
(check-expect (render-positions (list (make-posn 1 1)) MT)
              (place-image WORM-BODY WORM-SIZE WORM-SIZE MT))
(check-expect (render-positions (list (make-posn 2 1)) MT)
              (place-image WORM-BODY (* 3 WORM-SIZE) WORM-SIZE MT))
(check-expect (render-positions (list (make-posn 1 2)) MT)
              (place-image WORM-BODY WORM-SIZE (* 3 WORM-SIZE) MT))
(check-expect (render-positions (list (make-posn 5 6)) MT)
              (place-image WORM-BODY (* 9 WORM-SIZE) (* 11 WORM-SIZE) MT))
(check-expect (render-positions (list (make-posn 3 4) (make-posn 5 6)) MT)
              (place-image WORM-BODY (* 5 WORM-SIZE) (* 7 WORM-SIZE)
                           (place-image WORM-BODY (* 9 WORM-SIZE) (* 11 WORM-SIZE) MT)))
(define (render-positions lop image)
  (cond
    [(empty? lop) image]
    [else (place-image WORM-BODY
                       (* WORM-SIZE (- (* 2 (posn-x (first lop))) 1))
                       (* WORM-SIZE (- (* 2 (posn-y (first lop))) 1))
                       (render-positions (rest lop) image))]))

; WormState Key -> WormState
; changes direction of WormState according to key pressed
(check-expect (change-direction (make-worm (list (make-posn 4 4)) "right") "k")
              (make-worm (list (make-posn 4 4)) "right"))
(check-expect (change-direction (make-worm (list (make-posn 4 4)) "right") "right")
              (make-worm (list (make-posn 4 4)) "right"))
(check-expect (change-direction (make-worm (list (make-posn 4 4)) "up") "right")
              (make-worm (list (make-posn 4 4)) "right"))
(check-expect (change-direction (make-worm (list (make-posn 4 4)) "down") "right")
              (make-worm (list (make-posn 4 4)) "right"))
(check-expect (change-direction (make-worm (list (make-posn 4 4)) "left") "right")
              (make-worm (list (make-posn 4 4)) "left"))
(check-expect (change-direction (make-worm (list (make-posn 4 4) (make-posn 3 8)) "right") "up")
              (make-worm (list (make-posn 4 4) (make-posn 3 8)) "up"))
(check-expect (change-direction (make-worm (list (make-posn 4 4) (make-posn 3 8)) "up") "left")
              (make-worm (list (make-posn 4 4) (make-posn 3 8)) "left"))
(check-expect (change-direction (make-worm (list (make-posn 4 4) (make-posn 3 8)) "down") "down")
              (make-worm (list (make-posn 4 4) (make-posn 3 8)) "down"))
(check-expect (change-direction (make-worm (list (make-posn 4 4) (make-posn 3 8)) "left") "right")
              (make-worm (list (make-posn 4 4) (make-posn 3 8)) "left"))
(define (change-direction ws key)
  (cond
    [(and (string=? key "right") (not (string=? (worm-direction ws) "left")))
     (make-worm (worm-positions ws) key)]
    [(and (string=? key "left") (not (string=? (worm-direction ws) "right")))
     (make-worm (worm-positions ws) key)]
    [(and (string=? key "up") (not (string=? (worm-direction ws) "down")))
     (make-worm (worm-positions ws) key)]
    [(and (string=? key "down") (not (string=? (worm-direction ws) "up")))
     (make-worm (worm-positions ws) key)]
    [else ws]))

; WormState -> WormState
; produces new WormState by moving the worm is specified direction
(check-expect (tock (make-worm (list (make-posn 2 2)) "right"))
              (make-worm (list (make-posn 3 2)) "right"))
(check-expect (tock (make-worm (list (make-posn 2 2)) "up"))
              (make-worm (list (make-posn 2 1)) "up"))
(check-expect (tock (make-worm (list (make-posn 2 2)) "down"))
              (make-worm (list (make-posn 2 3)) "down"))
(check-expect (tock (make-worm (list (make-posn 2 2)) "left"))
              (make-worm (list (make-posn 1 2)) "left"))
(check-expect (tock (make-worm (list (make-posn 4 4) (make-posn 4 5) (make-posn 5 5)) "right"))
              (make-worm (list (make-posn 4 5) (make-posn 5 5) (make-posn 6 5)) "right"))
(check-expect (tock (make-worm (list (make-posn 4 4) (make-posn 4 5) (make-posn 5 5)) "up"))
              (make-worm (list (make-posn 4 5) (make-posn 5 5) (make-posn 5 4)) "up"))
(check-expect (tock (make-worm (list (make-posn 4 4) (make-posn 4 5) (make-posn 5 5)) "down"))
              (make-worm (list (make-posn 4 5) (make-posn 5 5) (make-posn 5 6)) "down"))
(define (tock ws)
  (make-worm (rest (move-worm (worm-positions ws) (worm-direction ws)))
             (worm-direction ws)))

; List-of-Posns String -> List-of-Posns
; creates another posn in List-of-Posns in given direction
(check-expect (move-worm (list (make-posn 2 2)) "right") (list (make-posn 2 2) (make-posn 3 2)))
(check-expect (move-worm (list (make-posn 2 2)) "up") (list (make-posn 2 2) (make-posn 2 1)))
(check-expect (move-worm (list (make-posn 2 2)) "down") (list (make-posn 2 2) (make-posn 2 3)))
(check-expect (move-worm (list (make-posn 2 2)) "left") (list (make-posn 2 2) (make-posn 1 2)))
(check-expect (move-worm (list (make-posn 4 4) (make-posn 4 5) (make-posn 5 5)) "right")
              (list (make-posn 4 4) (make-posn 4 5) (make-posn 5 5) (make-posn 6 5)))
(check-expect (move-worm (list (make-posn 4 4) (make-posn 4 5) (make-posn 5 5)) "up")
              (list (make-posn 4 4) (make-posn 4 5) (make-posn 5 5) (make-posn 5 4)))
(check-expect (move-worm (list (make-posn 4 4) (make-posn 4 5) (make-posn 5 5)) "down")
              (list (make-posn 4 4) (make-posn 4 5) (make-posn 5 5) (make-posn 5 6)))
(define (move-worm lop dir)
   (cond
     [(empty? (rest lop))
      (cons (first lop)
            (cond
              [(string=? dir "right") (list (make-posn (+ (posn-x (first lop)) 1) (posn-y (first lop))))]
              [(string=? dir "left") (list (make-posn (- (posn-x (first lop)) 1) (posn-y (first lop))))]
              [(string=? dir "down") (list (make-posn (posn-x (first lop)) (+ (posn-y (first lop)) 1)))]
              [(string=? dir "up") (list (make-posn (posn-x (first lop)) (- (posn-y (first lop)) 1)))]
              [else '()]))]
     [else (cons (first lop) (move-worm (rest lop) dir))]))

; WormState -> Boolean
; returns #true if worm hit the wall
(check-expect (hit-border? (make-worm '() "right")) #false)
(check-expect (hit-border? (make-worm (list (make-posn 3 3)) "right")) #false)
(check-expect (hit-border? (make-worm (list (make-posn 0 3)) "down")) #true)
(check-expect (hit-border? (make-worm (list (make-posn 6 20)) "left")) #true)
(check-expect (hit-border? (make-worm (list (make-posn 5 6) (make-posn 18 12)) "up")) #true)
(define (hit-border? ws)
  (hit-border?/list (worm-positions ws)))

; List-of-Posns -> Boolean
; returns #true if worm hit the wall
(check-expect (hit-border?/list '()) #false)
(check-expect (hit-border?/list (list (make-posn 3 3))) #false)
(check-expect (hit-border?/list (list (make-posn 0 3))) #true)
(check-expect (hit-border?/list (list (make-posn 6 20))) #true)
(check-expect (hit-border?/list (list (make-posn 5 6) (make-posn 18 12))) #true)
(define (hit-border?/list lop)
  (cond
    [(empty? lop) #false]
    [(or (<= (posn-x (first lop)) 0)
         (> (posn-x (first lop)) FIELD-SIZE)
         (<= (posn-y (first lop)) 0)
         (> (posn-y (first lop)) FIELD-SIZE)) #true]
    [else (hit-border?/list (rest lop))]))

; WormState -> Boolean
; returns #true if worm hit itself
(check-expect (hit-itself? (make-worm '() "left")) #false)
(check-expect (hit-itself? (make-worm (list (make-posn 3 3)) "up")) #false)
(check-expect (hit-itself? (make-worm (list (make-posn 3 3) (make-posn 3 3)) "left")) #true)
(check-expect (hit-itself?
               (make-worm
                (list (make-posn 4 5) (make-posn 5 5) (make-posn 5 4) (make-posn 4 4) (make-posn 4 5))
                "right"))
              #true)
(check-expect (hit-itself?
               (make-worm
                (list (make-posn 4 5) (make-posn 5 5) (make-posn 5 4) (make-posn 4 4) (make-posn 4 3))
                "down"))
              #false)
(define (hit-itself? ws)
  (hit-itself?/list (worm-positions ws)))

; List-of-Posns -> Boolean
; returns #true if worm hit the wall
(check-expect (hit-itself?/list '()) #false)
(check-expect (hit-itself?/list (list (make-posn 3 3))) #false)
(check-expect (hit-itself?/list (list (make-posn 3 3) (make-posn 3 3))) #true)
(check-expect (hit-itself?/list
               (list (make-posn 4 5) (make-posn 5 5) (make-posn 5 4) (make-posn 4 4) (make-posn 4 5)))
              #true)
(check-expect (hit-itself?/list
               (list (make-posn 4 5) (make-posn 5 5) (make-posn 5 4) (make-posn 4 4) (make-posn 4 3)))
              #false)
(define (hit-itself?/list lop)
  (cond
    [(empty? lop) #false]
    [else (member? (first lop) (rest lop))]))

; WormState -> Boolean
; return #true if worm hit the border or itself
(check-expect (game-over? (make-worm '() "left")) #false)
(check-expect (game-over? (make-worm (list (make-posn 3 3)) "up")) #false)
(check-expect (game-over? (make-worm (list (make-posn 3 3) (make-posn 3 3)) "left")) #true)
(check-expect (game-over?
               (make-worm
                (list (make-posn 4 5) (make-posn 5 5) (make-posn 5 4) (make-posn 4 4) (make-posn 4 5))
                "right"))
              #true)
(check-expect (game-over?
               (make-worm
                (list (make-posn 4 5) (make-posn 5 5) (make-posn 5 4) (make-posn 4 4) (make-posn 4 3))
                "down"))
              #false)
(check-expect (game-over? (make-worm (list (make-posn 0 3)) "down")) #true)
(check-expect (game-over? (make-worm (list (make-posn 6 20)) "left")) #true)
(check-expect (game-over? (make-worm (list (make-posn 5 6) (make-posn 18 12)) "up")) #true)
(define (game-over? ws)
  (or (hit-border? ws) (hit-itself? ws)))

; WormState -> Image
; renders lose image
(check-error (render-final (make-worm '() "down")) NOT-FINAL-RENDER-ERROR) 
(check-error (render-final (make-worm (list (make-posn 1 1)) "up")) NOT-FINAL-RENDER-ERROR)
(check-expect (render-final (make-worm (list (make-posn 0 3)) "down"))
              (place-image (text TEXT-HIT-BORDER TEXT-SIZE "green")
                           (/ SCENE-SIZE 2)
                           (/ SCENE-SIZE 2)
                           (render (make-worm (list (make-posn 0 3)) "down"))))
(check-expect (render-final (make-worm (list (make-posn 6 20)) "left"))
              (place-image (text TEXT-HIT-BORDER TEXT-SIZE "green")
                           (/ SCENE-SIZE 2)
                           (/ SCENE-SIZE 2)
                           (render (make-worm (list (make-posn 6 20)) "left"))))
(check-expect (render-final (make-worm (list (make-posn 5 6) (make-posn 18 12)) "up"))
              (place-image (text TEXT-HIT-BORDER TEXT-SIZE "green")
                           (/ SCENE-SIZE 2)
                           (/ SCENE-SIZE 2)
                           (render (make-worm (list (make-posn 5 6) (make-posn 18 12)) "up"))))
(check-expect (render-final (make-worm (list (make-posn 0 3)) "down"))
              (place-image (text TEXT-HIT-BORDER TEXT-SIZE "green")
                           (/ SCENE-SIZE 2)
                           (/ SCENE-SIZE 2)
                           (render (make-worm (list (make-posn 0 3)) "down"))))
(check-expect (render-final (make-worm (list (make-posn 3 3) (make-posn 3 3)) "left"))
              (place-image (text TEXT-HIT-ITSELF TEXT-SIZE "green")
                           (/ SCENE-SIZE 2)
                           (/ SCENE-SIZE 2)
                           (render (make-worm (list (make-posn 3 3) (make-posn 3 3)) "left"))))
(check-expect (render-final
               (make-worm
                (list (make-posn 4 5) (make-posn 5 5) (make-posn 5 4) (make-posn 4 4) (make-posn 4 5))
                "right"))
              (place-image (text TEXT-HIT-ITSELF TEXT-SIZE "green")
                           (/ SCENE-SIZE 2)
                           (/ SCENE-SIZE 2)
                           (render
                            (make-worm
                             (list (make-posn 4 5) (make-posn 5 5) (make-posn 5 4) (make-posn 4 4) (make-posn 4 5))
                             "right"))))
(define (render-final ws)
  (place-image (text
                (cond
                  [(hit-border? ws) TEXT-HIT-BORDER]
                  [(hit-itself? ws) TEXT-HIT-ITSELF]
                  [else (error NOT-FINAL-RENDER-ERROR)])
                TEXT-SIZE "green")
               (/ SCENE-SIZE 2)
               (/ SCENE-SIZE 2)
               (render ws)))
  
; WormState -> WormState
; launches the program from some initial state 
(define (main rate)
   (big-bang INITIAL
     [on-tick tock rate]
     [on-key change-direction]
     [to-draw render]
     [stop-when game-over? render-final]))