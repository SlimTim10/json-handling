import Pet
  ( Pet(..)
  , Species(..)
  , DateOfBirth(..)
  )
import Lib
  ( readJSON
  )
import Assert
  ( assert
  , assertEither
  )

testSingle = do
  putStrLn "Single pet"
  pet <- readJSON "test/1.json"
  assertEither pet
    Pet
    { name = "Nermal"
    , species = Cat
    , colour = "grey"
    , dob = DateOfBirth 1979 9 3
    }

testMultiple = do
  putStrLn "Multiple pets"
  pets <- readJSON "test/2.json"
  assertEither pets
    [
      Pet
      { name = "Nermal"
      , species = Cat
      , colour = "grey"
      , dob = DateOfBirth 1979 9 3
      }
    ,
      Pet
      { name = "Garfield"
      , species = Cat
      , colour = "orange"
      , dob = DateOfBirth 1978 6 19
      }
    ]

main :: IO ()
main = do
  testSingle
  testMultiple
