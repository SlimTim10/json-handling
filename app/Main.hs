module Main where

import Lib
  ( readJSON
  )
import Pet
  ( Pet(..)
  , Species(..)
  , DateOfBirth(..)
  )
import Packet
  ( Packet(..)
  )

import Data.Aeson
  ( encode
  )

main :: IO ()
main = do
  putStrLn "Single pet"
  nermal <- readJSON "test/nermal.json" :: IO (Either String Pet)
  print nermal
  print . encode $ Packet 0x00000001 [0x03, 0x02, 0x01]
