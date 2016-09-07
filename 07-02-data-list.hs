-- Data.List module
-- http://learnyouahaskell.com/modules#data-list
--
-- `map` and `filter` are part of `Data.List`, and are imported by `Prelude` by
-- default.
import Data.List

-- What follows is just me playing around with some of the functions listed in
-- the book that I find interesting

-- transpose, remember transposing matrixes from the geometry course at first
-- year of engineering?
m = [
  [1,2,3]
  ,[4,5,6]
  ,[7,8,9]
  ]
t = transpose m

-- concatMap
x = concat . map (replicate 4) $ [1..3]
x' = concatMap (replicate 4) [1..3]

-- takeWhile, seen it "already" while looking into FRP signal operations
y = takeWhile (<10) $ map (^2) [1..]

-- span is similar to takeWhile, but returns the discarded list as well as the
-- _taken_ one
spanned = span (<4) [1..10]

-- break
broken = break (==4) [1..10]

-- Use a fold to implement searching a list for a sublist
--
-- I had to look at the solution for this one...
search :: (Eq a) => [a] -> [a] -> Bool
search sublist list =
  let targetLength = length list
  in foldl (\acc x -> if take targetLength x == sublist then True else acc) False (tails list)
-- What this does is that it uses tails to create a list of list, with each
-- element being the full list minus n starting elements, where n is the index
-- of the element: [['a', 'b', 'c'], ['b', 'c'], ['c'], []].  We can then
-- "scan" the list by folding this list of list, which is like moving a cursor
-- on the original list, starting from index 0. In the fold we can see if the
-- first m elements, where m is the length of the sublist we're looking for,
-- match the sublist.  The fold starts with accumulator False and sets it to
-- true only if a match is found, otherwise it sets it as its previous value.
-- This also makes so that once a match is found, the value True is not lost in
-- the fold.

-- The behaviour of this `search` function we wrote is actually the same as
-- `isInfixOf`
_ = isInfixOf "pizza" "I love pizza"

-- There are also `isPrefixOf` and `isSuffixOf`.

-- `unlines` is pretty cool
joinedMultilineString = unlines ["a", "b", "c"]
