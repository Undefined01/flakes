{ pkgs, lib
, stdenv
, fetchurl
, dpkg
, patchelf
, fcitx5
, opencc
, lsb-release
, xprop
}:

let
  version = "4.2.1.145";
in
stdenv.mkDerivation {
  name = "fcitx5-sogou-pinyin-${version}";
  src = fetchurl {
    name = "sogou-pinyin.deb";
    url = "https://ime-sec.gtimg.com/202404182311/ff3209ef8423947a2e6bb7535d43261a/pc/dl/gzindex/1680521603/sogoupinyin_4.2.1.145_amd64.deb";
    sha256 = "sha256-MRGvF6ar3dgLhWqpwfV5oTfWnz1zXq2TbdtuXwi1nzs=";
  };
  buildInputs = [ dpkg fcitx5 opencc lsb-release xprop ];

  unpackPhase = "true";
  installPhase = ''
    # install logic based on AUR package:
    mkdir -p $out
    dpkg -x $src $out
    mv $out/usr/lib/*-linux-gnu/fcitx $out/usr/lib/
    rmdir $out/usr/lib/*-linux-gnu
    # Avoid warning "No such key 'Gtk/IMModule' in schema 'org.gnome.settings-daemon.plugins.xsettings'"
    # sed -i "s#Gtk/IMModule=fcitx#overrides={'Gtk/IMModule':<'fcitx'>}#" $out/usr/share/glib-2.0/schemas/50_sogoupinyin.gschema.override
    rm -r $out/opt/sogoupinyin/files/lib/qt5
    rm -r $out/opt/sogoupinyin/files/bin/qt.conf
  '';

  postFixup = ''
    # ELF patching, which I found in many other Nix derivations of proprietary deb packages:
    for file in $(find $out -type f \( -perm /0111 -o -name \*.so\* \) ); do
      ${patchelf}/bin/patchelf \
        --interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
        --set-rpath "${pkgs.lib.makeLibraryPath (with pkgs; [ fcitx5 opencc lsb-release xprop ])}" \
        "$file" || true
        # ^ not listed in rpath: qtwebkit libidn11
    done
    # install -m755 sogou-autostart $out/usr/bin
    # ^ I'm not sure what this sogou-autostart is
    # Do not modify $out/etc/xdg/autostart/fcitx-ui-sogou-qimpanel.desktop, as it is
    # a symlink to absolute path "/usr/share/applications/fcitx-ui-sogou-qimpanel.desktop"
    # sed -i 's/sogou-qimpanel\ %U/sogou-autostart/g' $out/usr/share/applications/fcitx-ui-sogou-qimpanel.desktop
    # ^ commented bit from the AUR package
    # # Fix the desktop link
    # substituteInPlace $out/usr/share/applications/fcitx-ui-sogou-qimpanel.desktop \
    #   --replace sogou-qimpanel $out/usr/bin/sogou-qimpanel
    # ^ alternative, didn't get either to work
  '';

  meta = with lib; {
    description = "Sogou Pinyin for Linux";
    homepage = https://shurufa.sogou.com/linux;
    # license = licenses.unfree;
    maintainers = with maintainers; [ KiaraGrouwstra ];
    platforms = [ "x86_64-linux" ];
  };

}
