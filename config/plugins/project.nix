{
  plugins.project-nvim = {
    enable = true;
    enableTelescope = true;
  };
  keymaps = [
    {
      key = "<leader>fp";
      action = "<CMD>Telescope projects<CR>";
      options.desc = "Find Project";
    }
  ];
}
