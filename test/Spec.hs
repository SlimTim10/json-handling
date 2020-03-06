import Lib
  ( Pet(..), Species(..)
  )
import Assert (assert)
    
main :: IO ()
main = do
  assert "1.json" (Pet {name = "Nermal", species = Cat, colour = "grey", age = 3})
