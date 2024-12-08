{
  imports = [
    ./neotree.nix
    ./telescope.nix
    ./treesitter-refactor.nix
    ./treesitter-textobjects.nix
    ./barbar.nix
    ./oil.nix
    ./neoscroll.nix
    # ./galaxyline.nix
  ];
  plugins = {
    better-escape.enable = true;
    guess-indent.enable = true;
    noice = {
      enable = true;
      settings.presets.lsp_doc_border = true;
    };
    indent-blankline.enable = true;
    web-devicons.enable = true;
    which-key.enable = true;
    treesitter = {
      enable = true;
      nixvimInjections = false;
    };
    treesitter-context.enable = true;
    intellitab.enable = true;
    notify.enable = true;
    rainbow-delimiters.enable = true;
    # smart-splits.enable = true; Waiting for zellij integration
    transparent.enable = true;
    autoclose.enable = true;
    todo-comments.enable = true;
    nvim-ts-autotag = {
      enable = true;
      settings = {
        enable_close_on_slash = true;
      };
    };
    render-markdown.enable = true;
  };
}
