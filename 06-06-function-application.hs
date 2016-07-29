-- http://learnyouahaskell.com/higher-order-functions#function-application

-- Function application with a space is left-associative, function application
-- with $ is right-associative.
--
-- When a $ is encountered, the expression on its right is applied as the
-- parameter to the function on its left.

-- How about sqrt 3 + 4 + 9?
_ = sqrt $ 3 + 4 + 9

-- How about sum (filter (> 10) (map (*2) [2..10]))?
_ = sum $ filter (> 10) $ map (*2) [2..10]

-- NEXT TIME
-- But apart from getting rid of parentheses, $ means that function application
-- can be treated just like another function. That way, we can, for instance,
-- map function application over a list of functions:
_ = map ($ 3) [(1+), (2*), (^2), sqrt]
