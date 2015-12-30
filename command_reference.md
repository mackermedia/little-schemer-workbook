S-expressions

## Atom:

A string of chars/digits/single char/

## Lists:

`(turkey gravy)`

Atoms or S-expressions enclosed in parens

## car:

First element of a list
Only for non-empty lists.

## cdr:

Remainder of list after first element.
Only for non-empty lists.

## cons:

Adds the first arg to the beginning of the second arg.
Takes 2 args.
2nd arg must be a list.
The result is a list.

`cons (banana and) (peanut butter and jelly) => ((banana and) peanut butter and jelly)`

## atom?

Returns true/false if the arg is an atom

## null?:

`(null? a)`
only for lists!
returns true or false

## eq?

`(eq? a1 a2)`
Checks for equality of atoms -- non-numeric!

## lat?

Returns true if it is a list of only atoms. If the list contains a list = false

## member?

Returns true/false if the arg (atom) is a member of the 2nd arg (list)

## quote

Returns a copy of a supplied list
`(quote ())`

## rember

Means "remove a member"
`(rember mint (lamb chops and mint jelly)) => (lamb chops and jelly)`

## insertR

Takes 3 args: atoms 'new' and 'old' and a 'lat'. builds a lat with 'new' inserted tot he right of the 1st occurrence of 'old'
