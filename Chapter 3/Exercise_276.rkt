;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_276) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
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

; String Date LTracks -> LTracks
; extracts from the LTracks the list of tracks
; that belong to the given album and have been played after the given date
(check-expect (select-album-date "Best hits" (make-date 2016 1 1 0 0 0) ltracks-example-1) '())
(check-expect (select-album-date "Best hits" (make-date 2016 1 1 0 0 0) ltracks-example-2)
              ltracks-example-2)
(check-expect (select-album-date "Best hits" (make-date 2017 1 1 0 0 0) ltracks-example-2) '())
(check-expect (select-album-date "The Best" (make-date 2016 1 1 0 0 0) ltracks-example-2) '())
(check-expect (select-album-date "Best hits" (make-date 2016 1 1 0 0 0) ltracks-example-3) ltracks-example-2)
(check-expect (select-album-date "Best hits" (make-date 2022 1 1 0 0 0) ltracks-example-3) '())
(check-expect (select-album-date "The Best" (make-date 2016 1 1 0 0 0) ltracks-example-3)
              (list track-example-2))
(check-expect (select-album-date "Best hits" (make-date 2016 1 1 0 0 0) ltracks-example-4)
              (list track-example-1 track-example-1))
(check-expect (select-album-date "Best hits" (make-date 2018 1 1 0 0 0) ltracks-example-4) '())
(check-expect (select-album-date "The Best" (make-date 2016 1 1 0 0 0) ltracks-example-4) (list track-example-2))
(check-expect (select-album-date "The Best" (make-date 2022 1 1 0 0 0) ltracks-example-4) '())
(define (select-album-date album date lt)
  (local ((define (filter-album-date track)
            (and (string=? album (track-album track)) (date>? (track-played track) date))))
    (filter filter-album-date lt)))

; Date Date -> Boolean
; returns true if first date greater than second
(check-expect (date>? (make-date 2014 1 1 0 0 0) (make-date 2014 1 1 0 0 0)) #false)
(check-expect (date>? (make-date 2015 1 1 0 0 0) (make-date 2014 1 1 0 0 0)) #true)
(check-expect (date>? (make-date 2014 1 1 0 0 0) (make-date 2015 1 1 0 0 0)) #false)
(check-expect (date>? (make-date 2014 2 1 0 0 0) (make-date 2014 1 1 0 0 0)) #true)
(check-expect (date>? (make-date 2014 1 1 0 0 0) (make-date 2014 2 1 0 0 0)) #false)
(check-expect (date>? (make-date 2014 1 2 0 0 0) (make-date 2014 1 1 0 0 0)) #true)
(check-expect (date>? (make-date 2014 1 1 0 0 0) (make-date 2014 1 2 0 0 0)) #false)
(check-expect (date>? (make-date 2014 1 1 5 0 0) (make-date 2014 1 1 0 0 0)) #true)
(check-expect (date>? (make-date 2014 1 1 0 0 0) (make-date 2014 1 1 5 0 0)) #false)
(check-expect (date>? (make-date 2014 1 1 0 5 0) (make-date 2014 1 1 0 0 0)) #true)
(check-expect (date>? (make-date 2014 1 1 0 0 0) (make-date 2014 1 1 0 5 0)) #false)
(check-expect (date>? (make-date 2014 1 1 0 0 5) (make-date 2014 1 1 0 0 0)) #true)
(check-expect (date>? (make-date 2014 1 1 0 0 0) (make-date 2014 1 1 0 0 5)) #false)
(define (date>? date1 date2)
  (cond [(> (date-year date1) (date-year date2)) #true]
        [(< (date-year date1) (date-year date2)) #false]
        [else
         (cond [(> (date-month date1) (date-month date2)) #true]
               [(< (date-month date1) (date-month date2)) #false]
               [else
                (cond [(> (date-day date1) (date-day date2)) #true]
                      [(< (date-day date1) (date-day date2)) #false]
                      [else
                       (cond [(> (date-hour date1) (date-hour date2)) #true]
                             [(< (date-hour date1) (date-hour date2)) #false]
                             [else
                              (cond [(> (date-minute date1) (date-minute date2)) #true]
                                    [(< (date-minute date1) (date-minute date2)) #false]
                                    [else (> (date-second date1) (date-second date2))])])])])]))

; LTracks -> List-of-LTracks
; produces a list of LTracks, one per album.
; Each album is uniquely identified by its title and shows up in the result only once
(check-expect (select-albums ltracks-example-1) '())
(check-expect (select-albums ltracks-example-2) (list ltracks-example-2))
(check-expect (select-albums ltracks-example-3) (list (list track-example-1) (list track-example-2)))
(check-expect (select-albums ltracks-example-4)
              (list (list track-example-2) (list track-example-1 track-example-1)))
(define (select-albums lts)
  (create-lists-by-albums (select-album-titles/unique lts) lts))

; List-of-Strings LTracks -> List-of-LTracks
; creates a list of LTracks, one per given album from alist
(check-expect (create-lists-by-albums '() ltracks-example-1) '())
(check-expect (create-lists-by-albums (list "Best hits" "The Best") ltracks-example-1) (list '() '()))
(check-expect (create-lists-by-albums (list "Best hits") ltracks-example-2) (list ltracks-example-2))
(check-expect (create-lists-by-albums (list "The Best") ltracks-example-2) (list'()))
(check-expect (create-lists-by-albums (list "Best hits" "The Best") ltracks-example-3)
              (list (list track-example-1) (list track-example-2)))
(check-expect (create-lists-by-albums (list "Best hits" "The Best") ltracks-example-4)
              (list (list track-example-1 track-example-1) (list track-example-2)))
(check-expect (create-lists-by-albums (list "The Best" "Best hits") ltracks-example-4)
              (list (list track-example-2) (list track-example-1 track-example-1)))
(check-expect (create-lists-by-albums (list "Best hits") ltracks-example-4)
              (list (list track-example-1 track-example-1)))
(check-expect (create-lists-by-albums (list "The Best") ltracks-example-4)
              (list (list track-example-2)))
(check-expect (create-lists-by-albums '() ltracks-example-1) '())
(define (create-lists-by-albums alist lts)
  (local ((define (select-by-album album)
            (select-album album lts)))
  (map select-by-album alist)))

; LTracks -> List-of-Strings
; consumes an LTracks and produces the list of album titles
(check-expect (select-all-album-titles ltracks-example-1) '())
(check-expect (select-all-album-titles ltracks-example-2) (list "Best hits"))
(check-expect (select-all-album-titles ltracks-example-3) (list "Best hits" "The Best"))
(check-expect (select-all-album-titles ltracks-example-4) (list "Best hits" "The Best" "Best hits"))
(define (select-all-album-titles lt)
  (map track-album lt))

; List-of-Strings -> List-of-Strings
; consumes a List-of-strings and constructs one that contains every String from the given list exactly once
(check-expect (create-set '()) '())
(check-expect (create-set (list "a")) (list "a"))
(check-expect (create-set (list "a" "b")) (list "a" "b"))
(check-expect (create-set (list "c" "c")) (list "c"))
(check-expect (create-set (list "a" "b" "c")) (list "a" "b" "c"))
(check-expect (create-set (list "a" "b" "a")) (list "b" "a"))
(define (create-set los)
  (local ((define (filter-set s set)
            (if (member? s set)
                set
                (cons s set))))
    (foldr filter-set '() los)))

; LTracks -> List-of-Strings
; consumes an LTracks and produces a list of unique album titles
(check-expect (select-album-titles/unique ltracks-example-1) '())
(check-expect (select-album-titles/unique ltracks-example-2) (list "Best hits"))
(check-expect (select-album-titles/unique ltracks-example-3) (list "Best hits" "The Best"))
(check-expect (select-album-titles/unique ltracks-example-4) (list "The Best" "Best hits"))
(define (select-album-titles/unique lt)
  (create-set (select-all-album-titles lt)))

; String LTracks -> LTracks
; extracts from the LTracks the list of tracks that belong to the given album
(check-expect (select-album "Best hits" ltracks-example-1) '())
(check-expect (select-album "Best hits" ltracks-example-2) ltracks-example-2)
(check-expect (select-album "The Best" ltracks-example-2) '())
(check-expect (select-album "Best hits" ltracks-example-3) ltracks-example-2)
(check-expect (select-album "The Best" ltracks-example-3) (list track-example-2))
(check-expect (select-album "Best hits" ltracks-example-4) (list track-example-1 track-example-1))
(check-expect (select-album "The Best" ltracks-example-4) (list track-example-2))
(define (select-album album lt)
   (local ((define (filter-album t)
            (string=? album (track-album t))))
    (filter filter-album lt)))