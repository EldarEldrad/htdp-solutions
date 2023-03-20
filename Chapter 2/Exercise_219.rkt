;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise_219) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct worm [positions direction food])
; A WormState is a structure:
;   (make-worm List-of-Posns String Posn)
; interpretation create worm with its body in given positions, moving in specified direction
; Also, food is located in given Posn

(define FIELD-SIZE 15)
(define WORM-SIZE 4)
(define WORM-BODY (circle WORM-SIZE "solid" "red"))
(define FOOD-BODY (circle WORM-SIZE "solid" "green"))
(define SCENE-SIZE (* 2 FIELD-SIZE WORM-SIZE))
(define MT (empty-scene SCENE-SIZE SCENE-SIZE))

(define TEXT-HIT-BORDER "worm hit border")
(define TEXT-HIT-ITSELF "worm hit itself")
(define TEXT-SIZE 16)

(define NOT-FINAL-RENDER-ERROR "render-final: reached final render but WormState is not final")

; Posn -> Posn 
; ???
(check-satisfied (food-create (make-posn 1 1)) not=-1-1?)
(define (food-create p)
  (food-check-create
     p (make-posn (random FIELD-SIZE) (random FIELD-SIZE))))
 
; Posn Posn -> Posn 
; generative recursion 
; ???
(define (food-check-create p candidate)
  (if (or (equal? p candidate)
          (= 0 (posn-x candidate))
          (= 0 (posn-y candidate)))
      (food-create p) candidate))
 
; Posn -> Boolean
; use for testing only 
(define (not=-1-1? p)
  (not (and (= (posn-x p) 1) (= (posn-y p) 1))))

(define INITIAL (make-worm
                 (list (make-posn 1 1))
                 "right"
                 (food-create (make-posn 1 1))))

; WormState -> Image
; draws current WormState
(check-expect (render (make-worm '() "down" (make-posn 1 1))) (place-image FOOD-BODY WORM-SIZE WORM-SIZE MT))
(check-expect (render (make-worm (list (make-posn 1 1)) "up" (make-posn 4 4)))
              (place-image FOOD-BODY (* 7 WORM-SIZE) (* 7 WORM-SIZE)
                           (place-image WORM-BODY WORM-SIZE WORM-SIZE MT)))
(check-expect (render (make-worm (list (make-posn 2 1)) "right" (make-posn 2 3)))
              (place-image FOOD-BODY (* 3 WORM-SIZE) (* 5 WORM-SIZE)
                           (place-image WORM-BODY (* 3 WORM-SIZE) WORM-SIZE MT)))
(check-expect (render (make-worm (list (make-posn 1 2)) "left" (make-posn 3 4)))
              (place-image FOOD-BODY (* 5 WORM-SIZE) (* 7 WORM-SIZE)
                           (place-image WORM-BODY WORM-SIZE (* 3 WORM-SIZE) MT)))
(check-expect (render (make-worm (list (make-posn 5 6)) "right" (make-posn 1 5)))
              (place-image FOOD-BODY WORM-SIZE (* 9 WORM-SIZE)
                           (place-image WORM-BODY (* 9 WORM-SIZE) (* 11 WORM-SIZE) MT)))
(check-expect (render (make-worm (list (make-posn 3 4) (make-posn 5 6)) "up" (make-posn 4 4)))
              (place-image FOOD-BODY (* 7 WORM-SIZE) (* 7 WORM-SIZE)
                           (place-image WORM-BODY (* 5 WORM-SIZE) (* 7 WORM-SIZE)
                                        (place-image WORM-BODY (* 9 WORM-SIZE) (* 11 WORM-SIZE) MT))))
(define (render ws)
  (place-image FOOD-BODY
               (* WORM-SIZE (- (* 2 (posn-x (worm-food ws))) 1))
               (* WORM-SIZE (- (* 2 (posn-y (worm-food ws))) 1))
               (render-positions (worm-positions ws) MT)))

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
(check-expect (change-direction (make-worm (list (make-posn 4 4)) "right" (make-posn 3 4)) "k")
              (make-worm (list (make-posn 4 4)) "right" (make-posn 3 4)))
(check-expect (change-direction (make-worm (list (make-posn 4 4)) "right" (make-posn 3 4)) "right")
              (make-worm (list (make-posn 4 4)) "right" (make-posn 3 4)))
(check-expect (change-direction (make-worm (list (make-posn 4 4)) "up" (make-posn 3 4)) "right")
              (make-worm (list (make-posn 4 4)) "right" (make-posn 3 4)))
(check-expect (change-direction (make-worm (list (make-posn 4 4)) "down" (make-posn 3 4)) "right")
              (make-worm (list (make-posn 4 4)) "right" (make-posn 3 4)))
(check-expect (change-direction (make-worm (list (make-posn 4 4)) "left" (make-posn 3 4)) "right")
              (make-worm (list (make-posn 4 4)) "left" (make-posn 3 4)))
(check-expect (change-direction (make-worm (list (make-posn 4 4) (make-posn 3 8)) "right" (make-posn 3 4)) "up")
              (make-worm (list (make-posn 4 4) (make-posn 3 8)) "up" (make-posn 3 4)))
(check-expect (change-direction (make-worm (list (make-posn 4 4) (make-posn 3 8)) "up" (make-posn 3 4)) "left")
              (make-worm (list (make-posn 4 4) (make-posn 3 8)) "left" (make-posn 3 4)))
(check-expect (change-direction (make-worm (list (make-posn 4 4) (make-posn 3 8)) "down" (make-posn 3 4)) "down")
              (make-worm (list (make-posn 4 4) (make-posn 3 8)) "down" (make-posn 3 4)))
(check-expect (change-direction (make-worm (list (make-posn 4 4) (make-posn 3 8)) "left" (make-posn 3 4)) "right")
              (make-worm (list (make-posn 4 4) (make-posn 3 8)) "left" (make-posn 3 4)))
(define (change-direction ws key)
  (cond
    [(and (string=? key "right") (not (string=? (worm-direction ws) "left")))
     (make-worm (worm-positions ws) key (worm-food ws))]
    [(and (string=? key "left") (not (string=? (worm-direction ws) "right")))
     (make-worm (worm-positions ws) key (worm-food ws))]
    [(and (string=? key "up") (not (string=? (worm-direction ws) "down")))
     (make-worm (worm-positions ws) key (worm-food ws))]
    [(and (string=? key "down") (not (string=? (worm-direction ws) "up")))
     (make-worm (worm-positions ws) key (worm-food ws))]
    [else ws]))

; WormState -> WormState
; produces new WormState by moving the worm is specified direction
(check-expect (tock (make-worm (list (make-posn 2 2)) "right" (make-posn 9 6)))
              (make-worm (list (make-posn 3 2)) "right" (make-posn 9 6)))
(check-expect (tock (make-worm (list (make-posn 2 2)) "up" (make-posn 9 6)))
              (make-worm (list (make-posn 2 1)) "up" (make-posn 9 6)))
(check-expect (tock (make-worm (list (make-posn 2 2)) "down" (make-posn 9 6)))
              (make-worm (list (make-posn 2 3)) "down" (make-posn 9 6)))
(check-expect (tock (make-worm (list (make-posn 2 2)) "left" (make-posn 9 6)))
              (make-worm (list (make-posn 1 2)) "left" (make-posn 9 6)))
(check-expect (tock (make-worm (list (make-posn 4 4) (make-posn 4 5) (make-posn 5 5)) "right" (make-posn 9 6)))
              (make-worm (list (make-posn 5 4) (make-posn 4 4) (make-posn 4 5)) "right" (make-posn 9 6)))
(check-expect (tock (make-worm (list (make-posn 4 4) (make-posn 4 5) (make-posn 5 5)) "left" (make-posn 9 6)))
              (make-worm (list (make-posn 3 4) (make-posn 4 4) (make-posn 4 5)) "left" (make-posn 9 6)))
(check-expect (tock (make-worm (list (make-posn 4 4) (make-posn 4 5) (make-posn 5 5)) "up" (make-posn 9 6)))
              (make-worm (list (make-posn 4 3) (make-posn 4 4) (make-posn 4 5)) "up" (make-posn 9 6)))
(check-random (tock (make-worm (list (make-posn 8 6)) "right" (make-posn 9 6)))
              (make-worm (list (make-posn 9 6) (make-posn 8 6)) "right" (food-create (make-posn 9 6))))
(check-random (tock (make-worm (list (make-posn 10 6)) "left" (make-posn 9 6)))
              (make-worm (list (make-posn 9 6) (make-posn 10 6)) "left" (food-create (make-posn 9 6))))
(check-random (tock (make-worm (list (make-posn 9 7)) "up" (make-posn 9 6)))
              (make-worm (list (make-posn 9 6) (make-posn 9 7)) "up" (food-create (make-posn 9 6))))
(check-random (tock (make-worm (list (make-posn 9 5)) "down" (make-posn 9 6)))
              (make-worm (list (make-posn 9 6) (make-posn 9 5)) "down" (food-create (make-posn 9 6))))
(define (tock ws)
  (if (eat-food-now? ws)
      (make-worm (move-worm (worm-positions ws) (worm-direction ws))
                 (worm-direction ws)
                 (food-create (worm-food ws)))
      (make-worm (remove-last (move-worm (worm-positions ws) (worm-direction ws)))
                 (worm-direction ws)
                 (worm-food ws))))

; WormState -> Boolean
; returns #true if worm will eat food on moving
(check-expect (eat-food-now? (make-worm (list (make-posn 2 2)) "right" (make-posn 9 6))) #false)
(check-expect (eat-food-now? (make-worm '() "right" (make-posn 9 6))) #false)
(check-expect (eat-food-now? (make-worm (list (make-posn 8 6)) "right" (make-posn 9 6))) #true)
(check-expect (eat-food-now? (make-worm (list (make-posn 10 6)) "left" (make-posn 9 6))) #true)
(check-expect (eat-food-now? (make-worm (list (make-posn 9 7)) "up" (make-posn 9 6))) #true)
(check-expect (eat-food-now? (make-worm (list (make-posn 9 5)) "down" (make-posn 9 6))) #true)
(define (eat-food-now? ws)
  (cond
    [(empty? (worm-positions ws)) #false]
    [(and (string=? (worm-direction ws) "right")
          (= (posn-x (worm-food ws)) (+ (posn-x (first (worm-positions ws))) 1))
          (= (posn-y (worm-food ws)) (posn-y (first (worm-positions ws))))) #true]
    [(and (string=? (worm-direction ws) "left")
          (= (posn-x (worm-food ws)) (- (posn-x (first (worm-positions ws))) 1))
          (= (posn-y (worm-food ws)) (posn-y (first (worm-positions ws))))) #true]
    [(and (string=? (worm-direction ws) "down")
          (= (posn-x (worm-food ws)) (posn-x (first (worm-positions ws))))
          (= (posn-y (worm-food ws)) (+ (posn-y (first (worm-positions ws))) 1))) #true]
    [(and (string=? (worm-direction ws) "up")
          (= (posn-x (worm-food ws)) (posn-x (first (worm-positions ws))))
          (= (posn-y (worm-food ws)) (- (posn-y (first (worm-positions ws))) 1))) #true]
    [else #false]))

; List -> List
; removes last element of given non-emply list
(check-expect (remove-last (list "a")) '())
(check-expect (remove-last (list "a" "b")) (list "a"))
(check-expect (remove-last (list "a" "b" "c")) (list "a" "b"))
(define (remove-last l)
  (cond
    [(empty? (rest l)) '()]
    [else (cons (first l) (remove-last (rest l)))]))

; List-of-Posns String -> List-of-Posns
; creates another posn in List-of-Posns in given direction
(check-expect (move-worm (list (make-posn 2 2)) "right") (list (make-posn 3 2) (make-posn 2 2)))
(check-expect (move-worm (list (make-posn 2 2)) "up") (list (make-posn 2 1) (make-posn 2 2)))
(check-expect (move-worm (list (make-posn 2 2)) "down") (list (make-posn 2 3) (make-posn 2 2)))
(check-expect (move-worm (list (make-posn 2 2)) "left") (list (make-posn 1 2) (make-posn 2 2)))
(check-expect (move-worm (list (make-posn 4 4) (make-posn 4 5) (make-posn 5 5)) "right")
              (list (make-posn 5 4) (make-posn 4 4) (make-posn 4 5) (make-posn 5 5)))
(check-expect (move-worm (list (make-posn 4 4) (make-posn 4 5) (make-posn 5 5)) "left")
              (list (make-posn 3 4) (make-posn 4 4) (make-posn 4 5) (make-posn 5 5)))
(check-expect (move-worm (list (make-posn 4 4) (make-posn 4 5) (make-posn 5 5)) "up")
              (list (make-posn 4 3) (make-posn 4 4) (make-posn 4 5) (make-posn 5 5)))
(define (move-worm lop dir)
   (append
    (cond
      [(string=? dir "right") (list (make-posn (+ (posn-x (first lop)) 1) (posn-y (first lop))))]
      [(string=? dir "left") (list (make-posn (- (posn-x (first lop)) 1) (posn-y (first lop))))]
      [(string=? dir "down") (list (make-posn (posn-x (first lop)) (+ (posn-y (first lop)) 1)))]
      [(string=? dir "up") (list (make-posn (posn-x (first lop)) (- (posn-y (first lop)) 1)))]
      [else '()])
    lop))

; WormState -> Boolean
; returns #true if worm hit the wall
(check-expect (hit-border? (make-worm '() "right" (make-posn 9 6))) #false)
(check-expect (hit-border? (make-worm (list (make-posn 3 3)) "right" (make-posn 9 6))) #false)
(check-expect (hit-border? (make-worm (list (make-posn 0 3)) "down" (make-posn 9 6))) #true)
(check-expect (hit-border? (make-worm (list (make-posn 6 20)) "left" (make-posn 9 6))) #true)
(check-expect (hit-border? (make-worm (list (make-posn 5 6) (make-posn 18 12)) "up" (make-posn 9 6))) #true)
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
(check-expect (hit-itself? (make-worm '() "left" (make-posn 9 6))) #false)
(check-expect (hit-itself? (make-worm (list (make-posn 3 3)) "up" (make-posn 9 6))) #false)
(check-expect (hit-itself? (make-worm (list (make-posn 3 3) (make-posn 3 3)) "left" (make-posn 9 6))) #true)
(check-expect (hit-itself?
               (make-worm
                (list (make-posn 4 5) (make-posn 5 5) (make-posn 5 4) (make-posn 4 4) (make-posn 4 5))
                "right"
                (make-posn 9 6)))
              #true)
(check-expect (hit-itself?
               (make-worm
                (list (make-posn 4 5) (make-posn 5 5) (make-posn 5 4) (make-posn 4 4) (make-posn 4 3))
                "down"
                (make-posn 9 6)))
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
(check-expect (game-over? (make-worm '() "left" (make-posn 9 6))) #false)
(check-expect (game-over? (make-worm (list (make-posn 3 3)) "up" (make-posn 9 6))) #false)
(check-expect (game-over? (make-worm (list (make-posn 3 3) (make-posn 3 3)) "left" (make-posn 9 6))) #true)
(check-expect (game-over?
               (make-worm
                (list (make-posn 4 5) (make-posn 5 5) (make-posn 5 4) (make-posn 4 4) (make-posn 4 5))
                "right"
                (make-posn 9 6)))
              #true)
(check-expect (game-over?
               (make-worm
                (list (make-posn 4 5) (make-posn 5 5) (make-posn 5 4) (make-posn 4 4) (make-posn 4 3))
                "down"
                (make-posn 9 6)))
              #false)
(check-expect (game-over? (make-worm (list (make-posn 0 3)) "down" (make-posn 9 6))) #true)
(check-expect (game-over? (make-worm (list (make-posn 6 20)) "left" (make-posn 9 6))) #true)
(check-expect (game-over? (make-worm (list (make-posn 5 6) (make-posn 18 12)) "up" (make-posn 9 6))) #true)
(define (game-over? ws)
  (or (hit-border? ws) (hit-itself? ws)))

; WormState -> Image
; renders lose image
(check-error (render-final (make-worm '() "down" (make-posn 9 6))) NOT-FINAL-RENDER-ERROR) 
(check-error (render-final (make-worm (list (make-posn 1 1)) "up" (make-posn 9 6))) NOT-FINAL-RENDER-ERROR)
(check-expect (render-final (make-worm (list (make-posn 0 3)) "down" (make-posn 9 6)))
              (place-image (text TEXT-HIT-BORDER TEXT-SIZE "green")
                           (/ SCENE-SIZE 2)
                           (/ SCENE-SIZE 2)
                           (render (make-worm (list (make-posn 0 3)) "down" (make-posn 9 6)))))
(check-expect (render-final (make-worm (list (make-posn 6 20)) "left" (make-posn 9 6)))
              (place-image (text TEXT-HIT-BORDER TEXT-SIZE "green")
                           (/ SCENE-SIZE 2)
                           (/ SCENE-SIZE 2)
                           (render (make-worm (list (make-posn 6 20)) "left" (make-posn 9 6)))))
(check-expect (render-final (make-worm (list (make-posn 5 6) (make-posn 18 12)) "up" (make-posn 9 6)))
              (place-image (text TEXT-HIT-BORDER TEXT-SIZE "green")
                           (/ SCENE-SIZE 2)
                           (/ SCENE-SIZE 2)
                           (render (make-worm (list (make-posn 5 6) (make-posn 18 12)) "up" (make-posn 9 6)))))
(check-expect (render-final (make-worm (list (make-posn 0 3)) "down" (make-posn 9 6)))
              (place-image (text TEXT-HIT-BORDER TEXT-SIZE "green")
                           (/ SCENE-SIZE 2)
                           (/ SCENE-SIZE 2)
                           (render (make-worm (list (make-posn 0 3)) "down" (make-posn 9 6)))))
(check-expect (render-final (make-worm (list (make-posn 3 3) (make-posn 3 3)) "left" (make-posn 9 6)))
              (place-image (text TEXT-HIT-ITSELF TEXT-SIZE "green")
                           (/ SCENE-SIZE 2)
                           (/ SCENE-SIZE 2)
                           (render (make-worm (list (make-posn 3 3) (make-posn 3 3)) "left" (make-posn 9 6)))))
(check-expect (render-final
               (make-worm
                (list (make-posn 4 5) (make-posn 5 5) (make-posn 5 4) (make-posn 4 4) (make-posn 4 5))
                "right"
                (make-posn 9 6)))
              (place-image (text TEXT-HIT-ITSELF TEXT-SIZE "green")
                           (/ SCENE-SIZE 2)
                           (/ SCENE-SIZE 2)
                           (render
                            (make-worm
                             (list (make-posn 4 5) (make-posn 5 5) (make-posn 5 4) (make-posn 4 4) (make-posn 4 5))
                             "right"
                             (make-posn 9 6)))))
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