-- http://learnyouahaskell.com/higher-order-functions#composition

-- Haskell's function composition is similar to the mathematic's one, and is
-- done through the `.` operator.
--
-- (f . g)(x) = f(g(x))
--
-- One of the uses for function composition is making functions on the fly to
-- pass to other functions, in a more concise way than using lambdas.
--
-- Function composition is right-associative.

-- Say we have a list of numbers and we want to turn them all into negative
-- numbers. One way to do that would be to get each number's absolute value and
-- then negate it.
p :: Num a => [a] -> [a]
p = map (negate . abs)

-- If you want to rewrite an expression with a lot of parentheses by using
-- function composition, you can start by putting the last parameter of the
-- innermost function after a $ and then just composing all the other function
-- calls, writing them without their last parameter and putting dots between
-- them.
--
-- Rewrite using function composition and application:
-- replicate 100 (product (map (*3) (zipWith max [1,2,3,4,5] [4,5,6,7,8])))
--
rewrite 100 . product . map (*3) . zipWith max [1,2,3,4,5] $ [4,5,6,7,8]
