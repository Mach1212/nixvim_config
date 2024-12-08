{
  plugins.neo-tree = {
    enable = true;
    enableGitStatus = true;
    closeIfLastWindow = true;
  };
  keymaps = [
    {
      key = "<leader>e";
      action = "<CMD>Neotree toggle<CR>";
      options.desc = "Neotree Toggle";
    }
  ];
}
