module Packet
  ( Packet(..)
  ) where

import GHC.Generics (Generic)
import Data.Aeson
  ( FromJSON
  , ToJSON
  )

data Packet = Packet
  { propAddress :: Int
  , payload :: [Int]
  }
  deriving (Show, Eq, Generic, ToJSON, FromJSON)
