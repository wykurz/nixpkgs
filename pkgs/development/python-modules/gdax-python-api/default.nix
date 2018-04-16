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
}:

buildPythonPackage rec {
  pname = "gdax";
  version = "0.2";
  name = "${pname}-${version}";

  buildInputs = [ codecov pytest-asyncio pytestcov pytest-mock ];
  propagatedBuildInputs = [ aiofiles aiohttp async-timeout sortedcontainers ];

  checkPhase = ''
    ${python.interpreter} test/test.py
  '';

  src = fetchgit {
    url = "${meta.homepage}.git";
    rev = "a2c2cb339ef4193ce62e17bb57367021246f359b";
    sha256 = "018rl6wl36ihizas79czjpwax2pp9fd9xb9ymy3f9hdcxf0f8jqz";
  };

  disabled = pythonOlder "3.6";

  meta = with stdenv.lib; {
    description = "Unofficial GDAX API client written in Python3 using async/await";
    homepage    = https://github.com/csko/gdax-python-api;
    license     = licenses.mit;
    maintainers = with maintainers; [ wykurz ];
  };
}
