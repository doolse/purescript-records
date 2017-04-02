module Test.Main where

import Prelude
import Control.Monad.Eff.Console (log)
import Data.Record (merge)

type Mandatory r = (x::Int|r)
type Optional = (opt::String)
type Properties = Record (Mandatory Optional)

defaults :: {|Optional}
defaults = {opt:"DefaultProp"}

makeProps1 :: Properties
makeProps1 = merge defaults {x:2,opt:"makeProps1"}

makeProps2 :: Properties
makeProps2 = merge defaults {x:2}

-- won't compile - extra label
-- makeProps3 :: Properties
-- makeProps3 = mergeDefaults defaults {x:2, opt:"Optional", anythingElse: 1}

-- won't compile - wrong type
-- makeProps4 :: Properties
-- makeProps4 = mergeDefaults defaults {x:2, opt: 1}

-- won't compile - missing label
-- makeProps5 :: Properties
-- makeProps5 = mergeDefaults defaults {opt: 1}

main = do
  log $ makeProps1.opt
  log $ makeProps2.opt
