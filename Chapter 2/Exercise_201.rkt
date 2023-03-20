;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise_201) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
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
(define ltracks-example-4 (list track-example-1 track-example-2 track-example-1))

; LTracks -> List-of-Strings
; consumes an LTracks and produces the list of album titles
(check-expect (select-all-album-titles ltracks-example-1) '())
(check-expect (select-all-album-titles ltracks-example-2) (list "Best hits"))
(check-expect (select-all-album-titles ltracks-example-3) (list "Best hits" "The Best"))
(check-expect (select-all-album-titles ltracks-example-4) (list "Best hits" "The Best" "Best hits"))
(define (select-all-album-titles lt)
  (cond
    [(empty? lt) '()]
    [else (cons (track-album (first lt))
                (select-all-album-titles (rest lt)))]))

; List-of-Strings -> List-of-Strings
; consumes a List-of-strings and constructs one that contains every String from the given list exactly once
(check-expect (create-set '()) '())
(check-expect (create-set (list "a")) (list "a"))
(check-expect (create-set (list "a" "b")) (list "a" "b"))
(check-expect (create-set (list "c" "c")) (list "c"))
(check-expect (create-set (list "a" "b" "c")) (list "a" "b" "c"))
(check-expect (create-set (list "a" "b" "a")) (list "b" "a"))
(define (create-set los)
  (cond
    [(empty? los) '()]
    [(member? (first los) (rest los)) (create-set (rest los))]
    [else (cons (first los) (create-set (rest los)))]))

; LTracks -> List-of-Strings
; consumes an LTracks and produces a list of unique album titles
(check-expect (select-album-titles/unique ltracks-example-1) '())
(check-expect (select-album-titles/unique ltracks-example-2) (list "Best hits"))
(check-expect (select-album-titles/unique ltracks-example-3) (list "Best hits" "The Best"))
(check-expect (select-album-titles/unique ltracks-example-4) (list "The Best" "Best hits"))
(define (select-album-titles/unique lt)
  (create-set (select-all-album-titles lt)))