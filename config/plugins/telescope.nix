{
  plugins.telescope = {
    enable = true;
    extensions = {
      fzf-native.enable = true;
      fzy-native.enable = true;
    };
    settings.defaults = {
      file_ignore_patterns = ["^%.git[/\\]" "[/\\]%.git[/\\]"];
      # path_display = "truncate";
      sorting_strategy = "ascending";
      layout_config = {
        horizontal = {
          prompt_position = "top";
          preview_width = 0.55;
        };
        vertical = {mirror = false;};
        width = 0.87;
        height = 0.80;
        preview_cutoff = 120;
      };
      mappings = {
        i = {
          "jk" = "close";
        };
      };
    };
    keymaps = {};
  };
  keymaps = [
    {
      key = "<leader>ff";
      action = "<CMD>Telescope find_files<CR>";
      options.desc = "Find Files";
    }
    {
      key = "<leader>fF";
      action = "<CMD>Telescope find_files no_ignore=true<CR>";
      options.desc = "Find Files All Files";
    }
    {
      key = "<leader>fw";
      action = "<CMD>Telescope live_grep<CR>";
      options.desc = "Find String";
    }
    {
      key = "<leader>fW";
      action = "<CMD>Telescope live_grep no_ignore=true<CR>";
      options.desc = "Find String All Files";
    }
    {
      key = "<leader>fn";
      action = "<CMD>Telescope notify<CR>";
      options.desc = "Find Notifications";
    }
  ];
}
