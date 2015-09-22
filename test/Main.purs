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

  traceAnyM "Testing"
  effInt >>= traceAnyM >>= eatInt
  effRec >>= traceAnyM >>= \r -> do
    traceA r.x

  where
  effInt :: Eff () Int
  effInt = pure 0

  effRec :: Eff () _
  effRec = pure {x : "foo"}

  eatInt :: Int -> Eff () Unit
  eatInt = const $ pure unit
