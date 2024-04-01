{ inputs, ... }:

{
  unstable-packages = final: prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };

  shell_gpt = final: prev: {
    shell_gpt = final.unstable.shell_gpt;
  };
}
