{pkgs, ...}: {
  extraPlugins = with pkgs; [
    (vimUtils.buildVimPlugin
      {
        pname = "hlargs";
        version = "latest";
        src = fetchFromGitHub {
          owner = "m-demare";
          repo = "hlargs.nvim";
          rev = "a5a7fdacc0ac2f7ca9d241e0e059cb85f0e733bc";
          hash = "sha256-HIQrwlOP/iQoNpH7ETusb7PMaGKrkOrhHlNdQ+fYeCk=";
        };
        meta.homepage = "https://github.com/m-demare/hlargs.nvim";
      })
  ];
  performance.combinePlugins.standalonePlugins = ["hlargs"];
  extraConfigLua =
    #lua
    ''
      require('hlargs').setup()
    '';
}
