local null_ls = require("null-ls")

local buf_map = function(bufnr, mode, lhs, rhs, opts)
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
        silent = true,
    })
end

-- Run a single tsserver source action (organize imports, add missing imports).
local ts_source_action = function(kind)
    vim.lsp.buf.code_action({ context = { only = { kind }, diagnostics = {} }, apply = true })
end

local on_attach = function(client, bufnr)
    vim.cmd('command! LspDef lua vim.lsp.buf.definition()')
    vim.cmd('command! LspCodeAction lua vim.lsp.buf.code_action()')
    vim.cmd('command! LspHover lua vim.lsp.buf.hover()')
    vim.cmd('command! LspRename lua vim.lsp.buf.rename()')
    vim.cmd('command! LspRefs lua vim.lsp.buf.references()')
    vim.cmd('command! LspTypeDef lua vim.lsp.buf.type_definition()')
    vim.cmd('command! LspImplementation lua vim.lsp.buf.implementation()')
    vim.cmd('command! LspDiagPrev lua vim.diagnostic.jump({ count = -1, float = true })')
    vim.cmd('command! LspDiagNext lua vim.diagnostic.jump({ count = 1, float = true })')
    buf_map(bufnr, 'n', 'gd', ':LspDef<CR>')
    buf_map(bufnr, 'n', 'gr', ':LspRename<CR>')
    buf_map(bufnr, 'n', 'gy', ':LspTypeDef<CR>')
    buf_map(bufnr, 'n', '<Leader>j', ':LspHover<CR>')
end

-- ts_ls (formerly tsserver); formatting is left to prettier via none-ls.
vim.lsp.config('ts_ls', {
    on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        vim.keymap.set('n', 'gs', function() ts_source_action('source.organizeImports') end,
            { buffer = bufnr, silent = true })
        vim.keymap.set('n', 'go', function() ts_source_action('source.addMissingImports.ts') end,
            { buffer = bufnr, silent = true })
        on_attach(client, bufnr)
    end,
})
vim.lsp.enable('ts_ls')

-- none-ls is the maintained fork of null-ls (same module name); eslint moved
-- out of core into none-ls-extras.
null_ls.setup({
    sources = {
        require("none-ls.diagnostics.eslint"),
        require("none-ls.code_actions.eslint"),
        null_ls.builtins.formatting.prettier,
    },
    on_attach = on_attach,
})
