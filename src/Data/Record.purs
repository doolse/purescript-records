module Data.Record (
  merge,
  mergeDefaults,
  class RowSubset,
  OptionalDefaults(..)
) where

-- | Merge two records together unsafely.
-- | Fields common between the two will result in the value from r2 being kept
foreign import unsafeMerge
  :: forall r1 r2 r3
  .  Record r1
  -> Record r2
  -> Record r3

-- | Merge record `a` with `b`, with the common fields in `b` overriding `a`
merge :: forall a b c. Union b a c => Record a -> Record b -> Record c
merge = unsafeMerge

-- | Proof that row `r` is a subset of row `s`
class RowSubset (r :: # Type) (s :: # Type)
instance rowSubset :: (Union r s st, Union s t st, Union t u s) => RowSubset r s

-- | Represents a record of default values `o`, which will be merged with a
-- | record that has at least fields `m`
newtype OptionalDefaults (m :: # Type) o = OptionalDefaults (Record o)

-- | Merge a record `mr` with optional default values.
-- |
-- | The record `mr` must consist of the fields from the `m` plus a subset
-- | of fields from `o`. The result is the closed row `mo`.
mergeDefaults :: forall m r o mr mo
  .  Union m r mr
  => Union m o mo
  => RowSubset r o
  => OptionalDefaults m o -> Record mr -> Record mo
mergeDefaults (OptionalDefaults d) = unsafeMerge d
