module Data.Record (
  merge,
  mergeDefaults,
  class Subrow,
  class MergeDefaults
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
class Subrow (r :: # Type) (s :: # Type)
instance subrow :: Union r t s => Subrow r s

class MergeDefaults (o :: # Type) (mr :: # Type) (mo :: # Type)
instance mergeInstance :: (Union o m mo, Union m r mr, Subrow r o) => MergeDefaults o mr mo

-- | Merge a record `mr` with optional default values `o`.
-- |
-- | The record `mr` must consist of the common fields from `mo` and `mr` plus a subset
-- | of fields from `o`. The result is the closed row `mo`.
mergeDefaults :: forall o mr mo. MergeDefaults o mr mo => Record o -> Record mr -> Record mo
mergeDefaults = unsafeMerge
