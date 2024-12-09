{
  plugins.neo-tree = {
    enable = true;
    enableGitStatus = true;
    closeIfLastWindow = true;
    extraOptions = {
      window.width = 32;
    };
  };
  keymaps = [
    {
      key = "<leader>e";
      action = "<CMD>Neotree toggle<CR>";
      options.desc = "Neotree Toggle";
    }
  ];
}
