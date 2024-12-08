{
  plugins.oil = {
    enable = true;
    settings = {
      experimental_watch_for_changes = true;
      delete_to_trash = true;
      keymaps = {
        "<leader>q" = "actions.close";
        "<S-h>" = "actions.parent";
        "<S-l>" = "actions.select";
        "<S-k>" = "actions.open_external";
        "~" = "actions.open_cwd";
        "<leader>h" = "actions.toggle_hidden";
        "<leader>t" = "actions.toggle_trash";
        "<leader>s" = "actions.change_sort";
        "<leader>r" = "actions.refresh";
        "<leader>y" = "actions.yank_entry";
      };
      float = {
        padding = 0;
        border = "rounded";
      };
      columns = [
        "icon"
      ];
    };
  };
  keymaps = [
    {
      key = "<leader>E";
      action = "<CMD>Oil --float<CR>";
      options.desc = "Open Oil";
    }
  ];
}
