module Main where

import           Bassbull
import           Test.Hspec

main :: IO ()
main = hspec $ do
  describe "Verify that bassbull outputs the correct data" $ do
    it "equals 4858210" $ do
      summed <- getAtBatsSum "batting.csv"
      summed `shouldBe` Right 4858210
