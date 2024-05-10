#! /usr/bin/env nix-shell
#! nix-shell --packages python3Packages.toml
#! nix-shell -i python3

# Or with flake
#! /usr/bin/env nix
#! nix shell --impure --expr ``
#! nix with (import (builtins.getFlake "nixpkgs") {});
#! nix python3.withPackages(ps: with ps; [ toml ])
#! nix ``
#! nix --command python3

import toml
from typing import Any, Dict
import argparse

# starship preset nerd-font-symbols -o starship.toml
# nix-shell -p 'python3.withPackages(ps: with ps; [ toml ])' --run 'python3 convert.py'
# nix shell --impure --expr 'with (import (builtins.getFlake "nixpkgs") {}); python3.withPackages(ps: with ps; [ toml ])' --command python3 convert.py

def dict_to_nix(input_dict: Dict[str, Any], indent: int = 4) -> str:
    """
    Recursively convert a Python dictionary to a Nix configuration string.
    """
    nix_str = ""
    indent_str = " " * indent
    for key, value in input_dict.items():
        if isinstance(value, dict):
            nix_str += f"{indent_str}{key} = {{\n{dict_to_nix(value, indent + 2)}{indent_str}}};\n"
        else:
            # Format the value as a Nix string literal, escaping double quotes and backslashes
            formatted_value = str(value).replace("\\", "\\\\").replace("\"", "\\\"")
            nix_str += f"{indent_str}{key} = \"{formatted_value}\";\n"
    return nix_str

def convert_toml_to_nix(toml_file_path: str, nix_file_path: str):
    # Read the TOML file
    with open(toml_file_path, "r") as toml_file:
        toml_dict = toml.load(toml_file)
    
    # Convert the dictionary to Nix format
    nix_str = "{ ... }:\n\n{\n  programs.starship.settings = {\n" + dict_to_nix(toml_dict) + "  };\n}\n"
    
    # Write the Nix configuration to a file
    with open(nix_file_path, "w") as nix_file:
        nix_file.write(nix_str)


if __name__ == "__main__":
    # Parse command-line arguments
    parser = argparse.ArgumentParser(description="Convert a Starship TOML configuration file to a Nix configuration file")
    parser.add_argument("toml_file", help="Path to the input TOML file")
    parser.add_argument("-o", "--output", dest="nix_file", help="Path to the output Nix file")
    args = parser.parse_args()

    # Convert the TOML file to a Nix file
    if args.nix_file:
        convert_toml_to_nix(args.toml_file, args.nix_file)
    else:
        nix_file = args.toml_file.replace(".toml", ".nix")
        convert_toml_to_nix(args.toml_file, nix_file)

