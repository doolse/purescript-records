module Data.Record.Class (
    class Subrow,
    class RecordMerge,
    class IntersectRow
) where

-- | Proof that row `r` is a subset of row `s`
class Subrow (r :: # Type) (s :: # Type)
instance srInst :: Union r t s => Subrow r s

-- | Proof of row `i` being the intersection of rows `ri` and `si`,
-- | `r` is `i` subtracted from `ri` and
-- | `s` is `i` subtracted from `si`
class IntersectRow (ri :: # Type) (si :: # Type) (i :: # Type) (r :: # Type) (s :: # Type)
instance irInst :: (Union r i ri, Union i s si) => IntersectRow ri si i r s

class RecordMerge (o :: # Type) (mr :: # Type) (mo :: # Type)
instance rmInst :: (IntersectRow mo mr m o r, Subrow r o) => RecordMerge o mr mo
