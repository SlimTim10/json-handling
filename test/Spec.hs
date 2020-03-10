import Lib
  ( readJSON
  )
import Assert
  ( assert
  , assertEither
  )
import Pet
  ( Pet(..)
  , Species(..)
  , DateOfBirth(..)
  )
import Packet
  ( Packet(..)
  )

testSinglePet = do
  putStrLn "Single pet"
  pet <- readJSON "test/nermal.json"
  assertEither pet
    Pet
    { name = "Nermal"
    , species = Cat
    , colour = "grey"
    , dob = DateOfBirth 1979 9 3
    }

testMultiplePets = do
  putStrLn "Multiple pets"
  pets <- readJSON "test/cats.json"
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

testSinglePacket = do
  putStrLn "Single packet"
  pkt <- readJSON "test/packet.json"
  assertEither pkt
    Packet
    { propAddress = 1
    , payload = [3, 2, 1]
    }

main :: IO ()
main = do
  testSinglePet
  testMultiplePets
  testSinglePacket
