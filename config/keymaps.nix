{
  globals.mapleader = " ";
  keymaps = [
    {
      key = "<leader>q";
      action = "<CMD>q<CR>";
      options.desc = "Exit Vim";
    }
    {
      key = "<leader>Q";
      action = "<CMD>q!<CR>";
      options.desc = "Force Exit Vim";
    }
    {
      key = "<leader>w";
      action = "<CMD>w<CR>";
      options.desc = "Write Buffer";
    }
    {
      key = "<leader>W";
      action = "<CMD>w!<CR>";
      options.desc = "Force Write Buffer";
    }
  ];
}
