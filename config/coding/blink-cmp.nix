{helpers, ...}: {
  plugins.blink-cmp = {
    enable = true;
    settings = {
      appearance = {
        nerd_font_variant = "normal";
      };
      completion = {
        list.selection = {
          preselect = false;
          auto_insert = false;
        };
        menu = {
          enabled = true;
          auto_show = true;
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
          auto_show_delay_ms = 500;
          window = {
            border = "rounded";
          };
        };
      };
      signature = {
        enabled = false;
        # window = {
        #   border = "none";
        # };
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
              return cmp.accept()
            end
          '';
        in [
          select_and_accept
          "fallback"
        ];
      };
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
