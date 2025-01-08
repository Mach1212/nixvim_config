{
  plugins.lsp-lines = {
    enable = true;
  };
  diagnostics = {
    virtual_text = true;
    virtual_lines = {
      highlight_whole_line = false;
      only_current_line = true;
    };
  };
  keymaps = [
    {
      key = "<leader>ul";
      action = ''<CMD>require("lsp_lines").toggle()<CR>'';
      options.desc = "Toggle lsp_lines";
    }
  ];
}
