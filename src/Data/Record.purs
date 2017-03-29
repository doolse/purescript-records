module Data.Record (
  merge,
  mergeDefaults,
  class Subrow,
  class MergeDefaults,
  class IntersectRow
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
instance srInst :: Union r t s => Subrow r s

-- | Proof of row `i` being the intersection of rows `ri` and `si`,
-- | `r` is `i` subtracted from `ri` and
-- | `s` is `i` subtracted from `si`
class IntersectRow (ri :: # Type) (si :: # Type) (i :: # Type) (r :: # Type) (s :: # Type)
instance irInst :: (Union r i ri, Union i s si) => IntersectRow ri si i r s

class MergeDefaults (o :: # Type) (mr :: # Type) (mo :: # Type)
instance mdInst :: (IntersectRow mo mr m o r, Subrow r o) => MergeDefaults o mr mo

-- | Merge a record `mr` with optional default values `o`, resulting in record `mo`.
-- |
-- | The record `mr` must consist of the common fields from `mo` and `mr` plus a subset
-- | of fields from `o`.
-- |
-- | Examples:
-- | * mergeDefaults {a:1,b:"Unspecified"} {a:3,c:"Mandatory"} = {a:3,b:"Unspecified",c:"Mandatory"}
-- | * mergeDefaults {a:1,b:"Unspecified"} {c:"Only mandatory"} = {a:1,b:"Unspecified",c:"Only Mandatory"}
-- | * mergeDefaults {a:1,b:"Unspecified"} {a:"Wrong type"} = wont compile
mergeDefaults :: forall o mr mo. MergeDefaults o mr mo => Record o -> Record mr -> Record mo
mergeDefaults = unsafeMerge
