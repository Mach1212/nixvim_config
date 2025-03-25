{
  description = "My neovim configuration";

  # RUSTC_WRAPPER=sccache

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
    nixpkgs-old.url = "github:NixOS/nixpkgs/05bbf675397d5366259409139039af8077d695ce";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = {
    flake-parts,
    nixvim,
    nixpkgs-old,
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
        pkgs-old = import nixpkgs-old {inherit system;};
        nixvim' = nixvim.legacyPackages."${system}";
        nixvimModule = {
          inherit pkgs;
          module = import ./config; # import the module directly
          # You can use `extraSpecialArgs` to pass additional arguments to your module files
          extraSpecialArgs = {
            inherit inputs;
            inherit pkgs-old;
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
