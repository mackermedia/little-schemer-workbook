(define insertR
  (lambda (new old lat)
    (cond
      ((null? lat) (quote ()))
      (else (cond
              ((eq? (car lat) old)
               (cons old
                 (cons new (cdr lat))))
              (else (cons (car lat)
                      (insertR new old
                        (cdr lat)))))))))

(define insertL
  (lambda (new old lat)
    (cond
      ((null? lat) (quote ()))
      (else (cond
              ((eq? (car lat) old)
               (cons new lat))
              (else (cons (car lat)
                      (insertL new old
                        (cdr lat)))))))))

; replace the first occurrence of old in the lat with new
(define subst
  (lambda (new old lat)
    (cond
      ((null? lat) (quote ()))
      (else (cond
              ((eq? (car lat) old)
                (cons new (cdr lat)))
              (else (cons (car lat)
                      (subst new old (cdr lat)))))))))

; remove all occurrences of an atom
(define multirember
  (lambda (a lat)
    (cond
      ((null? lat) (quote()))
      (else
        (cond
          ((eq? (car lat) a)
            (multirember a (cdr lat)))
          (else (cons (car lat)
                  (multirember a (cdr lat)))))))))

(define multiinsertR
  (lambda (new old lat)
    (cond
      ((null? lat) (quote ()))
      (else
        (cond
          ((eq? (car lat) old)
            (cons (car lat)
              (cons new
                (multiinsertR new old (cdr lat)))))
          (else (cons (car lat)
                  (multiinsertR new old (cdr lat)))))))))

; write multiinsertL replaces multiple occurrences to the left
(define multiinsertL
  (lambda (new old lat)
    (cond
      ((null? lat) (quote ()))
      (else
        (cond
          ((eq? (car lat) old)
            (cons new
              (cons old
                (multiinsertL new old (cdr lat)))))
          (else (cons (car lat)
                  (multiinsertL new old (cdr lat)))))))))

; write multisubst which replaces multiple occurrences
(define multisubst
  (lambda (new old lat)
    (cond
      ((null? lat) (quote ()))
      (else
        (cond
          ((eq? (car lat) old)
            (cons new
              (multisubst new old (cdr lat))))
          (else (cons (car lat)
                  (multisubst new old (cdr lat)))))))))
