{ lib, stdenv, fetchurl, zig, ncurses }:

stdenv.mkDerivation rec {
  pname = "ncdu";
  version = "2.1.1";

  src = fetchurl {
    url = "https://dev.yorhel.nl/download/${pname}-${version}.tar.gz";
    sha256 = "sha256-1sI3TKUNQLYhE0aXKi6JyWARcv0HBNiF7aWx4JoqSO0=";
  };

  XDG_CACHE_HOME="Cache"; # FIXME This should be set in stdenv

  nativeBuildInputs = [
    zig
  ];

  buildInputs = [ ncurses ];

  PREFIX = placeholder "out";

  meta = with lib; {
    description = "Disk usage analyzer with an ncurses interface";
    homepage = "https://dev.yorhel.nl/ncdu";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = with maintainers; [ pSub SuperSandro2000 ];
  };
}
