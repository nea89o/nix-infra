let
  nea = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINg2WYMRKINwbH5UCqqK2qq/qW0gG1NnaALHqEyU4NzM";
  users = [ nea ];
  systems = [ ];
  all = users ++ systems;
in
{
  "secret1.age".publicKeys = all;
}
