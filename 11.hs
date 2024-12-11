import System.IO
import Data.List.Split (splitOn)
import Control.Monad (forM)

numDigits :: Int -> Int
numDigits n
  | n == 0 = 1
  | n < 0  = numDigits(-n)
  | otherwise = length (show n)

splitNum :: Int -> [Int]
splitNum n
  | n < 10    = [n, 0]
  | otherwise = 
    let str = show n 
        len = length str
        (h1, h2) = splitAt (len `div` 2) str
    in [read h1, read h2]

transform1 :: [Int] -> [Int]
transform1 nums = concatMap modfiy nums 
  where
    modfiy n
      | n == 0             = [1]
      | even (numDigits n)  = splitNum n
      | otherwise          = [n * 2024]

run :: [Int] -> Int -> IO [Int]
run nums 0 = return nums
run nums n = do
  let newacc = transform1 nums
  putStr (show n)
  putStr " "
  print (length newacc)
  run newacc (n - 1)

main :: IO ()
main = do 
  -- Read file into nums
  contents <- readFile "input" 
  let nums = map (read::String->Int) (words contents)

  print (nums)

  -- Loop 25 times
  print "Loop 25"
  result <- run nums 25
  print (length result) 

  -- Loop 75 times
  print "Loop 75"
  result2 <- run nums 75
  print (length result2)
