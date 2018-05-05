{ stdenv
, buildPythonPackage
, fetchgit
, python
, pythonOlder
, codecov
, pytest-asyncio
, pytestcov
, pytest-mock
, aiofiles
, aiohttp
, async-timeout
, sortedcontainers
, asynctest
, pytest
}:

buildPythonPackage rec {
  pname = "gdax";
  version = "0.2";
  name = "${pname}-${version}";

  buildInputs = [ codecov pytest pytest-asyncio pytestcov pytest-mock asynctest ];
  propagatedBuildInputs = [ aiofiles aiohttp async-timeout sortedcontainers ];

  checkPhase = ''
    ${python.interpreter} -m pytest tests
  '';

  src = fetchgit {
    url = "${meta.homepage}.git";
    rev = "7eec4ef442905c8d9e2f1f3aec032e3d13c6803d";
    sha256 = "0ysrv7hyh4qdb67xikzibphl78ff4mgf309n73fk8c0l3wy14920";
  };

  disabled = pythonOlder "3.6";

  meta = with stdenv.lib; {
    description = "Unofficial GDAX API client written in Python3 using async/await";
    homepage    = https://github.com/wykurz/gdax-python-api;
    license     = licenses.mit;
    maintainers = with maintainers; [ wykurz ];
  };
}
