{
  plugins.lsp = {
    enable = true;
    servers = {
      nixd.enable = true;
      eslint.enable = true;
      ts_ls.enable = true;
      bashls.enable = true;
      cssls.enable = true;
      cmake.enable = true;
      dockerls.enable = true;
      docker_compose_language_service.enable = true;
      pyright.enable = true;
      yamlls.enable = true;
    };
    # inlayHints = true;
  };
  keymaps = [
    {
      mode = "n";
      key = "[d";
      options.desc = "Previous diagnostic";
      action.__raw = ''
        function()
          vim.diagnostic.goto_prev()
        end
      '';
    }
    {
      mode = "n";
      key = "]d";
      options.desc = "Next diagnostic";
      action.__raw = ''
        function()
          vim.diagnostic.goto_next()
        end
      '';
    }
  ];
}
