{
  symlinkJoin,
  slurp,
  sway,
  makeWrapper,
  jq,
  coreutils,
  pkgs,
}:
let
  script-name = "swayprop";
  script = (pkgs.writeScriptBin script-name (builtins.readFile ./swayprop.sh)).overrideAttrs (old: {
    buildCommand = "${old.buildCommand}\n patchShebangs $out";
  });
in
symlinkJoin {
  name = script-name;
  paths = [
    script
    sway
    jq
    slurp
    coreutils
  ];
  buildInputs = [ makeWrapper ];
  postBuild = "wrapProgram $out/bin/${script-name} --prefix PATH : $out/bin";
}
