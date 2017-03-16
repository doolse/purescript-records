module Data.Record where

class RecordUnion (l :: # Type) (r :: # Type) (u :: # Type) | l r -> u

instance recordUnion :: (Union l r u1, Union r l u2, Normalised u1 u, Normalised u2 u) => RecordUnion l r u

-- | Merge two records with the values in the second overriding the first
foreign import merge :: forall a b u. RecordUnion b a u => {|a} -> {|b} -> {|u}
