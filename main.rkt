#lang racket

(require "gui.rkt")
(require "cli.rkt")

(define (main)
  (when (= (vector-length (current-command-line-arguments)) 0)
    (error "usage: --gui / --cli")
    )
  (match (vector-ref (current-command-line-arguments) 0)
    ["--gui" (start-gui)]
    ["--cli" (start-cli)]
    [_ (error "usage: --gui / --cli")]
    )
  )

(main)
