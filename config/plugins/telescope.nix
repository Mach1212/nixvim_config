{
  plugins.telescope = {
    enable = true;
    extensions = {
      fzf-native.enable = true;
    };
  };
  keymaps = [
    {
      key = "<leader>ff";
      action = "<CMD>Telescope find_files<CR>";
      options.desc = "Find Files";
    }
  ];
}
