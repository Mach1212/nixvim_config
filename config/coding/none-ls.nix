{
  plugins.none-ls = {
    enable = true;
    settings = {
      diagnostics_format = "[#{s}] #{c} #{m}";
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
