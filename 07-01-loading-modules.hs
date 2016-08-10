-- Loading Modules
--
-- You can import only some functions in a module
import Data.List (nub, sort)

-- You can import a module except some functions
import Data.List hiding (nubBy)

-- To avoid functions name clashes you can use "qualified" imports
import qualified Data.Map

-- `Prelude`'s filter
x = filter odd [1, 2, 3, 4]

-- `Data.Map`'s filter
turtles =
  [("leo", "blue")
  ,("mikey", "orange")
  ,("donnie", "purple")
  ,("raph", "red")
  ]
y = Data.Map.filter (\value -> (length value) > 4) $ Data.Map.fromList turtles

-- Using the full name of the module can be cumbersome, you can associate
-- another name to is by doing:
--
-- This is not compiling, not sure why
-- import qualified Data.Char as Char
--
-- z = Char.isAlpha "2"
