module Debug
  ( class DebugWarning
  , trace
  , traceM
  , traceTime
  , spy
  , spyWith
  , debugger
  ) where

import Prelude

import Data.Function.Uncurried (Fn2, Fn1, runFn1, runFn2)
import Prim.TypeError (class Warn, Text)

-- | Nullary class used to raise a custom warning for the debug functions.
class DebugWarning

instance warn :: Warn (Text "Debug function usage") => DebugWarning

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

-- | Measures the time it takes the given function to run and prints it out,
-- | then returns the function's result. This is handy for diagnosing
-- | performance problems by wrapping suspected parts of the code in
-- | `traceTime`.
-- |
-- | For example:
-- | ```purescript
-- | bunchOfThings =
-- |   [ traceTime "one" \_ -> one x y
-- |   , traceTime "two" \_ -> two z
-- |   , traceTime "three" \_ -> three a b c
-- |   ]
-- | ```
-- |
-- | Console output would look something like this:
-- | ```
-- | one took 3.456ms
-- | two took 562.0023ms
-- | three took 42.0111ms
-- | ```
-- |
-- | Note that the timing precision may differ depending on whether the
-- | Performance API is supported. Where supported (on most modern browsers and
-- | versions of Node), the Performance API offers timing resolution of 5
-- | microseconds. Where Performance API is not supported, this function will
-- | fall back on standard JavaScript Date object, which only offers a
-- | 1-millisecond resolution.
traceTime :: forall a. DebugWarning => String -> (Unit -> a) -> a
traceTime = runFn2 _traceTime

foreign import _traceTime :: forall a. Fn2 String (Unit -> a) a

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
