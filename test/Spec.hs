import Lib
  ( Pet(..), Species(..), DateOfBirth(..)
  , readPet, readPets
  )
import Assert
  ( assert
  , assertEither
  )

testSingle = do
  putStrLn "Single pet"
  pet <- readPet "test/1.json"
  assertEither pet
    Pet
    { name = "Nermal"
    , species = Cat
    , colour = "grey"
    , dob = DateOfBirth { year = 1979, month = 9, day = 3 }
    }

testMultiple = do
  putStrLn "Multiple pets"
  pets <- readPets "test/2.json"
  assertEither pets
    [
      Pet
      { name = "Nermal"
      , species = Cat
      , colour = "grey"
      , dob = DateOfBirth { year = 1979, month = 9, day = 3 }
      }
    ,
      Pet
      { name = "Garfield"
      , species = Cat
      , colour = "orange"
      , dob = DateOfBirth { year = 1978, month = 6, day = 19 }
      }
    ]

main :: IO ()
main = do
  testSingle
  testMultiple
