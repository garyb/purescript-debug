// Alias require to prevent webpack or browserify from actually requiring.
var req = typeof module === "undefined" ? undefined : module.require;
var util = (function() {
  try {
    return req === undefined ? undefined : req("util");
  } catch(e) {
    return undefined;
  }
})();

export var _trace = function (x, k) {
  // node only recurses two levels into an object before printing
  // "[object]" for further objects when using console.log()
  if (util !== undefined) {
    console.log(util.inspect(x, { depth: null, colors: true }));
  } else {
    console.log(x);
  }
  return k({});
};

export var _spy = function (tag, x) {
  if (util !== undefined) {
    console.log(tag + ":", util.inspect(x, { depth: null, colors: true }));
  } else {
    console.log(tag + ":", x);
  }
  return x;
};

export var _debugger = function (f) {
  debugger;
  return f();
};

var now = (function () {
  var perf;
  if (typeof performance !== "undefined") {
    // In browsers, `performance` is available in the global context
    perf = performance;
  } else if (req) {
    // In Node, `performance` is an export of `perf_hooks`
    try { perf = req("perf_hooks").performance; }
    catch(e) { }
  }

  return (function() { return (perf || Date).now(); });
})();

exports._traceTime = function(name, f) {
  var start = now();
  var res = f();
  var end = now();
  console.log(name + " took " + (end - start) + "ms");
  return res;
};
