module Debug.Trace
  ( class DebugWarning
  , trace
  , traceM
  , spy
  , spyWith
  , debugger
  ) where

import Prelude

import Data.Function.Uncurried (Fn2, Fn1, runFn1, runFn2)
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
trace :: forall a b. DebugWarning => a -> (Unit -> b) -> b
trace a k = runFn2 _trace a k

foreign import _trace :: forall a b. Fn2 a (Unit -> b) b

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
spy :: forall a. DebugWarning => String -> a -> a
spy tag a = runFn2 _spy tag a

foreign import _spy :: forall a. Fn2 String a a

-- | Similar to `spy`, but allows a function to be passed in to alter the value
-- | that will be printed. Useful in cases where the raw printed form of a value
-- | is inconvenient to read - for example, when spying on a `Set`, passing
-- | `Array.fromFoldable` here will print it in a more useful form.
spyWith ∷ ∀ a b. DebugWarning ⇒ String → (a → b) → a → a
spyWith msg f a = const a (spy msg (f a))

-- | Triggers any available debugging features in the current runtime - in a
-- | web browser with the debug tools open, this acts like setting a breakpoint
-- | in the script. If no debugging feature are available nothing will occur,
-- | although the passed contination will still be evaluated.
-- |
-- | Generally this works best by passing in a block of code to debug as the
-- | continuation argument, as stepping forward in the debugger will then drop
-- | straight into the passed code block.
debugger :: forall a. DebugWarning => (Unit → a) -> a
debugger f = runFn1 _debugger f

foreign import _debugger :: forall a. Fn1 (Unit → a) a
