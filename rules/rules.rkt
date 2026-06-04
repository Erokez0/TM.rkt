#lang racket

(define/contract (make-rules)
  (-> hash?)
  (make-hash)
  )

(define (add-rule rules state instruction result)
  (-> hash? string? string? list? void?)
  (hash-set!
    rules state
    (make-hash
      (list
        (cons
          instruction
          result
          )
        )
      )
    )
  )


(provide make-rules add-rule)
