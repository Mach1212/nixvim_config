{
  imports = [
    ./rustaceanvim.nix
    ./lsp-lines.nix
    ./blink-cmp.nix
  ];
  plugins.lsp = {
    enable = true;
    servers = {
      nixd.enable = true;
    };
    # inlayHints = true;
  };
}
