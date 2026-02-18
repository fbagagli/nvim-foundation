-- lua/plugins/lsp.lua
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "williamboman/mason-lspconfig.nvim",
    { "j-hui/fidget.nvim", opts = {} },
    "saghen/blink.cmp", -- Assumption: you are using blink as per kickstart
  },
  config = function()
    -- LSP stands for Language Server Protocol. It's a protocol that helps editors
    -- and language tooling communicate in a standardized fashion.
    --
    -- In general, you have a "server" which is some tool built to understand a particular
    -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
    -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
    -- processes that communicate with some "client" - in this case, Neovim!
    --
    -- LSP provides Neovim with features like:
    --  - Go to definition
    --  - Find references
    --  - Autocompletion
    --  - Symbol Search
    --  - and more!
    --
    -- Thus, Language Servers are external tools that must be installed separately from
    -- Neovim. This is where `mason` and related plugins come into play.
    --
    -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
    -- and elegantly composed help section, `:help lsp-vs-treesitter`

    --  This function gets run when an LSP attaches to a particular buffer.
    --    That is to say, every time a new file is opened that is associated with
    --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
    --    function will be executed to configure the current buffer
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
      callback = function(event)
        -- In this case, we create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        -- Rename the variable under your cursor.
        --  Most Language Servers support renaming across files, etc.
        map("grn", vim.lsp.buf.rename, "[R]e[n]ame")

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })

        -- Find references for the word under your cursor.
        map("grr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

        map("K", vim.lsp.buf.hover, "Hover Documentation")

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        map("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-t>.
        map("grd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header.
        map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")

        -- Fuzzy find all the symbols in your current workspace.
        --  Similar to document symbols, except searches over your entire project.
        map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        map("grt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")

        -- Open diagnostic float
        map("gl", vim.diagnostic.open_float, "Open diagnostic f[l]oat")

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method("textDocument/documentHighlight", event.buf) then
          local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
            end,
          })
        end
      end,
    })
    -- LSP servers and clients are able to communicate to each other what features they support.
    --  By default, Neovim doesn't support everything that is in the LSP specification.
    --  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
    --  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
    local capabilities = require("blink.cmp").get_lsp_capabilities()
    require("mason-lspconfig").setup({})
    local servers = {
      "basedpyright", -- Python
      "ruff", -- Python linter
      "clangd", -- C/C++
      "bashls", -- Bash
      "shfmt", -- shell formatter for conform
    }
    local ensure_installed = vim.list_extend({}, servers)
    vim.list_extend(ensure_installed, {
      "lua_ls", -- Lua Language server
      "stylua", -- Used to format Lua code
      -- You can add other tools here that you want Mason to install
    })

    require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

    for _, name in ipairs(servers) do
      vim.lsp.config(name, { capabilities = capabilities })
      vim.lsp.enable(name)
    end

    -- Special Lua Config, as recommended by neovim help docs
    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
      on_init = function(client)
        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if
            path ~= vim.fn.stdpath("config")
            and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
          then
            return
          end
        end

        client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
          runtime = {
            version = "LuaJIT",
            path = { "lua/?.lua", "lua/?/init.lua" },
          },
          workspace = {
            checkThirdParty = false,
            -- NOTE: this is a lot slower and will cause issues when working on your own configuration.
            --  See https://github.com/neovim/nvim-lspconfig/issues/3189
            library = vim.api.nvim_get_runtime_file("", true),
          },
        })
      end,
      settings = {
        Lua = {},
      },
    })
    vim.lsp.enable("lua_ls")
  end,
}
