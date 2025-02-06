{
  lib,
  pkgs,
  ...
}: {
  plugins.conform-nvim = {
    enable = true;
    settings = {
      formatters_by_ft = {
        nix = [
          "alejandra"
        ];
        lua = [
          "stylua"
        ];
        javascript = [
          "eslint_d"
          "prettierd"
        ];
        typescript = [
          "eslint_d"
          "prettierd"
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
      format_on_save = {
        timeout_ms = 200;
        lsp_format = "fallback";
      };
      # format_on_save =
      #   # Lua
      #   ''
      #     function(bufnr)
      #       if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      #         return
      #       end
      #
      #       if slow_format_filetypes[vim.bo[bufnr].filetype] then
      #         return
      #       end
      #
      #       local function on_format(err)
      #         if err and err:match("timeout$") then
      #           slow_format_filetypes[vim.bo[bufnr].filetype] = true
      #         end
      #       end
      #
      #       return { timeout_ms = 200, lsp_fallback = true }, on_format
      #      end
      #   '';
      formatters = {
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
        squeeze_blanks = {
          command = lib.getExe' pkgs.coreutils "cat";
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
}
