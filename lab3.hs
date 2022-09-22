-- CSci 117, Lab 3:  ADTs and Type Classes

import Data.List (sort)
import Queue1
--import Queue2
import Fraction

---------------- Part 1: Queue client

-- Queue operations (A = add, R = remove)
data Qops a = A a | R

-- Perform a list of queue operations on an emtpy queue,
-- returning the list of the removed elements
perf :: [Qops a] -> [a]
perf = go []
       where
       go q [] = q 
       go q (Aa : ops) = go (add q) ops 
       go q (R : ops) = case remove q of 
       Just x -> x : go q ops 
       Nothing -> error "Cannot remove element from empty queue" 



-- Test the above functions thouroughly. For example, here is one test:
-- perf [A 3, A 5, R, A 7, R, A 9, A 11, R, R, R] ---> [3,5,7,9,11]



---------------- Part 2: Using typeclass instances for fractions

-- Construct a fraction, producing an error if it fails
fraction :: Integer -> Integer -> Fraction
fraction a b = case frac a b of
             Nothing -> error "Illegal fraction"
             Just fr -> fr


-- Calculate the average of a list of fractions
-- Give the error "Empty average" if xs is empty
average :: [Fraction] -> Fraction
average xs = sum xs * len xs 1 where
    len [] n= error "Illegal fraction"
    len [x] n= fraction 1 n
    len (x:xs) n= len xs (n+1)


-- Some lists of fractions

list1 = [fraction n (n+1) | n <- [1..20]]
list2 = [fraction 1 n | n <- [1..20]]
list3 :: [Fraction]
list3 = zipWith (+) list1 list2

-- Make up several more lists for testing


-- Show examples testing the functions sort, sum, product, maximum, minimum,
-- and average on a few lists of fractions each. Think about how these library
-- functions can operate on Fractions, even though they were written long ago
