doubleMe x = x * 2

doubleUs x y = doubleMe x + doubleMe y

doubleSmaller x = if x > 100
then x
else x * 2

doubleSmallerParam x p = if x > p
then x
else x * 2

-- You can put lists together using ++
joinedList = [1, 2] ++ [3, 4]

-- When using ++ Haskell has to traverse the list on the left, which can take
-- time

-- We can prepend to a list using `:` or _cons_.
prependedList = 1 : [2, 3]

-- `elem` takes a thing and a list of things and tells wethere the thing is in
-- the list.
-- It is usually used an an infix rather than prefix
isInList = 4 `elem` [1,2,3]

-- List comprehension
listCompr = [ x * 2 | x <- [1..10] ]

-- List comprehension with multiple predicates
listCompr' = [ x * 2 | x <- [1..10], x * 2 > 10 ]

-- Self Challenge:
-- Let's say we want a comprehension that replaces each odd number
-- greater than 10 with "BANG!" and each odd number that's less than 10 with
-- "BOOM!". If a number isn't odd, we throw it out of our list. For
-- convenience, we'll put that comprehension inside a function so we can easily
-- reuse it.
--
-- My version
gio_bangBoom = [ if x > 10 then "BANG!" else "BOOM" | x <- [1..], x `mod` 2 /= 0 ]

-- Actual version
bangBoom xs = [ if x > 10 then "BANG!" else "BOOM" | x <- xs, odd x ]

-- Differences:
--
-- I didn't realise that we should have passed the list as the input of the
-- function, which is quite dumb as functions with no inputs are quite dumb.
--
-- I also didn't know about the `odd` function, although I could have guessed
-- it.

-- Tuples!

-- `zip`, it's funny how clear its behavious is here compared to ReactiveCocoa
zipped = zip [1 .. 5] ["one", "two", "three", "four", "five"]
-- [(1,"one"),(2,"two"),(3,"three"),(4,"four"),(5,"five")]

-- Self Challenge:
-- Here's a problem that combines tuples and list comprehensions: which right
-- triangle that has integers for all sides and all sides equal to or smaller
-- than 10 has a perimeter of 24?
--
triangles = [ (x,y,z) | z <- [1..10], y <- [1..z], x <- [1..y], x^2 + y^2 == z^2, x + y + z == 24 ]
