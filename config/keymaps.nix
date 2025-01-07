{
  globals.mapleader = " ";
  keymaps = [
    {
      key = "<leader>q";
      action = "<CMD>q<CR>";
      options.desc = "Vim Exit";
    }
    {
      key = "<leader>Q";
      action = "<CMD>q!<CR>";
      options.desc = "Vim Exit Forced";
    }
    {
      key = "<leader>w";
      action = "<CMD>w<CR>";
      options.desc = "Buffer Write";
    }
    {
      key = "<leader>ww";
      action = "<CMD>w<CR>";
      options.desc = "Buffer Write All";
    }
    {
      key = "<leader>W";
      action = "<CMD>w!<CR>";
      options.desc = "Buffer Write Forced";
    }
    {
      key = "<C-h>";
      action = "<C-w>h";
      options.desc = "Pane Goto Left";
    }
    {
      key = "<C-l>";
      action = "<C-w>l";
      options.desc = "Pane Goto Right";
    }
    {
      key = "<C-j>";
      action = "<C-w>j";
      options.desc = "Pane Goto Down";
    }
    {
      key = "<C-k>";
      action = "<C-w>k";
      options.desc = "Pane Goto Up";
    }
    {
      key = "<C-Left>";
      action = "<C-w><";
      options.desc = "Pane Goto Left";
    }
    {
      key = "<C-Right>";
      action = "<C-w>>";
      options.desc = "Pane Goto Right";
    }
    {
      key = "<C-Up>";
      action = "<C-w>-";
      options.desc = "Pane Goto Down";
    }
    {
      key = "<C-Down>";
      action = "<C-w>+";
      options.desc = "Pane Goto Up";
    }
  #   {
  #     mode = "n";
  #     key = "[d";
  #     options.desc = "Previous diagnostic";
  # 
  #     action.__raw = ''
  #       function()
  #         vim.diagnostic.goto_prev()
  #       end
  #     '';
  #   }
  #   {
  #     mode = "n";
  #     key = "]d";
  #     options.desc = "Next diagnostic";
  # 
  #     action.__raw = ''
  #       function()
  #         vim.diagnostic.goto_next()
  #       end
  #     '';
  #   }
  ];
}
