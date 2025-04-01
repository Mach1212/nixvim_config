{
  plugins.nerdy = {
    enable = true;
    enableTelescope = true;
  };

  keymaps = [
    {
      key = "<leader>mn";
      options.desc = "Misc get ascii wingdings";
      action = "<CMD>lua require('telescope').extensions.nerdy.nerdy()<CR>";
    }
  ];
}
