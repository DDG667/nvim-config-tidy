vim.o.ru = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.cursorline = true
vim.o.showmode = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.expandtab = true
vim.o.splitbelow = true
vim.o.breakindent = true
vim.o.showmatch = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.fileencodings = "utf-8"
vim.o.whichwrap = "<,>,[,]"
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.completeopt = "noinsert,menuone,noselect"
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.encoding = "UTF-8"
--vim.o.updatetime = 100                                                         vim.opt.termguicolors = true

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
    { "williamboman/mason.nvim" },
    { "navarasu/onedark.nvim",           lazy = true },
    { "nvim-treesitter/nvim-treesitter", dependencies = { "HiPhish/nvim-ts-rainbow2" } },
    { "windwp/nvim-autopairs" },
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "kyazdani42/nvim-web-devicons" },
        config = function()
            require("nvim-tree").setup({
                sort_by = "case_sensitive",
                renderer = {
                    group_empty = true,
                },
                filters = {
                    dotfiles = false,
                },
            })
        end,
    },
    { "romgrk/barbar.nvim" ,config=function ()
require("bufferline").setup({
    auto_hide = true,
    tabpages = true,
    closable = true,
    clickable = true,
    --icons = true,
    insert_at_end = false,
    insert_at_start = false,
    maximum_padding = 1,
    minimum_padding = 1,
    maximum_length = 30,
    no_name_title = nil,
})
    end},
    { "neovim/nvim-lspconfig" },
    {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },
    { "feline-nvim/feline.nvim",            dependencies = { "kyazdani42/nvim-web-devicons" } },
    { "lukas-reineke/indent-blankline.nvim" },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-nvim-lsp-document-symbol",
            "saadparwaiz1/cmp_luasnip",
            "lukas-reineke/cmp-under-comparator",
        },
    },
    { "onsails/lspkind.nvim" },
})
require("onedark").setup({
    style = "darker",
    transparent = true,
})

require("onedark").load()
require("nvim-treesitter.configs").setup({
    highlight = { -- enable highlighting for all file types
        enable = true, -- you can also use a table with list of langs here (e.g. { "python", "javascript" })
    },
    rainbow = {
        enable = true,
        -- Which query to use for finding delimiters
        query = "rainbow-parens",
        -- Highlight the entire buffer all at once
        strategy = require("ts-rainbow").strategy.global,
    },
})

require("nvim-autopairs").setup()

local line_ok, feline = pcall(require, "feline")
if not line_ok then
    return
end

local one_monokai = {
    fg = "#abb2bf",
    bg = "#2c323c",
    green = "#98c379",
    yellow = "#e5c07b",
    purple = "#c678dd",
    orange = "#d19a66",
    peanut = "#f6d5a4",
    red = "#e88388",
    aqua = "#61afef",
    blue = "#61afef",
    darkblue = "#2c323c",
    dark_red = "#f75f5f",
}

local vi_mode_colors = {
    NORMAL = "green",
    OP = "green",
    INSERT = "yellow",
    VISUAL = "purple",
    LINES = "orange",
    BLOCK = "dark_red",
    REPLACE = "red",
    COMMAND = "aqua",
}

local c = {
    vim_mode = {
        provider = {
            name = "vi_mode",
            opts = {
                show_mode_name = false,
                -- padding = "center", -- Uncomment for extra padding.
            },
        },
        hl = function()
            return {
                fg = require("feline.providers.vi_mode").get_mode_color(),
                bg = "darkblue",
                style = "bold",
                name = "NeovimModeHLColor",
            }
        end,
        left_sep = "block",
        right_sep = "block",
    },
    gitBranch = {
        provider = "git_branch",
        hl = {
            fg = "peanut",
            bg = "darkblue",
            style = "bold",
        },
        left_sep = "block",
        right_sep = "block",
    },
    gitDiffAdded = {
        provider = "git_diff_added",
        hl = {
            fg = "green",
            bg = "darkblue",
        },
        left_sep = "block",
        right_sep = "block",
    },
    gitDiffRemoved = {
        provider = "git_diff_removed",
        hl = {
            fg = "red",
            bg = "darkblue",
        },
        left_sep = "block",
        right_sep = "block",
    },
    gitDiffChanged = {
        provider = "git_diff_changed",
        hl = {
            fg = "fg",
            bg = "darkblue",
        },
        left_sep = "block",
        right_sep = "right_filled",
    },
    separator = {
        provider = "",
    },
    fileinfo = {
        provider = {
            name = "file_info",
            opts = {
                type = "unique",
            },
        },
        hl = {
            style = "bold",
        },
        left_sep = " ",
        right_sep = " ",
    },
    diagnostic_errors = {
        provider = "diagnostic_errors",
        hl = {
            fg = "red",
        },
    },
    diagnostic_warnings = {
        provider = "diagnostic_warnings",
        hl = {
            fg = "yellow",
        },
    },
    diagnostic_hints = {
        provider = "diagnostic_hints",
        hl = {
            fg = "aqua",
        },
    },
    diagnostic_info = {
        provider = "diagnostic_info",
    },
    lsp_client_names = {
        provider = "lsp_client_names",
        enable = false,
        hl = {
            fg = "purple",
            bg = "darkblue",
            style = "bold",
        },
        left_sep = "left_filled",
        right_sep = "block",
    },
    file_size = {
        provider = {
            name = "file_size",
        },
    },
    file_type = {
        provider = {
            name = "file_type",
            opts = {
                filetype_icon = true,
                case = "titlecase",
            },
        },
        hl = {
            fg = "red",
            bg = "darkblue",
            style = "bold",
        },
        left_sep = "block",
        right_sep = "block",
    },
    file_encoding = {
        provider = "file_encoding",
        hl = {
            fg = "orange",
            bg = "darkblue",
            style = "bold",
        },
        left_sep = "block",
        right_sep = "block",
    },
    position = {
        provider = "position",
        hl = {
            fg = "green",
            bg = "darkblue",
            style = "bold",
        },
        left_sep = "block",
        right_sep = "block",
    },
    line_percentage = {
        provider = "line_percentage",
        hl = {
            fg = "aqua",
            bg = "darkblue",
            style = "bold",
        },
        left_sep = "block",
        right_sep = "block",
    },
    scroll_bar = {
        provider = "scroll_bar",
        hl = {
            fg = "blue",
            style = "bold",
        },
    },
}

local left = {
    c.vim_mode,
    c.gitBranch,
    c.gitDiffAdded,
    c.gitDiffRemoved,
    c.gitDiffChanged,
    c.separator,
}

local middle = {
    c.fileinfo,
    c.diagnostic_errors,
    c.diagnostic_warnings,
    c.diagnostic_info,
    c.diagnostic_hints,
}

local right = {
    --c.lsp_client_names,
    c.file_size,
    c.file_type,
    --c.file_encoding,
    c.position,
    c.line_percentage,
    c.scroll_bar,
}

local components = {
    active = {
        left,
        middle,
        right,
    },
    inactive = {
        left,
        middle,
        right,
    },
}

feline.setup({
    components = components,
    theme = one_monokai,
    vi_mode_colors = vi_mode_colors,
})

require("mason").setup()

vim.diagnostic.config({ underline = true, virtual_text = true, signs = true, severity_sort = true })
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
    --[[require("lsp_signature").on_attach({
        bind = true, -- This is mandatory, otherwise border config won't get registered.
        handler_opts = {
            border = "rounded",
        },
    }, bufnr)]]
    --
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)

    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set("n", "<space>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)

    local map = function(mode, l, r, opts)
        opts = opts or {}
        opts.silent = true
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
    end

    map("n", "gd", vim.lsp.buf.definition, { desc = "go to definition" })
    map("n", "<C-]>", vim.lsp.buf.definition)
    map("n", "K", vim.lsp.buf.hover)
    map("n", "<C-k>", vim.lsp.buf.signature_help)
    map("n", "<space>rn", vim.lsp.buf.rename, { desc = "varialbe rename" })
    map("n", "gr", vim.lsp.buf.references, { desc = "show references" })
    map("n", "[d", vim.diagnostic.goto_prev, { desc = "previous diagnostic" })
    map("n", "]d", vim.diagnostic.goto_next, { desc = "next diagnostic" })
    map("n", "<space>q", vim.diagnostic.setqflist, { desc = "put diagnostic to qf" })
    map("n", "<space>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })
    map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, { desc = "add workspace folder" })
    map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, { desc = "remove workspace folder" })
    map("n", "<space>wl", function()
        vim.inspect(vim.lsp.buf.list_workspace_folders())
    end, { desc = "list workspace folder" })

    -- Set some key bindings conditional on server capabilities
    if client.server_capabilities.documentFormattingProvider then
        map("n", "<space>f", vim.lsp.buf.format, { desc = "format code" })
    end
    vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = function()
            local float_opts = {
                focusable = false,
                close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                border = "rounded",
                source = "always", -- show source in diagnostic popup window
                prefix = " ",
            }

            if not vim.b.diagnostics_pos then
                vim.b.diagnostics_pos = { nil, nil }
            end

            local cursor_pos = vim.api.nvim_win_get_cursor(0)
            if
                (cursor_pos[1] ~= vim.b.diagnostics_pos[1] or cursor_pos[2] ~= vim.b.diagnostics_pos[2])
                and #vim.diagnostic.get() > 0
            then
                vim.diagnostic.open_float(nil, float_opts)
            end

            vim.b.diagnostics_pos = cursor_pos
        end,
    })

    vim.keymap.set("n", "<space>f", function()
        vim.lsp.buf.format({ async = true })
    end, bufopts)
end

local lsp_flags = {
    debounce_text_changes = 100,
}
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require("lspconfig")
local servers = { "tsserver" }

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        flags = lsp_flags,
    })
end

require("lspkind").init({
    mode = "symbol_text",
    preset = "codicons",
    symbol_map = {
        Text = "",
        Method = "",
        Function = "",
        Constructor = "",
        Field = "ﰠ",
        Variable = "",
        Class = "ﴯ",
        Interface = "",
        Module = "",
        Property = "ﰠ",
        Unit = "塞",
        Value = "",
        Enum = "",
        Keyword = "",
        Snippet = "",
        Color = "",
        File = "",
        Reference = "",
        Folder = "",
        EnumMember = "",
        Constant = "",
        Struct = "פּ",
        Event = "",
        Operator = "",
        TypeParameter = "",
    },
})
local lspkind = require("lspkind")
local luasnip = require("luasnip")

local cmp = require("cmp")
cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-u>"] = cmp.mapping.scroll_docs(-4), -- Up
        ["<C-d>"] = cmp.mapping.scroll_docs(4), -- Down
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
        { name = "nvim_lsp_signature_help" },
        --{ name = "buffer",  keyword_length = 2 },
        { name = "nvim_lua" },
        --{name="cmdline"}
    },
    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol", -- show only symbol annotations
            maxwidth = 32,
            ellipsis_char = "...",
            before = function(entry, vim_item)
                return vim_item
            end,
        }),
    },
    completion = {
        keyword_length = 1,
        completeopt = "menu,noselect",
    },
    sorting = {
        comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            require("cmp-under-comparator").under,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },
})

cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "nvim_lsp_document_symbol" },
        { name = "buffer" },
    },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local status, bufferline = pcall(require, "bufferline")
if not status then
    print("ERROR bufferline")
    return
end

