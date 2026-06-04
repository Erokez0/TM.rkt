#lang racket

(require racket/gui)
(require racket/string)

(require "interpreter.rkt")
(require "rules.rkt")
(require "consts.rkt")

(define rules (make-rules))

(define (add-transition-element table-panel state-column symbol-column new-state-column new-symbol-column direction-column delete-column confirm-column)
  (define state-input (new text-field% [parent state-column] [init-value ""] [label ""]))
  (define symbol-input (new text-field% [parent symbol-column] [init-value ""] [label ""]))
  (define new-state-input (new text-field% [parent new-state-column] [init-value ""] [label ""]))
  (define new-symbol-input (new text-field% [parent new-symbol-column] [init-value ""] [label ""]))
  (define direction-input (new choice% [parent direction-column] [choices '("Налево" "Направо")] [label ""]))

  (define delete-button
    (new button%
      [parent delete-column]
      [label "Удалить"]
      [callback
       (lambda (b e)
         (begin
           (send state-column delete-child state-input)
           (send symbol-column delete-child symbol-input)
           (send new-state-column delete-child new-state-input)
           (send new-symbol-column delete-child new-symbol-input)
           (send direction-column delete-child direction-input)
           (send delete-column delete-child delete-button)
           (send confirm-column delete-child confirm-button)
           (void)
           )
         )
       ]
      )
    )

  (define confirm-button
    (new button%
      [parent confirm-column]
      [label "Подтвердить"]
      [callback
       (lambda (b e)
         (begin
           (define state (send state-input get-value))
           (define symbol (send symbol-input get-value))
           (define new-symbol (send new-symbol-input get-value))
           (define new-state (send new-state-input get-value))
           (define direction
             (if (equal? (send direction-input get-string-selection) "Налево")
                 LEFT
                 RIGHT
                 )
             )
           (define result (list new-state new-symbol direction))
           (add-rule rules state symbol result)
           (void)
           )
         )
       ]
      )
    )
  (void)
  )

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
      [callback
       (lambda (tf evt)
         ;; (set! rules (file->string (get-file)))
         (message-box
           "Загрузка файла"
           "На данный момент зазгрузка файла не реализована, но спасибо"
           )
         )
       ]
      )
    )


  (define editor-panel (new vertical-panel% [parent frame]))
  (define editor-title (new message% [parent editor-panel] [label "Редактор переходов"]))

  (define transition-table
    (new horizontal-panel% [parent editor-panel]
      [stretchable-width #t]
      [stretchable-height #t]))

  (define state-column
    (new vertical-panel%
      [parent transition-table]
      [stretchable-width #f]
      )
    )
  (new message% [parent state-column] [label "Состояние"])


  (define symbol-column
    (new vertical-panel%
      [parent transition-table]
      [stretchable-width #f]
      )
    )
  (new message% [parent symbol-column] [label "Символ"])


  (define new-state-column
    (new vertical-panel%
      [parent transition-table]
      [stretchable-width #f]
      )
    )
  (new message% [parent new-state-column] [label "Новое состояние"])

  (define new-symbol-column
    (new vertical-panel%
      [parent transition-table]
      [stretchable-width #f]
      )
    )
  (new message% [parent new-symbol-column] [label "Запись"])

  (define direction-column
    (new vertical-panel%
      [parent transition-table]
      [stretchable-width #f]
      )
    )
  (new message% [parent direction-column] [label "Направление"])

  (define delete-column
    (new vertical-panel%
      [parent transition-table]
      [stretchable-width #f]
      )
    )
  (new message% [parent delete-column] [label "✏️"])

  (define confirm-column
    (new vertical-panel%
      [parent transition-table]
      [stretchable-width #f]
      )
    )
  (new message% [parent confirm-column] [label "🔞"])


  (define add-transition
    (new button%
      [parent editor-panel]
      [label "Добавить переход"]
      [callback
       (lambda (tf evt)
         (add-transition-element transition-table state-column symbol-column new-state-column new-symbol-column direction-column delete-column confirm-column)
         )
       ]
      )
    )

  (define (on-process tf evt)
    (define tape (string-split (send tape-input get-value) " "))
    (define result-tape (interpret tape rules))
    (define result-tape-str (string-join result-tape " "))
    (send tape-input set-value result-tape-str)
    )

  (define tape-panel (new horizontal-panel% [parent frame]))
  (define tape-title (new message% [parent tape-panel] [label "Лента"]))
  (define tape-input (new text-field% [parent tape-panel] [init-value ""] [label ""]))
  (define proccess-tape-button
    (new button%
      [parent tape-panel]
      [label "Запустить"]
      [callback on-process]
      )
    )

  (add-transition-element transition-table state-column symbol-column new-state-column new-symbol-column direction-column delete-column confirm-column)
  (send frame show #t)
  )

(provide start-gui)
