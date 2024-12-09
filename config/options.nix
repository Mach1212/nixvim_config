{
  viAlias = true;
  vimAlias = true;

  opts = {
    relativenumber = true;
    termguicolors = true;
  };

  colorschemes.onedark = {
    enable = true;
    settings = {
      style = "darker";
    };
  };

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
