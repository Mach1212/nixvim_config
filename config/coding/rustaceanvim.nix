{
  plugins.rustaceanvim = {
    enable = true;
    rustAnalyzerPackage = null;
    settings.server = {
      # cmd = [
      #   "rustup"
      #   "run"
      #   "nightly"
      #   "rust-analyzer"
      # ];
      standalone = false;
      load_vscode_settings = false;
      status_notify_level = "warn";
      default_settings = {
        rust-analyzer = {
          check = {
            command = "clippy";
          };
          completion = {
            fullFunctionSignatures.enable = true;
            # hideDepreciated = true;
            snippets.custom = {
              Ok = {
                postfix = "ok";
                body = "Ok($\{receiver})";
                description = "Wrap the expression in a `Result::Ok`";
                scope = "expr";
              };
            };
            termSearch.enable = true;
          };
          diagnostics = {
            # experimental.enable = true;
            styleLints.enable = true;
          };
          hover = {
            actions.references.enable = true;
            memoryLayout.niches = true;
          };
          imports = {
            # preferNoStd = true;
            preferPrelude = true;
          };
          inlayHints = {
            bindingModeHints.enable = true;
            closureCaptureHints.enable = true;
            closureReturnTypeHints.enable = "always";
            discriminantHints.enable = "always";
            expressionAdjustmentHints.enable = "always";
            genericParameterHints = {
              lifetime.enable = true;
              type.enable = true;
            };
            implicitDrops.enable = true;
            lifetimeElisionHints = {
              enable = "always";
              useParameterNames = true;
            };
            rangeExclusiveHints.enable = true;
          };
          lens.references = {
            adt.enable = true;
            enumVariant.enable = true;
            method.enable = true;
            trait.enable = true;
          };
        };
      };
    };
  };
  keymaps = [
    # {
    #   key = "<leader>e";
    #   action = "<CMD>Neotree toggle<CR>";
    #   options.desc = "Neotree Toggle";
    # }
  ];
}
