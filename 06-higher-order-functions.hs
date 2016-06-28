-- http://learnyouahaskell.com/higher-order-functions

multThree :: (Num a) => a -> a -> a -> a
multThree x y z = x * y * z

-- We are going to make a function that takes a function and then applies it twice to something!
-- My solution:
-- applyTwice :: f -> a -> a
-- applyTwice function value = function (function value)
--
-- This kind of type signature doesn't really tell the compiler that f is a function, it needs to be explicit
applyTwice :: (a -> a) -> a -> a
applyTwice f x = f (f x)

-- Now we're going to use higher order programming to implement a really useful function that's in the standard library. It's called zipWith. It takes a function and two lists as parameters and then joins the two lists by applying the function between corresponding elements.
-- My solution (which works):
zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' f [] _ = []
zipWith' f _ [] = []
zipWith' f (x:xs) (y:ys) = [f x y] ++ zipWith' f xs ys
-- Better solution
zipWith'' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith'' _ [] _ = []
zipWith'' _ _ [] = []
zipWith'' f (x:xs) (y:ys) = f x y : zipWith'' f xs ys

-- We'll implement another function that's already in the standard library,
-- called flip.
-- Flip simply takes a function and returns a function that is like our
-- original function, only the first two arguments are flipped.
flip' :: (a -> b -> c) -> (b -> a -> c)
-- Had no idea how to do it...
flip' f = g
  where g x y = f y x
-- Other version (I swear I though of this, but wasn't sure about wether those
-- x and y would have been legit or the compile would have thought the out of
-- the scope)
flip'' :: (a -> b -> c) -> b -> a -> c
flip'' f x y = f y x

-- Implement map
map' :: (a -> b) -> [a] -> [b]
map' _ [] = []
map' f (x:xs) = f x : map' f xs

-- Implement filter
filter' :: (a -> Bool) -> [a] -> [a]
filter' _ [] = []
filter' f (x:xs)
  | f x == True = x : filter' f xs
  | otherwise = filter' f xs
-- Simpler version, should have guessed that...
filter'' :: (a -> Bool) -> [a] -> [a]
filter'' _ [] = []
filter'' f (x:xs)
  | f x       = x : filter'' f xs
  | otherwise = filter'' f xs

-- Reimplement quicksort using filter
quicksort' :: (Ord a) => [a] -> [a]
quicksort' [] = []
quicksort' (x:xs) =
  let smallerSorted = quicksort' (filter (<=x) xs)
      biggerSorted = quicksort' (filter (>x) xs)
  in smallerSorted ++  [x] ++ biggerSorted

-- Reimplement triangles problem using map an filters rather than list
-- comprehension.
--
-- Here's a problem that combines tuples and list comprehensions: which right
-- triangle that has integers for all sides and all sides equal to or smaller
-- than 10 has a perimeter of 24?
--
triangles' = filter sum24 (filter rightTriangle oneToTenTriplets)
  where
    oneToTenTriplets = [ (x, y, z) | x <- [1..10], y <- [1..10], z <- [1..10] ]
    rightTriangle (x, y, z) = x^2 + y^2 == z^2
    sum24 (x, y, z) = x + y + z == 24

-- Let's find the largest number under 100,000 that's divisible by 3829.
-- (To do that, we'll just filter a set of possibilities in which we know the 
-- solution lies.)
--
-- My solution
largestDivisible = head (reverse (filter divisible [0..100000]))
  where divisible x = x `mod` 3829 == 0
-- Book's solution
largestDivisible' :: (Integral a) => a
largestDivisible' = head (filter divisible [100000,99999..])
  where divisible x = x `mod` 3829 == 0
---
-- The book's solution is cool becaues it uses one less function, although is
-- not as nice to read I think.

-- Collatz sequences.
-- We take a natural number. If that number is even, we divide
-- it by two. If it's odd, we multiply it by 3 and then add 1
-- to that. We take the resulting number and apply the same
-- thing to it, which produces a new number and so on. In
-- essence, we get a chain of numbers. It is thought that for
-- all starting numbers, the chains finish at the number 1. So
-- if we take the starting number 13, we get this sequence:
--
-- 13, 40, 20, 10, 5, 16, 8, 4, 2, 1.
--
-- 13*3 + 1 equals 40. 40 divided by 2 is 20, etc. We see that the chain has 10
-- terms.
--
-- Now what we want to know is this: for all starting numbers between 1 and
-- 100, how many chains have a length greater than 15?
--
--
-- Since it is said that any sequence finishes with 1, I'm assuming that 1 is
-- the end condition for the sequecne. Because otherwise we'd get 1*3+1=4,
-- 4/2=2, 2/2=1, 1*3+1=4, etc...
--
-- My solution
{-
collatz :: (Integral a) => a -> [a]
collatz 0 = []
collatz 1 = []
collatz x
  | odd x     = let collatz_odd = x * 3 + 1
    in [collatz_odd] ++ collatz collatz_odd
  | otherwise = let collatz_even = x `div` 2
    in [collatz_even] ++ collatz collatz_even
-}
-- I misunderstood the fact that the first element of the sequence is the
-- number itself, due to a newline.
-- I also wrongly evaluated the edge case for 1, partly due to the whole first
-- element mistake.
-- I'm pretty happy with my use of let though :)
--
-- Book's solution
chain :: (Integral a) => a -> [a]
chain 1 = [1]
chain n
  | odd n = n : chain(n * 3 + 1)
  | even n = n : chain(n `div` 2)

-- Now that we have the Collatz chain generator, how can we use it to solve
-- the question?
--
-- For all starting numbers between 1 and 100, how many chains have a length
-- greater than 15?
--
-- So... we just learnt about takeWhile, shall we try to use it? Or should we
-- evaluate all the chains and filter base on the lenght?
--
collatzSolutionsCount = length (filter longerThanFifteen (map chain [1..100]))
  where longerThanFifteen xs = length xs > 15

-- Understainding map for functions with multiple parameters.
-- 👉 Currying + Partial application
--
-- map (*) [0..]
--
-- The type of * is Num a => a -> a -> a, mapping this function on a Num a,
-- would result in a Num a => a -> a.
--
-- So map (*) [0..] results in [(0*), (1*), (2*), ...]

-- Lambdas
--
-- "Lambdas are basically anonymous functions that are used because we need
-- some functions only once"
--
-- Re-write the collatz solution using a lamda
collatzSolutionsCount' = length (filter (\xs -> length xs > 15) (map chain [1..100]))

-- If a pattern matching fails in a lambda, a runtime error occurs, so be
-- careful when pattern matching in lambdas!"

-- Implement flip using lambdas without parenthesis
--
--    flip :: (a -> b -> c) -> b -> a -> c
--
-- flip takes an input of type a -> b -> c, and returns an output of type
-- b -> a -> c. That is it takes a function that expecting two inputs of type
-- a and b and returning c, and returns another function with the parameters
-- flipped.
flip''' :: (a -> b -> c) -> b -> a -> c
flip''' f = \x y -> f y x
-- I didn't get there by myself, I had to look the answer.
-- The book says:
--
-- So use lambdas in this way when you want to make it
-- explicit that your function is mainly meant to be partially
-- applied and passed on to a function as a parameter.
--
-- I guess that since the first parameter is `(a -> b -> c)`, it's easy for the
-- compiler to understand that it is a function that expects two arguments.
-- The `\x y -> ...` has type signature `t -> u`.
-- Finally `f y x` means giving y and x, **in that order**, as input to f.
-- This means that means giving y and x, **in that order**, as input to f.
-- This means that...
-- I still haven't gotten it :'(

--
-- folds functions
--

-- These are easy, they're like Ruby and Swift's `reduce` :D

-- foldl, left fold, "folds the list on the left side". This means that the
-- binary function is applied between the starting value and the head of the
-- list.
--
-- foldl is exactly (as far as I understand at the moment) like Ruby and
-- Swift's result.

-- Let's implement sum again, only this time, we'll use a fold instead of
-- explicit recursion.
sum' :: (Num a) => [a] -> a
sum' xs = foldl (+) 0 xs

-- Thanks to the power of currying we can write an even more succint version:
sum'' :: (Num a) => [a] -> a
sum'' = foldl (+) 0
-- > Generally, if you have a function like foo a = bar b a,
-- you can rewrite it as foo = bar b, because of currying.

-- Let's implement elem using a left fold
elem' :: (Eq a) => a -> [a] -> Bool
elem' x = foldl (\acc y -> acc || (x == y)) False

--- Book's solution
elem'' :: (Eq a) => a -> [a] -> Bool
elem'' y ys = foldl (\acc x -> if x == y then True else acc) False ys
-- I have a feeling that using if-then instead of doing an OR every time results
-- in an operation less per iteration.

-- Implement map using a right fold
map'' :: (a -> b) -> [a] -> [b]
map'' f xs = foldr (\x acc -> f x : acc) [] xs

-- Implement map using a left fold
map''' :: (a -> b) -> [a] -> [b]
map''' f xs = foldl (\acc x -> acc ++ [f x]) [] xs

-- [...] the thing is that the ++ function is much more
-- expensive than :, so we usually use right folds when we're
-- building up new lists from a list.

-- One big difference is that right folds work on infinite lists, whereas left
-- ones don't! To put it plainly, if you take an infinite list at some point
-- and you fold it up from the right, you'll eventually reach the beginning of
-- the list. However, if you take an infinite list at a point and you try to
-- fold it up from the left, you'll never reach an end!

-- Implement sum of list using fold(l|r)1
sum''' :: (Num a) => [a] -> a
sum''' xs = foldl1 (+) xs
-- or using currying and foldr1
sum'''' :: (Num a) => [a] -> a
sum'''' = foldr1 (+)

-- Warning! foldl1 and foldr1 throw runtime errors if the list is empty!
-- Which is obvious as they depend on the list having a starting/eding value.
