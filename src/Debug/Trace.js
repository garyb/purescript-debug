"use strict";

// Alias require to prevent webpack or browserify from actually requiring.
var req = typeof module === "undefined" ? undefined : module.require;
var util = req === undefined ? undefined : req("util");

exports.showAny = function () {
  return function(x) {
    // node only recurses two levels into an object before printing
    // "[object]" for further objects when using console.log()
    if (util !== undefined) {
      return util.inspect(x, { depth: null, colors: false });
    } else {
      return JSON.stringify(x);
    }
  };
};

exports.traceAny = function () {
  return function (x) {
    return function (k) {
      console.log(exports.showAny()(x));
      return k({});
    };
  };
};
