;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_510) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; N String String -> String?
; reads all the words from the in-f, arranges these words in the given order into lines of maximal width w
; and writes these lines to out-f
(define (fmt w in-f out-f)
  (local ((define words (read-words in-f))
          (define (fmt-internal/a low result)
            (cond
              [(empty? low) result]
              [(<= (+ (string-length (first low)) (string-length (first result)) 1) w)
               (fmt-internal/a (rest low)
                               (cons (string-append (first result) " " (first low))
                                     (rest result)))]
              [else (fmt-internal/a (rest low)
                                    (cons (first low)
                                          (cons (string-append (first result) "\n")
                                                (rest result))))])))
    (write-file out-f (foldl string-append "" (fmt-internal/a (rest words) (list (first words)))))))

(fmt 15 "in-f.dat" "out-f.dat")