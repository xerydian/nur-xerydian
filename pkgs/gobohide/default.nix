{ lib, fetchFromGitHub, stdenv, 
  autoconf, automake, libtool, pkg-config, gettext, libnl, ... }:

stdenv.mkDerivation {
  name = "GoboHide";
  version = "1.3"; # change to desired tag or version
  src = fetchFromGitHub {
    owner = "gobolinux";
    repo = "GoboHide";
    rev = "e0813b7"; # change to a tag/commit you want
    sha256 = "sha256-21hCHS/ckniQexo9QQ+FdU9306eYHmCe9WWYF6Tqyn8=";
  };

  nativeBuildInputs = [
    autoconf
    automake
    libtool
    pkg-config
    libnl
  ];

  buildInputs = [
    gettext
  ];

  # upstream provides autogen/autoreconf scripts — run them
  preConfigure = ''
    export LANG=C.UTF-8
    autoreconf -fi
    ./configure --prefix=$out \
                --sysconfdir=$out/etc \
                --localstatedir=$out/var
  '';

  # override configureFlags if you prefer
  configureFlags = [];

  # if project uses raw Makefile targets, default targets should work
  installPhase = ''
    make install
  '';

  meta = with lib; {
    description = "GoboHide userspace client (GoboLinux)";
    homepage = "https://github.com/gobolinux/GoboHide";
    license = licenses.gpl2Plus;
    maintainers = [ ];
    platforms = platforms.linux;
  };
}