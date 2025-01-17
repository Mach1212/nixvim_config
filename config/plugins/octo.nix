{
  pkgs,
  inputs,
  ...
}: {
  plugins.octo = {
    enable = true;
  };
  extraPlugins = with pkgs.vimPlugins; [
    (pkgs.vimUtils.buildVimPlugin {
      pname = "plenary.nvim";
      version = "latest";
      src = lib.fetchfromgithub;
      meta.homepage = "https://github.com/nvim-lua/plenary.nvim";
    })
  ];
}
