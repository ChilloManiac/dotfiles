"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode_1 = require("vscode");
async function runFromCodeLens(args) {
    const { activeTextEditor, terminals, createTerminal } = vscode_1.window;
    if (!activeTextEditor) {
        return;
    }
    if (activeTextEditor.document.isDirty) {
        const saved = await activeTextEditor.document.save();
        if (!saved) {
            return;
        }
    }
    const elixirLsTerminal = terminals.find((terminal) => terminal.name == "ElixirLS") ||
        createTerminal("ElixirLS");
    elixirLsTerminal.show();
    elixirLsTerminal.sendText("clear");
    elixirLsTerminal.sendText(`cd ${args.projectDir}`);
    elixirLsTerminal.sendText(buildTestCommand(args));
}
exports.default = runFromCodeLens;
function escapeSingleQuotes(s) {
    return isWindows() ? s : s.replace(/'/g, "'\\''");
}
function quote(s) {
    const q = isWindows() ? '"' : `'`;
    return [q, s, q].join("");
}
function isWindows() {
    return process.platform.includes("win32");
}
function buildTestCommand(args) {
    const testFilter = buildTestInclude(args.describe, args.testName, args.module);
    return `mix test --exclude test --include ${quote(escapeSingleQuotes(testFilter))} ${args.filePath}`;
}
function buildTestInclude(describe, testName, module) {
    if (module) {
        return `module:${module}`;
    }
    if (!testName) {
        return `describe:${describe}`;
    }
    if (describe) {
        return `test:test ${describe} ${testName}`;
    }
    return `test:test ${testName}`;
}
//# sourceMappingURL=runTestFromCodeLens.js.map