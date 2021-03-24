{ lib, buildPythonPackage, fetchFromGitHub, isPy27
, numpy
, pytest
}:

buildPythonPackage rec {
  version = "2.4.1";
  pname = "gsd";
  disabled = isPy27;

  src = fetchFromGitHub {
    owner = "glotzerlab";
    repo = pname;
    rev = "v${version}";
    sha256 = "02zxfmqw7a5kz8qjdph9a9961mbkd4haxwwa28yjkxs5hzs5x3c8";
  };

  propagatedBuildInputs = [ numpy ];

  checkInputs = [ pytest ];
  checkPhase = ''
    pytest
  '';

  meta = with lib; {
    description = "General simulation data file format";
    homepage = "https://github.com/glotzerlab/gsd";
    license = licenses.bsd2;
    maintainers = [ maintainers.costrouc ];
  };
}
