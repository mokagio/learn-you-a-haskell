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

-- Next time:
-- inits and tails are like init and tail...
