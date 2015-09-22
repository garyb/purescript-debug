module Debug.Trace where

import Prelude

-- | Log a message to the console for debugging purposes and then return a
-- | value. The return value is thunked so it is not evaluated until after the
-- | message has been printed, to preserve a predictable console output.
-- |
-- | For example:
-- | ``` purescript
-- | doSomething = trace "Hello" \_ -> ... some value or computation ...
-- | ```
trace :: forall a. String -> (Unit -> a) -> a
trace = traceAny

-- | Log a `Show`able value to the console for debugging purposes and then
-- | return a value.
traceShow :: forall a b. (Show a) => a -> (Unit -> b) -> b
traceShow = traceAny <<< show

-- | Log any PureScript value to the console for debugging purposes and then
-- | return a value. This will log the value's underlying representation for
-- | low-level debugging.
foreign import traceAny :: forall a b. a -> (Unit -> b) -> b

-- | Log any PureScript value to the console and return the unit value of the
-- | Applicative `a`.
traceAnyA :: forall a b. (Applicative a) => b -> a Unit
traceAnyA s = traceAny s \_ -> pure unit

-- | Log a message to the console for debugging purposes and then return the
-- | unit value of the Applicative `a`.
-- |
-- | For example:
-- | ``` purescript
-- | doSomething = do
-- |   traceA "Hello"
-- |   ... some value or computation ...
-- | ```
traceA :: forall a. (Applicative a) => String -> a Unit
traceA = traceAnyA

-- | Log a `Show`able value to the console for debugging purposes and then
-- | return the unit value of the Applicative `a`.
traceShowA :: forall a b. (Show b, Applicative a) => b -> a Unit
traceShowA = traceAnyA <<< show

-- | Log any PureScript value to the console and return it in `Monad`
-- | useful when one has monadic chains
-- | ```purescript
-- | mbArray :: Maybe (Array Int)
-- | foo :: Int
-- | foo = fromMaybe zero
-- |   $ mbArray
-- |   >>= traceAnyM
-- |   >>= head
-- |   >>= traceAnyM
-- | ```
traceAnyM :: forall m a. (Monad m) => a -> m a
traceAnyM s = traceAny s \_ -> pure s

-- | Same as `traceAnyM` but only for `Show`able values
traceShowM :: forall m a. (Show a, Monad m) => a -> m a
traceShowM s = traceAny (show s) \_ -> pure s
