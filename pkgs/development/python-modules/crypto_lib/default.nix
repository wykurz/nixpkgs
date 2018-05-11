# Find: from XXX import YYY
# rg import|sed -nr 's/.*from ([^ .]+)[^ ]* import .*/\1/p'|sort|uniq
# Find: import XXX
# rg import|rg -v from|sed -nr 's/.*import ([^ ]+).*/\1/p'|sort|uniq

{ stdenv
, buildPythonPackage
, fetchgitPrivate
, python
, pythonOlder
, asyncio
, gdax-python-api
, matplotlib
, numpy
, pandas
, pytz
, Quandl
, requests
, websocket_client
}:

buildPythonPackage rec {
  pname = "crypto_lib";
  version = "0.1";
  name = "${pname}-${version}";

  buildInputs = [ ];
  propagatedBuildInputs = [
    asyncio
    gdax-python-api
    matplotlib
    numpy
    pandas
    pytz
    Quandl
    requests
    websocket_client
  ];

  # checkPhase = ''
  #   ${python.interpreter} -m pytest tests
  # '';

  src = fetchgitPrivate {
    url = "git@github.com:wykurz/crypto_lib.git";
    rev = "7bf729160da61de70351f31ee19732b8f97945f6";
    sha256 = "01h46an85b304ahp1x9g4q053bqcq3fh2j39z79jxy38663vw528";
  };

  disabled = pythonOlder "3.6";

  meta = with stdenv.lib; {
    description = "Crypto lib library.";
    homepage    = https://github.com/wykurz/crypto_lib;
    license     = licenses.mit;
    maintainers = with maintainers; [ wykurz ];
  };
}
