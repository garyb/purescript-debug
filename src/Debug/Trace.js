/* global exports, console, require */
"use strict";

// module Debug.Trace

exports.traceAny = function (x) {
  return function (k) {
    // node only recurses two levels into an object before printing
    // "[object]" for further objects when using console.log()
    if (require !== undefined) {
      var util = require("util");
      console.log(util.inspect(x, { depth: null, colors: true }));
    } else {
      console.log(x);
    }

    return k({});
  };
};
