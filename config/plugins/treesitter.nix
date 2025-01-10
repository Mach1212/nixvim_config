{
  plugins.treesitter = {
    enable = true;
    nixvimInjections = false;
    # folding = true;
    settings = {
      highlight.enable = true;
      indent.enable = true;
      incremental_selection.enable = true;
    };
  };
}
