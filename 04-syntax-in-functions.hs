-- Example says:
lucky :: (Integral a) => a -> String
lucky 7 = "LUCKY NUMBER SEVEN!"
lucky x = "Sorry, you're out of luck, pal!"
-- But I recon it could be better written as
lucky' :: (Integral a) => a -> String
lucky' 7 = "LUCKY NUMBER SEVEN!"
lucky' _ = "Sorry, you're out of luck, pal!"
-- Yep, it's correct ^_^

-- Self Challenge:
-- What if we wanted to make a function that takes two vectors in a 2D space
-- (that are in the form of pairs) and adds them together [using pattern
-- matching]
sumVectors :: (Num a) => (a, a) -> (a, a) -> (a, a)
sumVectors (x, y) (z, k) = (x + z, y + k)
-- YEAH!

-- Self Challenge:
-- Now that we know how to pattern match against list, let's make our own
-- implementation of the head function.
-- head' :: [a] -> a
-- head' x:xs = x
-- ^__ doesn't compile because the pattern needs to be within parenthesis
-- and it's also missing the case of an empty list
head' :: [a] -> a
head' [] = error "Can't call head on an empty list"
head' (x:_) = x

-- Self Challenge:
-- We already implemented our own length function using list comprehension. Now
-- we'll do it by using pattern matching and a little recursion:
length' :: Num b => [a] -> b
length' [] = 0
length' (x:xs) = 1 + length' xs
-- Almost!
length'' :: Num b => [a] -> b
length'' [] = 0
length'' (_:xs) = 1 + length'' xs

-- Self Challenge:
-- Let's implement our own max function. If you remember, it takes two things
-- that can be compared and returns the larger of them. [using guard]
max' :: Ord a => a -> a -> a
max' x y
  | x > y     = x
  | otherwise = y

-- Self Challenge:
-- Let's make another fairly trivial function where we get a first and a last
-- name and give someone back their initials.
initials :: String -> String -> String
-- failed :/
initials x y = [f] ++ ". " ++ [l]
  where (f:_) = x
        (l:_) = y

initials' :: String -> String -> String
initials' (f:_) (l:_) = [f] ++ ". " ++ [l]

-- Self Challenge:
-- Staying true to our healthy programming theme, let's make a function that
-- takes a list of weight-height pairs and returns a list of BMIs.
-- ...
-- Another fail
calcBMIs :: RealFloat a => [(a,a)] -> [a]
calcBMIs xs = [ bmi w h | (w,h) <- xs ]
  where bmi w h = w / h^2

-- Since I failed before let me add a layer, return the BMI sentence
--
-- Other fail :/
-- Not sure why this doesn't work...
-- bmisValues :: Num a => [(a,a)] -> [String]
-- bmisValues xs = [ bmiValue w h | (w,h) <- xs ]
  -- where bmiValue w h
    -- | bmi <= slim   = "slim"
    -- | bmi <= normal = "normal"
    -- | otherwise     = "fat"
    -- where bmi = w / h^2
          -- (slim, normal) = (10, 20)

-- Self Challenge:
--  Let's rewrite our previous example of calculating lists of weight-height
--  pairs to use a let inside a list comprehension instead of defining an
--  auxiliary function with a where.
calcBMIs' :: RealFloat a => [(a,a)] -> [a]
calcBMIs' xs = [ let bmi2 w h = w / h ^ 2 in bmi2 w h | (w,h) <- xs ]
