#lang racket
(require "../interpreter/interpreter.rkt")

(define-syntax interpret!
  (syntax-rules ()
    [
     (_ ...rest)
     (interpret '(...rest))
     ]
    )
  )

(provide interpret!)
