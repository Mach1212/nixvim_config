{helpers, ...}: {
  imports = [
    ./neotree.nix
    ./hlsearch.nix
    # ./chadtree.nix
    ./better-escape.nix
    ./telescope.nix
    ./treesitter.nix
    ./treesitter-refactor.nix
    ./treesitter-textobjects.nix
    ./barbar.nix
    ./neoscroll.nix
    ./mini.nix
    # ./indent-tools.nix
    ./flash.nix
    ./notify.nix
    ./lazygit.nix
    ./noice.nix
    ./yazi.nix
    ./number-toggle.nix
    # ./octo.nix
    ./indent-blankline.nix
    ./astrotheme.nix
    ./startuptime.nix
    ./hlargs.nix
    # ./project.nix Breaks neovim cwd tracking with auto-session monorepo rpoblem.
    ./auto-session.nix
    ./gitsigns.nix
    # ./copilot.nix
    # ./codecompanion.nix
    ./jupyter.nix
    ./gitlinker.nix
    ./ufo.nix
  ];
  plugins = {
    image.enable = true;
    lualine.enable = true;
    web-devicons.enable = true;
    which-key.enable = true;
    rainbow-delimiters.enable = true;
    # smart-splits.enable = true; Waiting for zellij integration
    transparent.enable = true;
    nvim-autopairs = {
      enable = true;
      settings = {
        check_ts = true;
        disable_filetype = [
          "TelescopePrompt"
        ];
      };
    };
    todo-comments.enable = true;
    ts-autotag = {
      enable = true;
      settings = {
        enable_close_on_slash = true;
      };
    };
    ts-comments.enable = true;
    render-markdown = {
      enable = true;
      settings = {
        render_modes = helpers.listToUnkeyedAttrs ["n" "c" "t" "i"];
      };
    };
    dropbar.enable = true;
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
