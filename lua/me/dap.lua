local api = vim.api
local dap = require('dap')
local HOME = os.getenv('HOME')
local option_silent = {noremap = true, silent=true}
local map = vim.api.nvim_set_keymap


local M = setmetatable({}, {
  __index = function(tbl, key)
    if key == 'widgets' then
      local val = require('dap.ui.widgets')
      rawset(tbl, key, val)
      return val
    end
    return dap[key]
  end,
})


local function add_tagfunc(widget)
  local orig_new_buf = widget.new_buf
  widget.new_buf = function(...)
    local bufnr = orig_new_buf(...)
    api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.require'me.lsp.ext'.symbol_tagfunc")
    return bufnr
  end
end


local function setup_widgets()
  local widgets = require('dap.ui.widgets')
  M.sidebar = widgets.sidebar(widgets.scopes)
  add_tagfunc(widgets.expression)
  add_tagfunc(widgets.scopes)
end


function M.setup()
  setup_widgets()

  -- Setup signs
  vim.fn.sign_define('DapBreakpoint', {text='✋', texthl='', linehl='', numhl=''})
  vim.fn.sign_define('DapBreakpointRejected', {text='🚫', texthl='', linehl='', numhl=''})
  vim.fn.sign_define('DapStopped', {text='👉', texthl='', linehl='', numhl=''})
  
  dap.listeners.after.event_initialized['me-keys'] = function()
    api.nvim_set_keymap("n", "<down>", "<cmd>lua require('dap').step_over()<CR>", {noremap = true, silent = true})
    api.nvim_set_keymap("n", "<left>", "<cmd>lua require('dap').step_out()<CR>", {noremap = true, silent = true})
    api.nvim_set_keymap("n", "<right>", "<cmd>lua require('dap').step_into()<CR>", {noremap = true, silent = true})
  end
  dap.listeners.after.event_terminated['me-keys'] = function()
    api.nvim_del_keymap("n", "<down>")
    api.nvim_del_keymap("n", "<left>")
    api.nvim_del_keymap("n", "<right>")
  end

  dap.defaults.fallback.terminal_win_cmd = 'tabnew'
  dap.defaults.fallback.external_terminal = {
    command = '/bin/zsh';
    args = {'-e'};
  }
  require('dap-python').setup('~/.virtualenvs/py3venv/bin/python')
  table.insert(dap.configurations.python, {
    type = 'python',
    request = 'launch',
    program = '${workspaceFolder}/${file}',
    console = 'integratedTerminal',
    name = 'Launch file with autoReload',
    autoReload = {
      enable = true,
    }
  })

  dap.configurations.java = {
    {
      type = 'java';
      request = 'attach';
      name = "Debug (Attach) - Remote";
      hostName = "127.0.0.1";
      port = 5005;
    },
  }

  dap.adapters.go = {
    type = 'executable';
    command = 'node';
    args = {HOME .. '/dev/golang/vscode-go/dist/debugAdapter.js'};
    enrich_config = function(conf, on_config)
      if not conf.dlvToolPath then
        conf.dlvToolPath = '/usr/bin/dlv'
      end
      on_config(conf)
    end;
  }
  dap.configurations.go = {
    {
      type = 'go';
      name = 'Debug';
      request = 'launch';
      showLog = true;
      program = "${file}";
    },
  }

  dap.configurations.lua = {
    {
      type = 'nlua',
      request = 'attach',
      name = "Attach to running Neovim instance",
      port = 44444,
    }
  }
  dap.adapters.nlua = function(callback, config)
    local port = config.port
    local opts = {
      args = {
        '-e', vim.v.progpath,
        '-c', string.format('lua require("osv").launch({port = %d})', port),
      },
      cwd = vim.fn.getcwd(),
      detached = true
    }
    local handle
    local pid_or_err
    handle, pid_or_err = vim.loop.spawn('zsh', opts, function(code)
      handle:close()
      if code ~= 0 then
        print('nvim exited', code)
      end
    end)
    assert(handle, 'Could not run zsh:' .. pid_or_err)

    -- doing a `client = new_tcp(); client:connect()` within vim.wait doesn't work
    -- because an extra client connecting confuses `osv`, so sleep a bit instead
    -- to wait until server is started
    vim.cmd('sleep')
    callback({ type = 'server', host = '127.0.0.1', port = port })
  end

--   dap.adapters.node2 = {
--     type = 'executable',
--     command = 'node',
--     args = {os.getenv('HOME') .. '/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js'},
--   }
  dap.configurations.javascript = {
    {
      type = 'node2',
      request = 'launch',
      program = '${workspaceFolder}/${file}',
      cwd = '/tmp/',
      sourceMaps = true,
      protocol = 'inspector',
      console = 'integratedTerminal',
    },
  }

--   dap.adapters.cppdbg = {
--     id = 'cppdbg',
--     type = 'executable',
--     command = HOME .. '/apps/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
--   }
  
  dap.configurations.cpp = {
    {
      name = 'Attach to gdbserver :1234',
      type = 'cppdbg',
      request = 'launch',
      MIMode = 'gdb',
      miDebuggerServerAddress = 'localhost:1234',
      miDebuggerPath = '/bin/gdb',
      cwd = '${workspaceFolder}',
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
    },
  }
  dap.configurations.c = dap.configurations.cpp
  dap.configurations.rust = dap.configurations.cpp

  require('dap.ext.vscode').load_launchjs()
  map("n", "<leader>db", ':lua require"dap".toggle_breakpoint()<CR>', option_silent)
  map("n", "<leader>dB", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", option_silent)
  map("n", "<leader>so", ':lua require"dap".step_out()<CR>', option_silent)
  map("n", "<leader>si", ':lua require"dap".step_into()<CR>', option_silent)
  map("n", "<leader>sv", ':lua require"dap".step_over()<CR>', option_silent)
  map("n", "<leader>sc", ':lua require"dap".continue()<CR>', option_silent)
  map("n", "<leader>dk", ':lua require"dap".up()<CR>', option_silent)
  map("n", "<leader>dj", ':lua require"dap".down()<CR>', option_silent)
  map("n", "<leader>dc", ':lua require"dap".terminate()<CR>', option_silent)
  map("n", "<leader>dr", ':lua require"dap".repl.toggle({}, "vsplit")<CR><C-w>l', option_silent)
  map("n", "<leader>di", ':lua require"dap.ui.variables".hover()<CR>', option_silent)
  map("n", "<leader>di", ':lua require"dap.ui.variables".visual_hover()<CR>', option_silent)
  map("n", "<leader>d?", ':lua require"dap.ui.variables".scopes()<CR>', option_silent)
  map("n", "<leader>de", ':lua require"dap".set_exception_breakpoints({"all"})<CR>', option_silent)
  map("n", "<leader>da", ':lua require"debugHelper".attach()<CR>', option_silent)
  map("n", "<leader>dA", ':lua require"debugHelper".attachToRemote()<CR>', option_silent)
  map("n", "<leader>du", ':lua require"dap.ui.widgets".hover()<CR>', option_silent)
  map(
      "n",
      "<leader>d?",
      ':lua local widgets=require"dap.ui.widgets";widgets.centered_float(widgets.scopes)<CR>',
      option_silent
  )

  map("n", "<leader>ds", ":Telescope dap frames<CR>", option_silent)
  map("n", "<leader>dbs", ":Telescope dap list_breakpoints<CR>", option_silent)

  map("n", "<leader>O", ":lua require('dapui').open()<CR>", option_silent)
  map("n", "<leader>C", ":lua require('dapui').close()<CR>", option_silent)
  map("n", "<leader>T", ":lua require('dapui').toggle()<CR>", option_silent)
  map("n", "<leader>dcfg", ":Telescope dap configurations<CR>", option_silent)
end

M.setup()
return M