{
  plugins.none-ls = {
    enable = true;
    settings = {
      diagnostics_format = "[#{s}] #{c} #{m}";
      on_attach = ''
        function(client, bufnr)
          -- Integrate lsp-format with none-ls
          require('lsp-format').on_attach(client, bufnr)
          if client.name == prettierd and not require("lspconfig.util").root_pattern("eslint.config.mjs") then 
            return prettierd
          end
        end
      '';
    };
    sources = {
      formatting = {
        alejandra.enable = true;
        prettierd = {
          enable = true;
          disableTsServerFormatter = true;
        };
      };
    };
  };
}
