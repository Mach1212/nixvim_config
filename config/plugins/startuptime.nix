{pkgs, ...}: {
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      pname = "startuptime";
      version = "latest";
      src = pkgs.fetchFromGitHub {
        owner = "dstein64";
        repo = "vim-startuptime";
        rev = "ac2cccb5be617672add1f4f3c0a55ce99ba34e01";
        hash = "sha256-+r4fDjEofLpz8+J8sPCFxwwCUbjNpMe1Hpa62LDtdD0=";
      };
      meta.homepage = "https://github.com/dstein64/vim-startuptime";
    })
  ];
}
