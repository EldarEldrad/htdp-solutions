;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_27) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define FIXED-COST 180)
(define COST-PER-ATTENDEE 0.04)
(define ATTENDEE-AT-BASIC-COST 120)
(define BASIC-COST 5.0)
(define COST-STEP 0.1)
(define PEOPLE-STEP 15)

(define (attendees ticket-price)
  (- ATTENDEE-AT-BASIC-COST (* (- ticket-price BASIC-COST) (/ PEOPLE-STEP COST-STEP))))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
  (+ FIXED-COST (* COST-PER-ATTENDEE (attendees ticket-price))))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))