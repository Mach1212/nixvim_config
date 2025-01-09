{
  pkgs,
  helpers,
  lib,
  ...
}: {
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      pname = "astrotheme";
      version = "latest";
      src = pkgs.fetchFromGitHub {
        owner = "AstroNvim";
        repo = "astrotheme";
        rev = "33ae26a33171fa83384bf6d8fe6b155c519f9069";
        hash = "sha256-3nYDtBCv0l+6pgzvnkbTdx/5dFWegSyr/MWaQEq+c6s=";
      };
      meta.homepage = "https://github.com/AstroNvim/astrotheme";
    })
  ];
  extraConfigLua =
    #lua
    ''
      require("astrotheme").setup({
      	palette = "astrodark",
      	background = { -- :h background, palettes to use when using the core vim background colors
          light = "astrolight",
          dark = "astrodark",
        },

        style = {
          transparent = false,         -- Bool value, toggles transparency.
          inactive = true,             -- Bool value, toggles inactive window color.
          float = true,                -- Bool value, toggles floating windows background colors.
          neotree = true,              -- Bool value, toggles neo-trees background color.
          border = true,               -- Bool value, toggles borders.
          title_invert = true,         -- Bool value, swaps text and background colors.
          italic_comments = true,      -- Bool value, toggles italic comments.
          simple_syntax_colors = true, -- Bool value, simplifies the amounts of colors used for syntax highlighting.
        },

        termguicolors = true, -- Bool value, toggles if termguicolors are set by AstroTheme.

        terminal_color = true, -- Bool value, toggles if terminal_colors are set by AstroTheme.

        plugin_default = "true", -- Sets how all plugins will be loaded
                                -- "auto": Uses lazy / packer enabled plugins to load highlights.
                                -- true: Enables all plugins highlights.
                                -- false: Disables all plugins.
      })
      local colorscheme = "astrotheme"
      local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
      -- vim.o.background = "dark" -- or "light" for light mode
      if not ok then
        vim.notify("Colorscheme " .. colorscheme .. " not found!")
        return
      end
    '';
}
