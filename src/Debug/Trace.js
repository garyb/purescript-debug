/* global exports, console, require */
"use strict";

// Alias require to prevent webpack or browserify from actually requiring.
var req = typeof require === "undefined" ? undefined : require;
var util = req === undefined ? undefined : req("util");

// module Debug.Trace

exports.traceAny = function (x) {
  return function (k) {
    // node only recurses two levels into an object before printing
    // "[object]" for further objects when using console.log()
    if (util !== undefined) {
      console.log(util.inspect(x, { depth: null, colors: true }));
    } else {
      console.log(x);
    }

    return k({});
  };
};
