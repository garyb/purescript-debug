{ name = "debug"
, dependencies = [ "console", "effect", "functions", "prelude" ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
