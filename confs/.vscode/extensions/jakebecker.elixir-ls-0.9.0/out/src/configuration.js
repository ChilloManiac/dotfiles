"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.configuration = {
    indentationRules: {
        decreaseIndentPattern: new RegExp("^\\s*((\\}|\\])\\s*$|(after|else|catch|rescue|end)\\b)"),
        increaseIndentPattern: new RegExp("(after|else|catch|rescue|fn|^.*(do|<\\-|\\->|\\{|\\[|\\=))\\s*$"),
    },
};
//# sourceMappingURL=configuration.js.map