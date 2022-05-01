// Alias require to prevent webpack or browserify from actually requiring.
const req = typeof module === "undefined" ? undefined : module.require;
const util = (function() {
  try {
    return req === undefined ? undefined : req("util");
  } catch(e) {
    return undefined;
  }
})();

export function _trace(x, k) {
  // node only recurses two levels into an object before printing
  // "[object]" for further objects when using console.log()
  if (util !== undefined) {
    console.log(util.inspect(x, { depth: null, colors: true }));
  } else {
    console.log(x);
  }
  return k({});
}

export function _spy(tag, x) {
  if (util !== undefined) {
    console.log(tag + ":", util.inspect(x, { depth: null, colors: true }));
  } else {
    console.log(tag + ":", x);
  }
  return x;
}

export function _debugger(f) {
  debugger;
  return f();
}
