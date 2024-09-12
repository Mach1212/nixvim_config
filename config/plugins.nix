
_: {
  imports = [
    ./plugins/gitsigns.nix
    ./plugins/lazygit.nix
    ./plugins/startup.nix
    ./plugins/toggleterm.nix
    ./plugins/telescope.nix
    ./plugins/betterescape.nix
    ./plugins/noice.nix
  ];
  
  plugins = {
    lualine = {
      enable = true;
    };
    neo-tree = {
      enable = true;
      closeIfLastWindow = true;
    };
    which-key = {
      enable = true;
      settings = {
        delay = 200;
        expand = 1;
      };
    };
    notify = {
      enable = true;
    };
  };
}
