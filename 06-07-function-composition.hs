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
