{pkgs, pkgs-old, ...}: {
  plugins.lsp = {
    enable = true;
    servers = {
      nixd = {
        enable = true; 
        package = pkgs-old.nixd;
      };
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
      key = "[d";
      options.desc = "Previous diagnostic";
      action.__raw = ''
        function()
          vim.diagnostic.goto_prev()
        end
      '';
    }
    {
      key = "]d";
      options.desc = "Next diagnostic";
      action.__raw = ''
        function()
          vim.diagnostic.goto_next()
        end
      '';
    }
    {
      key = "ln";
      options.desc = "Lsp Diagnostics";
      action = "<CMD>Telescope diagnostics<CR>";
    }
    {
      key = "<leader>li";
      options.desc = "Lsp Info";
      action = "<CMD>LspInfo<CR>";
    }
    {
      key = "<leader>lI";
      options.desc = "Lsp Log";
      action = "<CMD>LspLog<CR>";
    }
    {
      key = "<leader>ln";
      options.desc = "Lsp Notif";
      action = "<CMD>LspInfo<CR>";
    }
    # {
    #   key = "<leader>la";
    #   options.desc = "Lsp Action";
    #   action = "<CMD>lua vim.lsp.buf.code_action()<CR>";
    # }
    {
      key = "<leader>lr";
      options.desc = "Lsp Rename";
      action = "<CMD>lua vim.lsp.buf.rename()<CR>";
    }
    {
      key = "<leader>lR";
      options.desc = "Lsp References";
      action = "<CMD>lua vim.lsp.buf.references()<CR>";
    }
    {
      key = "<leader>ld";
      options.desc = "Lsp Definition";
      action = "<CMD>lua vim.lsp.buf.definition()<CR>";
    }
    {
      key = "<leader>lD";
      options.desc = "Lsp Declaration";
      action = "<CMD>lua vim.lsp.buf.declaration()<CR>";
    }
  ];
}
