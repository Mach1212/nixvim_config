{
  imports = [
    ./neotree.nix
    ./better-escape.nix
    ./telescope.nix
    ./treesitter.nix
    ./treesitter-refactor.nix
    ./treesitter-textobjects.nix
    ./barbar.nix
    ./neoscroll.nix
    ./mini.nix
    ./flash.nix
    ./notify.nix
    ./lazygit.nix
    ./comment.nix
    ./noice.nix
    ./yazi.nix
    ./number-toggle.nix
    ./inc-rename.nix
    ./octo.nix
    ./indent-blankline.nix
    ./astrotheme.nix
    ./colorizer.nix
  ];
  plugins = {
    # lz-n.enable = true;
    guess-indent.enable = true;
    web-devicons.enable = true;
    which-key.enable = true;
    treesitter-context.enable = true;
    intellitab.enable = true;
    rainbow-delimiters.enable = true;
    # smart-splits.enable = true; Waiting for zellij integration
    transparent.enable = true;
    autoclose.enable = true;
    todo-comments.enable = true;
    ts-autotag = {
      enable = true;
      settings = {
        enable_close_on_slash = true;
      };
    };
    render-markdown.enable = true;
    gitsigns = {
      enable = true;
      settings.watch_gitdir.enable = true;
    };
    ts-context-commentstring.enable = true;
  };
}
