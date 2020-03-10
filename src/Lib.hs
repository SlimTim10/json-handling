module Lib
  ( Pet(..), Species(..)
  , readPet, readPets
  , getJSON
  ) where

import GHC.Generics
import qualified Data.ByteString.Lazy as B
import Data.Aeson
  ( FromJSON
  , ToJSON
  , parseJSON
  , withObject
  , withText
  , eitherDecode
  , encode
  , (.:)
  )

data Species = Cat | Lizard | Dog
  deriving (Show, Eq, Generic, ToJSON)

instance FromJSON Species where
  parseJSON = withText "Species" $ \text ->
    case text of
      "cat" -> return Cat
      "lizard" -> return Lizard
      "dog" -> return Dog
      _ -> fail "invalid species"

data Pet = Pet
  { name :: String
  , species :: Species
  , colour :: String
  , age :: Int
  } deriving (Show, Generic, FromJSON, ToJSON, Eq)
      
-- instance FromJSON PetJSON where
--   parseJSON = withObject "Pet" $ \o -> do
--     name <- o .: "name"
--     species <- o .: "species"
--     colour <- o .: "colour"
--     age <- o .: "age"
--     -- let name = firstName ++ " " ++ lastName
--     return PetJSON
--       { name = name
--       , species = species
--       , colour = colour
--       , age = age
--       }

getJSON :: FilePath -> IO B.ByteString
getJSON = B.readFile

readPet :: FilePath -> IO (Either String Pet)
readPet fp = do
  bs <- getJSON fp
  return $ eitherDecode bs

readPets :: FilePath -> IO (Either String [Pet])
readPets fp = do
  bs <- getJSON fp
  return $ eitherDecode bs
