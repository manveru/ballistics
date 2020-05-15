{ sources ? import ./sources.nix }:
import sources.nixpkgs {
  overlays = [
    (final: prev: {
      inherit (import sources.niv { pkgs = prev; }) niv;
      ballistics-ng-env = prev.bundlerEnv {
        ruby = prev.ruby_2_7;
        name = "ballistics-ng";
        gemdir = ../.;
      };
    })
  ];
}
