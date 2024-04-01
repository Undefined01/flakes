{ pkgs, config }:

{
  secretUpdate =
    { name, runtimeInputs ? [ ], script }:
    let
      updateScript = pkgs.lib.getExe (pkgs.writeShellApplication {
        name = "${name}-update-secrets";
        runtimeInputs = with pkgs; [ coreutils ] ++ runtimeInputs;
        text = script;
      });
    in
    {
      systemd.user.services."${name}-update-secrets" = {
        Unit = {
          Description = "update secret file for ${name}";
          Requires = "agenix.service";
          After = "agenix.service";
        };
        Service = {
          Type = "oneshot";
          ExecStart = updateScript;
        };
        Install.WantedBy = [ "default.target" ];
      };
      home.activation."${name}" = config.lib.dag.entryAnywhere updateScript;
    };
}
