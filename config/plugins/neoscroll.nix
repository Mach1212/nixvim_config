{
  plugins.neoscroll = {
    enable = true;
  };
  extraConfigLua = ''
    require('neoscroll').setup({
      duration_multiplier = 0.3,
    })
  '';
}
