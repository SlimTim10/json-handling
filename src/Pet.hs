module Pet
  ( Pet(..)
  , Species(..)
  , DateOfBirth(..)
  ) where

import GHC.Generics (Generic)
import Data.Aeson
  ( FromJSON
  , ToJSON
  , parseJSON
  , withText
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

data DateOfBirth = DateOfBirth
  { year :: Int
  , month :: Int
  , day :: Int
  }
  deriving (Show, Eq, Generic, ToJSON, FromJSON)

data Pet = Pet
  { name :: String
  , species :: Species
  , colour :: String
  , dob :: DateOfBirth
  } deriving (Show, Eq, Generic, ToJSON, FromJSON)
