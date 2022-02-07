"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const child_process_1 = require("child_process");
const gitty_1 = require("gitty");
const os_1 = require("os");
const path_1 = require("path");
const vscode_1 = require("vscode");
// TODO: make this configurable
// This ZIP is directly specifying a commit at github
const sourceRepo = "https://github.com/elixir-lsp/elixir-ls.git";
function configureElixirLS(context) {
    const cmd = "language_server" + file_type();
    const repoPath = path_1.join(context.extensionPath, "elixir-ls-repo");
    const path = path_1.join(context.extensionPath, "elixir-ls-release");
    const fullCmd = path_1.join(path, cmd);
    const opts = { command: fullCmd };
    const serverOpts = {
        debug: opts,
        run: opts,
    };
    const result = new Promise((resolve, reject) => {
        gitty_1.Repository.clone(repoPath, sourceRepo, (err) => {
            if (!err) {
                resolve("cloned");
            }
            else if (err && /exists/.test(err)) {
                resolve("update");
            }
            else {
                reject(err);
            }
        });
    })
        .then((action) => {
        if (action === "update") {
            // TODO: check for updates
        }
        // TODO: check errors
        // TODO: skip conditionally
        child_process_1.spawnSync("mix", ["deps.get"], { cwd: repoPath });
        child_process_1.spawnSync("mix", ["compile"], { cwd: repoPath });
        child_process_1.spawnSync("mix", ["elixir_ls.release", "-o", path], { cwd: repoPath });
    })
        .then((_) => serverOpts)
        .catch((err) => {
        vscode_1.window.showErrorMessage(`${err}`);
        return null;
    });
    return result;
}
exports.configureElixirLS = configureElixirLS;
function file_type() {
    if (os_1.platform() === "win32") {
        return ".bat";
    }
    else {
        return ".sh";
    }
}
//# sourceMappingURL=ex_ls.js.map