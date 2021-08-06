{ makeWrapper, pkgs, stdenv }:

let
  easier = pkgs.callPackage ../easier/easier.nix {};
in
stdenv.mkDerivation rec {
  name = "polybar-utils";
  version = "1.0.0";

  meta = {
    description = "Polybar utilities";
    license = stdenv.lib.licenses.mit;
    platforms = stdenv.lib.platforms.all;
  };

  dontUnpack = true;
  preferLocalBuild = true;

  src = ./resources;

  nativeBuildInputs = [
    makeWrapper
  ];

  phases = "preInstall installPhase";

  preInstall = ''
    mkdir -p $out/bin;
  '';

  installPhase = ''
    makeWrapper \
      $src/poly-applications \
      $out/bin/poly-applications \
      --prefix PATH : ${easier}

    makeWrapper \
      $src/poly-battery \
      $out/bin/poly-battery \
      --prefix PATH : ${easier}

    makeWrapper \
      $src/poly-bluetooth \
      $out/bin/poly-bluetooth \
      --prefix PATH : ${easier}

    makeWrapper \
      $src/poly-brightness \
      $out/bin/poly-brightness \
      --prefix PATH : ${easier}

    makeWrapper \
      $src/poly-bspwm-workspace \
      $out/bin/poly-bspwm-workspace \
      --prefix PATH : ${easier}

    makeWrapper \
      $src/poly-cpu-temp \
      $out/bin/poly-cpu-temp \
      --prefix PATH : ${easier}

    makeWrapper \
      $src/poly-datetime \
      $out/bin/poly-datetime \
      --prefix PATH : ${easier}

    makeWrapper \
      $src/poly-ethernet \
      $out/bin/poly-ethernet \
      --prefix PATH : ${easier}

    makeWrapper \
      $src/poly-micro \
      $out/bin/poly-micro \
      --prefix PATH : ${easier}

    makeWrapper \
      $src/poly-networks \
      $out/bin/poly-networks \
      --prefix PATH : ${easier}

    makeWrapper \
      $src/poly-power \
      $out/bin/poly-power \
      --prefix PATH : ${easier}

    makeWrapper \
      $src/poly-sys-usage \
      $out/bin/poly-sys-usage \
      --prefix PATH : ${easier}

    makeWrapper \
      $src/poly-termtabs \
      $out/bin/poly-termtabs \
      --prefix PATH : ${easier}

    makeWrapper \
      $src/poly-trash \
      $out/bin/poly-trash \
      --prefix PATH : ${easier}

    makeWrapper \
      $src/poly-volume \
      $out/bin/poly-volume \
      --prefix PATH : ${easier}

    makeWrapper \
      $src/poly-vpn \
      $out/bin/poly-vpn \
      --prefix PATH : ${easier}

    makeWrapper \
      $src/poly-weather \
      $out/bin/poly-weather \
      --prefix PATH : ${easier}

    makeWrapper \
      $src/poly-wifi \
      $out/bin/poly-wifi \
      --prefix PATH : ${easier}

    makeWrapper \
      $src/poly-windows \
      $out/bin/poly-windows \
      --prefix PATH : ${easier}
  '';
}
