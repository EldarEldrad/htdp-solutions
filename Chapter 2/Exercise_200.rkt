;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise_200) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; An LTracks is one of:
; – '()
; – (cons Track LTracks)

(define-struct track
  [name artist album time track# added play# played])
; A Track is a structure:
;   (make-track String String String N N Date N Date)
; interpretation An instance records in order: the track's 
; title, its producing artist, to which album it belongs, 
; its playing time in milliseconds, its position within the 
; album, the date it was added, how often it has been 
; played, and the date when it was last played

(define-struct date [year month day hour minute second])
; A Date is a structure:
;   (make-date N N N N N N)
; interpretation An instance records six pieces of information:
; the date's year, month (between 1 and 12 inclusive), 
; day (between 1 and 31), hour (between 0 
; and 23), minute (between 0 and 59), and 
; second (also between 0 and 59).

(define date-example-1 (make-date 2006 9 14 18 36 10))
(define date-example-2 (make-date 2016 2 12 12 15 18))
(define date-example-3 (make-date 2018 10 3 9 2 1))
(define date-example-4 (make-date 2021 6 29 23 18 42))

(define track-example-1 (make-track "Money" "Pink Floyd" "Best hits" 220000 2 date-example-1 6 date-example-2))
(define track-example-2 (make-track "Rasputin" "Boney M" "The Best" 316345 4 date-example-3 13 date-example-4))

(define ltracks-example-1 '())
(define ltracks-example-2 (list track-example-1))
(define ltracks-example-3 (list track-example-1 track-example-2))

; LTracks -> Number
; consumes an element of LTracks and produces the total amount of play time
(check-expect (total-time ltracks-example-1) 0)
(check-expect (total-time ltracks-example-2) 220000)
(check-expect (total-time ltracks-example-3) (+ 220000 316345))
(define (total-time lts)
  (cond
    [(empty? lts) 0]
    [else (+ (track-time (first lts))
             (total-time (rest lts)))]))