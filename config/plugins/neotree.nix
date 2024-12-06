{
  plugins.neo-tree = {
    enable = true;
    enableGitStatus = true;
  };
  keymaps = [
    {
      key = "<leader>e";
      action = "<CMD>Neotree toggle<CR>";
      options.desc = "Toggle Neotree";
    }
  ];
}
