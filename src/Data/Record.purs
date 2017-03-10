module Data.Record where

class RowUnion (l :: # *) (r :: # *) (o :: # *) | l r -> o

-- | Merge two records with the values in the second overriding the first
foreign import merge :: forall a b c. RowUnion b a c => {|a} -> {|b} -> {|c}
