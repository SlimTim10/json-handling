module Assert
  ( assert
  ) where

import qualified Data.ByteString.Lazy as B
import Data.Aeson (eitherDecode)

import Lib
  ( PetJSON(..), Pet(..), Species(..)
  , mkPet
  , getJSON
  )

assert :: FilePath -> Pet -> IO ()
assert fp pet = do
  bs <- getJSON fp
  case check bs of
    Left error -> do
      putStrLn failMessage
      putStrLn error
    Right msg -> putStrLn msg
  where
    failMessage = "Test " ++ fp ++ " failed"
    passMessage = "Test " ++ fp ++ " passed"
    check :: B.ByteString -> Either String String
    check bs = do
      petJSON <- eitherDecode bs
      p <- mkPet petJSON
      if p == pet
        then Right passMessage
        else Left "Pets don't match"
