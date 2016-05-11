-- `::` is read as "has type of"

-- When writing our own functions, we can choose to give them an explicit type
-- declaration. This is generally considered to be good practice except when
-- writing very short functions. 

-- :t (==)
-- (==) :: Eq a => a -> a -> Bool
--
-- Everything before the => symbol is called a class constraint. We can read
-- the previous type declaration like this: the equality function takes any two
-- values that are of the same type and returns a Bool. The type of those two
-- values must be a member of the Eq class (this was the class constraint).

-- Type annotation
--
-- This wouldn't compile:
-- read "4"
-- But this does:
read "4" :: Int

-- Self Challenge:
-- Given that the type of `fromIntegral` is:
--    fromIntegral :: (Integral a, Num b) => a -> b
-- what would the result of:
--    fromIntegral (length [1,2,3,4]) + 3.2
-- be?
--
-- -> 4 + 3 = 7
-- because `a` is constrained to the Integral type class, so the 3.2 would
-- become a 3
--
-- ☝️ INCORRECT!
--
-- I evaluated the function in the wrong order!
--    fromIntegral (length [1,2,3,4]) + 3.2
--    ^_____________________________^ + 3.2
--    (4 :: Num) + 3.2
--    7.2
