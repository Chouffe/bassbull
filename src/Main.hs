module Main where

import           Bassbull

-- It uses as much memory as it takes to store the entire CSV file in memory
action1 :: IO ()
action1 = do
  summed <- getAtBatsSum "batting.csv"
  putStrLn $ "Total atBats was: " ++ show summed

-- Use Streaming to load one row at a time
action2 :: IO ()
action2 = do
  summed <- getAtBatsSumStreaming "batting.csv"
  putStrLn $ "Total atBats was: " ++ show summed

main :: IO ()
main = action2
