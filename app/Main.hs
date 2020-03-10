module Main where

import Pet
  ( Pet(..)
  , Species(..)
  , DateOfBirth(..)
  )
import Lib
  ( readJSON
  )

main :: IO ()
main = do
  putStrLn "Single pet"
  pet <- readJSON "test/1.json" :: IO (Either String Pet)
  print pet
