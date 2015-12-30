(define rember*
  (lambda (a lat)
    (cond
      ((null? lat) (quote ()))
      ((atom? (car lat))
        (cond
          ((eq? (car lat) a)
            (rember* a (cdr lat)))
          (else (cons (car lat)
                  (rember* a (cdr lat))))))
      (else (cons (rember* a (car lat))
              (rember* a (cdr lat)))))))

(define insertR*
  (lambda (new old lat)
    (cond
      ((null? lat) (quote ()))
      ((atom? (car lat))
        (cond
          ((eq? (car lat) old)
            (cons old
              (cons new
                (insertR* new old (cdr lat)))))
          (else (cons (car lat)
                  (insertR* new old (cdr lat))))))
      (else (cons (insertR* new old (car lat))
              (insertR* new old (cdr lat)))))))

(define occur*
  (lambda (a list)
    (cond
      ((null? list) 0)
      ((atom? (car list))
        (cond
          ((eq? (car list) a)
            (add1 (occur* a (cdr list))))
          (else (occur* a (cdr list)))))
      (else (+ (occur* a (car list))
              (occur* a (cdr list)))))))

(define subst*
  (lambda (new old list)
    (cond
      ((null? list) (quote ()))
      ((atom? (car list))
        (cond
          ((eq? (car list) old)
            (cons new
              (subst* new old (cdr list))))
          (else (cons (car list)
                  (subst* new old (cdr list))))))
      (else (cons (subst* new old (car list))
              (subst* new old (cdr list)))))))

(define insertL*
  (lambda (new old list)
    (cond
      ((null? list) (quote ()))
      ((atom? (car list))
        (cond
          ((eq? (car list) old)
            (cons new
              (cons old
                (insertL* new old (cdr list)))))
          (else (cons (car list)
                  (insertL* new old (cdr list))))))
      (else (cons (insertL* new old (car list))
              (insertL* new old (cdr list)))))))

(define member*
  (lambda (a list)
    (cond
      ((null? list) #f)
      ((atom? (car list))
        (or
          (eq? (car list) a)
          (member* a (cdr list))))
      (else (or (member* a (car list))
              (member* a (cdr list)))))))

(define leftmost
  (lambda (list)
    (cond
      ((atom? (car list)) (car list))
      (else (leftmost (car list))))))

(define eqlist?
  (lambda (l1 l2)
    (cond
      ((and (null? l1) (null? l2)) #t)
      ((or (null? l1) (null? l2)) #f)
      ((and (atom? (car l1)) (atom? (car l2)))
       (and (eqan? (car l1) (car l2))
          (eqlist? (cdr l1) (cdr l2))))
      ((or (atom? (car l1))
          (atom? (car l2))))
      (else
        (and (eqlist? (car l1) (car l2))
          (eqlist? (cdr l1) (cdr l2)))))))

(define equal?
  (lambda (s1 s2)
    (cond
      ((and (atom? s1) (atom? s2))
          (eqan? s1 s2))
      ((or (atom? s1) (atom? s2)) #f)
      (else (eqlist? s1 s2)))))


(define eqlist?
  (lambda (l1 l2)
    (cond
      ((and (null? l1) (null? l2)) #t)
      ((or (null? l1) (null? l2)) #f)
      (else
        (and (equal? (car l1) (car l2))
          (eqlist? (cdr l1) (cdr l2)))))))
