{
  plugins.telescope = {
    enable = true;
    extensions = {
      fzf-native.enable = true;
      fzy-native.enable = true;
    };
    settings.defaults = {
      # file_ignore_patterns = ["^%.git[/\\]" "[/\\]%.git[/\\]" "^%*.lock" "[/\\]*.lock*"];
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
        n = {
          q = "close";
          "h" = "results_scrolling_left"; # scroll left
          "l" = "results_scrolling_right"; # scroll right
          "j" = "move_selection_next"; # scroll down
          "k" = "move_selection_previous"; # scroll up
          "<C-h>" = "preview_scrolling_left"; # scroll left
          "<C-l>" = "preview_scrolling_right"; # scroll right
          "<C-j>" = "preview_scrolling_down"; # scroll down
          "<C-k>" = "preview_scrolling_up"; # scroll up
        };
        i = {
          # ["<PageUp>"] = actions.results_scrolling_up,
          # ["<PageDown>"] = actions.results_scrolling_down,
          "<C-h>" = "preview_scrolling_left"; # scroll left
          "<C-l>" = "preview_scrolling_right"; # scroll right
          "<C-j>" = "preview_scrolling_down"; # scroll down
          "<C-k>" = "preview_scrolling_up"; # scroll up
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
      action = "<CMD>Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>";
      options.desc = "Find Files All Files";
    }
    {
      key = "<leader>fw";
      action = "<CMD>Telescope live_grep<CR>";
      options.desc = "Find String";
    }
    {
      key = "<leader>fW";
      action = "<CMD>Telescope live_grep glob_pattern=*<CR>";
      options.desc = "Find String All Files";
    }
    {
      key = "<leader>fn";
      action = "<CMD>Telescope notify<CR>";
      options.desc = "Find Notifications";
    }
  ];
}
