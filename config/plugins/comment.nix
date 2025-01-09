{
  plugins.comment = {
    enable = true;
    settings = {
      # mappings = false;
      # toggler = {
      #   line = "<leader>/";
      #   # block = "<leader><S-/>";
      # };
    };
  };
  extraConfigLua =
    #lua
    ''
      vim.keymap.set("n", "<leader>/", "gcc", { remap = true })
      vim.keymap.set("n", "<leader>?", "gbc", { remap = true })
      vim.keymap.set("v", "<leader>/", "gcc", { remap = true })
      vim.keymap.set("v", "<leader>?", "gbc", { remap = true })
    '';
}
