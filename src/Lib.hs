module Lib
  ( PetJSON(..), Pet(..), Species(..)
  , mkPet
  , getJSON
  ) where

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
  deriving (Show, Eq)

data PetJSON = PetJSON
  { name :: String
  , species :: String
  , colour :: String
  , age :: Int
  } deriving (Show, Generic, ToJSON, Eq)

data Pet = Pet
  { name :: String
  , species :: Species
  , colour :: String
  , age :: Int
  } deriving (Show, Eq)

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

getJSON :: FilePath -> IO B.ByteString
getJSON = B.readFile
