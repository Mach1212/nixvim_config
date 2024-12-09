{
  description = "My neovim configuration";

  # RUSTC_WRAPPER=sccache

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
    galaxyline = {
      url = "github:NTBBloodbath/galaxyline.nvim";
      flake = false;
    };
    plenary = {
      url = "github:nvim-lua/plenary.nvim";
      flake = false;
    };
    githubNotifications = {
      url = "github:rlch/github-notifications.nvim";
      flake = false;
    };
  };

  outputs = {
    nixvim,
    flake-parts,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];

      perSystem = {
        pkgs,
        system,
        ...
      }: let
        nixvim' = nixvim.legacyPackages."${system}";
        nixvimModule = {
          inherit pkgs;
          module = import ./config; # import the module directly
          # You can use `extraSpecialArgs` to pass additional arguments to your module files
          extraSpecialArgs = {
            inherit inputs;
          };
        };
        nvim = nixvim'.makeNixvimWithModule nixvimModule;
      in {
        packages = {
          default = nvim;
        };
      };
    };
}
