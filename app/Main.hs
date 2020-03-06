module Main where

import Lib
  ( PetJSON, Pet
  , mkPet
  , getJSON
  )

import GHC.Generics
import qualified Data.ByteString.Lazy as B
import Data.Aeson
  ( eitherDecode
  )

main :: IO ()
main = do
  bs <- getJSON "1.json"
  case eitherDecode bs :: Either String PetJSON of
    Left error -> print error
    Right petJSON -> case mkPet petJSON of
      Left error -> print error
      Right pet -> print pet

-- main :: IO ()
-- main = do
--   bs <- getJSON
--   let pet = toString $ (decode bs :: Maybe PetJSON)
--   print pet

-- toString :: Maybe PetJSON -> String
-- toString (Just petJSON) = do
--   pet <- mkPet petJSON
--   return $ pet
-- toString Nothing = "Invalid JSON"
