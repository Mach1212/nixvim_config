{
  imports = [
    ./neotree.nix
    ./telescope.nix
  ];
  plugins = {
    noice.enable = true;
    better-escape.enable = true;
    which-key.enable = true;
    # intellitab.enable = true;
  };
}
