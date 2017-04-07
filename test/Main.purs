module Test.Main where

import Prelude
import Debug.Trace (traceAnyA, spy, traceA, traceAnyM, traceAny, traceShow, trace)
import Control.Monad.Eff (Eff)

main :: Eff () Unit
main = do
  trace "Testing" \_ ->
  traceShow true \_ ->
  traceAny { x: 10 } \_ ->
  pure unit
  traceA "Testing"
  traceAnyA { x: 10 }

  void $ traceAnyM "Testing"
  effInt >>= traceAnyM >>= eatInt
  effRec >>= traceAnyM >>= \r -> do
    traceA r.x

  let dummy = spy { foo: 1, bar: [1, 2] }
  traceAnyA dummy
  where
  effInt :: Eff () Int
  effInt = pure 0

  effRec :: Eff () { x :: String }
  effRec = pure { x : "foo" }

  eatInt :: Int -> Eff () Unit
  eatInt = const $ pure unit
