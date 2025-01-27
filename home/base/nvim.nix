{pkgs, ...}: {
  programs.nvchad = {
    enable = true;

    extraPackages = with pkgs; [
      # Nix language support
      nil # LSP
      alejandra # formatter

      # Python
      basedpyright # LSP
      black # formatter

      # Javascript & Typescript
      biome # formatter and linter

      # Typescript
      typescript-language-server
    ];

    extraConfig = ''
      local nvlsp = require "nvchad.configs.lspconfig"
      local lspconfig = require "lspconfig"

      nvlsp.defaults()

      lspconfig.basedpyright.setup{}
      lspconfig.nil_ls.setup{}
      lspconfig.biome.setup{}
      lspconfig.ts_ls.setup{}

      require("conform").setup({
        formatters_by_ft = {
          nix = { "alejandra" },
          python = { "black" },
          javascript = { "biome" },
          typescript = { "biome" },
          typescriptreact = { "biome" },
        },

        format_on_save = {
          timeout_ms = 500,
          lsp_format = "fallback",
        },
      })

      vim.api.nvim_create_user_command("Format", function(args)
        local range = nil
        if args.count ~= -1 then
          local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
          range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
          }
        end
        require("conform").format({ async = true, lsp_format = "fallback", range = range })
      end, { range = true })
    '';
  };
}
