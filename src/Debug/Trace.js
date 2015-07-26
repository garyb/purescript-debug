/* global exports, console */
"use strict";

// module Debug.Trace

exports.traceAny = function (x) {
  return function (k) {
    console.log(x);
    return k({});
  };
};
