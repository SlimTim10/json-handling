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
import Packet (Packet(..))
import qualified Packet as P

import qualified Data.ByteString.Char8 as BS
import Data.Char (chr)

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

testValidPackets = do
  putStrLn "Valid packets"
  let raw = BS.pack . map chr $ [0,0,0,1,3,3,2,1]
  assert (P.validPacket raw) True
  let raw = BS.pack . map chr $ [0,0,0,1,1,0]
  assert (P.validPacket raw) True

testInvalidPackets = do
  putStrLn "Invalid packets"
  let raw = BS.pack . map chr $ []
  assert (P.validPacket raw) False
  let raw = BS.pack . map chr $ [0,0,0,1]
  assert (P.validPacket raw) False
  let raw = BS.pack . map chr $ [0,0,0,1,1]
  assert (P.validPacket raw) False
  let raw = BS.pack . map chr $ [0,0,0,1,1,0,0]
  assert (P.validPacket raw) False
  let raw = BS.pack . map chr $ [0,0,0,1,3,0,0]
  assert (P.validPacket raw) False

testCreatePacket = do
  putStrLn "Create packet from raw bytes"
  let raw = BS.pack . map chr $ [0,0,0,1,3,3,2,1]
  assert
    (P.fromBytes raw)
    (Just (Packet {propAddress = 1, payload = [3,2,1]}))

main :: IO ()
main = do
  testSinglePet
  putStrLn ""
  testMultiplePets
  putStrLn ""
  testSinglePacket
  putStrLn ""
  testValidPackets
  putStrLn ""
  testInvalidPackets
  putStrLn ""
  testCreatePacket
