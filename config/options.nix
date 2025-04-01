{
  inputs,
  pkgs,
  ...
}: {
  package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
  luaLoader.enable = true;

  viAlias = true;
  vimAlias = true;

  opts = {
    number = true;
    relativenumber = true;
    termguicolors = true;
    shiftwidth = 2;
    tabstop = 2;
    ignorecase = true;
    smartcase = true;
    undofile = true;
    mouse = "a";
    mousemodel = "extend";
  };

  # extraConfigLua = ''
  #   vim.opt.mouse = ""
  # '';

  performance = {
    byteCompileLua = {
      enable = true;
      configs = true;
      initLua = true;
      nvimRuntime = true;
      plugins = true;
    };
    combinePlugins = {
      enable = true;
      standalonePlugins = ["conform.nvim"];
    };
  };

  clipboard.register = "unnamedplus";

  extraConfigLua =
    #lua
    ''
      local function my_paste(_)
      	return function(_)
      		local content = vim.fn.getreg('"')
      		return vim.split(content, "\n")
      	end
      end
      vim.g.clipboard = {
      	name = "OSC 52",
      	copy = {
      		["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      		["*"] = require("vim.ui.clipboard.osc52").copy("*"),
      	},
      	paste = {
      		["+"] = my_paste("+"),
      		["*"] = my_paste("*"),
      	},
      }
    '';
}
