with import ./nix { };
mkShell {
  buildInputs = [ ballistics-ng-env ballistics-ng-env.wrappedRuby niv bundix ];
}
