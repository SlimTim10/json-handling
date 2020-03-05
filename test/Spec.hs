{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric, DeriveAnyClass #-}
{-# LANGUAGE DuplicateRecordFields, NamedFieldPuns #-}

import Lib
  ( PetJSON(..), Pet(..), Species(..)
  , mkPet
  , getJSON
  )

import GHC.Generics
import qualified Data.ByteString.Lazy as B
import Data.Aeson
  ( eitherDecode
  )

assert :: FilePath -> Pet -> IO ()
assert fp pet = do
  bs <- getJSON fp
  case eitherDecode bs :: Either String PetJSON of
    Left error -> do
      putStrLn failMessage
      print error
    Right petJSON -> case mkPet petJSON of
      Left error -> do
        putStrLn failMessage
        print error
      Right p ->
        if p == pet
        then putStrLn passMessage
        else putStrLn failMessage
  where
    failMessage = "Test " ++ fp ++ " failed"
    passMessage = "Test " ++ fp ++ " passed"
        
main :: IO ()
main = do
  assert "1.json" (Pet {name = "Nermal", species = Cat, colour = "grey", age = 3})
