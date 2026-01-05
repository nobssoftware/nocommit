{
  inputs = {
    systems.url = "systems";
    flake-utils = {
      url = "flake-utils";
      inputs.systems.follows = "systems";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    flake-parts.url = "github:hercules-ci/flake-parts";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs =
    { self, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } ({
      systems = import inputs.systems;
      imports = [ inputs.treefmt-nix.flakeModule ];
      perSystem =
        { pkgs, ... }:
        {
          treefmt = {
            projectRootFile = "flake.nix";
            programs.nixfmt = {
              enable = true;
              strict = true;
            };
          };
          # This derivation needs git and grep on the PATH.  Those dependencies
          # could be baked in from this flake’s nixpkgs, but that feels like more
          # trouble than it’s worth: it’s highly unlikely this will ever be used
          # in a system without grep, let alone git (!), and it’s nicer to always
          # default to the system tools.
          packages.default = pkgs.writeShellScriptBin "nocommit-pre-commit" (builtins.readFile ./pre-commit);
        };
    });
}
