#lang racket

(require "consts.rkt")
(require "rules.rkt")



;; rules[state][instruction] -> '(state instruction direction)
(define/contract (process-instruction rules instruction state)
  (-> hash? string? string? list?)
  (unless (hash-has-key? rules state)
    (error (format "rules for state \"~a\" are not defined" state)))

  (define instruction-hash (hash-ref rules state))

  (unless (hash-has-key? instruction-hash instruction)
    (error (format "rules for state \"~a\" with instruction \"~a\" are not defined" state instruction)))

  (hash-ref instruction-hash instruction)
  )

(define/contract (move-position position direction)
  (-> number? string? number?)
  (match direction
    [LEFT (- position 1)]
    [RIGHT (+ position 1)]
    [_ (error "invalid direction")]
    )
  )

(define/contract (interpret tape rules)
  (-> (listof string?) hash? (listof string?))
  (define starting-state START)
  (define starting-position 0)

  (define/contract (loop tape rules state position)
    (-> (listof string?) hash? string? number? (listof string?))
    (when (= position (length tape))
      (set! position 0)
      )
    (define instruction (list-ref tape position))
    (define result (process-instruction rules instruction state))
    (define new-state (car result))
    (define new-instruction (cadr result))
    (define direction (caddr result))
    (define new-position (move-position position direction))
    (define processed-tape (list-set tape position new-instruction))

    (if
      (equal? new-state END)
      processed-tape
      (loop processed-tape rules new-state new-position)
      )
    )

  (loop tape rules starting-state starting-position)
  )


;;
;; (define example-rules (make-rules))
;; (add-rule example-rules "Q0" "1" (list "Q1" "x" RIGHT))
;; (add-rule example-rules START "1" (list END "x" RIGHT))
;;
;; (interpret (list "1") example-rules)
;;
(provide interpret)
