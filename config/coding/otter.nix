{
  plugins.otter = {
    enable = true;
    settings = {
      lsp.diagnostic_update_events = ["InsertLeave" "BufWritePost"];
    };
  };
}
