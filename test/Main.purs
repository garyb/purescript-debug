module Test.Main where

import Prelude
import Debug.Trace
import Control.Monad.Eff

main :: Eff () Unit
main = do
  trace "Testing" \_ ->
  traceShow true \_ ->
  traceAny { x: 10 } \_ ->
  pure unit
  traceA "Testing"
  traceAnyA { x: 10 }
