#lang racket

(define Q0 0)
(define Q1 1)
(define Q2 2)
(define Q3 3)
(define Q_ACCEPT 4)

(define LEFT 5)
(define RIGHT 6)
(define STAY 7)

(define/contract (process-instruction state cymbol)
  (-> char? char? (list/c char? integer? integer?))
  (match* (state cymbol)
    [(Q0 #\1) (#\x RIGHT Q1)]
    [(Q0 #\*) (#\* RIGHT Q3)]
    [(Q0 #\_) (#\_ STAY Q_ACCEPT)]
    [(Q1 #\1) (#\1 RIGHT Q1)]
    [(Q1 #\*) (#\* RIGHT Q1)]
    [(Q1 #\x) (#\x RIGHT Q2)]
    [(Q2 #\1) (#\1 RIGHT Q2)]
    [(Q2 #\_) (#\1 LEFT Q1)]
    [(Q3 #\1) (#\1 RIGHT Q3)]
    [(Q3 #\x) (#\1 LEFT Q3)]
    [(Q3 #\_) (#\_ LEFT Q0)]
    )
  )


;; (define/contract (start-execution tape)
;;   (-> (listof char?) (listof char?)
;;       (define/contract (loop state tape)
;;         (-> integer? (listof char?) (listof char?))
;;         (if (= state Q_ACCEPT)
;;             tape
;;             (loop state tape)
;;             )
;;         )
;;       (loop Q0 tape)
;;       )
;;   )

(process-instruction (0 #\*))

(define/contract (interpret tape)
  (-> (listof char?) void?)
  (void)
  )

(provide interpret)
