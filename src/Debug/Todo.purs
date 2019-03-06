module Debug.Todo
( notImplementedYet
, (???)
, todo
) where

import Data.Symbol (class IsSymbol, SProxy, reflectSymbol)
import Prim.TypeError (class Warn, Beside, Text)

notImplementedYet :: forall a. Warn (Text "not implemented yet") => a
notImplementedYet = crashWith "not implemented yet"

infix 5 notImplementedYet as ???

todo :: forall a s. IsSymbol s => Warn (Beside (Text "TODO: ") (Text s)) => SProxy s -> a
todo s = crashWith (reflectSymbol s)

foreign import crashWith :: forall a. String -> a
