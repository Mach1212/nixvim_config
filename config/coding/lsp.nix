{
  pkgs,
  pkgs-old,
  helpers,
  ...
}: {
  plugins.lsp = {
    enable = true;
    # lazyLoad.settings = {
    #   event = ["BufReadPost" "BufNewFile"];
    #   cmd = ["LspInfo" "LspInstall" "LspUninstall"];
    # };
    servers = {
      nixd = {
        enable = true;
        package = pkgs-old.nixd;
      };
      bashls.enable = true;

      cmake.enable = true;

      # python
      ruff.enable = true;

      lua_ls.enable = true;

      dockerls.enable = true;
      docker_compose_language_service.enable = true;

      # webdev
      html.enable = true;
      cssls.enable = true;
      tailwindcss.enable = true;
      eslint = {
        enable = true;
        package = pkgs.eslint_d;
      };

      # java
      jdtls.enable = true;

      jsonls.enable = true;
      yamlls.enable = true;
    };
    # inlayHints = true;
  };
  diagnostics = {
    virtual_text = {
      source = "always";
    };
    severity_sort = true;
    float = {
      source = "always";
    };
  };
  keymaps = [
    {
      key = "k";
      action = "gk";
    }
    # {
    #   key = "[d";
    #   options.desc = "Previous diagnostic";
    #   action.__raw = ''
    #     function()
    #       vim.diagnostic.goto_prev()
    #     end
    #   '';
    # }
    # {
    #   key = "]d";
    #   options.desc = "Next diagnostic";
    #   action.__raw = ''
    #     function()
    #       vim.diagnostic.goto_next()
    #     end
    #   '';
    # }
    {
      key = "<leader>ln";
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
      key = "<leader>lN";
      options.desc = "Lsp Notif";
      action = "<CMD>LspInfo<CR>";
    }
    # {
    #   key = "<leader>la";
    #   options.desc = "Lsp Action";
    #   action = "<CMD>lua vim.lsp.buf.code_action()<CR>";
    # }
    # {
    #   key = "<leader>lr";
    #   options.desc = "Lsp Rename";
    #   action = "<CMD>lua vim.lsp.buf.rename()<CR>";
    # }
    # {
    #   key = "<leader>lR";
    #   options.desc = "Lsp References";
    #   action = "<CMD>lua vim.lsp.buf.references()<CR>";
    # }
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
    {
      key = "<leader>ud";
      options.desc = "Toggle lsp diagnostics";
      action = "<CMD>ToggleDiagnostics<CR>";
    }
  ];
  extraConfigLua =
    #lua
    ''
      local mach12toggleLspDiagnostics = 0
      vim.api.nvim_create_user_command("ToggleDiagnostics", function(args)
      	if mach12toggleLspDiagnostics == 0 then
      		vim.diagnostic.config({
      			underline = false,
      			virtual_text = false,
      			signs = false,
      			update_in_insert = false,
      		})
      		mach12toggleLspDiagnostics = 1
      	elseif mach12toggleLspDiagnostics == 1 then
      		vim.diagnostic.config({
      			underline = true,
      			update_in_insert = true,
      			signs = true,
      		})
      		mach12toggleLspDiagnostics = 2
      	elseif mach12toggleLspDiagnostics == 2 then
      		vim.diagnostic.config({
      			virtual_text = true,
      		})
      		mach12toggleLspDiagnostics = 0
      	end
      end, {
      	desc = "Toggle line numbers",
      })
    '';
}
