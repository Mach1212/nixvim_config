{
  plugins.treesitter = {
    enable = true;
    nixvimInjections = false;
    folding = true;
    settings = {
      highlight = {
        additional_vim_regex_highlighting = true;
        custom_captures = {};
        enable = true;
        disable = [];
      };
      # ignore_install = [
      #   "rust"
      # ];
      indent.enable = true;
      incremental_selection.enable = true;
      parser_install_dir = {
        __raw = "vim.fs.joinpath(vim.fn.stdpath('data'), 'treesitter')";
      };
    };
  };
  opts = {
    foldmethod = "indent";
    foldlevelstart = 99;
  };
}
