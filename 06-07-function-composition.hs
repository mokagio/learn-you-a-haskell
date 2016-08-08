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
_ = replicate 100 . product . map (*3) . zipWith max [1,2,3,4,5] $ [4,5,6,7,8]

-- Point free style
--
-- Rewrite using point free style
-- fn x = ceiling (negate (tan (cos (max 50 x))))
fn  = ceiling . negate . tan . cos . max 50

-- Many times, a point free style is more readable and concise, because it
-- makes you think about functions and what kind of functions composing them
-- results in instead of thinking about data and how it's shuffled around.
-- You can take simple functions and use composition as glue to form more
-- complex functions.
--
-- However, many times, writing a function in point free style can be less
-- readable if a function is too complex. That's why making long chains of
-- function composition is discouraged. The prefered style is to use let
-- bindings to give labels to intermediary results or split the problem into
-- sub-problems and then put it together so that the function makes sense to
-- someone reading it instead of just making a huge composition chain.

oddSquareSumMap :: Integer
oddSquareSumMap =  sum (takeWhile (<10000) (filter odd (map (^2) [1..])))

oddSquareSumComposition :: Integer
oddSquareSumComposition = sum . takeWhile (<10000) . filter odd . map (^2) $ [1..]

-- let can help readability
oddSquareSumLet :: Integer
oddSquareSumLet =
  let oddSquares = filter odd (map (^2) [1..])
      lessThan1000 = takeWhile (<10000) oddSquares
  in sum lessThan1000
