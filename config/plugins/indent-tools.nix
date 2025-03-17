{pkgs, ...}: {
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      pname = "plenary.nvim";
      version = "latest";
      src = pkgs.fetchFromGitHub {
        owner = "nvim-lua";
        repo = "plenary.nvim";
        rev = "857c5ac632080dba10aae49dba902ce3abf91b35";
        hash = "";
      };
      meta.homepage = "https://github.com/nvim-lua/plenary.nvim";
    })
    (pkgs.vimUtils.buildVimPlugin {
      pname = "arshlib";
      version = "latest";
      src = pkgs.fetchFromGitHub {
        owner = "arsham";
        repo = "arshlib.nvim";
        rev = "111fd439268adda206a24b133096893869a50764";
        hash = "sha256-NuRh9VPztFdPdqUX8yuUes084pXkSZStWp6ewUlgqso=";
      };
      meta.homepage = "https://github.com/arsham/arshlib.nvim";
    })
    (pkgs.vimUtils.buildVimPlugin {
      pname = "indent-tools";
      version = "latest";
      src = pkgs.fetchFromGitHub {
        owner = "arsham";
        repo = "indent-tools.nvim";
        rev = "31b839d65aa04b568fabe5e100a63cc44ef3f5d5";
        hash = "sha256-F0Q7UvvOGulkLce1JiT9GvB+itCtwnJLzMpETm+Sg28=";
      };
      meta.homepage = "https://github.com/arsham/indent-tools.nvim";
    })
  ];
  extraConfigLua = ''
    require("indent-tools").config({})
  '';
}
