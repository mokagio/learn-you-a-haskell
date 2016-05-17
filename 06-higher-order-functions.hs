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
largestDivisible' = head (filter divisible [100000,99999,..]))
  where divisible x = x `mod` 3829 == 0
---
-- The book's solution is cool becaues it uses one less function, although is
-- not as nice to read I think.
