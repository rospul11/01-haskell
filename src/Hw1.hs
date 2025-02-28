{- | CSE 114A: Intro to Haskell Assignment.
     Do not change the skeleton code!

     You may only replace the `error "TBD:..."` parts.

     For this assignment, you may use any library function on integers
     but only the following library functions on lists:

     length
     (++)
     (==)

 -}

module Hw1 where

import Prelude  hiding (replicate, sum, reverse)


-- | Sum the elements of a list
--
-- >>> sumList [1, 2, 3, 4]
-- 10
--
-- >>> sumList [1, -2, 3, 5]
-- 7
--
-- >>> sumList [1, 3, 5, 7, 9, 11]
-- 36

-- used slides for this
sumList :: [Int] -> Int
sumList [] = 0
sumList (x:xs) = x + sumList(xs) 


-- | `digitsOfInt n` should return `[]` if `n` is not positive,
--    and otherwise returns the list of digits of `n` in the
--    order in which they appear in `n`.
--
-- >>> digitsOfInt 3124
-- [3, 1, 2, 4]
--
-- >>> digitsOfInt 352663
-- [3, 5, 2, 6, 6, 3]

digitsOfInt :: Int -> [Int]
digitsOfInt n
    | n <= 0    = []   
    | otherwise = go n  
    where
        go 0 = []                               -- Base case
        go num = go (num `div` 10) ++ [num `mod` 10]  
-- the num 'div' 10 is basically dividing the given num by 10 
{-
Memory:

num = 3124
3124/ 10 = 312 (new num)
3124 mod 10 = 4 (Which gets added to the list) [4]
312 / 10 = 31 (new num)
312 mod 10 = 2 [24]
31 / 10 = 3
31 mod 10 = 1 [124]
3/10 = 0
3 mod 10 = 3 [3124]
Base Case reached n = 0 returns 0

-}

-- | `digits n` returns the list of digits of `n`
--
-- >>> digits 31243
-- [3,1,2,4,3]
--
-- digits (-23422)
-- [2, 3, 4, 2, 2]

digits :: Int -> [Int]
digits n = digitsOfInt (abs n)


-- | From http://mathworld.wolfram.com/AdditivePersistence.html
--   Consider the process of taking a number, adding its digits,
--   then adding the digits of the number derived from it, etc.,
--   until the remaining number has only one digit.
--   The number of additions required to obtain a single digit
--   from a number n is called the additive persistence of n,
--   and the digit obtained is called the digital root of n.
--   For example, the sequence obtained from the starting number
--   9876 is 9876 -> 30 -> 3, so 9876 has
--   an additive persistence of 2 and
--   a digital root of 3.
--
-- NOTE: assume additivePersistence & digitalRoot are only called with positive numbers

-- >>> additivePersistence 9876
-- 2

-- >>> additivePersistence 99999
-- 2

additivePersistence :: Int -> Int
additivePersistence n 
    | n < 10    = 0  -- Base case: single-digit numbers have additive persistence 0
    | otherwise = 1 + additivePersistence (sumList(digitsOfInt n))

-- | digitalRoot n is the digit obtained at the end of the sequence
--   computing the additivePersistence

-- >>> digitalRoot 9876
-- 3

-- >>> digitalRoot 99999
-- 9

digitalRoot :: Int -> Int
digitalRoot n 
    | n < 10    = n  -- Base case: single-digit numbers have the same digital root
    | otherwise = digitalRoot (sumList (digitsOfInt n))


-- | listReverse [x1,x2,...,xn] returns [xn,...,x2,x1]
--
-- >>> listReverse []
-- []
--
-- >>> listReverse [1,2,3,4]
-- [4,3,2,1]
--
-- >>> listReverse ["i", "want", "to", "ride", "my", "bicycle"]
-- ["bicycle", "my", "ride", "to", "want", "i"]

listReverse :: [a] -> [a]
listReverse [] = []               -- Base case: an empty list is reversed to an empty list
listReverse (x:xs) = listReverse xs ++ [x]  -- Reverse the rest of the list and append x to the end


-- | In Haskell, a `String` is a simply a list of `Char`, that is:
--
-- >>> ['h', 'a', 's', 'k', 'e', 'l', 'l']
-- "haskell"
--
-- >>> palindrome "malayalam"
-- True
--
-- >>> palindrome "myxomatosis"
-- False

palindrome :: String -> Bool
palindrome w = w == listReverse w
