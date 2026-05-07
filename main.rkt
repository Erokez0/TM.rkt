#lang racket

(require "gui/gui.rkt")
(require "cli/cli.rkt")

(define (main)
  (match (vector-ref (current-command-line-arguments) 0))
  [("--gui") (start-gui)]
  [("--cli") (start-cli)]
  [(_) (error "usage: --gui / --cli")]
  )

(main)
