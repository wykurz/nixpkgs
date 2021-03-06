{ runCommand
, nix
, bash
, git
, jq
, nix-prefetch-scripts
, coreutils
, common-updater-scripts
, gnugrep
, gnused
, curl
}:

{ repoName
, attrPath ? repoName
, versionPolicy ? "release"
}:

let
  script = ./update.sh;

  updateScript = runCommand "update.sh" {
    inherit bash git jq nix coreutils gnugrep gnused curl;
    # These weren't being substituted
    nix_prefetch_scripts = nix-prefetch-scripts;
    common_updater_scripts = common-updater-scripts;
  } ''
    substituteAll ${script} $out
    chmod +x $out
  '';

  throwFlag = throw "${versionPolicy} is not a valid versionPolicy - Options are either 'release' or 'master' (defaults to release).";

  versionFlag = { release = "-r"; master = "-m"; }.${versionPolicy} or throwFlag;

in [ updateScript versionFlag repoName attrPath ]
