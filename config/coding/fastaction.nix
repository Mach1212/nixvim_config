{
  plugins.fastaction = {
    enable = true;
    settings = {
      popup = {
        hide_cursor = false;
        title = "";
        border = "none";
      };
    };
  };
  keymaps = [
    {
      key = "<leader>la";
      options.desc = "Lsp Action";
      action = ''<CMD>lua require("fastaction").code_action()<CR>'';
    }
  ];
}
