{pkgs, ...}: {
  viAlias = true;
  vimAlias = true;

  colorschemes.catppuccin.enable = true;

  opts = {
    relativenumber = true;
  };

  performance = {
    byteCompileLua = {
      enable = true;
      nvimRuntime = true;
      plugins = true;
    };
    combinePlugins = {
      enable = true;
      standalonePlugins = [];
    };
  };
}
