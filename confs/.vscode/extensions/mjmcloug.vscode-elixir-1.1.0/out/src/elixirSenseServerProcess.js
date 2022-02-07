"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const child_process_1 = require("child_process");
const path = require("path");
const vscode = require("vscode");
// tslint:disable:no-null-keyword
class ElixirSenseServerProcess {
    constructor(projectPath, onTcpServerReady) {
        this.projectPath = projectPath;
        this.onTcpServerReady = onTcpServerReady;
        this.command = 'elixir';
        const extensionPath = vscode.extensions.getExtension('mjmcloug.vscode-elixir').extensionPath;
        this.args = [path.join(extensionPath, 'elixir_sense/run.exs')];
        this.proc = null;
    }
    static initClass() {
        this.prototype.ready = false;
        this.prototype.proc = null;
    }
    start(port, env) {
        this.proc = this.spawnChildProcess(port, env);
        this.proc.stdout.on('data', (chunk) => {
            if (this.onTcpServerReady) {
                let authToken;
                let host;
                let _;
                console.log(chunk.toString());
                if (chunk.includes('ok:')) {
                    [_, host, port, authToken] = Array.from(chunk.toString().split(':'));
                }
                this.onTcpServerReady(host, port, authToken || undefined);
                this.onTcpServerReady = null;
                return;
            }
            console.log(`[ElixirSense] ${chunk.toString()}`);
            return this.ready = true;
        });
        this.proc.stderr.on('data', (chunk) => {
            this.ready = true;
            const message = `[ElixirSense] ${chunk.toString()}`;
            if (chunk.indexOf('Server Error') === -1) {
                console.warn(message);
            }
            else {
                console.log(message);
            }
        });
        this.proc.on('close', (exitCode) => {
            console.log(`[vscode-elixir] Child process exited with code ${exitCode}`);
            this.ready = false;
            this.proc = null;
        });
        this.proc.on('error', (error) => {
            console.error(`[vscode-elixir] ${error.toString()}`);
            this.ready = false;
            this.proc = null;
        });
    }
    stop() {
        this.proc.stdin.end();
        this.ready = false;
        this.proc = null;
    }
    spawnChildProcess(port, env) {
        const options = {
            cwd: this.projectPath,
            stdio: 'pipe',
            windowsVerbatimArguments: false
        };
        if (process.platform === 'win32') {
            options.windowsVerbatimArguments = true;
            // quote all args in case they contain spaces in their paths. the ^ is the escape character; ^" is cmd.exe-speak for \".
            const args = this.args.map((arg) => `^"${arg}^"`);
            return child_process_1.spawn('cmd', ['/s', '/c', `"${[this.command].concat(args).concat('tcpip', port, env).join(' ')}"`], options);
        }
        else {
            return child_process_1.spawn(this.command, this.args.concat('unix', port, env), options);
        }
    }
}
exports.ElixirSenseServerProcess = ElixirSenseServerProcess;
//# sourceMappingURL=elixirSenseServerProcess.js.map