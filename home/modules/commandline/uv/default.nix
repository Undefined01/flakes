{
  programs.uv = {
    enable = true;
    settings = {
      pip.index-url = "https://pypi.mirrors.ustc.edu.cn/simple/";
      index = [
        {
          url = "https://pypi.mirrors.ustc.edu.cn/simple/";
          default = true;
        }
      ];
      # python-install-mirror = "https://github.com/astral-sh/python-build-standalone/releases/download";
      python-install-mirror = "https://hub.gitmirror.com/https://github.com/astral-sh/python-build-standalone/releases/download";
    };
  };
}
