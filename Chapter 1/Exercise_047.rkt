;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_47) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; The HappinessLevel is a Number
; represents happiness level between 0 and MAXIMUM-HAPPINESS

(define MINIMUM-HAPPINESS 0)
(define MAXIMUM-HAPPINESS 100)
(define HAPPINESS-STEP 0.1)
(define HAPPINESS-DECREASE 1/5)
(define HAPPINESS-INCREASE 1/3)

(define GAUGE-HEIGHT 400)
(define GAUGE-WIDTH 100)

(define MT (empty-scene GAUGE-WIDTH GAUGE-HEIGHT))

; HappinessLevel -> HappinessLevel
; decrease current h by HAPPINESS-STEP
(check-expect (tock (/ MAXIMUM-HAPPINESS 2)) (- (/ MAXIMUM-HAPPINESS 2) HAPPINESS-STEP))
(check-expect (tock MAXIMUM-HAPPINESS) (- MAXIMUM-HAPPINESS HAPPINESS-STEP))
(check-expect (tock MINIMUM-HAPPINESS) MINIMUM-HAPPINESS)
(check-expect (tock (+ MINIMUM-HAPPINESS (/ HAPPINESS-STEP 2))) MINIMUM-HAPPINESS)
(define (tock h)
      (max (- h HAPPINESS-STEP) MINIMUM-HAPPINESS))

; HappinessLevel -> Image
; renders happiness gauge based on current h
(check-expect (render MAXIMUM-HAPPINESS) (overlay (rectangle GAUGE-WIDTH GAUGE-HEIGHT "solid" "red") MT))
(check-expect (render MINIMUM-HAPPINESS) MT)
(check-expect (render (/ (+ MAXIMUM-HAPPINESS MINIMUM-HAPPINESS) 2))
              (overlay/align "middle" "bottom" (rectangle GAUGE-WIDTH (/ GAUGE-HEIGHT 2) "solid" "red") MT))
(define (render h)
  (overlay/align "middle" "bottom"
                 (rectangle GAUGE-WIDTH
                            (* GAUGE-HEIGHT (/ h (+ MAXIMUM-HAPPINESS MINIMUM-HAPPINESS)))
                            "solid" "red")
                 MT))

; HappinessLevel KeyEvent -> HappinessLevel
; increase or decrease happiness level based on key pressed
(check-expect (press MAXIMUM-HAPPINESS "h") MAXIMUM-HAPPINESS)
(check-expect (press MAXIMUM-HAPPINESS "up") MAXIMUM-HAPPINESS)
(check-expect (press MAXIMUM-HAPPINESS "down") (- MAXIMUM-HAPPINESS HAPPINESS-DECREASE))
(check-expect (press MINIMUM-HAPPINESS "h") MINIMUM-HAPPINESS)
(check-expect (press MINIMUM-HAPPINESS "up") (+ MINIMUM-HAPPINESS HAPPINESS-INCREASE))
(check-expect (press MINIMUM-HAPPINESS "down") MINIMUM-HAPPINESS)
(check-expect (press (/ (+ MAXIMUM-HAPPINESS MINIMUM-HAPPINESS) 2) "h")
              (/ (+ MAXIMUM-HAPPINESS MINIMUM-HAPPINESS) 2))
(check-expect (press (/ (+ MAXIMUM-HAPPINESS MINIMUM-HAPPINESS) 2) "up")
              (+ (/ (+ MAXIMUM-HAPPINESS MINIMUM-HAPPINESS) 2) HAPPINESS-INCREASE))
(check-expect (press (/ (+ MAXIMUM-HAPPINESS MINIMUM-HAPPINESS) 2) "down")
              (- (/ (+ MAXIMUM-HAPPINESS MINIMUM-HAPPINESS) 2) HAPPINESS-DECREASE))
(define (press h ke)
  (cond
    [(key=? ke "up") (min MAXIMUM-HAPPINESS (+ h HAPPINESS-INCREASE))]
    [(key=? ke "down") (max MINIMUM-HAPPINESS (- h HAPPINESS-DECREASE))]
    [else h]))

(define (main h)
  (big-bang MAXIMUM-HAPPINESS
    [on-tick tock]
    [to-draw render]
    [on-key press]))