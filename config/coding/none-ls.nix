{
  plugins.none-ls = {
    enable = true;
    settings = {
      diagnostics_format = "[#{s}] #{c} #{m}";
      # on_attach = ''
      #   function(client, bufnr)
      #     if client.name == prettierd and not require("lspconfig.util").root_pattern("eslint.config.mjs") then 
      #       return prettierd
      #     end
      #     return true
      #   end
      # '';
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
