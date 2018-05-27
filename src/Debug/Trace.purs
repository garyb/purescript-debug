module Debug.Trace where

import Prelude

import Prim.TypeError (class Warn, Text)

-- | Nullary class used to raise a custom warning for the debug functions.
class DebugWarning

instance warn :: Warn (Text "Debug.Trace usage") => DebugWarning

-- | Log any PureScript value to the console for debugging purposes and then
-- | return a value. This will log the value's underlying representation for
-- | low-level debugging, so it may be desireable to `show` the value first.
-- |
-- | The return value is thunked so it is not evaluated until after the
-- | message has been printed, to preserve a predictable console output.
-- |
-- | For example:
-- | ``` purescript
-- | doSomething = trace "Hello" \_ -> ... some value or computation ...
-- | ```
foreign import trace :: forall a b. DebugWarning => a -> (Unit -> b) -> b

-- | Log any PureScript value to the console and return the unit value of the
-- | Monad `m`.
traceM :: forall m a. DebugWarning => Monad m => a -> m Unit
traceM s = do
  pure unit
  trace s \_ -> pure unit

-- | Logs any value and returns it, using a "tag" or key value to annotate the
-- | traced value. Useful when debugging something in the middle of a
-- | expression, as you can insert this into the expression without having to
-- | break it up.
foreign import spy :: forall a. DebugWarning => String -> a -> a
