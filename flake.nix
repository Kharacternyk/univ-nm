{
  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system:
    with import nixpkgs { inherit system; }; {
      devShell = with {
        server = writeShellScriptBin "server" ''
          ls *.md | entr make &
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
