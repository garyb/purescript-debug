"use strict";

// Alias require to prevent webpack or browserify from actually requiring.
var req = typeof module === "undefined" ? undefined : module.require;
var util = (function() {
  try {
    return req === undefined ? undefined : req("util");
  } catch(e) {
    return undefined;
  }
})();

exports.trace = function () {
  return function (x) {
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
};

exports.spy = function () {
  return function (tag) {
    return function (x) {
      if (util !== undefined) {
        console.log(tag + ":", util.inspect(x, { depth: null, colors: true }));
      } else {
        console.log(tag + ":", x);
      }
      return x;
    };
  };
};
