module Test.Main where

import Prelude
import Debug.Trace (spy, trace, traceM)
import Effect (Effect)

main :: Effect Unit
main = do
  trace "Testing" \_ ->
    trace true \_ ->
      trace { x: 10 } \_ -> do
        traceM "Testing"
        traceM { x: 10 }

  traceM "Testing"

  effInt
    >>= spy "i"
    >>> eatInt

  effRec
    >>= spy "r"
    >>> \r -> traceM r.x

  let dummy = spy "dummy" { foo: 1, bar: [1, 2] }
  traceM dummy

  where
  effInt :: Effect Int
  effInt = pure 0

  effRec :: Effect { x :: String }
  effRec = pure { x : "foo" }

  eatInt :: Int -> Effect Unit
  eatInt = const $ pure unit
