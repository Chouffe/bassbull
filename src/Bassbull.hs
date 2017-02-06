module Bassbull where

import qualified Data.ByteString.Lazy as BL
import           Data.Csv
import qualified Data.Csv.Streaming   as CS
import qualified Data.Foldable        as F
import           Data.Maybe           (fromMaybe)
import qualified Data.Vector          as V

type BaseballStats = (BL.ByteString, Maybe Int, BL.ByteString, Maybe Int)

baseballStats :: BL.ByteString -> Either String (V.Vector BaseballStats)
baseballStats = decode NoHeader

-- Streaming version
baseballStats2 :: BL.ByteString -> CS.Records BaseballStats
baseballStats2 = CS.decode NoHeader

fourth :: (a, b, c, d) -> d
fourth (_, _, _, d) = d

summer :: (a, b, c, Maybe Int) -> Int -> Int
summer = (+) . fromMaybe 0 .fourth

-- FilePath is just an alias for String
getAtBatsSum :: FilePath -> IO (Either String Int)
getAtBatsSum battingCsv = do
  csvData <- BL.readFile battingCsv
  return $ fmap (V.foldr summer 0) (baseballStats csvData)

getAtBatsSumStreaming :: FilePath -> IO Int
getAtBatsSumStreaming battingCsv = do
  csvData <- BL.readFile battingCsv
  return $ F.foldr summer 0 (baseballStats2 csvData)
