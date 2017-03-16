module Data.Record where

class RecordUnion (l :: # Type) (r :: # Type) (u :: # Type) (o :: # Type)

instance recordUnion :: (Union l r u, Normalised u o) => RecordUnion l r u o

-- | Merge two records with the values in the second overriding the first
foreign import merge :: forall a b u c. RecordUnion b a u c => {|a} -> {|b} -> {|c}
