module Test.Main where

import Prelude
import Debug.Trace
import Control.Monad.Eff

main :: Eff () Unit
main = trace "Testing" \_ ->
  traceShow true \_ ->
  traceAny { x: 10 } \_ ->
  pure unit
