{ stdenv, lib, bundlerApp, bundlerUpdateScript, ruby_3_0, libinput }:

bundlerApp {
  pname = "fusuma";
  gemdir = ./.;
  ruby = ruby_3_0;
  exes = [ "fusuma" "fusuma-sendkey" ];

  passthru.updateScript = bundlerUpdateScript "fusuma";
}
