{pkgs, ...}: {
  programs.nvchad = {
    enable = true;

    extraPackages = with pkgs; [
      gnumake

      # Nix language support
      nil # LSP
      alejandra # formatter

      # Python
      basedpyright # LSP
      black # formatter

      # Javascript & Typescript
      biome # formatter and linter
      prettierd

      # Typescript
      typescript-language-server
      # Svelte lsp
      svelte-language-server
      # TailwindCSS lsp
      tailwindcss-language-server

      # Rust lsp
      rust-analyzer
      rustfmt
    ];

    extraPlugins = ''         
      return {
        {
          "yetone/avante.nvim",
          event = "VeryLazy",
          version = false, -- Never set this value to "*"! Never!
          opts = {
            -- add any opts here
            -- for example
            provider = "openai",
            providers = {
              openai = {
                endpoint = "https://api.openai.com/v1",
                model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
                extra_request_body = {
                  timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
                  temperature = 0.75,
                  max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
                  --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
                },
              },
            },
          },
          -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
          build = "make",
          -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
          dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            --- The below dependencies are optional,
            "echasnovski/mini.pick", -- for file_selector provider mini.pick
            "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
            "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
            "ibhagwan/fzf-lua", -- for file_selector provider fzf
            "stevearc/dressing.nvim", -- for input provider dressing
            "folke/snacks.nvim", -- for input provider snacks
            "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
            "zbirenbaum/copilot.lua", -- for providers='copilot'
            {
              -- support for image pasting
              "HakonHarnes/img-clip.nvim",
              event = "VeryLazy",
              opts = {
                -- recommended settings
                default = {
                  embed_image_as_base64 = false,
                  prompt_for_file_name = false,
                  drag_and_drop = {
                    insert_mode = true,
                  },
                  -- required for Windows users
                  use_absolute_path = true,
                },
              },
            },
            {
              -- Make sure to set this up properly if you have lazy=true
              'MeanderingProgrammer/render-markdown.nvim',
              opts = {
                file_types = { "markdown", "Avante" },
              },
              ft = { "markdown", "Avante" },
            },
          },
        }
      }'';

    extraConfig = ''
      local nvlsp = require "nvchad.configs.lspconfig"
      local lspconfig = require "lspconfig"

      nvlsp.defaults()

      lspconfig.basedpyright.setup{}
      lspconfig.nil_ls.setup{}
      lspconfig.biome.setup{}
      lspconfig.svelte.setup{}
      lspconfig.tailwindcss.setup{}
      lspconfig.ts_ls.setup{}
      lspconfig.rust_analyzer.setup{}

      require("conform").setup({
        formatters_by_ft = {
          nix = { "alejandra" },
          python = { "black" },
          javascript = { "biome" },
          rust = { "rustfmt" },
          svelte = { "prettierd" },
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
