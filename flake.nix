{
  inputs.utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, utils }: utils.lib.eachDefaultSystem (system:
    with import nixpkgs { inherit system; }; {
      devShell = pkgs.mkShell {
        packages = [
          pkgs.python310
          pkgs.python310Packages.Pweave
          pkgs.entr
          (pkgs.writeShellScriptBin "server" ''
            ls *.md | entr pweave -f md2html /_ &
            python -m http.server
          '')
        ];
      };
    }
  );
}
