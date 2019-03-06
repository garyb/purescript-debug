"use strict";

// module Todo

exports.crashWith = function () {
  return function (msg) {
    throw new Error(msg);
  };
};
