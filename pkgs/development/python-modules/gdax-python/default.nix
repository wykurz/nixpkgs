{ stdenv
, buildPythonPackage
, fetchgit
, python
, pythonOlder
, dateutil
, pymongo
, pytest
, pytestcov
, requests
, six
, sortedcontainers
, websocket_client
}:

buildPythonPackage rec {
  pname = "gdax";
  version = "1.0.6";
  name = "${pname}-${version}";

  buildInputs = [ pytest pytestcov dateutil ];
  propagatedBuildInputs = [
    pymongo
    requests
    six
    sortedcontainers
    websocket_client
 ];

  checkPhase = ''
    ${python.interpreter} -m pytest
  '';

  src = fetchgit {
    url = "${meta.homepage}.git";
    rev = "df1360dc8092f28b11859a4071e528b993486161";
    sha256 = "0c9ppgmg6832fhwakxmsflg5zklgli8q2qr1zw7vq4lbrg16niv3";
  };

  disabled = pythonOlder "3.6";

  meta = with stdenv.lib; {
    description = "Unofficial GDAX API client written in Python3 using async/await";
    homepage    = https://github.com/wykurz/gdax-python;
    license     = licenses.mit;
    maintainers = with maintainers; [ wykurz ];
  };
}
