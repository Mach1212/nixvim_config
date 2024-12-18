{
  plugins.barbar = {
    enable = true;
    keymaps = {};
    settings = {
      sidebar_filetypes = {
        neo-tree = {event = "BufWipeout";};
      };
    };
  };
  keymaps = [
    {
      key = "<S-h>";
      action = "<Cmd>BufferPrevious<CR>";
      options.desc = "Buffer Left";
    }
    {
      key = "<S-l>";
      action = "<Cmd>BufferNext<CR>";
      options.desc = "Buffer Right";
    }
    {
      key = "<leader>n";
      action = "<Cmd>tabnew<CR>";
      options.desc = "Buffer Create";
    }
    {
      key = "<leader>c";
      action = "<Cmd>BufferClose<CR>";
      options.desc = "Buffer Close";
    }
    {
      key = "<A-.>";
      action = "<Cmd>BufferMoveNext<CR>";
      options.desc = "Buffer Move Right";
    }
    {
      key = "<A-,>";
      action = "<Cmd>BufferMovePrevious<CR>";
      options.desc = "Buffer Move Right";
    }
  ];
}
