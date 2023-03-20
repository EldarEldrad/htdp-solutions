;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise_221) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define WIDTH 10) ; # of blocks, horizontally
(define HEIGHT 15) ; # of blocks, vertically
(define SIZE 10) ; blocks are squares
(define SCENE-WIDTH (* WIDTH SIZE))
(define SCENE-HEIGHT (* HEIGHT SIZE))
(define MT (empty-scene SCENE-WIDTH SCENE-HEIGHT))

(define BLOCK ; red squares with black rims
  (overlay
    (square (- SIZE 1) "solid" "red")
    (square SIZE "outline" "black")))

(define-struct tetris [block landscape])
(define-struct block [x y])
 
; A Tetris is a structure:
;   (make-tetris Block Landscape)
; A Landscape is one of: 
; – '() 
; – (cons Block Landscape)
; A Block is a structure:
;   (make-block N N)
 
; interpretations
; (make-block x y) depicts a block whose left 
; corner is (* x SIZE) pixels from the left and
; (* y SIZE) pixels from the top;
; (make-tetris b0 (list b1 b2 ...)) means b0 is the
; dropping block, while b1, b2, and ... are resting

(define landscape0 '())
(define landscape1 (list (make-block 0 (- HEIGHT 1))))
(define landscape2 (list (make-block 0 (- HEIGHT 1)) (make-block 0 (- HEIGHT 2))))
(define landscape3 (list (make-block 0 (- HEIGHT 1)) (make-block 0 (- HEIGHT 2)) (make-block 2 (- HEIGHT 1))))
(define block-dropping (make-block 5 3))
(define tetris0 (make-tetris block-dropping landscape0))
(define tetris1 (make-tetris block-dropping landscape1))
(define tetris2 (make-tetris block-dropping landscape2))
(define tetris3 (make-tetris block-dropping landscape3))

(define INITIAL (make-tetris (make-block 0 0) '()))

; Block -> Block 
; ???
(check-satisfied (generate-block (make-block 1 1)) not=-1-1?)
(define (generate-block p)
  (generate-block-check
     p (make-block (random WIDTH) 0)))
 
; Block Block -> Block 
; generative recursion 
; ???
(define (generate-block-check p candidate)
  (if (equal? p candidate)
      (generate-block p) candidate))
 
; Block -> Boolean
; use for testing only 
(define (not=-1-1? p)
  (not (and (= (block-x p) 1) (= (block-y p) 1))))

; Tetris -> Image
; renders Tetris game
(check-expect (tetris-render tetris0) (tetris-render/block block-dropping MT))
(check-expect (tetris-render tetris1)
              (tetris-render/block block-dropping (tetris-render/landscape landscape1 MT)))
(check-expect (tetris-render tetris2)
              (tetris-render/block block-dropping (tetris-render/landscape landscape2 MT)))
(check-expect (tetris-render tetris3)
              (tetris-render/block block-dropping (tetris-render/landscape landscape3 MT)))
(define (tetris-render t)
  (tetris-render/block (tetris-block t)
                       (tetris-render/landscape (tetris-landscape t)
                                                MT)))

; Landscape Image -> Image
; renders landscape on given image
(check-expect (tetris-render/landscape landscape0 MT) MT)
(check-expect (tetris-render/landscape landscape1 MT)
              (tetris-render/block (make-block 0 (- HEIGHT 1)) MT))
(check-expect (tetris-render/landscape landscape2 MT)
              (tetris-render/block (make-block 0 (- HEIGHT 1))
                                   (tetris-render/block (make-block 0 (- HEIGHT 2)) MT)))
(check-expect (tetris-render/landscape landscape3 MT)
              (tetris-render/block (make-block 0 (- HEIGHT 1))
                                   (tetris-render/block (make-block 0 (- HEIGHT 2))
                                                        (tetris-render/block (make-block 2 (- HEIGHT 1)) MT))))
(define (tetris-render/landscape l img)
  (cond
    [(empty? l) img]
    [else (tetris-render/block (first l)
                               (tetris-render/landscape (rest l) img))]))

; Block Image -> Image
; renders block on given image
(check-expect (tetris-render/block (make-block 0 0) MT) (place-image/align BLOCK 0 0 "left" "top" MT))
(check-expect (tetris-render/block block-dropping MT) (place-image/align BLOCK (* 5 SIZE) (* 3 SIZE) "left" "top" MT))
(check-expect (tetris-render/block (make-block (- WIDTH 1) (- HEIGHT 1)) MT)
              (place-image/align BLOCK SCENE-WIDTH SCENE-HEIGHT "right" "bottom" MT))
(define (tetris-render/block b img)
  (place-image/align BLOCK (* (block-x b) SIZE) (* (block-y b) SIZE) "left" "top" img))

; Tetris -> Tetris
; creates new Tetris state after one clock tick
(check-expect (tetris-tick tetris0) (make-tetris (make-block 5 4) landscape0))
(check-expect (tetris-tick tetris1) (make-tetris (make-block 5 4) landscape1))
(check-expect (tetris-tick tetris2) (make-tetris (make-block 5 4) landscape2))
(check-expect (tetris-tick tetris3) (make-tetris (make-block 5 4) landscape3))
(check-expect (tetris-tick INITIAL) (make-tetris (make-block 0 1) '()))
(check-random (tetris-tick (make-tetris (make-block 0 (- HEIGHT 2)) (list (make-block 0 (- HEIGHT 1)))))
              (make-tetris (generate-block (make-block 0 (- HEIGHT 2)))
                           (list (make-block 0 (- HEIGHT 2))
                                 (make-block 0 (- HEIGHT 1)))))
(check-random (tetris-tick (make-tetris (make-block 5 (- HEIGHT 1)) '()))
              (make-tetris (generate-block (make-block 5 (- HEIGHT 1)))
                           (list (make-block 5 (- HEIGHT 1)))))
(define (tetris-tick t)
  (if (or (= (block-y (tetris-block t)) (- HEIGHT 1))
          (member? (make-block (block-x (tetris-block t)) (+ 1 (block-y (tetris-block t))))
                   (tetris-landscape t)))
      (make-tetris (generate-block (tetris-block t))
                   (cons (tetris-block t) (tetris-landscape t)))
      (make-tetris (make-block (block-x (tetris-block t)) (+ 1 (block-y (tetris-block t))))
                   (tetris-landscape t))))

; Tetris -> Tetris
; main function
(define (tetris-main rate)
  (big-bang INITIAL
    [to-draw tetris-render]
    [on-tick tetris-tick rate]))