{pkgs, ...}: {
  plugins = {
    molten = {
      enable = true;
      settings = {
        auto_open_output = true;
        image_provider = "image.nvim";
        # output_win_cover_gutter = true;
        # output_win_hide_on_leave = true;
        # output_win_style = false;
        # save_path.__raw = "vim.fn.stdpath('data')..'/molten'";
        # show_mimetype_debug = false;
        use_border_highlights = true;
        virt_lines_off_by_1 = true;
        virt_text_output = true;
        wrap_output = true;
      };
    };
    image = {
      enable = true;
    };
    quarto = {
      enable = true;
      settings = {
        lspFeatures = {
          languages = ["python" "rust"];
          chunks = "all";
          diagnostics = {
            enabled = true;
            triggers = ["InsertLeave" "BufWritePost"];
          };
          completion = {
            enabled = true;
          };
        };
        # keymap = {
        #     hover = "H";
        #     definition = "gd";
        #     rename = "<leader>rn";
        #     references = "gr";
        #     format = "<leader>gf";
        # };
        codeRunner = {
          enabled = true;
          default_method = "molten";
        };
      };
    };
    jupytext = {
      enable = true;
      settings = {
        custom_language_formatting = {
          python = {
            style = "markdown";
            extension = "md";
            force_ft = "markdown";
          };
        };
      };
    };
  };
}
