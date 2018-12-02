--- Part Two ---
-- You notice that the device repeats the same frequency change list over and over.
-- To calibrate the device, you need to find the first frequency it reaches twice.
--
-- For example, using the same list of changes above, the device would loop as
-- follows:
--
-- Current frequency  0, change of +1; resulting frequency  1. Current frequency
-- 1, change of -2; resulting frequency -1. Current frequency -1, change of +3;
-- resulting frequency  2. Current frequency  2, change of +1; resulting frequency
-- 3. (At this point, the device continues from the start of the list.) Current
-- frequency  3, change of +1; resulting frequency  4. Current frequency  4, change
-- of -2; resulting frequency  2, which has already been seen. In this example, the
-- first frequency reached twice is 2. Note that your device might need to repeat
-- its list of frequency changes many times before a duplicate frequency is found,
-- and that duplicates might be found while in the middle of processing the list.
--
-- Here are other examples:
--
-- +1, -1 first reaches 0 twice. +3, +3, +4, -2, -4 first reaches 10 twice. -6, +3,
-- +8, +5, -6 first reaches 5 twice. +7, +7, -2, -7, -4 first reaches 14 twice.
-- What is the first frequency your device reaches twice?
--
import Data.Set as Set (Set, fromList, insert)

signedInt :: String -> Integer
signedInt s = if (head s) == '-'
  then read s :: Integer
  else read(tail s) :: Integer

-- sumSet :: Int -> [Integer] -> Set Integer
-- sumSet a b = sumSet_b a
--   where
--     sumSet_b a
--       | a == 0 = fromList [0]
--       | otherwise = newSet
--       where
--         newSet = insert (b !! a) (sumSet (a - 1) b)
--     sumSets = map sumSet_b [0 ..]

subSum :: Int -> [Integer] -> Integer
subSum a b = subSum_b a
  where
    subSum_b a
      | a == 0 = 0
      | otherwise = newSum
      where
        newSum = (b !! a) + (subSum (a - 1) b)
    subSums = map subSum_b [0 ..]

main = do
  s <- readFile("./01a.txt")
  let ns = map signedInt (lines s)
  let s = sum ns
  print s
  -- let sums = [ subSum i (cycle ns) | i <- [1..10000] ]
  -- let sums = fold subSum
  -- let uniq = [ x | x <- sums, x `elem` sums ]
  -- let x = uniq !! 1
  -- print x
