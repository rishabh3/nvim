local M = {}
local api = vim.api


function M.statusline()
    local parts = {
      [[%<» %{luaeval("require'me'.file_or_lsp_status()")} %m%r%=]],
      "%#warningmsg#",
      "%{&paste?'[paste] ':''}",
      "%*",
  
      "%#warningmsg#",
      "%{&ff!='unix'?'['.&ff.'] ':''}",
      "%*",
  
      "%#warningmsg#",
      "%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.'] ':''}",
      "%*",
      [[%{luaeval("require'me'.dap_status()")}]]
    }
    local bufnr = api.nvim_get_current_buf()
    local has_clients = not vim.tbl_isempty(vim.lsp.buf_get_clients(bufnr))
    if has_clients then
      table.insert(parts, [[%{luaeval("require'me'.diagnostic_status()")}]])
    end
    return table.concat(parts, '')
end

function M.diagnostic_status()
    local num_errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    if num_errors > 0 then
      return ' 💀 ' .. num_errors .. ' '
    end
    local num_warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    if num_warnings > 0 then
      return ' 💩' .. num_warnings .. ' '
    end
    return ''
end

function M.dap_status()
    local ok, dap = pcall(require, 'dap')
    if not ok then
      return ''
    end
    local status = dap.status()
    if status ~= '' then
      return status .. ' | '
    end
    return ''
end

function M.file_or_lsp_status()
    local messages = vim.lsp.util.get_progress_messages()
    local mode = api.nvim_get_mode().mode
    if mode ~= 'n' or vim.tbl_isempty(messages) then
      return M.format_uri(vim.uri_from_bufnr(api.nvim_get_current_buf()))
    end
    local percentage
    local result = {}
    for _, msg in pairs(messages) do
      if msg.message then
        table.insert(result, msg.title .. ': ' .. msg.message)
      else
        table.insert(result, msg.title)
      end
      if msg.percentage then
        percentage = math.max(percentage or 0, msg.percentage)
      end
    end
    if percentage then
      return string.format('%03d: %s', percentage, table.concat(result, ', '))
    else
      return table.concat(result, ', ')
    end
end

function M.setup()
    require('me.lsp.conf').setup()

    vim.diagnostic.config({
        virtual_text = false,
        float = {
          source = 'always',
        },
    })
    
    U = M
end

function M.reload(name, children)
    children = children or false
    package.loaded[name] = nil
    if children then
      for pkg_name, _ in pairs(package.loaded) do
        if vim.startswith(pkg_name, name) then
          package.loaded[pkg_name] = nil
        end
      end
    end
    return require(name)
end

M.modules = setmetatable({}, {
    __index = function(_, k)
      return M.reload(k)
    end
})

function M.activate_reload(name, children)
    name = name or vim.fn.fnamemodify(api.nvim_buf_get_name(0), ':t:r')
    children = children or false
    vim.cmd('augroup lua-debug')
    vim.cmd('au!')
    vim.cmd(string.format("autocmd BufWritePost <buffer> lua U.reload('%s', %s)", name, children))
    vim.cmd('augroup end')
end
  

function M.reload_dap()
    require('dap.repl').close()
    U.reload('dap', true)
    U.reload('me.dap')
    U.reload('jdtls.dap').setup_dap({hotcodereplace = 'auto'})
end

return M