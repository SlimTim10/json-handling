module Assert
  ( assert
  , assertEither
  ) where

assert :: Eq a => a -> a -> IO ()
assert a b
  | a == b = putStrLn "Assertion passed"
  | otherwise = putStrLn "Assertion failed"

assertEither :: Eq a => Either String a -> a -> IO ()
assertEither (Left error) _ = putStrLn error
assertEither (Right a) b = assert a b
