{
  plugins.fastaction = {
    enable = true;
  };
  keymaps = [
    {
      key = "<leader>la";
      options.desc = "Lsp Action";
      action = ''<CMD>lua require("fastaction").code_action()<CR>'';
    }
  ];
}
