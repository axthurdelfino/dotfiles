{
  description = "development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixpkgs-unstable";
  };

  outputs = { nixpkgs, ... }:
    let
      linux = "x86_64-linux";
      mac = "aarch64-darwin";

      linuxPkgs = nixpkgs.legacyPackages.${linux};
      macPkgs = nixpkgs.legacyPackages.${mac};
    in
    {
      devShells.${linux}.default = linuxPkgs.mkShell {
        packages = with linuxPkgs; [
          jdk
          maven
          gcc
          clang
          gdb
          rustc
          cargo
          go
          nodejs
          git
          ripgrep
          fd
          jq
        ];
      };

      devShells.${mac}.default = macPkgs.mkShell {
        packages = with macPkgs; [
          jdk
          maven
          clang
          gdb
          rustc
          cargo
          go
          nodejs
          git
          ripgrep
          fd
          jq
        ];
      };
    };
}
