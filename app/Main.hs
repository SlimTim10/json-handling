module Main where

import Lib
  ( Pet(..), Species(..)
  , readPet
  )

main :: IO ()
main = do
  putStrLn "Single pet"
  pet <- readPet "test/1.json"
  print pet

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
