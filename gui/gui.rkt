#lang racket

(require racket/gui)

(define rules (make-hash))
(define (start-gui)
  (define frame (new frame% [label "TM.rkt"] [width 400] [height 300]))
  (define title (new message% [label "Панель управления ТМ"] [parent frame]))
  (define import-panel (new vertical-panel% [parent frame]))
  (define import-title (new message% [parent import-panel] [label "Загрузить файл"]))
  (define upload-file-button
    (new button%
      [parent import-panel]
      [label "Загрузить файл"]
      [stretchable-width #t]
      [stretchable-height #t]
      [style '(multi-line)]
      [callback (lambda (tf evt)
                  (set! rules (file->string (get-file)))
                  )])
    )
  (define editor-panel (new vertical-panel% [parent frame]))
  (define editor-title (new message% [parent editor-panel] [label "Редактор переходов"]))
  (define add-transition
    (new button%
      [parent editor-panel]
      [label "Нажми"]
      [callback
       (lambda (tf evt)
         (define new-shit (new message% [parent editor-panel] [label "шок"]))
         (void)
         )]))

  (send frame show #t)

  )


(provide start-gui)
