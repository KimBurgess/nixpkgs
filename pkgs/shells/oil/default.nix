{ stdenv, lib, fetchurl, readline }:

stdenv.mkDerivation rec {
  pname = "oil";
  version = "0.8.8";

  src = fetchurl {
    url = "https://www.oilshell.org/download/oil-${version}.tar.xz";
    sha256 = "sha256-J9aNuw72qufoVY6VnbdpCtpcI6GAI7ON10XGEJuqieI=";
  };

  postPatch = ''
    patchShebangs build
  '';

  preInstall = ''
    mkdir -p $out/bin
  '';

  buildInputs = [ readline ];
  configureFlags = [ "--with-readline" ];

  # Stripping breaks the bundles by removing the zip file from the end.
  dontStrip = true;

  meta = {
    description = "A new unix shell";
    homepage = "https://www.oilshell.org/";

    license = with lib.licenses; [
      psfl # Includes a portion of the python interpreter and standard library
      asl20 # Licence for Oil itself
    ];

    maintainers = with lib.maintainers; [ lheckemann alva ];
  };

  passthru = {
      shellPath = "/bin/osh";
  };
}
