{helpers, ...}: {
  plugins.typescript-tools = {
    enable = true;
    settings = {
      # handlers = {
      #   "textDocument/publishDiagnostics" = ''
      #     api.filter_diagnostics(
      #       { 80006 }
      #     )
      #   '';
      # };
      settings = {
        on_attach = ''
          function(client)
          	client.server_capabilities.documentFormattingProvider = false
          	client.server_capabilities.documentRangeFormattingProvider = false
          end
        '';
        tsserver_file_preferences = {
          __raw = ''
            function(ft)
              return {
                includeInlayParameterNameHints = "all",
                includeCompletionsForModuleExports = true,
                quotePreference = "auto",
              }
            end
          '';
        };
        # tsserver_format_options = {
        #   __raw = ''
        #     function(ft)
        #       return {
        #         allowIncompleteCompletions = false,
        #         allowRenameOfImportPath = false,
        #       }
        #     end
        #   '';
        # };
        # tsserver_plugins = [
        #   "@styled/typescript-styled-plugin"
        # ];
      };
    };
  };
}
