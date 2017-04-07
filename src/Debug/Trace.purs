module Debug.Trace where

import Prelude

-- | Nullary class used to raise a custom warning for the debug functions.
class DebugWarning

instance warn :: Warn "Debug.Trace usage" => DebugWarning

-- | Log a message to the console for debugging purposes and then return a
-- | value. The return value is thunked so it is not evaluated until after the
-- | message has been printed, to preserve a predictable console output.
-- |
-- | For example:
-- | ``` purescript
-- | doSomething = trace "Hello" \_ -> ... some value or computation ...
-- | ```
trace :: forall a. DebugWarning => String -> (Unit -> a) -> a
trace = traceAny

-- | Log a `Show`able value to the console for debugging purposes and then
-- | return a value.
traceShow :: forall a b. DebugWarning => Show a => a -> (Unit -> b) -> b
traceShow = traceAny <<< show

-- | Log any PureScript value to the console for debugging purposes and then
-- | return a value. This will log the value's underlying representation for
-- | low-level debugging.
foreign import traceAny :: forall a b. DebugWarning => a -> (Unit -> b) -> b

-- | Log any value and return it
spy :: forall a. DebugWarning => a -> a
spy a = traceAny a \_ -> a

-- | Log any PureScript value to the console and return the unit value of the
-- | Applicative `a`.
traceAnyA :: forall a b. DebugWarning => Applicative a => b -> a Unit
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
traceA :: forall a. DebugWarning => Applicative a => String -> a Unit
traceA = traceAnyA

-- | Log a `Show`able value to the console for debugging purposes and then
-- | return the unit value of the Applicative `a`.
traceShowA :: forall a b. DebugWarning => Show b => Applicative a => b -> a Unit
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
traceAnyM :: forall m a. DebugWarning => Monad m => a -> m a
traceAnyM s = traceAny s \_ -> pure s

-- | Same as `traceAnyM` but only for `Show`able values
traceShowM :: forall m a. DebugWarning => Show a => Monad m => a -> m a
traceShowM s = traceAny (show s) \_ -> pure s
