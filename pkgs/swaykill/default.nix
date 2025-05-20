{
  symlinkJoin,
  sway,
  makeWrapper,
  jq,
  coreutils,
  pkgs,
}:
let
  script = (pkgs.writeScriptBin "swaykill" (builtins.readFile ./swaykill.sh)).overrideAttrs (old: {
    buildCommand = "${old.buildCommand}\n patchShebangs $out";
  });
in
symlinkJoin rec {
  name = "swaykill";
  paths = [
    script
    sway
    jq
    coreutils
  ];
  buildInputs = [ makeWrapper ];
  postBuild = "wrapProgram $out/bin/${name} --prefix PATH : $out/bin";
}
