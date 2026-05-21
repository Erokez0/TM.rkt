#lang racket

(require "../interpreter/interpreter.rkt")
(require "../rules/rules.rkt")

(define-syntax interpret!
  (syntax-rules ()
    [
     (_ rules arg ...)
     (interpret '(arg ...) rules)
     ]
    )
  )

;; EXAMPLE
;;
;;(make-rules! (Q0 1 ->))
;;
;;
;;
(define-syntax make-rules!
  (syntax-rules ()
    [
     (_ ...)
     (make-rules)
     ]
    )
  )

(define-syntax add-rule!
  (syntax-rules ()
    [
     (_ rules state instruction -> result ...)
     (add-rule rules state instruction (list result ...))
     ]
    )
  )

(define rules (make-rules))
;; (add-rule! 'Q0 'x -> 'Q1 'x 'RIGHT)


(provide interpret!)
