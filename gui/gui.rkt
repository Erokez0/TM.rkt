#lang racket

(require racket/gui)

(define frame (new frame% [label "Example"]))

; Show the frame by calling its show method
(send frame show #t)

(define (start-gui)
  (let [(frame (new frame% [label "TM.rkt"] [width 400] [height 300]))]
    (send frame show #t)
    )
  )


(provide start-gui)
