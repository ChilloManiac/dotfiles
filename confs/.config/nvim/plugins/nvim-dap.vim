Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'


nnoremap <leader>dc <cmd>lua require"dap".continue()<CR>
nnoremap <leader>dvo <cmd>lua require"dap".step_over()<CR>
nnoremap <leader>di <cmd>lua require"dap".step_into()<CR>
nnoremap <leader>do <cmd>lua require"dap".step_out()<CR>
nnoremap <leader>b <cmd>lua require"dap".toggle_breakpoint()<CR>

nnoremap <leader>dsc <cmd>lua require"dap.ui.variables".scopes()<CR>
nnoremap <leader>dhh <cmd>lua require"dap.ui.variables".hover()<CR>
vnoremap <leader>dhv <cmd>lua require"dap.ui.variables".visual_hover()<CR>

nnoremap <leader>duh <cmd>lua require"dap.ui.widgets".hover()<CR>
nnoremap <leader>duf <cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>)

nnoremap <leader>dsbr <cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>
nnoremap <leader>dsbm <cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>
nnoremap <leader>dro <cmd>lua require"dap".repl.open()<CR>
nnoremap <leader>drl <cmd>lua require"dap".repl.run_last()<CR>

nnoremap <leader>dlb <cmd>lua require"telescope".extensions.dap.list_breakpoints{}<CR>
nnoremap <leader>dv <cmd>lua require"telescope".extensions.dap.variables{}<CR>
nnoremap <leader>df <cmd>lua require"telescope".extensions.dap.frames{}<CR>

nnoremap <leader>dui <cmd>lua require"dapui".toggle()<CR>
function LoadNvimDap()
lua << EOF
local dap = require('dap')

vim.fn.sign_define('DapBreakpoint', {text='👉', linehl='', numhl=''})

dap.adapters = { 
    pythonApi = {
         type = 'server';
         host = 'localhost';
         port = 6969
    },
    pythonIntTest = {
         type = 'server';
         host = 'localhost';
         port = 6069
    },
    pythonFile = {
        type = 'executable';
        command = 'python';
        args = {'-m', 'debugpy.adapter'}
    },
}

dap.configurations.python = {
  {
    type = 'pythonApi'; 
    request = 'attach';
    name = "Python: Api";
    pathMappings = {
          {
            localRoot = "${workspaceFolder}",
            remoteRoot = "/opt/lama"
          }
      }
  },
  {
    type = 'pythonIntTest'; 
    request = 'attach';
    name = "Python: Integration Test";
    pathMappings = {
          {
            localRoot = "${workspaceFolder}",
            remoteRoot = "/opt/lama"
          }
      }
  },
  {
    type = 'pythonFile';
    request = 'launch';
    name = 'Python Unit Test';
    module = "pytest";
    args = {'-s', '${file}'};
  },
  {
    type = 'pythonFile';
    request = 'launch';
    name = 'Python File';
    program = '${file}';
  },
}

require('dapui').setup()
EOF
endfunction

augroup LoadNvimDap
    autocmd!
    autocmd User PlugLoaded call LoadNvimDap()
augroup END
