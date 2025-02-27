{
  inputs,
  pkgs,
  ...
}: {
  package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
  luaLoader.enable = true;

  viAlias = true;
  vimAlias = true;

  opts = {
    relativenumber = true;
    termguicolors = true;
    shiftwidth = 2;
    tabstop = 2;
    ignorecase = true;
    smartcase = true;
    undofile = true;
  };

  # extraConfigLua = ''
  #   vim.opt.mouse = ""
  # '';

  clipboard.register = "unnamedplus";

  performance = {
    byteCompileLua = {
      enable = true;
      configs = true;
      initLua = true;
      nvimRuntime = true;
      plugins = true;
    };
    combinePlugins = {
      enable = true;
      standalonePlugins = [];
    };
  };
}
