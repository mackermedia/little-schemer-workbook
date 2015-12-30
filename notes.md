# Little Schemer Reference/Notes

## Chapter 1 - Toys

* **atom**:
* **list**: collection of atoms enclosed w/ parens
* **S-expression**: all atoms & lists are S-expressions
* *car*: the first S-expression of a list -- doesn't work on atoms or empty lists
    * `(car l)` where `l is (((hotdogs)) (and))` is `((hotdogs))`
* *cdr*: the remaining S-expressions after the first of a list -- doesn't work on atoms or empty lists
    * `(cdr l)` where `l is ((x) t r)` is `(t r)` -- always returns a list
* *cons*: adds any S-expression to the front of a list
    * `(cons a l)` where `l is (butter and jelly)` and `a is peanut` is `(peanut butter and jelly)`
* *(null? l)*: is true if l is an empty list `()` -- can only ask it of lists
* *(atom? l)*: similar to null but ask if a thing is an atom -- takes any S-expression
* *(eq? a b)*: takes two args, both must be non-numeric atoms -- returns equality evaluation

## Chapter 2 - Do It, Do It Again, And Again, And Again

* *(lat? l)*: is a list of only atoms -- if it has any lists or is `()` it's false
* *(cond ...)*: is a conditional
* *(lambda ...)*: defines a function
* *(define ...)*: gives a function a name
* example `lat?` function:
    ```
    (define lat?
      (lambda (l)
        (cond
          ((null? l) #t )
          ((atom? (car l)) (lat? (cdr )))
          (else #f))))
    ```
* *(or (null? l1) (null? l2))*: evaluates each expression, returns true if either are true
* *(member? a lat)*: returns true if the atom a is a member of the list lat
    ```
    (define member?
      (lambda (a lat)
        (cond
          ((null? lat) #f)
          (else (or (eq? (car lat) a)
                  (member? a (cdr lat)))))))
    ```
* **The First Commandment (preliminary)**: Always ask `null?` as the 1st question in expressing any function

## Chapter 3 - Cons the Magnificent

* *(rember a lat)*: "rember" stands for remove a member
    * takes an atom as first arg, and list as 2nd arg
    * only removes the first matching instance
    * returns original list if no match
* walk through writing our own function
    * 1. ask `(null? lat)` (first commandment) and return `()` if true
    * 2. if `null? lat` not true, we know at least one atom in the lat
    * 3. ask if a is equal to `(car lat)` (using cond() ())
    * 4. how ask equal? `(eq? (car lat) a)`
    * 5. what would be value of `(rember a lat)` if a were the same as `(car lat)` = `(cdr lat)`
    * 6. what do we do if `a` is not same as `(car lat)`? = keep `(car lat)`, but also find out if a is somewhere in rest of the lat
    * 7. how remove the first occurrence of a in rest of lat? = `(rember a (cdr lat))`
    ```
    (define rember
      (lambda (a lat)
        (cond
          ((null? lat) (quote ())
          (else (cond
                  ((eq? (car lat) a) (cdr lat))
                  (else (rember a
                          (cdr lat)))))))))
    ```
    * ^ incorrect, b/c we're just returning `cdr` when finding the atom and not returning anything before it
        * ! use "cons the magnificent" (from chapter 1)
    * ** The Second Commandment**: Use `cons` to build lists.
    * now the fixed version:
    ```
    (define rember
      (lambda (a lat)
        (cond
          ((null? lat) (quote ())
          (else (cond
                  ((eq? (car lat) a) (cdr lat))
                  (else (cons (car lat)
                          (rember a
                            (cdr lat)))))))))
    ```
        * "`cons` the `car of lat`--bacon-- onto the value of `(rember a (cdr lat))`"
    * shorter version:
    ```
    (define rember
      (lambda (a lat)
        (cond
          ((null? lat) (quote ())
          ((eq? (car lat) a) (cdr lat))
          (else (cons (car lat)
                  (rember a (cdr lat))))))))
    ```
* *(firsts l)*: takes one list as arg, which is either a null list or contains only non-empty lists. It builds another list composed of the first S-expression of each internal list.
    ```
    (define firsts
      (lambda (l)
        (cond
          ((null? l) (quote ()))
          (else (cons (car (car l))
                  (firsts (cdr l)))))))
    ```
* **Third Commandment**: When building a list, describe the first typical element, and then `cons` it onto the natural recursion
* *(insertR new old lat)*: builds a new lat w/ `new` inserted to the right of the first occurrence of `old`
    ```
    (define insertR
      (lambda (new old lat)
        (cond
          ((null? lat) (quote ()))
          (else
            (cond
              ((eq? (car lat) old)
               (cons old
                 (cons new (cdr lat))))
              (else (cons (car lat)
                      (insertR new old
                        (cdr lat)))))))))
    ```
* write function *multirember* which gives as its final value the lat w/ all occurrences of `a` removed
    * if `a` is `cup` and `lat` is `(coffee cup tea cup and hick cup)`, result should be `(coffee tea and hick)`
    ```
    (define multirember
      (lambda (a lat)
        (cond
          ((null? lat) (quote ()))
          (else
            (cond
              ((eq? (car lat) a)
               (multirember a (cdr lat)))
              (else (cons (car lat)
                      (multirember a (cdr lat))))))
    ```
* **Fourth Commandment**: Always change at least one argument while recurring. It must be changed to be closer to termination. The changing argument must be tested in the termination condition: when using `cdr`, test termination with `null?`
