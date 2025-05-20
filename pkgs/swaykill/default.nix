{
  symlinkJoin,
  sway,
  makeWrapper,
  jq,
  xargs,
  kill,
}:
symlinkJoin rec {
  name = "swaykill";
  paths = [
    ./swaykill.sh
    sway
    jq
    xargs
    kill
  ];
  buildInputs = [ makeWrapper ];
  postBuild = "wrapProgram $out/bin/${name} --prefix PATH : $out/bin";
}
