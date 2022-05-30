local lsp = require 'vim.lsp'
local jdtls = require 'jdtls'
local api = vim.api
local M = {}
local lspc = {}

do
  -- id is filetype│root_dir
  local lsp_client_ids = {}

  function lspc.start(config, root_markers)
    local root_dir = require('jdtls.setup').find_root(root_markers)
    if not root_dir then return end

    local cmd = config.cmd[1]
    if tonumber(vim.fn.executable(cmd)) == 0 then
      api.nvim_command(string.format(
        ':echohl WarningMsg | redraw | echo "No LSP executable: %s" | echohl None', cmd))
      return
    end
    config['root_dir'] = root_dir
    local lsp_id = tostring(vim.bo.filetype) .. "│" .. root_dir
    local client_id = lsp_client_ids[lsp_id]
    if not client_id then
      client_id = lsp.start_client(config)
      lsp_client_ids[lsp_id] = client_id
    end
    local bufnr = api.nvim_get_current_buf()
    lsp.buf_attach_client(bufnr, client_id)
  end

  function lspc.restart()
    for id, client_id in pairs(lsp_client_ids) do
      local client = vim.lsp.get_client_by_id(client_id)
      if client then
        local bufs = vim.lsp.get_buffers_by_client_id(client_id)
        client.stop()
        local new_client_id = lsp.start_client(client.config)
        lsp_client_ids[id] = new_client_id
        for _, buf in pairs(bufs) do
          lsp.buf_attach_client(buf, new_client_id)
        end
      end
    end
  end
  M.restart = lspc.restart
end


-- array of mappings to setup; {<capability_name>, <mode>, <lhs>, <rhs>}
local key_mappings = {
  {"document_formatting", "n", "<space>f", "<Cmd>lua vim.lsp.buf.formatting()<CR>"},
  {"document_range_formatting", "v", "<space>f", "<Esc><Cmd>lua vim.lsp.buf.range_formatting()<CR>"},
  {"find_references", "n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>"},
  {"hover", "n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>"},
  {"declaration", "n", "gD",  "<Cmd>lua vim.lsp.buf.declaration()<CR>"},
  {"definition", "n", "gd",  "<Cmd>lua vim.lsp.buf.definition()<CR>"},
  {"signature_help", "i", "<c-space>",  "<Cmd>lua vim.lsp.buf.signature_help()<CR>"},
  {"workspace_symbol", "n", "gW", "<Cmd>lua vim.lsp.buf.workspace_symbol()<CR>"},
  {"add_workspace_folder", "n", "<space>wa", "<Cmd>vim.lsp.buf.add_workspace_folder()<CR>"},
  {"list_workspace_folders", "n", "<space>wl", "<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>"},
  {"remove_workspace_folder", "n", "<space>wr", "<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>"},
  {"type_definition", "n", "<space>D", "<Cmd>lua vim.lsp.buf.type_definition()<CR>"},
  {"rename", "n", "<space>rn", "<Cmd>lua vim.lsp.buf.rename()<CR>"},
  {"show_line_diagnostics", "n", "<space>e", "<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>"},
  {"goto_prev", "n", "[d", "<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>"},
  {"goto_next", "n", "]d", "<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>"},
  {"set_loclist", "n", "<space>q", "<Cmd>lua vim.lsp.diagnostic.set_loclist()<CR>"},
  {"formatting", "n", "<space>f", "<Cmd>lua vim.lsp.buf.formatting()<CR>"},
  {"range_formatting", "v", "<space>f", "<Cmd>lua vim.lsp.buf.range_formatting()<CR>"},
  {"code_action", "n", "<space>ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>"},
  {"code_action", "n", "<leader>r", "<Cmd>lua vim.lsp.buf.code_action { only = 'refactor' }<CR>"},
  {"code_action", "v", "<space>ca", "<Esc><Cmd>lua vim.lsp.buf.range_code_action()<CR>"},
  {"code_action", "v", "<leader>r", "<Esc><Cmd>lua vim.lsp.buf.range_code_action { only = 'refactor'}<CR>"},
}


local function on_init(client)
  if client.config.settings then
    client.notify('workspace/didChangeConfiguration', { settings = client.config.settings })
  end
end

local function on_attach(client, bufnr)
  local lsp_signature = require "lsp_signature"
  lsp_signature.on_attach()
  api.nvim_buf_set_var(bufnr, "lsp_client_id", client.id)
  api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  api.nvim_buf_set_option(bufnr, "bufhidden", "hide")

  if client.resolved_capabilities.goto_definition then
    api.nvim_buf_set_option(bufnr, 'tagfunc', "v:lua.vim.lsp.tagfunc")
  end
  local opts = { silent = true; }
  for _, mappings in pairs(key_mappings) do
    local capability, mode, lhs, rhs = unpack(mappings)
    if client.resolved_capabilities[capability] then
      api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
    end
  end
  api.nvim_buf_set_keymap(bufnr, "n", "crr", "<Cmd>lua vim.lsp.buf.rename(vim.fn.input('New Name: '))<CR>", opts)
  api.nvim_buf_set_keymap(bufnr, "i", "<c-n>", "<Cmd>lua require('lsp_compl').trigger_completion()<CR>", opts)
  vim.cmd('augroup lsp_aucmds')
  vim.cmd(string.format('au! * <buffer=%d>', bufnr))
  if client.resolved_capabilities['document_highlight'] then
    vim.cmd(string.format('au CursorHold  <buffer=%d> lua vim.lsp.buf.document_highlight()', bufnr))
    vim.cmd(string.format('au CursorHoldI <buffer=%d> lua vim.lsp.buf.document_highlight()', bufnr))
    vim.cmd(string.format('au CursorMoved <buffer=%d> lua vim.lsp.buf.clear_references()', bufnr))
  end
  if vim.lsp.codelens and client.resolved_capabilities['code_lens'] then
    -- vim.cmd(string.format('au BufEnter,BufModifiedSet,InsertLeave <buffer=%d> lua vim.lsp.codelens.refresh()', bufnr))
    api.nvim_buf_set_keymap(bufnr, "n", "<leader>cr", "<Cmd>lua vim.lsp.codelens.refresh()<CR>", opts)
    api.nvim_buf_set_keymap(bufnr, "n", "<leader>ce", "<Cmd>lua vim.lsp.codelens.run()<CR>", opts)
  end
  vim.cmd('augroup end')
  vim.notify("Started lsp for client with id " .. client.id .. " with name " .. client.name)
end

local function jdtls_on_attach(client, bufnr)
  on_attach(client, bufnr)
  local opts = { silent = true; }
  jdtls.setup_dap({hotcodereplace = 'auto'})
  jdtls.setup.add_commands()
  local nnoremap = function(lhs, rhs)
    api.nvim_buf_set_keymap(bufnr, 'n', lhs, rhs, opts)
  end
  local vnoremap = function(lhs, rhs)
    api.nvim_buf_set_keymap(bufnr, 'v', lhs, rhs, opts)
  end
  nnoremap("<leader>di", "<Cmd>lua require'jdtls'.organize_imports()<CR>")
  nnoremap("<leader>dt", "<Cmd>lua require('me.dap'); require'jdtls'.test_class()<CR>")
  nnoremap("<leader>dn", "<Cmd>lua require('me.dap'); require'jdtls'.test_nearest_method()<CR>")
  vnoremap("<leader>de", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>")
  nnoremap("<leader>de", "<Cmd>lua require('jdtls').extract_variable()<CR>")
  vnoremap("<leader>dm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>")
  vnoremap("<leader>dc", "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>")
  nnoremap("<leader>dc", "<Cmd>lua require('jdtls').extract_constant()<CR>")
  nnoremap("<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>")
  vnoremap("<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>")
end

local function lsp_installer_setup()
    local lsp_installer = require("nvim-lsp-installer");
    lsp_installer.on_server_ready(function(server)
        local opts = {}
        opts.on_attach = on_attach
        opts.flags = {
            debounce_text_changes = 150
        }
        server:setup(opts)
    end)
end


local function on_exit(client, bufnr)
  require('me.lsp.ext').detach(client.id, bufnr)
  vim.cmd('augroup lsp_aucmds')
  vim.cmd(string.format('au! * <buffer=%d>', bufnr))
  vim.cmd('augroup end')
end


local function mk_config()
  local capabilities = lsp.protocol.make_client_capabilities()
  capabilities.workspace.configuration = true
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return {
    flags = {
      debounce_text_changes = 80,
      allow_incremental_sync = true,
    };
    handlers = {},
    capabilities = capabilities;
    on_init = on_init;
    on_attach = on_attach;
    on_exit = on_exit;
  }
end


function M.add_client(cmd, opts)
  local config = mk_config()
  config['name'] = opts and opts.name or cmd[1]
  config['cmd'] = cmd
  lspc.start(config, opts and opts.root or {'.git'})
end


function M.start_jdt()
  local root_markers = {'gradlew', '.git'}
  local root_dir = require('jdtls.setup').find_root(root_markers)
  local home = os.getenv('HOME')
  local workspace_folder = vim.fn.fnamemodify(root_dir, ":p:h:t")
  local config = mk_config()
  config.flags.server_side_fuzzy_completion = true
  config.settings = {
    java = {
      signatureHelp = { enabled = true };
      contentProvider = { preferred = 'fernflower' };
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*"
        }
      };
      sources = {
        organizeImports = {
          starThreshold = 9999;
          staticStarThreshold = 9999;
        };
      };
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
        },
        hashCodeEquals = {
          useJava7Objects = true,
        },
        useBlocks = true,
      };
      configuration = {
        runtimes = {
            {
                name = "JavaSE-11",
                path = os.getenv("JAVA_HOME")
            },
        }
      };
    };
  }
  config.cmd = {
    "launch_jdtls", workspace_folder
  }
  config.on_attach = jdtls_on_attach

  local jar_patterns = {
    '/.local/java_debug/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar',
    '/.local/java_debug/vscode-java-decompiler/server/*.jar',
    '/.local/java_debug/vscode-java-test/java-extension/com.microsoft.java.test.plugin/target/*.jar',
    '/.local/java_debug/vscode-java-test/java-extension/com.microsoft.java.test.runner/target/*.jar',
    '/.local/java_debug/vscode-java-test/java-extension/com.microsoft.java.test.runner/target/lib/*.jar',
    -- '/dev/testforstephen/vscode-pde/server/*.jar'
  }
  -- npm install broke for me: https://github.com/npm/cli/issues/2508
  -- So gather the required jars manually; this is based on the gulpfile.js in the vscode-java-test repo
  local plugin_path = '/.local/java_debug/vscode-java-test/java-extension/com.microsoft.java.test.plugin.site/target/repository/plugins/'
  local bundle_list = vim.tbl_map(
    function(x) return require('jdtls.path').join(plugin_path, x) end,
    {
      'org.eclipse.jdt.junit4.runtime_*.jar',
      'org.eclipse.jdt.junit5.runtime_*.jar',
      'org.junit.jupiter.api*.jar',
      'org.junit.jupiter.engine*.jar',
      'org.junit.jupiter.migrationsupport*.jar',
      'org.junit.jupiter.params*.jar',
      'org.junit.vintage.engine*.jar',
      'org.opentest4j*.jar',
      'org.junit.platform.commons*.jar',
      'org.junit.platform.engine*.jar',
      'org.junit.platform.launcher*.jar',
      'org.junit.platform.runner*.jar',
      'org.junit.platform.suite.api*.jar',
      'org.apiguardian*.jar'
    }
  )
  vim.list_extend(jar_patterns, bundle_list)
  local bundles = {}
  for _, jar_pattern in ipairs(jar_patterns) do
    for _, bundle in ipairs(vim.split(vim.fn.glob(home .. jar_pattern), '\n')) do
      if not vim.endswith(bundle, 'com.microsoft.java.test.runner.jar') then
        table.insert(bundles, bundle)
      end
    end
  end
  local extendedClientCapabilities = jdtls.extendedClientCapabilities;
  extendedClientCapabilities.resolveAdditionalTextEditsSupport = true;
  config.init_options = {
    bundles = bundles;
    extendedClientCapabilities = extendedClientCapabilities;
  }
  -- mute; having progress reports is enough
  config.handlers['language/status'] = function() end
  jdtls.start_or_attach(config)
end


function M.setup()
  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' })
  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'single' })
  lsp_installer_setup()
end


return M