{
  viAlias = true;
  vimAlias = true;

  opts = {
    relativenumber = true;
  };

  colorschemes.catppuccin.enable = true;

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
