import Lib
  ( Pet(..), Species(..)
  , readPet, readPets
  )
import Assert
  ( assert
  , assertEither
  )

main :: IO ()
main = do
  putStrLn "Single pet"
  pet <- readPet "test/1.json"
  assertEither pet (Pet {name = "Nermal", species = Cat, colour = "grey", age = 3})
  putStrLn "Multiple pets"
  pets <- readPets "test/2.json"
  assertEither pets
    [ Pet {name = "Nermal", species = Cat, colour = "grey", age = 3}
    , Pet {name = "Garfield", species = Cat, colour = "orange", age = 10}
    ]
