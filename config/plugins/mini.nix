{
  plugins.mini = {
    enable = true;
    modules = {
      # animate = {
      #   scroll = {
      #     enable = false;
      #   };
      #   cursor = {
      #     enable = true;
      #     "__unkeyed-1.timing" = {
      #       __raw = "require('mini.animate').gen_timing.linear({ duration = 20, unit = 'total' })";
      #     };
      #   };
      # };
      surround = {
        n_lines = 100;
        mappings = {
          add = "Ss"; # Add surrounding in Normal and Visual modes
          delete = "dD"; # Delete surrounding
          find = "Sl"; # Find surrounding (to the right)
          find_left = "SL"; # Find surrounding (to the left)
          highlight = ""; # Highlight surrounding
          replace = "Sr"; # Replace surrounding
          update_n_lines = "Sn"; # Update `n_lines`

          suffix_last = "N"; # Suffix to search with "prev" method
          suffix_next = "n"; # Suffix to search with "next" method
        };
      };
    };
  };
  keymaps = [
    # {
    #   key = "<S-h>";
    #   action = "<Cmd>BufferPrevious<CR>";
    #   options.desc = "Buffer Left";
    # }
  ];
}
