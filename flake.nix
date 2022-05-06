{
  inputs.utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, utils }: utils.lib.eachDefaultSystem (system:
    with import nixpkgs { inherit system; }; {
      devShell = with {
        server = writeShellScriptBin "server" ''
          ls *.md | entr pweave -f md2html /_ &
          python -m http.server
        '';
      }; mkShell {
        packages = [
          python310
          python310Packages.Pweave
          entr
          server
        ];
      };
    }
  );
}
