{helpers, ...}: {
  plugins.blink-cmp = {
    enable = true;
    settings = {
      appearance = {
        nerd_font_variant = "normal";
        use_nvim_cmp_as_default = true;
      };
      completion = {
        menu = {
          enabled = true;
          border = "rounded";
        };
        trigger = {
          prefetch_on_insert = true;
        };
        accept = {
          auto_brackets = {
            enabled = true;
            semantic_token_resolution = {
              enabled = true;
              # blocked_filetypes = ["java"];
              timeout_ms = 400;
            };
          };
        };
        documentation = {
          auto_show = true;
          auto_show_delay_ms = 1000;
          window = {
            border = "rounded";
          };
        };
      };
      keymap = {
        preset = "super-tab";
        "<Tab>" = let
          select_next_and_move_snippet = helpers.mkRaw ''
            function(cmp)
              if not cmp.snippet_active() then return cmp.select_next() end
            end
          '';
        in [
          select_next_and_move_snippet
          "snippet_forward"
          "fallback"
        ];
        "<S-Tab>" = ["select_prev"];
        "<CR>" = let
          select_and_accept = helpers.mkRaw ''
            function(cmp)
              if cmp.snippet_active() then return cmp.accept()
              else return cmp.select_and_accept() end
            end
          '';
        in [
          select_and_accept
          "fallback"
        ];
      };
      # signature = {
      #   enabled = true;
      #   window = {
      #     border = "rounded";
      #   };
      # };
      sources = {
        cmdline = [];
        providers = {
          buffer = {
            score_offset = -7;
          };
          lsp = {
            fallbacks = [];
          };
        };
      };
    };
  };
}
