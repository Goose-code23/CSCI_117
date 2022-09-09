-- CSci 117, Lab 1:  Introduction to Haskell

---------------- Part 1 ----------------

-- WORK through Chapters 1 - 3 of LYaH. Type in the examples and make
-- sure you understand the results.  Ask questions about anything you
-- don't understand! This is your chance to get off to a good start
-- understanding Haskell.

--min 9 10 
-- 9
-- div 92 10
-- 9
--doubleMe x = x + x
--doubleMe 9
--18
--doubleMe 8.3
--16.6
-- succ 9 + max 5 4 + 1
-- 16 
-- succ 8
--9
-- 5==5
--5
--doubleUs x y = x*2 + y*2
--doubleUs 4 9 
--26
--doubleUs 2.3 34.2
--73.0
--doubleUs 28 88 + doubleMe 123
--478

---------------- Part 2 ----------------

-- The Haskell Prelude has a lot of useful built-in functions related
-- to numbers and lists.  In Part 2 of this lab, you will catalog many
-- of these functions.

-- Below is the definition of a new Color type (also called an
-- "enumeration type").  You will be using this, when you can, in
-- experimenting with the functions and operators below.
data Color = Red | Orange | Yellow | Green | Blue | Violet
     deriving (Show, Eq, Ord, Enum)
 
--succ Red
-- (1)For each of the Prelude functions listed below, give its type,
-- (2)describe briefly in your own words what the function does, answer
-- any questions specified, and give several examples of its use,
-- (3)including examples involving the Color type, if appropriate (note
-- that Color, by the deriving clause, is an Eq, Ord, and Enum type).
-- Include as many examples as necessary to illustration all of the
-- features of the function.  Put your answers inside {- -} comments.
-- I've done the first one for you (note that "λ: " is my ghci prompt).


-- succ, pred ----------------------------------------------------------------

{- 
succ :: Enum a => a -> a
pred :: Enum a => a -> a

For any Enum type, succ gives the next element of the type after the
given one, and pred gives the previous. Asking for the succ of the
last element of the type, or the pred of the first element of the type
results in an error.

λ: succ 5
6
λ: succ 'd'
'e'
λ: succ False
True
λ: succ True
*** Exception: Prelude.Enum.Bool.succ: bad argument
λ: succ Orange
Yellow
λ: succ Violet
*** Exception: succ{Color}: tried to take `succ' of last tag in enumeration
CallStack (from HasCallStack):
  error, called at lab1.hs:18:31 in main:Main
λ: pred 6
5
λ: pred 'e'
'd'
λ: pred True
False
λ: pred False
*** Exception: Prelude.Enum.Bool.pred: bad argument
λ: pred Orange
Red
λ: pred Red
*** Exception: pred{Color}: tried to take `pred' of first tag in enumeration
CallStack (from HasCallStack):
  error, called at lab1.hs:18:31 in main:Main
-}


-- toEnum, fromEnum, enumFrom, enumFromThen, enumFromTo, enumFromThenTo -------
-- As one of your examples, try  (toEnum 3) :: Color --------------------------
{-
(toEnum) :: Enum a => Int -> a

toEnum is an Enum type when implemented will return the value from a list or a dataset.

-- (toEnum 3) :: Color
-- Green
-- (toEnum 4) :: Color
-- Blue
-- (toEnum 0) :: Color
-- Red
--(toEnum 1) :: Color 
--Orange

(fromEnum) :: Enum a => a -> Int

fromEnum is an Enum type and when the function is implemented will give you which index the value is located at in a list or a dataset. 

-- fromEnum Red
-- 0
-- fromEnum Yellow
--2
-- fromEnum Blue
-- 4
-- fromEnum Green
-- 3

(fromEnum) :: Enum a => a -> Int

enumFrom is an Enum type and when implemented will return a list from the index you implemented it at 

--enumFrom Red
--[Red,Orange,Yellow,Green,Blue,Violet]
--enumFrom Green
--[Green,Blue,Violet]
--enumFrom Blue
--[Blue,Violet]
--enumFrom Violet
--[Violet]

(enumFromThen) :: Enum a => a -> a -> [a]

enumFromThen is an Enum type and when implemented will create a new list or dataset from the first argument to the second one with internal between the two
--enumFromThen Red Yellow
--[Red,Yellow,Blue]
--take 5 (enumFromThen 0 2)
--[0,2,4,6,8]
-take 10 (enumFrom 0 2)
--[0,2,4,6,8,10,12,14,16,18]

(enumFromTo) :: Enum a => a -> a -> [a]

enumFromTo is an Enum type and when implemented will create a new list or dataset from the first argument to the second one.

--enumFromTo Red Blue
--[Red,Orange,Yellow,Green,Blue]
--enumFromTo Red Yellow
--[Red,Orange,Yellow]
--enumFromTo Yellow Blue
--[Yellow,Green,Blue]
--enumFromTo Yellow Violet
--[Yellow,Green,Blue,Violet]

(enumFromThenTo) :: Enum a => a -> a -> a -> [a]
 
enumFromThento is an Enum type and when implemented it will create a new dataset from the first element to the last element and the difference between the first and second element 

--numFromThenTo Red Yellow Blue
--[Red,Yellow,Blue]
--enumFromThenTo Red Orange Blue
[Red,Orange,Yellow,Green,Blue]
--enumFromThenTo Red Yellow Green
--[Red,Yellow]

-}

-- ==, /= 

{-

(==) :: Eq a => a -> a -> Bool
(/=) :: Eq a => a -> a -> Bool

Both == and /= are Boolean types and test for equality and inequality and return a boolean value

--Red == Blue
--False
--10 == 10
--True
-- 9 ==10
--False
--9 /= 10
--True
--9 /= 9
--False
--Red /= Blue
--True
-}


-- quot, div (Q: what is the difference? Hint: negative numbers) 
{-

quot :: Integral a => a -> a -> a
div :: Integral a => a -> a -> a

 both quot and div take two int or floats as arguments and divide the first by the second. 

 when quot is performing its division it will round toward zero
 qout return zero if the number being divided is less than the other

 --quot 4 2
 --2
 -- quot 16 4
 --4
 --quot 8 12
 --0
 --quot 20 2
 --10
 
 div like stated before will divide the first number by the second 
 div will also return zero if the divisor is larger however div will return -1 if the absolute value is less   
 than the divisor
 
 --10 `div` 2
 --5
 --div 2 (-5)
 -- (-1)
 --div 12 6 
 --2
 -- div 10 5
 --2


-}

-- rem, mod  (Q: what is the difference? Hint: negative numbers) {-
 rem :: Integral a => a -> a -> a
 mod :: Integral a => a -> a -> a

 The rem function will return the remainder after dividing the first argument by the second argument 
 rem will also return the dividend if the dividend is less than the divisor.
 --rem 12 15
 --12
 --rem 43 5
 --3
 --rem (-2) 12
 --(-2)
 --rem 17 (-2)
 --1

 The mod function returns the remainder from the first argument and second argument. 
 mod will return the absolute value of the dividend and the divisor
 --mod (-15) 6
 --3
 --mod (17) 2
 --1
 --mod 15 4
 --3

 
-}

-- quotRem, divMod 
{- 
 quotRem :: Integral a => a -> a -> (a, a)
 divMod :: Integral a => a -> a -> (a, a)

 quotRem function will divide the first argument by the second and return a tuple of the remanider
 --quotRem 15 4
 --(3,3)
 --quotRem 26 3
 --(8,2)
 --quotRem 23 6
 --(3,5)

 divMod is the same as quotRem as it will return a a tuple of the remainder
 --divMod 45 7
 --(6,3)
 --divMod 5 2 
 --(2,1)
 --divMod 9 14
 --(0,9)

-}

-- &&, || 
{-

(&&) :: Bool -> Bool -> Bool
(||) :: Bool -> Bool -> Bool

 The and (&&) operator is a boolean type that requires two arguments to be true in order to evaluate to true
 -- 5 == 5 && 6==6
 --True
 -- 5 == 4 && 5 == 5
 --False
 --Red == Red && Blue == Green
 --False
 --Red == Red && Blue == Blue
 --True

 The or(||) operator is used when we want just one argument to be true to continue our program
 --Red == Red || Blue == Green
 --True
 --Red == Red || Blue == Blue
 --True
 --5 == 5 || 4 == 3
 --True
 --5 == 5 || 4 == 89
 --True
-}

-- ++ 
{-
(++) :: [a] -> [a] -> [a]
 The (++) operator is part of the Read type we use this operator to concatenate two strings or datasets
 --[["Duck", "Duck"] ++ ["Goose"]
 --["Duck","Duck","Goose"]

 --2,4,5,8,1,9] ++ [2,3,90,1]
 --[2,4,5,8,1,9,2,3,90,1]

 --[2,4,5,8,1,9] ++ [2,4,6,8,10,12]
 --[2,4,5,8,1,9,2,4,6,8,10,12]
-}

-- compare 
{-

 compare :: Ord a => a -> a -> Ordering

 The compare is part of the Ord typeclass where it will compare to arguments against each other
 --compare 20 40
 --LT
 --compare 10 2
 --GT
 --compare "Goose" "Duck"
 --GT
 --compare "Goose" "Dog"
 --GT

-}

-- <, > 
{-
(<) :: Ord a => a -> a -> Bool
(>) :: Ord a => a -> a -> Bool

These the greater than and less than operators are both part of the ord class type and will compare the two arguments to determine if the first argument is greater than the second.

The first operator less than (<) will determine if the first argument is less than the second.
Whereas the second operator will determine if the first argument is great than the second one.

 --5 < 3
 --False
 --5 < 5
 --False
 --Red < Blue
 --True
 --5 < 10
 --True
 --5 > 1
 --True
 --Blue > Red
 --True

-}

-- max, min {-
 max - max :: Ord a => a -> a -> a
 min - min :: Ord a => a -> a -> a
 
 The max operator is part of the ord class types and will compare two arguments and return the largest if the two
 The min operator is also part of the ord class type and will return the lowest value between the two arguments.
 --max 90 40
 --90
 --max 100 4
 --100
 -- max 100 200
 --200
 --max Red Blue
 --Blue
 --min Green Red
 --Red
 --min 90 150
 --90
 --min 90 15
 --15

-}

-- ^ 
{-
(^) :: (Integral b, Num a) => a -> b -> a

The Exponential operator will raise a number to the power of the second argument 

 --10^ 2
 --100
 -- 50 ^ 2
 --2500
 --10^ 7
 --10000000
 --7 ^ 5
 --16807

-}
-- concat 
{-
concat :: Foldable t => t [a] -> [a]
 The Concat operator will combine all input from a dataset and removing all commas from the dataset.
 --concat ["Duck", "Duck", "Goose"]
 --"DuckDuckGoose"
 --concat ["a","b","c"]
 --"abc"
 --concat ["a","b","c","z","y","x"]
 --"abczyx"
 --concat [[1,2,3], [4,5,6]]
 --[1,2,3,4,5,6]
-}
-- const {-
const :: a -> b -> a
 Takes the first input and returns that, or uses the first input to do whatever the second input requires'
 --const "food" "Tacos"
 --"food"
 --const 3 5
 --3
 --const "Hello" "GoodBye"
 --"Hello"
-}

-- cycle {-
 cycle :: [a] -> [a]
 The cycle function is used to create multiple repetitions of an argument that can be infinite thus we only take a small part
 --take 12 (cycle "duck")
 --"duckduckduck"
 --take 5 (cycle [1,2,3])
 --[1,2,3,1,2]
 --take 4 (cycle [1,2])
 --[1,2,1,2]
-}

-- drop, take 
{-
drop :: Int -> [a] -> [a]
take :: Int -> [a] -> [a]

The take function will take a number as an argument and take that many elements from the beginning of the list.
 --take 2 [1,2,3,4,5,6]
 --[1,2]
 --take 4 [4,7,2,4,1,5,1]
 --[4,7,2,4]
 --take 3 ["a","p","w","f"]
 --["a","p","w"]
-}

-- elem 
{-
elem :: (Foldable t, Eq a) => a -> t a -> Bool
 The elem function is used to tell us whether the int is in the dataset or not.
 --4 `elem` [3,4,5,6]
 --True
 --"f" `elem` ["f","m","z"]
 --True
 --3 `elem` [4,5,6,7,2,1]
 --False
-}
-- even 
{-
even :: Integral a => a -> Bool
 
The even function will evaluate a whole number and return whether it's a whole number or not. 
 --even  2 
 --True
 --even 3
 --False
 --even 6
 --True
 --even (-4)
 --True
-}
-- fst 
{-

fst :: (a, b) -> a

 The first function is when we are evaluating a pair in a tuple and return the first component

 --fst (4,5)
 --4
 --fst ("Blue", "Red")
 --"Blue"
 --fst (1,2)
 --1
 --fst (1,1000)
 --1
-}

-- gcd 
{-
gcd :: Integral a => a -> a -> a
 The gcd function will return the greatest common divisor between the two arguments.
 --gcd 90 10
 --10
 --gcd 5 50 
 --5
 --gcd 1 50
 --1
 --gcd 500 389
 --1

-}
-- head 
{-
head :: [a] -> a
The head function will return the first element from a dataset  
 --head [1,2,4,5,6]
 --1
 --head [3,4,6,31]
 --3
 --head [5,6,3,12,19]
 --5
-}

-- id 
{-
id :: a -> a
 The id function will return the argument unchanged 
 --id 4
 --4
 --id "Food"
 --"Food"
 --id 6
 --6
-}
-- init 
{-
init :: [a] -> [a]
 The init function will take a list and return everything except the last element.
 --init [1,2,3,4,5]
 --[1,2,3,4]
 --init [1,2,3,4,5,6,7,8]
 --[1,2,3,4,5,6,7]
 --init [2,4,6,8,10,12]
 --[2,4,6,8,10]
-}

-- last 
{-
last :: [a] -> a
 The last function will take a list and return the last element in the list
 --last [1,2,3,4,5,6]
 --6
 --last [5,6,7,4]
 --4
 --last [7,31,10,5]
 --5
 --last [[1,2,3],[4,5,6]]
 --[4,5,6]
-}

-- lcm {-
lcm :: Integral a => a -> a -> a
The lcm is the least common divisor it will take 2 arguments and return the least common divider between the two.
 --lcm 5 10
 --10
 --lcm 20 10
 --20
 --lcm 5 90
 --90
 --lcm 3452 72
 --62136
-}

-- length
{-
length :: Foldable t => t a -> Int
  The length function is used to measure the length of a dataset
 --length [1,2,3,4,5]
 --5
 --length [4,5,6]
 --3
 --length [4,5,6,7,8,9,10]
 --7
 --length [[1,2,3,4,5],[5,6,7,8]]
 --2

-}

-- null {-
null :: Foldable t => t a -> Bool
The null function is used to tell us if a dataset is empty or not 
 --null [1,2,3]
 --False
 --null []
 --True
 --null [5,6,7,9,10]
 --False
 --null [5,6,7]
 --False
-}

-- odd {-
odd :: Integral a => a -> Bool
The odd function is used to tell us whether an int is an odd number or not
 --odd 3
 --True
 -- odd 4
 --False
 --odd 7
 --7
 --odd 1923
 --True
-}

-- repeat {-
repeat :: a -> [a]
 The repeat function is used to repeat an argument and can be infinite if we don't us the take function
 --take 7 (repeat 3)
 --[3,3,3,3,3,3,3]
 --take 15 (repeat 6)
 --[6,6,6,6,6,6,6,6,6,6,6,6,6,6,6]
 --take 7 (repeat 2)
 --[2,2,2,2,2,2,2]
 --take 9 (repeat "Blue")
 --["Blue","Blue","Blue","Blue","Blue","Blue","Blue","Blue","Blue"]
-}

-- replicate {-
 replicate :: Int -> a -> [a]
 The replicate function will take two arguments the first is the number of replication made the second is the number being replicated
 --replicate 3 25
 --[25,25,25]
 --replicate 3 "Foods"
 --["Foods","Foods","Foods"]
 --replicate 4 "Cats"
 ---["Cats","Cats","Cats","Cats"]
 --replicate 4 7
 --[7,7,7,7]
-}

-- reverse 
{-
reverse :: [a] -> [a]

The reverse function is used to reverse a dataset 
 --reverse [1,2,3,4,5]
 --[5,4,3,2,1]
 --reverse [3,7,8,9,2]
 --[2,9,8,7,3]
 --reverse [3,7,321,13]
 --[13,321,7,3]
 --reverse [18,12,30,56,90]
 --[90,56,30,12,18]
-}

-- snd {-
snd :: (a, b) -> b
The snd function take a pair of tuples and returns the second int
 --snd (7,5)
 --5
 --snd (90,32)
 --32
 --snd (132,958)
 --958
 --snd ("Blue","Red")
 --"Red"
-}

-- splitAt
{-
splitAt :: Int -> [a] -> ([a], [a])
 Takes an integer and a dataset and splits them into two dataset.
 --splitAt 2 [1,2,3,4,5,6]
 --([1,2],[3,4,5,6])
 --splitAt 3 [4,5,6,7,8]
 --([4,5,6],[7,8])
 --splitAt 4 ["foo","moo","doo","cow","dog","Cat"]
 --(["foo","moo","doo","cow"],["dog","Cat"])
-}

-- zip {-
zip :: [a] -> [b] -> [(a, b)]
 
 The zip function takes two datasets and zips them together into one data set 

 --zip [1,2,3,4,5] ['a','b','c','d','e']
 --[(1,'a'),(2,'b'),(3,'c'),(4,'d'),(5,'e')]
 --zip ["food","dogs","cats"] [1,2,3]
 --[("food",1),("dogs",2),("cats",3)]
 --zip [11,12,13,14,15] [1,2,3,4,5]
 --[(11,1),(12,2),(13,3),(14,4),(15,5)]
 --zip [1,2,3,4,5] [5,6,7,8,9,10]
 --[(1,5),(2,6),(3,7),(4,8),(5,9)]
-}


-- The rest of these are higher-order, i.e., they take functions as
-- arguments. This means that you'll need to "construct" functions to
-- provide as arguments if you want to test them.

-- all, any {-
any :: Foldable t => (a -> Bool) -> t a -> Bool
all :: Foldable t => (a -> Bool) -> t a -> Bool

 The all function determines whether all elements of the struture satisfy the predicate
 --all (<5) [1,2,3,4]
 --True
 --all (<5) [5,6,7,8,9,10]
 --False
 --all (>7) [1,2,3,4,5]
 --False
 --all (<7) [4,5,6]
 --True
 
The any function determines whether any of the structure satisfies the predicate 
 --any (<6) [1,7,12,2]
 --True
 --any (2>) [1,4,54,12,90]
 --True
 --any (2>) [4,5,6,7,8,9]
 --False
 --any (<4) [1,2,3]
 --True

-}

-- break {-
break :: (a -> Bool) -> [a] -> ([a], [a])
 The break function is used to break a function depending on if the number used is great than or less than the number used in the dataset
 --break (<2) [1,2,3,4,5,6]
([],[1,2,3,4,5,6])
 --break (>2) [1,2,3,4,5]
([1,2],[3,4,5])
 --break (>1) [1,2,3,4,5]
([1],[2,3,4,5])

-}

-- dropWhile, takeWhile {-
dropWhile :: (a -> Bool) -> [a] -> [a]
takeWhile :: (a -> Bool) -> [a] -> [a]

The takeWhile function will return a dataset up until the parameter is no longer fulfilled
--takeWhile (<10) [1,2,3,4,5,11,12,13,14]
[1,2,3,4,5]
--takeWhile (<4) [1,2,3,5,6,7]
[1,2,3]
--takeWhile (<2) [1,2,3,4,5]
[1]
 
The dropWhile function will return a dataset up until the parameter is no longer fulfilled 
--dropWhile (>2) [1,2,3,4,5]
[1,2,3,4,5]
--dropWhile (>5) [1,2,4,6,7,8,9]
[1,2,4,6,7,8,9]
 
-}

-- filter {-
filter :: (a -> Bool) -> [a] -> [a]
The filter function is used to filter all number that don't satisfy the parameter
--filter (>5) [1,2,3,6,7,8]
[6,7,8]
--filter (<5) [1,2,3,6,7,8]
[1,2,3]
-}

-- iterate {-
iterate :: (a -> a) -> a -> [a]
 The integrate function is used to repeat a task that can be infinite without constraints 
 --take 5 (iterate (^2) 2)
  [2,4,16,256,65536]
 --take 3 (iterate(^4) 3)
[3,81,43046721]

-}

-- map {-
map :: (a -> b) -> [a] -> [b]
The map function always us to apply parameter to all element of a dataset
--map (/4) [2,4,6,8,10]
[0.5,1.0,1.5,2.0,2.5]
--map (*4) [2,4,5,6]
[8,16,20,24]
-}

-- span {-
span :: (a -> Bool) -> [a] -> ([a], [a])
The span function is used to evaluate a dataset whether the element in the dataset satisfies the constraints

--  span (<5) [1,3,5,7,9]
  ([1,3],[5,7,9])  
--span (>2) [1,2,4,5,6]
([],[1,2,4,5,6])
-}

