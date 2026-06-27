local servers = {
  "lua_ls",
  "html",
  "tailwindcss",
  "ts_ls",
  "solargraph",
  "csharp_ls",
  "fsautocomplete"

}
return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      ensure_installed = servers
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Responsible to config and enable specified lsp.
      local function setup (server, opts)
        opts = opts or {}
        opts.capabilities = capabilities

        vim.lsp.config(server, opts);
        vim.lsp.enable(server)
      end

      -- Automatically config and register LSPs
      -- Feel free to add/remove your favorite LSPs to the `servers` table as pecified above.
      for _, lsp in ipairs(servers) do
       setup(lsp, {})
      end

      -- Add your custom LSP configuration with helper function here.
      --
      --setup("tailwindcss")
      --setup("ts_ls")
      --setup("csharp_ls")
      --setup("fsautocomplete")
     
      -- Add your custom LSP configuration here.
      --
      --vim.lsp.config("tailwindcss", {
      --  capabilities = capabilities
      --})
      --vim.lsp.enable("tailwindcss")

      --vim.lsp.config("lua_ls", {
      --  capabilities = capabilities
      --})
      --vim.lsp.enable("lua_ls")


      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
      --vim.keymap.set("n", "<leader>rn", vim.lsp.buf.code_action, {})
      vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, {})
    end,
  },
}
