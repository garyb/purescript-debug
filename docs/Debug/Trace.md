## Module Debug.Trace

#### `trace`

``` purescript
trace :: forall a. String -> (Unit -> a) -> a
```

Log a message to the console for debugging purposes and then return a
value. The return value is thunked so it is not evaluated until after the
message has been printed, to preserve a predictable console output.

For example:
``` purescript
doSomething = trace "Hello" \_ -> ... some value or computation ...
```

#### `traceShow`

``` purescript
traceShow :: forall a b. (Show a) => a -> (Unit -> b) -> b
```

Log a `Show`able value to the console for debugging purposes and then
return a value.

#### `traceAny`

``` purescript
traceAny :: forall a b. a -> (Unit -> b) -> b
```

Log any PureScript value to the console for debugging purposes and then
return a value. This will log the value's underlying representation for
low-level debugging.

#### `traceAnyA`

``` purescript
traceAnyA :: forall a b. (Applicative a) => b -> a Unit
```

Log any PureScript value to the console and return the unit value of the
Applicative `a`.

#### `traceA`

``` purescript
traceA :: forall a. (Applicative a) => String -> a Unit
```

Log a message to the console for debugging purposes and then return the
unit value of the Applicative `a`.

For example:
``` purescript
doSomething = do
  traceA "Hello"
  ... some value or computation ...
```

#### `traceShowA`

``` purescript
traceShowA :: forall a b. (Show b, Applicative a) => b -> a Unit
```

Log a `Show`able value to the console for debugging purposes and then
return the unit value of the Applicative `a`.

#### `traceAnyM`

``` purescript
traceAnyM :: forall m a. (Monad m) => a -> m a
```

Log any PureScript value to the console and return it in `Monad`
useful when one has monadic chains
```purescript
mbArray :: Maybe (Array Int)
foo :: Int
foo = fromMaybe zero
  $ mbArray
  >>= traceAnyM
  >>= head
  >>= traceAnyM
```

#### `traceShowM`

``` purescript
traceShowM :: forall m a. (Show a, Monad m) => a -> m a
```

Same as `traceAnyM` but only for `Show`able values


