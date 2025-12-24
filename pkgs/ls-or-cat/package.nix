{ pkgs, ... }:

pkgs.writeScript "ls-or-cat" ''
  #/usr/bin/env bash

  if [ $# -eq 0 ]; then
    # 无参数时显示当前目录
    ls
  else
    while [ $# -gt 0 ]; do
      if [ -d "$1" ]; then
        # 参数是目录
        ls "$1"
      elif [ -f "$1" ]; then
        # 参数是文件
        cat "$1"
      else
        echo "error: '$1' is neither a file nor a directory" >&2
        return 1
      fi
      shift
    done
  fi
''
