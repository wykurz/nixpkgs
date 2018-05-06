# Find: from XXX import YYY
# rg import|sed -nr 's/.*from ([^ .]+)[^ ]* import .*/\1/p'|sort|uniq
# Find: import XXX
# rg import|rg -v from|sed -nr 's/.*import ([^ ]+).*/\1/p'|sort|uniq

{ stdenv
, buildPythonPackage
, fetchgitPrivate
, python
, pythonOlder
, gdax-python-api
, pandas
, pytz
}:

buildPythonPackage rec {
  pname = "crypto_trader";
  version = "0.1";
  name = "${pname}-${version}";

  buildInputs = [ ];
  propagatedBuildInputs = [ gdax-python-api pandas pytz ];

  # checkPhase = ''
  #   ${python.interpreter} -m pytest tests
  # '';

  src = fetchgitPrivate {
    url = "git@github.com:wykurz/crypto_trader.git";
    rev = "975febe96a9ac26f14bcd909946007043a3fcfd7";
    sha256 = "1767s5qhx06fsrzgyq9bsc5zkvb7dh2i00298p6cxbvhzc5ayrpn";
  };

  disabled = pythonOlder "3.6";

  meta = with stdenv.lib; {
    description = "Crypto trader library.";
    homepage    = https://github.com/wykurz/crypto_trader;
    license     = licenses.mit;
    maintainers = with maintainers; [ wykurz ];
  };
}
