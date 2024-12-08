{
  imports = [
    ./rustaceanvim.nix
  ];
  plugins.lsp = {
    enable = true;
  };
  keymaps = [
    # {
    #   key = "<leader>e";
    #   action = "<CMD>Neotree toggle<CR>";
    #   options.desc = "Neotree Toggle";
    # }
  ];
}
