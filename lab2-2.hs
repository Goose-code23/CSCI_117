-- CSci 117, Lab 2:  Functional techniques, iterators/accumulators,
-- and higher-order functions. Make sure you test all of your functions,
-- including key tests and their output in comments after your code.


---- Part 1: Basic structural recursion ----------------

-- 1. Merge sort

-- Deal a list into two (almost) equal-sizes lists by alternating elements
-- For example, deal [1,2,3,4,5,6,7] = ([1,3,5,7], [2,4,6])
-- and          deal   [2,3,4,5,6,7] = ([2,4,6], [3,5,7])
-- Hint: notice what's happening between the answers to deal [2..7] and
-- deal (1:[2..7]) above to get an idea of how to approach the recursion
deal :: [a] -> ([a],[a])
deal [] = ([],[])
deal (x:xs) = let (ys,zs) = deal xs
              in (x:zs,ys)

-- Now implement merge and mergesort (ms), and test with some
-- scrambled lists to gain confidence that your code is correct
merge :: Ord a => [a] -> [a] -> [a]
merge [] ys = ys
merge xs [] = xs
merge (x:xs) (y:ys)
  | x <= y = x : merge xs(y:ys)
  | x > y  = y : merge (x:xs) ys

ms :: Ord a => [a] -> [a]
ms [] = []
ms [x] = [x]
ms xs = merge (ms n) (ms m)   -- general case: deal, recursive call, merge
        where (n,m)=deal xs

-- 2. A backward list data structure 

-- Back Lists: Lists where elements are added to the back ("snoc" == rev "cons")
-- For example, the list [1,2,3] is represented as Snoc (Snoc (Snoc Nil 1) 2) 3
data BList a = Nil | Snoc (BList a) a deriving (Show,Eq)

-- Add an element to the beginning of a BList, like (:) does
cons :: a -> BList a -> BList a
cons x Nil = Snoc Nil x
cons v1 (Snoc box v2) = Snoc (cons v1 box) v2

-- Convert a usual list into a BList (hint: use cons in the recursive case)
toBList :: [a] -> BList a
toBList [] = Nil
toBList (b:box) = cons b (toBList box) 

-- Add an element to the end of an ordinary list
snoc :: [a] -> a -> [a]
snoc [] n = [n]
snoc(b:box)c = b: snoc box c 

-- Convert a BList into an ordinary list (hint: use snoc in the recursive case)
fromBList :: BList a -> [a]
fromBList Nil = []
fromBList (Snoc box b) = snoc (fromBList box) b 


-- 3. A binary tree data structure
data Tree a = Empty | Node a (Tree a) (Tree a) deriving (Show, Eq)

-- Count number of Empty's in the tree
num_empties :: Tree a -> Int
num_empties = undefined

-- Count number of Node's in the tree
num_nodes :: Tree a -> Int
num_nodes = undefined

-- Insert a new node in the leftmost spot in the tree
insert_left :: a -> Tree a -> Tree a
insert_left = undefined

-- Insert a new node in the rightmost spot in the tree
insert_right :: a -> Tree a -> Tree a
insert_right = undefined

-- Add up all the node values in a tree of numbers
sum_nodes :: Num a => Tree a -> a
sum_nodes = undefined

-- Produce a list of the node values in the tree via an inorder traversal
-- Feel free to use concatenation (++)
inorder :: Tree a -> [a]
inorder = undefined


-- 4. A different, leaf-based tree data structure
data Tree2 a = Leaf a | Node2 a (Tree2 a) (Tree2 a) deriving Show

-- Count the number of elements in the tree (leaf or node)
num_elts :: Tree2 a -> Int
num_elts (Leaf x) = 1
num_elts (Node2 bt l r) = (num_elts l) + (num_elts r) + 1 

-- Add up all the elements in a tree of numbers
sum_nodes2 :: Num a => Tree2 a -> a
sum_nodes2 (Leaf x) = x
sum_nodes2 (Node2 bt l r) = (sum_nodes2 l) + (sum_nodes2 r) + bt


-- Produce a list of the elements in the tree via an inorder traversal
-- Again, feel free to use concatenation (++)
inorder2 :: Tree2 a -> [a]
inorder2 (Leaf x) = [x]
inorder2 (Node2 bt l r) = inorder2 l ++ [bt] ++ inorder2 r


-- Convert a Tree2 into an equivalent Tree1 (with the same elements)
conv21 :: Tree2 a -> Tree a
conv21 (Leaf x) = (Node x Empty Empty) 
conv21 (Node2 bt l r) = Node bt (conv21 l)  (conv21 r) 


---- Part 2: Iteration and Accumulators ----------------


-- Both toBList and fromBList from Part 1 Problem 2 are O(n^2) operations.
-- Reimplement them using iterative helper functions (locally defined using
-- a 'where' clause) with accumulators to make them O(n)
toBList' :: [a] -> BList a
toBList' x= toBList_it x where
  toBList_it :: [a]->BList a
  toBList_it []=Nil
  toBList_it (x:xs)= cons x(toBList_it xs)

fromBList' :: BList a -> [a]
fromBList' x = fromBList_it x where
  fromBList_it :: BList a->[a]
  fromBList_it Nil = []
  fromBList_it (Snoc Nil a)=[a]
  fromBList_it (Snoc b a) = snoc (fromBList_it b)a


-- Even tree functions that do multiple recursive calls can be rewritten
-- iteratively using lists of trees and an accumulator. For example,
sum_nodes' :: Num a => Tree a -> a
sum_nodes' t = sum_nodes_it [t] 0 where
  sum_nodes_it :: Num a => [Tree a] -> a -> a
  sum_nodes_it [] a = a
  sum_nodes_it (Empty:ts) a = sum_nodes_it ts a
  sum_nodes_it (Node n t1 t2:ts) a = sum_nodes_it (t1:t2:ts) (n+a)

-- Use the same technique to convert num_empties, num_nodes, and sum_nodes2
-- into iterative functions with accumulators

num_empties' :: Tree a -> Int
num_empties' t = nmties [t] 0 where
  nmties [] a=a
  nmties (Empty:ts) a= nmties ts (a+1)
  nmties (Node n t1 t2:ts) a=nmties (t1:t2:ts) a


num_nodes' :: Tree a -> Int
num_nodes' t = num_nodes_it [t] 0 where
  num_nodes_it [] a =a
  num_nodes_it (Empty:ts) a=num_nodes_it ts a
  num_nodes_it (Node n t1 t2:ts) a = num_nodes_it (t1:t2:ts) (a+1)

sum_nodes2' :: Num a => Tree2 a -> a
sum_nodes2' t = sum_nodes2_it [t] 0 where
                sum_nodes2_it :: Num a => [Tree2 a] -> a -> a
                sum_nodes2_it [] x = x
                sum_nodes2_it ((Leaf a):ts) x = sum_nodes2_it ts (a+x)
                sum_nodes2_it (Node2 n t1 t2:ts) x = sum_nodes2_it (t1:t2:ts) (n+x)

-- Use the technique once more to rewrite inorder2 so it avoids doing any
-- concatenations, using only (:).
-- Hint 1: (:) produces lists from back to front, so you should do the same.
-- Hint 2: You may need to get creative with your lists of trees to get the
-- right output.
inorder2' :: Tree2 a -> [a]
inorder2' t = inord [t] [] where
  inord [] a=a
  inord (Leaf x:ts) a = x:inord ts a
  inord (Node2 n t1 t2:ts) a= inord [t1] a++[n]++inord (t2:ts) a




---- Part 3: Higher-order functions ----------------

-- The functions map, all, any, filter, dropWhile, takeWhile, and break
-- from the Prelude are all higher-order functions. Reimplement them here
-- as list recursions. break should process each element of the list at
-- most once. All functions should produce the same output as the originals.

my_map :: (a -> b) -> [a] -> [b]
my_map f []=[]
my_map f(x:xs)= f x: my_map f xs

my_all :: (a -> Bool) -> [a] -> Bool
my_all f []=True 
my_all f (x:xs)= f x && (my_all f xs)

my_any :: (a -> Bool) -> [a] -> Bool
my_any f [] = False
my_any f (x:xs) = f x || (my_any f xs) 

my_filter :: (a -> Bool) -> [a] -> [a]
my_filter f []=[]
my_filter f (x:xs)= if f x then x:(my_filter f xs)
else my_filter f xs

my_dropWhile :: (a -> Bool) -> [a] -> [a]
my_dropWhile f []= []
my_dropWhile f (x:xs)=if f x then my_dropWhile f xs
else (x:xs)

my_takeWhile :: (a -> Bool) -> [a] -> [a]
my_takeWhile f []= []
my_takeWhile f (x:xs)= if f x then x:my_takeWhile f xs
else []

my_break :: (a -> Bool) -> [a] -> ([a], [a])
my_break f []=([],[])
my_break f l=(first,second) where
  first =bhelper f l
  second=bhelper2 f l     where
  bhelper f []=[]
  bhelper f (x:xs)=if not(f x) then x:bhelper f xs else []
  bhelper2 f []=[]
  bhelper2 f (x:xs)= if f x then (x:xs) else bhelper2 f xs

-- Implement the Prelude functions and, or, concat using foldr

my_and :: [Bool] -> Bool
my_and =foldr (&&) True

my_or :: [Bool] -> Bool
my_or = foldr (||) False 

my_concat :: [[a]] -> [a]
my_concat = foldr (++) []

-- Implement the Prelude functions sum, product, reverse using foldl

my_sum :: Num a => [a] -> a
my_sum = foldl (+) 0 

my_product :: Num a => [a] -> a
my_product = foldl (*) 1

my_reverse :: [a] -> [a]
my_reverse [] = []
my_reverse xs = foldl (\a x-> x : a) [] xs


---- Part 4: Extra Credit ----------------

-- Convert a Tree into an equivalent Tree2, IF POSSIBLE. That is, given t1,
-- return t2 such that conv21 t2 = t1, if it exists. (In math, this is called
-- the "inverse image" of the function conv21.)  Thus, if conv21 t2 = t1, then
-- it should be that conv 12 t1 = Just t2. If there does not exist such a t2,
-- then conv12 t1 = Nothing. Do some examples on paper first so you can get a
-- sense of when this conversion is possible.
conv12 :: Tree a -> Maybe (Tree2 a)
conv12 = undefined


-- Binary Search Trees. Determine, by making only ONE PASS through a tree,
-- whether or not it's a Binary Search Tree, which means that for every
-- Node a t1 t2 in the tree, every element in t1 is strictly less than a and
-- every element in t2 is strictly greater than a. Complete this for both
-- Tree a and Tree2 a.

-- Hint: use a helper function that keeps track of the range of allowable
-- element values as you descend through the tree. For this, use the following
-- extended integers, which add negative and positvie infintiies to Int:

data ExtInt = NegInf | Fin Int | PosInf deriving Eq

instance Show ExtInt where
  show NegInf     = "-oo"
  show (Fin n) = show n
  show PosInf     = "+oo"

instance Ord ExtInt where
  compare NegInf  NegInf  = EQ
  compare NegInf  _       = LT
  compare (Fin n) (Fin m) = compare n m
  compare (Fin n) PosInf  = LT
  compare PosInf  PosInf  = EQ
  compare _       _       = GT
  -- Note: defining compare automatically defines <, <=, >, >=, ==, /=
  
bst :: Tree Int -> Bool
bst Empty=True
bst (Node a Empty Empty)=True
bst (Node a b c)= bsth b a == LT && bsth c a ==GT && bst b && bst c where
  bsth Empty x= GT
  bsth (Node a b c) x=compare a x 
    
bst2 :: Tree2 Int -> Bool
bst2 (Leaf a)= True
bst2 (Node2 a b c)= bst2h b a==LT && bst2h c a == GT && bst2 b && bst2 c where
  bst2h (Leaf a) x=compare a x 
  bst2h (Node2 a b c) x= compare a x

