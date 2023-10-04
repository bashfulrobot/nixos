{ pkgs, ... }: {
  programs.chromium = {
    enable = true;
    package = pkgs.chromium;
    commandLineArgs = [ "--ozone-platform-hint=auto" ];
    extensions = [
      { id = "aeblfdkhhhdcdjpifhhbdiojplfjncoa"; } # 1password
      { id = "kfimphpokifbjgmjflanmfeppcjimgah"; } # inoreader
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # dark reader
      { id = "ldgfbffkinooeloadekpmfoklnobpien"; } # raindrop.io
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
      { id = "lljedihjnnjjefafchaljkhbpfhfkdic"; } # jiffy reader
      { id = "haebnnbpedcbhciplfhjjkbafijpncjl"; } # tineye
      { id = "fggkaccpbmombhnjkjokndojfgagejfb"; } # tactiq
      { id = "glnpjglilkicbckjpbgcfkogebgllemb"; } # okta
      { id = "gabdloknkpdefdpkkibplcfnkngbidim"; } # delugesiphon
      { id = "kbfnbcaeplbcioakkpcpgfkobkghlhen"; } # grammarly
      { id = "pbmlfaiicoikhdbjagjbglnbfcbcojpj"; } # simplify
      { id = "jldhpllghnbhlbpcmnajkpdmadaolakh"; } # todoist
      { id = "kgjfgplpablkjnlkjmjdecgdpfankdle"; } # zoom
      { id = "lcbjdhceifofjlpecfpeimnnphbcjgnc"; } # xbrowsersync
      { id = "niloccemoadcdkdjlinkgdfekeahmflj"; } # pocket
      { id = "lmhkmibdclhibdooglianggbnhcbcjeh"; } # Summarize (gpt)
      { id = "liecbddmkiiihnedobmlmillhodjkdmb"; } # Loom video recording
      { id = "pkehgijcmpdhfbdbbnkijodmdjhbjlgp"; } # Privacy Badger

    ];
  };
}
