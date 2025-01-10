{
  plugins.lazygit = {
    enable = true;
  };
  keymaps = [
    {
      key = "<leader>gg";
      action = "<CMD>LazyGit<CR>";
      options.desc = "Open LazyGit";
    }
  ];
}
