{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric, DeriveAnyClass #-}
{-# LANGUAGE DuplicateRecordFields, NamedFieldPuns #-}

module Main where

import Lib

import GHC.Generics
import qualified Data.ByteString.Lazy as B
import Data.Aeson
  ( FromJSON
  , ToJSON
  , parseJSON
  , withObject
  , eitherDecode
  , encode
  , (.:)
  )

data Species = Cat | Lizard | Dog
  deriving (Show)

data PetJSON = PetJSON
  { name :: String
  , species :: String
  , colour :: String
  , age :: Int
  } deriving (Show, Generic, ToJSON)

data Pet = Pet
  { name :: String
  , species :: Species
  , colour :: String
  , age :: Int
  } deriving (Show)

parseSpecies :: String -> Either String Species
parseSpecies "cat" = Right Cat
parseSpecies "lizard" = Right Lizard
parseSpecies "dog" = Right Dog
parseSpecies _ = Left "Invalid species"

mkPet :: PetJSON -> Either String Pet
mkPet PetJSON {name, species, colour, age}
  | age < 0 = Left "Invalid age"
  | otherwise = do
      s <- parseSpecies species
      return Pet
        { name = name
        , species = s
        , colour = colour
        , age = age
        }

instance FromJSON PetJSON where
  parseJSON = withObject "Pet" $ \o -> do
    name <- o .: "name"
    species <- o .: "species"
    colour <- o .: "colour"
    age <- o .: "age"
    -- let name = firstName ++ " " ++ lastName
    return PetJSON
      { name = name
      , species = species
      , colour = colour
      , age = age
      }

jsonFile :: FilePath
jsonFile = "1.json"

getJSON :: IO B.ByteString
getJSON = B.readFile jsonFile

main :: IO ()
main = do
  bs <- getJSON
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
