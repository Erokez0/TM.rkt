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

(define (delete-rule rules state instruction)
  (-> hash? string? string? void?)
  (hash-update!
    rules state
    (lambda (instruction-hash)
      (hash-remove instruction-hash instruction)
      )
    )
  )

(provide make-rules add-rule delete-rule)
