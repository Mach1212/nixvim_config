{
  lib,
  pkgs,
  ...
}: {
  plugins.conform-nvim = {
    enable = true;
    settings = {
      formatters_by_ft = let
        jsFormat = [
          "prettierd"
          "eslint_d"
        ];
      in {
        nix = [
          "alejandra"
          "injected"
        ];
        lua = [
          "stylua"
        ];
        javascript = jsFormat;
        typescript = jsFormat;
        javascriptreact = jsFormat;
        "javascript.jsx" = jsFormat;
        typescriptreact = jsFormat;
        "typescript.tsx" = jsFormat;
        python = [
          "black"
          "isort"
        ];
        json = [
          "jq"
        ];
        yaml = [
          "yamlfmt"
        ];
        "_" = [
          "squeeze_blanks"
          "trim_whitespace"
          "trim_newlines"
        ];
      };
      log_level = "warn";
      notify_on_error = true;
      notify_no_formatters = true;
      format_on_save =
        # Lua
        ''
          function(bufnr)
            -- Disable with a global or buffer-local variable
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
              return
            end
            if vim.g.format_modifications_only then
              -- Prefer to format Git hunks over entire file
              format_hunks(bufnr)
            else
              return default_format_options
            end
          end
        '';
      formatters = {
        injected = {
          options = {
            ignore_errors = false;
            lang_to_ext = {
              lua = "lua";
              bash = "sh";
              markdown = "md";
              python = "py";
              rust = "rs";
            };
          };
        };
        shellcheck = {
          command = lib.getExe pkgs.shellcheck;
        };
        shfmt = {
          command = lib.getExe pkgs.shfmt;
        };
        shellharden = {
          command = lib.getExe pkgs.shellharden;
        };
        alejandra = {
          command = lib.getExe pkgs.alejandra;
        };
        prettierd = {
          command = lib.getExe pkgs.prettierd;
        };
        stylua = {
          command = lib.getExe pkgs.stylua;
        };
        jq = {
          command = lib.getExe pkgs.jq;
        };
        squeeze_blanks = {
          command = lib.getExe' pkgs.coreutils "cat";
        };
        black = {
          command = lib.getExe pkgs.black;
        };
        isort = {
          command = lib.getExe pkgs.isort;
        };
        yamlfmt = {
          command = lib.getExe pkgs.yamlfmt;
        };
      };
    };
  };
  # vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  userCommands = {
    Format = {
      command = ''lua require("conform").format()'';
    };
  };

  keymaps = [
    {
      key = "<leader>uf";
      action = "<CMD>FormatToggle!<CR>";
      options.desc = "Toggle Buffer Formatting";
    }
    {
      key = "<leader>uF";
      action = "<CMD>FormatToggle<CR>";
      options.desc = "Toggle Global Formatting";
    }
    {
      key = "<leader>u<A-f>";
      action = "<CMD>FormatGitHunksToggle<CR>";
      options.desc = "Toggle Git Hunk Formatting";
    }
  ];
  extraConfigLua =
    #lua
    ''
      default_format_options = {
        lsp_fallback = true,
        async = false,
        timeout = 5000,
      }
      local range_ignore_filetypes = { "lua" }
      local format = require("conform").format
      function format_hunks(bufnr)
        if vim.tbl_contains(range_ignore_filetypes, vim.bo.filetype) then
          format(default_format_options)
          return
        end
        local hunks = require("gitsigns").get_hunks()
        if not hunks then
          return
        end
        local function format_range()
          if next(hunks) == nil then
            vim.notify("GitHunks done", "info", { title = "Format" })
            return
          end
          local hunk = nil
          while next(hunks) ~= nil and (hunk == nil or hunk.type == "delete") do
            hunk = table.remove(hunks)
          end

          if hunk ~= nil and hunk.type ~= "delete" then
            local start = hunk.added.start
            local last = start + hunk.added.count
            -- nvim_buf_get_lines uses zero-based indexing -> subtract from last
            local last_hunk_line = vim.api.nvim_buf_get_lines(0, last - 2, last - 1, true)[1]
            local range = { start = { start, 0 }, ["end"] = { last - 1, last_hunk_line:len() } }
            format({ range = range, async = false, lsp_fallback = true, timeout = 5000 }, function()
              vim.defer_fn(function()
                format_range()
              end, 1)
            end)
          end
        end
        format_range()
      end
      vim.api.nvim_create_user_command("FormatDisable", function(args)
         if args.bang then
          -- FormatDisable! will disable formatting just for this buffer
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, {
        desc = "Disable autoformat-on-save",
        bang = true,
      })
      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = "Re-enable autoformat-on-save",
      })
      vim.api.nvim_create_user_command("FormatToggle", function(args)
        if args.bang then
          -- Toggle formatting for current buffer
          vim.b.disable_autoformat = not vim.b.disable_autoformat
          vim.notify("BufferFormat: " .. tostring(not vim.b.disable_autoformat))
        else
          -- Toggle formatting globally
          vim.g.disable_autoformat = not vim.g.disable_autoformat
          vim.notify("GlobalFormat: " .. tostring(not vim.g.disable_autoformat))
        end
      end, {
        desc = "Toggle autoformat-on-save",
        bang = true,
      })
      vim.api.nvim_create_user_command("FormatGitHunksToggle", function(args)
        vim.g.format_modifications_only = not vim.g.format_modifications_only
        vim.notify("GitHunksFormat: " .. tostring(vim.g.format_modifications_only))
      end, {
        desc = "Toggle git hunks autoformat-on-save",
        bang = true,
      })
    '';
}
